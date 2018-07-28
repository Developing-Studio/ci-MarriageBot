from subprocess import run
from os import remove
from re import compile
from io import BytesIO
from asyncio import sleep
from discord import Member, File, User
from discord.ext.commands import command, Context
from cogs.utils.custom_bot import CustomBot
from cogs.utils.checks.can_send_files import can_send_files
from cogs.utils.family_tree.family_tree_member import FamilyTreeMember


class Information(object):
    '''
    The information cog
    Handles all marriage/divorce/etc commands
    '''

    def __init__(self, bot:CustomBot):
        self.bot = bot
        self.substitution = compile(r'[^\x00-\x7F\x80-\xFF\u0100-\u017F\u0180-\u024F\u1E00-\u1EFF]')


    @command(aliases=['spouse', 'husband', 'wife'])
    async def partner(self, ctx:Context, user:Member=None):
        '''
        Shows you the partner of a given user
        '''

        if not user:
            user = ctx.author

        async with self.bot.database() as db:
            x = await db.get_marriage(user)
        if not x:
            await ctx.send(f"`{user!s}` is not currently married.")
            return
        i = x[0]

        u1 = self.bot.get_user(i['user_id'])
        u2 = self.bot.get_user(i['partner_id'])
        await ctx.send(f"`{u1!s}` is currently married to `{u2!s}`.")


    @command(aliases=['child'])
    async def children(self, ctx:Context, user:Member=None):
        '''
        Gives you a list of all of your children
        '''

        if user == None:
            user = ctx.author

        async with self.bot.database() as db:
            x = await db('SELECT * FROM parents WHERE parent_id=$1', user.id)
        if not x:
            await ctx.send(f"`{user!s}` has no children right now.")
            return
        await ctx.send(f"`{user!s}` has `{len(x)}` child" + {False:"ren",True:""}.get(len(x)==1) + ": " + ", ".join([f"`{self.bot.get_user(i['child_id'])!s}`" for i in x]))

    @command()
    async def parent(self, ctx:Context, user:Member=None):
        '''
        Tells you who your parent is
        '''

        if user == None:
            user = ctx.author

        async with self.bot.database() as db:
            x = await db('SELECT * FROM parents WHERE child_id=$1', user.id)
        if not x:
            await ctx.send(f"`{user!s}` has no parent.")
            return
        await ctx.send(f"`{user!s}`'s parent is `{self.bot.get_user(x[0]['parent_id'])!s}`.")


    @command()
    @can_send_files()
    async def treefile(self, ctx:Context, root:Member=None):
        '''
        Gives you the full family tree of a user
        '''

        if root == None:
            root = ctx.author

        text = FamilyTreeMember.get(root.id).generate_gedcom_file(self.bot)
        file = BytesIO(text.encode())
        await ctx.send(file=File(file, filename=f'Tree of {root.id}.ged'))


    @command()
    @can_send_files()
    async def tree(self, ctx:Context, root:Member=None, depth:int=-1):
        '''
        Gets the family tree of a given user
        '''

        try:
            return await self.treemaker(ctx, root, depth, False)
        except Exception as e:
            await ctx.send("I encountered an error while trying to generate your family tree. Could you inform `Caleb#2831`, so he can fix this in future for you?")
            raise e


    @command(aliases=['fulltree'])
    @can_send_files()
    async def globaltree(self, ctx:Context, root:User=None, depth:int=-1):
        '''
        Gets the global family tree of a given user
        '''

        try:
            return await self.treemaker(ctx, root, depth, True)
        except Exception as e:
            await ctx.send("I encountered an error while trying to generate your family tree. Could you inform `Caleb#2831`, so he can fix this in future for you?")
            raise e


    async def treemaker(self, ctx:Context, root:User, depth:int, all_guilds:bool):

        if root == None:
            root = ctx.author
        if depth <= 0:
            depth = -1

        # Get their family tree
        await ctx.trigger_typing()
        tree = FamilyTreeMember.get(root.id)

        # Make sure they have one
        if tree.children == [] and tree.partner == None and tree.parent == None:
            await ctx.send(f"`{root!s}` has no family to put into a tree .-.")
            return

        # Start the 3-step conversion process
        root, text = tree.to_tree_string(ctx, expand_backwards=depth, depth=depth*2, all_guilds=all_guilds)
        if text == '':
            await ctx.send(f"`{root!s}` has no family to put into a tree .-.")
            return

        # Write their treemaker code to a file
        with open(f'./trees/{root.id}.txt', 'w', encoding='utf-8') as a:
            # a.write(self.substitution.sub('_', text))
            a.write(text)

        # Convert and write to a dot file
        f = open(f'./trees/{root.id}.dot', 'w')
        _ = run([
            'python3.6', 
            './cogs/utils/family_tree/familytreemaker.py', 
            '-a', 
            # self.substitution.sub('_', str(root.get_name(self.bot))), 
            root.get_name(self.bot).replace('(', '_').replace(')', '_'), 
            f'./trees/{root.id}.txt'
            ], stdout=f)
        f.close()

        # Convert to an image
        _ = run([
            'dot', 
            '-Tpng', 
            f'./trees/{root.id}.dot', 
            '-o', 
            f'./trees/{root.id}.png', 
            # '-Gcharset=latin1', 
            '-Gcharset=UTF-8', 
            '-Gsize=200\\!', 
            '-Gdpi=100'
            ])

        # Send file and delete cached
        await ctx.send(ctx.author.mention, file=File(fp=f'./trees/{root.id}.png'))
        await sleep(1)  # Just so the file still isn't sending
        for i in [f'./trees/{root.id}.txt', f'./trees/{root.id}.dot', f'./trees/{root.id}.png']:
            _ = remove(i)
            # pass


def setup(bot:CustomBot):
    x = Information(bot)
    bot.add_cog(x)