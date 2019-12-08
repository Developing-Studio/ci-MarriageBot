CREATE TABLE marriages(
    user_id BIGINT NOT NULL,
    partner_id BIGINT NOT NULL,
    guild_id BIGINT NOT NULL DEFAULT 0,
    PRIMARY KEY (user_id, guild_id)
);
-- This table will hold marraiges both in date and divorced pairs
-- marriage_id will be a random 11-character string
-- user_id will be one of the users involved (the other user will get an entry with an identical marriage_id)


CREATE TABLE parents(
    child_id BIGINT NOT NULL,
    parent_id BIGINT NOT NULL,
    guild_id BIGINT NOT NULL DEFAULT 0,
    PRIMARY KEY (child_id, guild_id)
);
-- Since a child will only appear once, you can set child_id to the primary key
-- A parent can have many children, a child will have only one parent


CREATE TABLE blacklisted_guilds(
    guild_id BIGINT NOT NULL,
    PRIMARY KEY (guild_id)
);
-- Basically a big ol' list of blacklisted guild IDs


CREATE TABLE guild_specific_families(
    guild_id BIGINT NOT NULL,
    PRIMARY KEY (guild_id)
);
-- A big ol' list of guild IDs of people who've paid


CREATE TABLE guild_settings(
    guild_id BIGINT NOT NULL,
    prefix VARCHAR(30) DEFAULT 'm!',
    gold_prefix VARCHAR(30) DEFAULT 'm.',
    allow_incest BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (guild_id)
);
-- A config for a guild to change their prefix or other bot settings


CREATE TYPE direction AS ENUM('TB', 'LR');
CREATE TABLE customisation(
    user_id BIGINT NOT NULL,
    edge INTEGER DEFAULT NULL,
    node INTEGER DEFAULT NULL,
    font INTEGER DEFAULT NULL,
    highlighted_font INTEGER DEFAULT NULL,
    highlighted_node INTEGER DEFAULT NULL,
    background INTEGER DEFAULT NULL,
    direction direction DEFAULT 'TB',
    PRIMARY KEY (user_id)
);
-- A table for user tree customisations


CREATE TABLE command_log(
    guild_id BIGINT,
    channel_id BIGINT,
    user_id BIGINT,
    message_id BIGINT PRIMARY KEY,
    content VARCHAR(2000),
    command_name VARCHAR(100),
    invoked_with VARCHAR(100),
    command_prefix VARCHAR(2000),
    timestamp TIMESTAMP,
    command_failed BOOLEAN,
    valid BOOLEAN,
    shard_id SMALLINT
);


CREATE TABLE blocked_user(
    user_id BIGINT,
    blocked_user_id BIGINT,
    PRIMARY KEY (user_id, blocked_user_id)
);
-- A user and how they're blocked ie user_id is the person who blocks blocked_user_id


CREATE TABLE dbl_votes(
    user_id BIGINT PRIMARY KEY,
    timestamp TIMESTAMP
);
-- A table to track the last time a user voted for the bot


CREATE TABLE shard_logging(
        message_create INTEGER,
        message_edit INTEGER,
        typing_start INTEGER,
        message_delete INTEGER,
        reaction_add INTEGER,
        reaction_remove INTEGER,
        reaction_clear INTEGER,
        channel_create INTEGER,
        channel_delete INTEGER,
        channel_update INTEGER,
        member_join INTEGER,
        member_remove INTEGER,
        member_update INTEGER,
        guild_join INTEGER,
        guild_remove INTEGER,
        guild_update INTEGER,
        role_create INTEGER,
        role_delete INTEGER,
        role_update INTEGER,
        emoji_update INTEGER,
        voice_state_update INTEGER,
        member_ban INTEGER,
        member_unban INTEGER,
        latency DECIMAL,
        shard_id INTEGER,
        timestamp TIMESTAMP,
        PRIMARY KEY (shard_id, timestamp)
);
-- Simple event counter as logging for shards


CREATE TABLE blog_posts(
    url VARCHAR(50) PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    body TEXT NOT NULL,
    created_at TIMESTAMP,
    author_id BIGINT
);


CREATE TABLE stripe_purchases(
    id VARCHAR(64) NOT NULL,
    name VARCHAR(64) NOT NULL,
    customer_id VARCHAR(18),
    payment_amount INTEGER NOT NULL,
    discord_id BIGINT NOT NULL,
    guild_id BIGINT NOT NULL,
    completed BOOLEAN NOT NULL DEFAULT FALSE,
    checkout_complete_timestamp TIMESTAMP,
    PRIMARY KEY (id, name)
);


CREATE TABLE redirects(
    code VARCHAR(50) PRIMARY KEY,
    location VARCHAR(2000)
);


CREATE TABLE random_text(
    command_name VARCHAR(50),
    event_name VARCHAR(50),
    string VARCHAR(2000),
    language_code VARCHAR(2),
    PRIMARY KEY (command_name, event_name, string, language_code)
);
INSERT INTO random_text VALUES ('adopt', 'valid_target', 'It looks like {instigator.mention} wants to adopt you, {target.mention}. What do you think?', 'en');
INSERT INTO random_text VALUES ('adopt', 'valid_target', '{instigator.mention} wants to be your parent, {target.mention}. What do you say?', 'en');
INSERT INTO random_text VALUES ('adopt', 'valid_target', '{target.mention}, {instigator.mention} is interested in adopting you. How do you feel?', 'en');
INSERT INTO random_text VALUES ('adopt', 'valid_target', '{instigator.mention} wants to adopt you, {target.mention}. Do you accept?', 'en');
INSERT INTO random_text VALUES ('adopt', 'valid_target', '{instigator.mention} wants to share the love and make you their child, {target.mention}. What do you think?', 'en');
INSERT INTO random_text VALUES ('adopt', 'valid_target', '{instigator.mention} would love to adopt you, {target.mention}. What do you think?', 'en');
INSERT INTO random_text VALUES ('adopt', 'valid_target', '{target.mention}, today''s your lucky day. {instigator.mention} wants to adopt you. Do you accept?', 'en');
INSERT INTO random_text VALUES ('adopt', 'valid_target', '{target.mention}, {instigator.mention} wants to be your parent. What do you say?', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_family', 'Sorry but you''re already related to them, {instigator.mention}!', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_family', 'You can''t adopt someone if you''re related to them already.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_family', 'Laws prohibit adopting someone you''re related to already.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_family', 'You can''t adopt a family member!', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_me', 'I don''t think that''s appropriate.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_me', 'I would rather not.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_me', 'Thank you for the offer, but I''ll have to refuse.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_me', 'No thank you.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_me', 'I think it best you don''t adopt me. No offense.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_me', 'I have one daddy and one daddy only, sorry.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_me', 'Caleb would be pretty upset not gonna lie, so I''m gonna have to decline.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_me', 'The fee to adopt me is $50. Cough that up monthly and you''ve got yourself a MarriageBaby, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_me', 'Sorry but I''d rather not live with trash.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_bot', 'I don''t think bots can consent to that.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_bot', 'I don''t think you can adopt a robot quite yet.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_bot', 'Robots tend to not need parents most of the time.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_bot', 'I think a robot would make a bad child for you.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_bot', 'Pretty sure you have to adopt someone with sentience, {instigator.mention}, why don''t you try a different server member?', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_bot', '#BotsAreNotPeopleToo', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_you', 'You can''t adopt yourself, as far as I know.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_you', 'That''s you. You can''t adopt the you.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_you', 'Did you expect me to say yes?', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_you', 'Why did you think that would work?', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_you', 'Stop it. Weirdo.', 'en');
INSERT INTO random_text VALUES ('adopt', 'instigator_is_instigator', 'Be patient, {instigator.mention}, wait for a response on your other proposal first!', 'en');
INSERT INTO random_text VALUES ('adopt', 'instigator_is_instigator', 'Woah, slow down, wait for a response on the other proposal first.', 'en');
INSERT INTO random_text VALUES ('adopt', 'instigator_is_instigator', 'You can only make one proposal at a time. Please wait.', 'en');
INSERT INTO random_text VALUES ('adopt', 'instigator_is_instigator', 'I know it''s all very exciting but you can only make one proposal at a time.', 'en');
INSERT INTO random_text VALUES ('adopt', 'instigator_is_instigator', 'Wait your turn, you absolute nonce!', 'en');
INSERT INTO random_text VALUES ('adopt', 'instigator_is_instigator', 'Don''t be greedy, {instigator.mention}, wait your turn.', 'en');
INSERT INTO random_text VALUES ('adopt', 'instigator_is_instigator', 'Excuse me you soggy waffle, calm the heck town and wait pls and thx.', 'en');
INSERT INTO random_text VALUES ('adopt', 'instigator_is_target', 'You need to answer your proposal first.', 'en');
INSERT INTO random_text VALUES ('adopt', 'instigator_is_target', 'You can''t make any new proposals until you respond to the ones you have already.', 'en');
INSERT INTO random_text VALUES ('adopt', 'instigator_is_target', 'You''ve just been asked out though, you should answer them first.', 'en');
INSERT INTO random_text VALUES ('adopt', 'instigator_is_target', 'Please respond to your other proposal first.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_instigator', 'They just proposed to someone themself - give it a minute and see how it goes.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_instigator', 'You''ll have to wait until their own proposal is dealt with.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_instigator', 'They asked someone out themself; see what happens with that first.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_instigator', 'Please respond to your other proposal first.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_target', 'They''re a popular choice, aren''t they? Give them a minute to respond to their existing proposal.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_target', 'Looks like someone got there before you - see what they say to that.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_target', 'I don''t mean to start drama but someone already asked them out.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_target', 'Funnily enough, someone proposed to them already. See what they say to that before you propose yourself.', 'en');
INSERT INTO random_text VALUES ('adopt', 'request_timeout', 'Looks like you aren''t even deemed a response. That''s pretty rude. Try again later, {instigator.mention}!', 'en');
INSERT INTO random_text VALUES ('adopt', 'request_timeout', 'Apparently they have better things to do than respond to you, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('adopt', 'request_timeout', 'They didn''t respond... Ah well. I''ll send them back to the orphanage for you, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('adopt', 'request_timeout', 'Turns out they aren''t even interested enough to respond, {instigator.mention}. I apologise on their behalf.', 'en');
INSERT INTO random_text VALUES ('adopt', 'request_accepted', 'They said yes! I''m happy to introduce {instigator.mention} as your new parent, {target.mention}!', 'en');
INSERT INTO random_text VALUES ('adopt', 'request_accepted', 'You have a new child, {instigator.mention}! Say hello to {target.mention}~', 'en');
INSERT INTO random_text VALUES ('adopt', 'request_accepted', 'I''m sure {instigator.mention} will be happy to welcome you into the family, {target.mention}.', 'en');
INSERT INTO random_text VALUES ('adopt', 'request_accepted', 'WHO''S YOUR DADDY? Or...mommy...or parent...whatever, welcome to {instigator.mention}''s family, {target.mention}.', 'en');
INSERT INTO random_text VALUES ('adopt', 'request_denied', 'Looks like they don''t want to be your child, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('adopt', 'request_denied', 'They don''t want to, {instigator.mention}. Sorry!', 'en');
INSERT INTO random_text VALUES ('adopt', 'request_denied', 'They said no, {instigator.mention}, looks like they won''t be your child for now.', 'en');
INSERT INTO random_text VALUES ('adopt', 'request_denied', 'Apparently they don''t deem you a worthy parent, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_unqualified', 'It looks like they have a parent already.', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_unqualified', 'Sorry but they have a parent already!', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_unqualified', 'Looks like they already have a loving(?) parent. Sorry!', 'en');
INSERT INTO random_text VALUES ('adopt', 'target_is_unqualified', 'Looks like you missed the adoption train, {instigator.mention}, because {target.mention} already has a parent.', 'en');

INSERT INTO random_text VALUES ('copulate', 'request_timeout', 'Looks like the request timed out, {instigator.mention}!', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_timeout', 'Looks like they fell asleep, {instigator.mention} .-.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_timeout', 'Guess not! Try again later, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_timeout', 'If you''re really that horny, go and watch some porn(y).', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_timeout', 'You''re all alone with no one to bone.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_timeout', 'Sorry {instigator.mention}', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_timeout', '¯\_(ツ)_/¯ {instigator.mention}', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_timeout', 'Seems they got cold feet! Sorry buddy!', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} got frisky~', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} spent some alone time together ~~wink wonk~~', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} made sexy time together ;3', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} attempted to make babies.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} tried to have relations but couldn''t find the hole.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} went into the wrong hole.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} tried their hardest, but they came too early .-.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} slobbed each other''s knobs.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} had some frisky time in the pool and your doodoo got stuck because of pressure.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} had sex and you''ve contracted an STI. uh oh!', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} had sex but you finished early and now it''s just a tad awkward.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', 'Jesus saw what {instigator.mention} and {target.mention} did.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} did a lot of screaming.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} had sex and pulled a muscle. No more hanky panky for a while!', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention}… just please keep it down.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', 'Wrap it before you tap it, {instigator.mention} and {target.mention}.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{instigator.mention} and {target.mention} did the thing with the thing… oh gosh. Ew.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', 'Bing bong {instigator.mention}, turns out {target.mention} wants your ding dong!', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{target.mention} and {instigator.mention} did the nasty while spanking each others bum cheeks!', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{target.mention} and {instigator.mention} went to town, if you know what I mean.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{target.mention} and {instigator.mention} got it on. I sure hope Jesus consented, too…', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', 'JESUS CONSENTS, GOD WILLS IT.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{target.mention} and {instigator.mention} are getting freaky, looks like they aren’t afraid to show the pie.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{target.mention} and {instigator.mention} are fucking like rabbits, looks like they broke the bed. A new bed will be needed.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{target.mention} bends over {instigator.mention} and fucks them raw. ', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{target.mention} pushes {instigator.mention} against the wall, choking them and fucking them silly.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{target.mention} fucks {instigator.mention} in the ass, but they accidentally shit the bed.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{target.mention} fucks {instigator.mention} vigorously with a dildo! Jackhammer!', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_accepted', '{target.mention} plows {instigator.mention} into the couch before spraying {instigator.mention} with their semen!', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'Looks like they don''t wanna smash, {instigator.mention}!', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'Guess it''s back to the porn mags for you, {instigator.mention}. :/', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'Sucks to be you, buckaroo!', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'Guess your dick game isn''t strong enough.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', '¯\_(ツ)_/¯', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'Haters are your motivators~', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'Bing bong, they don''t want your ding dong!', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'No means no. Sorry!', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'I''d love to, but I''m going to have a migraine that night.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'I think I hear someone calling me... way, way over there. *poofs* Sorry {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'Like right now? I don''t think that''s a great idea, what with my infectious mouth disease and all...', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'This feels like the beginning of a really great friendship! Ouch.. Friendzoned.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'It''s not you; it''s your facial hair. And your shirt. And your personality.', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'I''d fuck you, but I''d be afraid of my future children inheriting your face', 'en');
INSERT INTO random_text VALUES ('copulate', 'request_denied', 'Oh, wait, I think I just spotted someone else that I''d rather be talking to! That has to sting...', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_bot', 'Hey {instigator.mention}, isn''t that illegal?', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_bot', 'I''m not sure a bot has enough sentience to consent if I''m gonna be honest. ', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_bot', 'I''m sure you''re very attracted to diodes and capacitors but you can''t blow a circuit board.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_bot', 'Sex robots aren''t quite up to modern standards yet, I''m afraid.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_me', 'I''m a bit out of your league, don''t you think?', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_me', 'I think I can do better than your twinky ass.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_me', 'Honestly? No.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_me', 'Gross. I''ll pass. ', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_me', 'Jesus is my only lover.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_me', 'I''m engaged to the Lord, no smashing before marriage.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_me', 'Thank you, next.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_me', 'STRANGER DANGER!', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_me', 'Sure, go ahead if you want to make me short circuit, that''s *perfectly* fine.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_me', 'My daddy said no I''m sorry.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_me', '#Binch is the only relationship I''m interested in, sorry.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_family', 'This ain''t the South, partner. Stop.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_family', 'Don''t turn the family tree into a family donut.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_family', 'That''s gross, {instigator.mention} please reconsider.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_you', 'Not on my Christian Minecraft server.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_you', 'Not in front of the children!', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_you', 'Dildos and dildon''ts - this. This right now. Just stop. Pls.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_you', 'Masturbation is the language of loneliness… got something you wanna talk about, bud?', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_you', 'Self-cest was so last year.', 'en');
INSERT INTO random_text VALUES ('copulate', 'target_is_you', 'Haven''t you heard? Masturbation makes you blind!', 'en');
INSERT INTO random_text VALUES ('copulate', 'valid_target', 'Hey, {target.mention}, do you wanna?', 'en');
INSERT INTO random_text VALUES ('copulate', 'valid_target', 'Hey {target.mention}, sex with {instigator.mention}? ', 'en');
INSERT INTO random_text VALUES ('copulate', 'valid_target', 'Hey {target.mention}. You wanna fuck?', 'en');
INSERT INTO random_text VALUES ('copulate', 'valid_target', 'What''s up {target.mention} you dtf?', 'en');
INSERT INTO random_text VALUES ('copulate', 'valid_target', 'Yoooo, you up to _smash_?', 'en');
INSERT INTO random_text VALUES ('copulate', 'valid_target', 'Hey {target.mention}, u wan sum fuk?', 'en');
INSERT INTO random_text VALUES ('copulate', 'valid_target', 'Hey, {target.mention}, ready to mingle? B)', 'en');
INSERT INTO random_text VALUES ('copulate', 'valid_target', 'Fuck me Daddy? ', 'en');
INSERT INTO random_text VALUES ('copulate', 'valid_target', 'H-hi *playfully plays with your shirt* m-my princess pa- parts tingle.', 'en');
INSERT INTO random_text VALUES ('copulate', 'valid_target', 'Roses are red, Violets are blue, I suck at poems, let''s fuck.', 'en');
INSERT INTO random_text VALUES ('copulate', 'valid_target', 'What''s the drop rate on your panties?', 'en');

INSERT INTO random_text VALUES ('disown', 'instigator_is_unqualified', 'They aren''t your child...', 'en');
INSERT INTO random_text VALUES ('disown', 'instigator_is_unqualified', 'Have you considered disowning someone who''s *actually* your child?', 'en');
INSERT INTO random_text VALUES ('disown', 'instigator_is_unqualified', 'Strangely enough you can only disown *your* children.', 'en');
INSERT INTO random_text VALUES ('disown', 'instigator_is_unqualified', 'Are you confusing that person for your child?', 'en');
INSERT INTO random_text VALUES ('disown', 'valid_target', 'Oof, {target.mention}, {instigator.mention} doesn''t seem to want you any more...', 'en');
INSERT INTO random_text VALUES ('disown', 'valid_target', 'Well, {instigator.mention}, say goodbye to {target.mention}.', 'en');
INSERT INTO random_text VALUES ('disown', 'valid_target', 'Might be good news for you, {target.mention}, but you''re finally free of {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('disown', 'valid_target', 'One child down, the rest to go.', 'en');
INSERT INTO random_text VALUES ('disown', 'valid_target', 'A sad day when a parent disowns their child...', 'en');
INSERT INTO random_text VALUES ('disown', 'valid_target', 'I''m sure this is very emotional for you. I''m sorry for your loss.', 'en');
INSERT INTO random_text VALUES ('disown', 'valid_target', 'One less problem for you to deal with.', 'en');
INSERT INTO random_text VALUES ('disown', 'valid_target', 'They''re just out to get some cigarettes and milk, I''m sure they''ll be back soon.', 'en');
INSERT INTO random_text VALUES ('disown', 'valid_target', 'I guess they got the winning lottery numbers, huh?', 'en');

INSERT INTO random_text VALUES ('divorce', 'instigator_is_unqualified', 'Crazy idea, but you could try getting married first?', 'en');
INSERT INTO random_text VALUES ('divorce', 'instigator_is_unqualified', 'It may seem like a stretch, but you need to marry someone before you can divorce them.', 'en');
INSERT INTO random_text VALUES ('divorce', 'instigator_is_unqualified', 'Maybe try marrying them first?', 'en');
INSERT INTO random_text VALUES ('divorce', 'instigator_is_unqualified', 'You''re not married. Don''t try to divorce strangers .', 'en');
INSERT INTO random_text VALUES ('divorce', 'instigator_is_unqualified', 'Way to use your imagination, {instigator.mention}! But unfortunately for you, you need to be married to someone before you can divorce them.', 'en');
INSERT INTO random_text VALUES ('divorce', 'instigator_is_unqualified', 'Sorry but you''re too lonely to do that.', 'en');
INSERT INTO random_text VALUES ('divorce', 'valid_target', 'Sorry, {target.mention}, looks like you''re single now. Congrats, {instigator.mention}!', 'en');
INSERT INTO random_text VALUES ('divorce', 'valid_target', 'I hope you figure it out some day, but for now it looks like the two of you are divorced, {instigator.mention}, {target.mention}.', 'en');
INSERT INTO random_text VALUES ('divorce', 'valid_target', 'At least you don''t have to deal with {instigator.mention} any more, {target.mention}, right...?', 'en');
INSERT INTO random_text VALUES ('divorce', 'valid_target', 'Not the happiest of news for you, {target.mention}, but it looks like {instigator.mention} just left you...', 'en');
INSERT INTO random_text VALUES ('divorce', 'valid_target', 'You and {target.mention} are now divorced. I wish you luck in your lives.', 'en');
INSERT INTO random_text VALUES ('divorce', 'valid_target', 'You and your partner are now divorced. I wish you luck in your lives.', 'en');
INSERT INTO random_text VALUES ('divorce', 'valid_target', 'I hope you figure it out some day, but for now, you and your partner are divorced, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('divorce', 'valid_target', 'You just committed marriagen''t.', 'en');
INSERT INTO random_text VALUES ('divorce', 'valid_target', '_Sad violin noises._', 'en');

INSERT INTO random_text VALUES ('emancipate', 'instigator_is_unqualified', 'You don''t actually have a parent. This is awkward.', 'en');
INSERT INTO random_text VALUES ('emancipate', 'instigator_is_unqualified', 'You''re already an orphan though!', 'en');
INSERT INTO random_text VALUES ('emancipate', 'valid_target', 'Looks like {instigator.mention} left you, {target.mention}. I''m sorry for your loss.', 'en');
INSERT INTO random_text VALUES ('emancipate', 'valid_target', 'You''re free of {target.mention}, {instigator.mention}!', 'en');
INSERT INTO random_text VALUES ('emancipate', 'valid_target', 'Say goodbye to {target.mention}, {instigator.mention}! You''re parentless now!', 'en');
INSERT INTO random_text VALUES ('emancipate', 'valid_target', 'Freedom for you, {instigator.mention}!', 'en');
INSERT INTO random_text VALUES ('emancipate', 'valid_target', 'Have fun living in the streets!', 'en');
INSERT INTO random_text VALUES ('emancipate', 'valid_target', 'You no longer have a parent.
... Don''t think too hard about it.', 'en');

INSERT INTO random_text VALUES ('makeparent', 'instigator_is_instigator', 'Hold your horses, {instigator.mention}, you''ve already made a proposition to someone.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'instigator_is_instigator', 'Slow down a bit - wait for a response to your other question.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'instigator_is_instigator', 'Though I hate to rain on your parade, you can only make one proposition at a time.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'instigator_is_instigator', 'Chill. One proposal at a time, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'instigator_is_instigator', 'You can only make or recieve one proposition at a time.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'instigator_is_target', 'Shouldn''t you respond to your other question first, {instigator.mention}?', 'en');
INSERT INTO random_text VALUES ('makeparent', 'instigator_is_target', 'I think you should prioritise your other proposal, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'instigator_is_target', 'You''ve already been asked something, {instigator.mention} - you should deal with that first.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'instigator_is_target', 'You can only make or recieve one proposition at a time.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'instigator_is_unqualified', 'I know it''s a strange setup, but you can only pick one of your parents, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'instigator_is_unqualified', 'You have a parent already, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'instigator_is_unqualified', 'You can only have one parent at a time, as odd as that sounds, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'instigator_is_unqualified', 'You can''t pick a new parent while you already have one, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_accepted', '{instigator.mention}, meet your new parent, {target.mention}!', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_accepted', '{target.mention}, you have sucessfully adopted {instigator.mention}!', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_accepted', 'I''m happy to introduce {instigator.mention} to the {target.mention} family!', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_accepted', 'They accepted, {instigator.mention}! Welcome to the new family.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_accepted', '{instigator.mention}, your new parent is {target.mention} c:', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_denied', 'Sorry, {instigator.mention}, but they said no.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_denied', 'Unfortunately they said no, {instigator.mention}. Better luck next time!', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_denied', 'It seems they aren''t ready to be your parent, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_timeout', 'Sorry, {instigator.mention}, but back to the orphanage with you.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_timeout', 'No response from your decided daddy, {instigator.mention}. Sorry about that.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_timeout', 'No response. Huh. Guess you''ll have to remain parentless for now, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_timeout', 'Ouch. No response. Sorry, {instigator.mention}. I''ll take you out for ice cream later.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_timeout', 'They didn''t seem to say anything, {instigator.mention}. Maybe try again later!', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_timeout', 'Sorry to say this, {instigator.mention}, but they didn''t get back in time to respond.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'request_timeout', '{instigator.mention}, your parent request has timed out. Try again when they''re online!', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_bot', 'Bots don''t make _terribly_ good parents, but I''ll allow it, {instigator.mention}. Have fun with your new family!', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_bot', 'Though robots often have trouble with love, I''m sure {target.mention} will make a lovely parent for you, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_bot', 'Your choice of robot is... interesting. {target.mention} is now your parent, {instigator.mention}!', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_bot', 'A robot probably isn''t the best choice, but who am I to judge? Have fun with your new family, {instigator.mention}!', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_family', 'They''re already part of the family you''re in, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_family', 'You can''t just mess up your family tree like that - you''re already related to that person, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_family', 'Family trees tend to get messed up when you get relations like that, so I''m gonna have to say no, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_family', '{instigator.mention}, they''re already part of your family.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_instigator', 'They''ve just proposed to someone. Give it a minute.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_instigator', 'Give them a minute to deal with their proposal and then try again.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_instigator', 'Looks like they''re focused on something else right now. Try again in a minute.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_instigator', 'Holdup, {instigator.mention}, they''ve just proposed to someone else.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_me', 'I''m afraid I''ll have to decline, but thank you for the offer.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_me', 'Not that I don''t _like_ you or anything, but I would rather not.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_me', 'You can''t adopt any robots, me included. Sorry!', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_me', 'Though I''d love to, I can''t.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_me', 'I''m sure I''d be a wonderful child, but I can''t set you as my child.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_me', 'Thanks for the offer, but no thank you.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_target', 'Oops, looks like someone else asked first. Just wait a minute and see what they say.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_target', 'Someone already made a proposition to them, try again in a minute.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_target', 'Looks like you''ll need to wait until they respond to your current offer.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_target', 'Unfotrunately they need to respond to their current proposal before you can make yours.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_you', 'Oh, ha ha, very funny.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_you', 'I''m not super sure why you thought that would work.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_you', 'Try picking someone that isn''t yourself next time!', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_you', 'Oddly enough, you can''t adopt yourself. I wonder why that is?', 'en');
INSERT INTO random_text VALUES ('makeparent', 'target_is_you', 'You can''t adopt yourself, I''m sorry to say.', 'en');
INSERT INTO random_text VALUES ('makeparent', 'valid_target', '{instigator.mention} wants to be your child, {target.mention}. Do you accept?', 'en');
INSERT INTO random_text VALUES ('makeparent', 'valid_target', '{instigator.mention} is willing to give their love to you and make you their parent, {target.mention}. What do you say?', 'en');
INSERT INTO random_text VALUES ('makeparent', 'valid_target', '{instigator.mention} would love to be adopted by you, {target.mention}. What do you think?', 'en');
INSERT INTO random_text VALUES ('makeparent', 'valid_target', 'Today could be your day, {instigator.mention}. {target.mention}, will you adopt them?', 'en');
INSERT INTO random_text VALUES ('makeparent', 'valid_target', '{target.mention}, {instigator.mention} wants to be your child. What do you say?', 'en');
INSERT INTO random_text VALUES ('makeparent', 'valid_target', '{target.mention}, do you want to be {instigator.mention}''s parent?', 'en');

INSERT INTO random_text VALUES ('propose', 'instigator_is_instigator', 'You''ve already proposed to someone, {instigator.mention}, just wait for a response.', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_instigator', 'You can only make one proposal at a time, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_instigator', 'One proposal at a time is the max limit, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_instigator', 'Calm it, {instigator.mention}, you already proposed to someone!', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_instigator', 'Calm your figurative or literal titties, {instigator.mention}, you''ve already proposed!', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_instigator', 'Hold those horsies, {instigator.mention}. Don''t just move on so quickly!', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_target', 'Sorry but you''ve gotta answer your current proposal before you can make one of your own.', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_target', 'You need to answer the proposal you have already before you can make a new one.', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_target', 'You''ve been proposed to already, {instigator.mention}. Please respond before moving on.', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_target', 'Don''t you want to answer the proposal you have already?', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_target', 'Someone already proposed to you though! Answer them first, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_unqualified', 'Maybe you should wait until after you''re divorced, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_unqualified', 'You already have someone, {instigator.mention}.You''re not single, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_unqualified', 'I hate to rain on your parade, {instigator.mention}, but I don''t think that appropriate while you''re married already.', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_unqualified', 'Polygamy is much harder to store in a database, {instigator.mention}. My apologies.', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_unqualified', 'Unfortunately I can''t show family trees with polygamy in them, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('propose', 'instigator_is_unqualified', 'YOU HAVE A SPOUSE ALREADY, {instigator.mention}!', 'en');
INSERT INTO random_text VALUES ('propose', 'request_accepted', '{instigator.mention}, {target.mention}, I now pronounce you married.', 'en');
INSERT INTO random_text VALUES ('propose', 'request_accepted', '{instigator.mention}, you''re now married to {target.mention} c:', 'en');
INSERT INTO random_text VALUES ('propose', 'request_accepted', 'And with that, {instigator.mention} and {target.mention} are partners.', 'en');
INSERT INTO random_text VALUES ('propose', 'request_accepted', 'After all the love and pining, it is done. {instigator.mention}, {target.mention}, you''re now married.', 'en');
INSERT INTO random_text VALUES ('propose', 'request_denied', 'That''s fair. The marriage has been called off.', 'en');
INSERT INTO random_text VALUES ('propose', 'request_denied', 'Oh boy. The wedding is off. You two talk it out.', 'en');
INSERT INTO random_text VALUES ('propose', 'request_denied', 'I hate to say it, {instigator.mention}, but they said no...', 'en');
INSERT INTO random_text VALUES ('propose', 'request_denied', 'Oh boy. They said no. That can''t be good.', 'en');
INSERT INTO random_text VALUES ('propose', 'request_denied', 'Maybe a night in a cheap motel with you, but marriage is too much commitment for `{target.mention}`.', 'en');
INSERT INTO random_text VALUES ('propose', 'request_denied', 'Sorry bb, you''re still one single pringle.', 'en');
INSERT INTO random_text VALUES ('propose', 'request_denied', 'Roses are red,
Violets are blue,
It looks like they don''t want to be with you, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('propose', 'request_timeout', '{instigator.mention}, your proposal has timed out. Try again when they''re online!', 'en');
INSERT INTO random_text VALUES ('propose', 'request_timeout', 'Huh. Seems like they didn''t respond. Maybe try again later, {instigator.mention}?', 'en');
INSERT INTO random_text VALUES ('propose', 'request_timeout', 'Apparently you aren''t even deemed worthy a response. That''s rude. Try later, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('propose', 'request_timeout', 'Time limits can''t bring you down, no no no no no no noooo!', 'en');
INSERT INTO random_text VALUES ('propose', 'request_timeout', 'Looks like they ghosted you! Maybe next time...', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_bot', 'To the best of my knowledge, most robots can''t consent.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_bot', 'The majority of robots are incapable of love, I''m afraid.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_bot', 'You can''t marry a robot _quite yet_ in this country. Give it a few years.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_bot', 'Robots, although attractive, aren''t great spouses.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_bot', 'Although that robot may love you, it''s afraid of commitment. Give it a few years.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_bot', 'Long distance relationships are hard, but they''re even harder with a robot incapable of feelings.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_family', 'That... that''s a family member of yours, {instigator.mention}...', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_family', 'Though we support free speech and all, you can''t really marry someone you''re related to, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_family', 'We''ve made great strides towards equality recently, {instigator.mention}, but you still can''t marry a relative of yours.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_family', '{instigator.mention} you''re related to them .-.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_family', 'Incestuous relationships tend to mess up the family tree, so I''m afraid I''ll have to say no, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_family', 'Despite what Mia says, incest is not wincest, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_family', 'Wh...what. That''s gross. No thank you, {instigator.mention}.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_instigator', 'I''m afraid they''ve already proposed to someone. Give it a minute - see how it goes.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_instigator', 'They seem to have just proposed to someone. See how that goes before you try yourself.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_instigator', 'Hold your horses - they''ve just proposed to someone else.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_instigator', 'They''re waiting on a response from soneone else; give it a minute.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_instigator', 'I think they''re interested in someone else, having just proposed to them.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'I''m flattered, but my heart belongs to another.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'Unfortunately, my standards raise above you.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'My love is exclusive to one other...', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'Though I''d love to make an exception for you, I can''t marry a human.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'I''m flattered but no, sweetheart.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'I''m a robot. I would recommend asking someone else.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'Perhaps pick a user with sentience.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'There''s desperate, and then there''s proposing to a bot.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'No.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'Thanks, but I could do better.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'Are you serious? No.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'I''m a robot, I''m not interested, and you could do better, sweetheart.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'Daddy Caleb says no, sorry.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'What type of cruel and unusual punishment is this? No thanks!', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'Oh dear god. No.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'Daddy Caleb says no. Your loss.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_me', 'Sorry, I don''t marry the inferior. I mean the less fortunate. I mean humans.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_target', 'They''re a popular choice, I see. Wait to see what they say to the other proposal they have before trying yourself.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_target', 'Someone just proposed to them. See what they say there first.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_target', 'Woah, hold on a minute - someone else proposed first. I wonder what they''ll say...', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_unqualified', 'I hate to tell you this, {instigator.mention}, but they''re already married...', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_unqualified', 'I don''t know if you knew this but they''re already married, {instigator.mention}...', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_unqualified', 'Oh, uh, sorry {instigator.mention}, but they''re already seeing someone.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_unqualified', 'Ah... this is awkward... they already have someone, {instigator.mention}...', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_unqualified', 'Polygamy is much harder to store in a database, {instigator.mention}. My apologies.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_unqualified', 'They''re already married, m8. Suck it up and move on.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_unqualified', 'They''re already with someone - don''t know if you knew.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_unqualified', 'Unfortunately they found someone they liked more than you. Sorry!', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_unqualified', 'As crazy a concept as this may sound, monogamy is the way I roll.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_unqualified', 'Poor unfortunate soul… they found someone before you got to them.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_you', 'That is you. You cannot marry the you.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_you', 'Are... are you serious? No.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_you', 'Marriage is a union between two people. You are one people. No.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_you', 'Self-cest ain''t cute. Try going for someone who''s not you.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_you', 'No.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_you', 'Autosexuality? Sorry, our architecture doesn''t support that.', 'en');
INSERT INTO random_text VALUES ('propose', 'target_is_you', '{target.mention}, do you accept {instigator.mention}''s proposal?
... Wait, no, you''re the same person. The marriage is off!', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{target.mention}, do you accept {instigator.mention}''s proposal?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{target.mention}, {instigator.mention} has proposed to you. What do you say?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{instigator.mention} may be young, but they''re full of heart. Do you want to marry them, {target.mention}', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{instigator.mention} finally wants to settle down with you, {target.mention}. Do you accept?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{target.mention}, will you marry {instigator.mention}?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{instigator.mention} wants you to be the love of their life, {target.mention}. Do you accept?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{instigator.mention} has got a nice big ring for you, {target.mention}. What do you say?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{instigator.mention} liked it so they want to put a ring on it...do you accept, {target.mention}?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{instigator.mention} longs for a married life together with {target.mention}. Do you share this fantasy, {target.mention}?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{target.mention}, you be the jelly in my peanut butter and jelly sandwich?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{target.mention}, {instigator.mention} wants to marry you. Will you accept?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'I hear wedding bells chiming, {target.mention}! Do you?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'Oh boy, {target.mention}, I can sense big things in your future. Will you say yes to marrying {instigator.mention}?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'Would you like to marry {instigator.mention}, {target.mention}?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'Whether it''ll last forever starts with one question: {target.mention}, would you like to marry {instigator.mention}?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'You know the drill: {target.mention}, marry {instigator.mention}?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'Commitment starts with a question. {target.mention}, will you marry {instigator.mention}?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'Yo {target.mention}, you down to marry {instigator.mention}?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'Hey {target.mention} it''s time to get _intimate_~ Do you wanna marry {instigator.mention}?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'Hey {target.mention} I dare you to marry {instigator.mention} ;3', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{target.mention}, you ready to uwu over {instigator.mention}? ', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'Hey {target.mention}, are you free tomorrow night? If so, you should get dinner with {instigator.mention} or maybe marry them or something idk.', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'Could {target.mention} and {instigator.mention} make a cuter married couple than Ollie and Caleb? They sure can try! c;', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'Wouldn''t {target.mention} and {instigator.mention} look cute as wedding cake toppers? Let''s make it happen!', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'Hey {target.mention}, wanna marry {instigator.mention} and achieve tumblr crackship fame?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', 'Does anyone ever daydream about {target.mention} snuggling {instigator.mention} in the moonlight?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{instigator.mention} and {target.mention} together? I don''t see it myself, but what does {target.mention} have to say?', 'en');
INSERT INTO random_text VALUES ('propose', 'valid_target', '{instigator.mention} and {target.mention}? Oh boy I can already see their adopted children! {target.mention}, what do you say?', 'en');
