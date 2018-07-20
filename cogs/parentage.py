from re import compile
from asyncio import TimeoutError
from discord import Member
from discord.ext.commands import command, Context
from cogs.utils.custom_bot import CustomBot
from cogs.utils.family_tree.family_tree import FamilyTree


class Parentage(object):
    '''
    The parentage cog
    Handles the adoption of parents
    '''

    def __init__(self, bot:CustomBot):
        self.bot = bot

        # Proposal text
        self.proposal_yes = compile(r"(i do)|(yes)|(of course)|(definitely)|(absolutely)|(yeah)|(yea)|(sure)")
        self.proposal_no = compile(r"(i don't)|(i dont)|(no)|(to think)|(i'm sorry)|(im sorry)")

        # Adoption cache
        self.cache = []


    @command()
    async def makeparent(self, ctx:Context, parent:Member):
        '''
        Picks a user that you want to be your parent
        '''

        instigator = ctx.author
        target = parent  # Just so "target" didn't show up in the help message

        # See if either user is already being proposed to
        if instigator.id in self.cache:
            await ctx.send("You can only make one adoption request at a time .-.")
            return
        elif target.id in self.cache:
            await ctx.send("That person has already been asked to adopt. Please wait.")
            return

        # Manage exclusions
        if target.id == self.bot.user.id:
            await ctx.send("I'm flattered but no, sweetheart 😘")
            return
        elif target.bot or instigator.bot:
            await ctx.send("Robots don't make particularly good parents.")
            return
        elif instigator.id == target.id:
            await ctx.send("Are you serious.")
            return

        # See if they already have a parent
        await ctx.trigger_typing()
        async with self.bot.database() as db:
            parentage = await db.get_parent(instigator)
            family_tree1 = FamilyTree(instigator.id, 6, go_back=-1)  # Get the instigator's tree
            await family_tree1.populate_tree(db)
            family_tree2 = FamilyTree(target.id, 6, go_back=-1)  # Get the instigator's tree
            await family_tree2.populate_tree(db)
        
        # If they are, tell them off
        treeset_1 = set([i.id for i in family_tree1.all_users()])
        treeset_2 = set([i.id for i in family_tree2.all_users()])
        if treeset_1.intersection(treeset_2):
            await ctx.send(f"{instigator.mention}, they're already part of your family.")
            return
        elif parentage:
            await ctx.send("Sorry, but you already have a parent :/")
            return

        # Make sure the user knows
        m = await ctx.send(f"Just to make sure, {instigator.mention}, you should know you can't change your parent after you do this, and you can only have one. Do you want to continue?")
        await m.add_reaction('👌')
        await m.add_reaction('👎')
        try:
            r, u = await self.bot.wait_for('reaction_add', check=lambda r, u: u.id == instigator.id and r.emoji in ['👌', '👎'], timeout=60.0)
            if r.emoji == '👎':
                await ctx.send("Well, that's your choice.")
                return
        except TimeoutError as e:
            await ctx.send("Well, the timeout has spoken.")
            return

        # No parent, send request
        async with self.bot.database() as db:
            await db.add_event(instigator=instigator, target=target, event='PARENT REQUEST')
        await ctx.send(f"{target.mention}, do you want to be {instigator.mention}'s parent?")
        self.cache.append(instigator.id)
        self.cache.append(target.id)

        # Make the check
        def check(message):
            '''
            The check to make sure that the user is giving a valid yes/no
            when provided with a proposal
            '''
            
            if message.author.id != target.id:
                return False
            if message.channel.id != ctx.channel.id:
                return False
            c = message.content.casefold()
            no = self.proposal_no.search(c)
            yes = self.proposal_yes.search(c)
            if any([yes, no]):
                return 'NO' if no else 'YES'
            return False

        # Wait for a response
        try:
            m = await self.bot.wait_for('message', check=check, timeout=60.0)
        except TimeoutError as e:
            async with self.bot.database() as db:
                await db.add_event(instigator=target, target=instigator, event='TIMEOUT')
            await ctx.send(f"{instigator.mention}, your parent request has timed out. Try again when they're online!")
            self.cache.remove(instigator.id)
            self.cache.remove(target.id)
            return

        # Valid response recieved, see what their answer was
        response = check(m)
        if response == 'NO':
            async with self.bot.database() as db:
                await db.add_event(instigator=target, target=instigator, event='DECLINE ADOPTION')
            await ctx.send("No adoption today, it seems..")
        elif response == 'YES':
            async with self.bot.database() as db:
                await db.add_event(instigator=target, target=instigator, event='ACCEPT ADOPTION')
                await db('INSERT INTO parents (child_id, parent_id) VALUES ($1, $2)', instigator.id, target.id)
            await ctx.send(f"{instigator.mention}, your new parent is {target.mention} c:")

        self.cache.remove(instigator.id)
        self.cache.remove(target.id)


    @command()
    async def disown(self, ctx:Context, child:Member):
        '''
        Lets you remove a user from being your child
        '''

        instigator = ctx.author
        target = child

        async with self.bot.database() as db:
            children = await db('SELECT * FROM parents WHERE parent_id=$1', instigator.id)
        if not children:
            await ctx.send(f"Heh. You don't have any children, {instigator.mention}.")
            return
        children_ids = [i['child_id'] for i in children]
        if target.id not in children_ids:
            await ctx.send(f"That person isn't your child, {instigator.mention}.")
            return
        async with self.bot.database() as db:
            await db('DELETE FROM parents WHERE child_id=$1 AND parent_id=$2', target.id, instigator.id)
        await ctx.send(f"Sorry, {target.mention}, but you're an orphan now. You're free, {instigator.mention}!")


def setup(bot:CustomBot):
    x = Parentage(bot)
    bot.add_cog(x)
