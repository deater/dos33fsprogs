;================
; Hidden Glen
;================

; (Walk in the path of Dongolev's arrows)
.byte "Hopefully this guy will have some sense and not shoot you.",0
; {Dongolev shoots you in the head}
.byte "That guy has no sense. He shot you. Dumb, dumb, dumb. Nice one, William Tell. You dead. Thanks for playing.",0

; +3 points
; + haldo
.byte "the archer stops arching and turns to you. ",34,"My brother told you to tell me haldo? He must want to start the old business back up!",34,0

; + haldo (before talking to Mendelev)
.byte "What'd you read that in PQ Stragedy Guide? Go talk to my brother first.",0

; + haldo (after Dongolev leaves)
.byte 34,"Haldo?",34,". you call out... ",34,"Hadloooooo",34,0

; + look (with Dongolev)
.byte "Well, looky here! A hidden glen! You LOVE hidden glens. This one has some kinda archer in it.",0

; + look (w/o Dongolev)
.byte "You're in a hidden glen. There's a tree with zillions of arrows in it.",0
 
; + look archer
.byte "He sure looks miffed at that tree. He's emptied 5 good quivers' worth into that poor thing.",0

; + look arrow
.byte "Somebody call a tree doctor. Them puppies are stuck in there like a, um, er ... stuck pig.",0

; + look bushes
.byte "There's some thick 'ol bushes up in this hidden glen.",0

; + look fence
.byte "Wow! There's a hole in it on THIS side too!",0

; + look tree
.byte "Dude, and then the elf, like, totally climbed up it. It was awesome!",0

; + climb tree
.byte "Naw, you'd probably figure out some way to kill yourself doing that.",0

; + climb/jump fence
.byte "Not going to dignify that with a response.",0

; + 2 points
; + get arrow
.byte "You pick out a really good one and yank it from the tree. Hooray! Now you have an arrow!",0

; + get arrow (Dogolev there) (Warning: As you can see, this kills you.)
.byte "Something tells me now's not a good time.",0
; {you get the arrow anyway and Dongolev shoots you}
.byte "It wasn't a good time. Hey, my mom's making peasant-kabobs for dinner TOO! Right. Anyway. You dead. Thanks for playing, and try not to die.",0

; + get arrow (After you get the arrow OR get arrow from after Kerrek)
.byte "You're pretty much all set on the arrow front. They're kinda cool, though.",0

; + get arrow (after killing Kerrek)
.byte "You grab yet another arrow from the tree hoping to get some bonus points.",0


;==========================
; Inside Baby Lady Cottage
;==========================

; + look
.byte "What a depressing little",13
.byte "cottage. It reeks of single",13
.byte "parent. A lady rocks her",13
.byte "baby in a chair. A mostly",13
.byte "empty shelf sits against",13
.byte "one wall.",0

; + look (after lady leaves)        
.byte "What a depressing little",13
.byte "cottage. It reeks of single",13
.byte "parent. There is one of those self-rocking chairs. A mostly empty shelf sits against one wall.",0

; + look baby (lady there)
.byte "Peasant babies are pretty",13
.byte "freaking adorable. This",13
.byte "little guy's no exception.",0

; + look chair
.byte "One of those self-rocking",13
.byte "kind. Not bad for a",13
.byte "brown-collar peasant-type.",13
.byte "Must be trickle-down in",13
.byte "action.",0

; + look feed
.byte "Cool Ranch. Your old",13
.byte "favorite.",0

; + look hay
.byte "Hay is for horses!",0
 
; + look lady/woman (while she's still there)
.byte "Typical pasty peasant",13
.byte "woman, overbearing and",13
.byte "judgemental. Obsessed",13
.byte "with goods and land.",0

; + look lady/woman (after she's gone)
.byte "I can't believe you thought you had a chance with her!/Dork!",0

; + look pillow
.byte "Swedish foam. Your",13
.byte "favorite.",0
 
; + look shelf
.byte "Nothing but a bag of",13
.byte "chicken feed.",0

; + talk
; + talk lady		WRONG IN WIKI
.byte 34,"Hello, I'm-",34," you start but",13
.byte "the lady cuts you off.",0
.byte 34,"Okay, here's why I let you",13
.byte "in here,",34," she explains. ",34,"My",13
.byte "husband got squished by",13
.byte "Trogdor. And to make",13
.byte "matters worse, the",13
.byte "insurance riches I got were",13
.byte "stolen by the Jhonka. Go",13
.byte "steal them back for us and",13
.byte "I'll give you something",13
.byte "great.",0

; + talk baby (before you get the baby)
.byte "You say some cute, stupid",13
.byte "stuff and the baby just",13
.byte "blows snot bubbles.",0

; + talk lady (after she's gone)
.byte "You'd call out her name and let it ring through the empty room, enveloping you in sorrow, but you don't actually know her name.",0

; +1 POINT!
; + get/take/steal chicken feed    [walks you to it]
.byte "You used to eat this stuff",13
.byte "like crazy when you were a",13
.byte "kid and your parents",13
.byte "weren't watching (which",13
.byte "was all too often). You",13
.byte "grab several large",13
.byte "handfuls.",0

; + get feed (after taking)  WIKI IS WRONG
.byte "You don't need any more. It",13
.byte "might give rise to old",13
.byte "temptations.",0

; + get baby (while she still has it) WIKI IS WRONG
.byte 34,"You wanna to be a part of",13
.byte "this family? GO GET US",13
.byte "THOSE RICHES!!",34," she",13
.byte "shrieks.",0

; + get chair (while she is there)
.byte "No. There's a big bag of",13
.byte "something in it. Oh, that's",13
.byte "the baby lady.",0

; + get chair (after she is gone)
.byte "No. Too big for pants.",0

; +5 POINTS
; + give riches
.byte 34,"My riches!!",34," she screams and snatches up every last gold coin. ",34,"Thanks, sucker! Here you go!",34," she shoves the baby into your hands and bolts out the door.",0
.byte "You later learn that she does this all the time and is wanted throughout the countryside. Those riches probably WERE the Jhonka's and who knows whose baby that is. Well, it's yours now.",0

; + ask about baby
.byte 34,"This little guy's all I",13
.byte "got left. If only someone",13
.byte "would steal back all our",13
.byte "riches from that",13
.byte "filthy Jhonka.",34,0

; + ask about fire       ; WIKI IS WRONG
.byte 34,"You need fire? A couple of",13
.byte "trees over near the",13
.byte "waterfall used to be on",13
.byte "fire. But now there's like",13
.byte "a signal lantern over there or",13
.byte "something.",34,0
.byte 34,"So should I ask that",13
.byte "signal lantern?",34," you ask.",0
.byte 34,"I dunno man! Whattaya want",13
.byte "from me?",34,0

; + ask about Jhonka
.byte 34,"That nasty thing killed my",13
.byte "husband and took my",13
.byte "riches!!",34,0
.byte 34,"I thought Trogdor killed",13
.byte "your husband,",34," you",13
.byte "interject.",0
.byte 34,"Oh right. Yeah. That's",13
.byte "what I said. Trogband",13
.byte "killed my husbdor.",34,0

; + ask about naked ned
.byte 34,"Don't talk about that",13
.byte "pervert in front of the",13
.byte " baby here.",34,0

; + ask about robe
.byte 34,"You can't have mine,",13
.byte "pervert! I'm not a nudist",13
.byte "peasant like that weirdo",13
.byte "over in west Peasantry!",34,0

; + ask about smell
.byte 34,"What smells is junior",13
.byte "here's drawers! I gotta",13
.byte "quit feeding him so much horse.",34,0
.byte 34,"And don't start asking me",13
.byte "for his diapers, sicko!",34,0

; + ask about trogdor
.byte "I hope you kill that",13
.byte "stupid dragon. My 'Wives of",13
.byte "Squished Peasants' support",13
.byte "group would bake you a Poor",13
.byte "Gary pie if you did.",34,0

; + ask about (unknown)
.byte 34,"I dunno what you're",13
.byte "talking about.",34,0

; + sleep
.byte "That's probably how the",13
.byte "first baby got here. Forget",13
.byte "it.",0

; + get gold/money
.byte "Um, that's chicken feed.",0

; + get hay
.byte "There's a huge bale a",13
.byte "couple of screens over from",13
.byte "here. Why bother stealing?",0

; + get stuff/food
.byte "Which foodstuffs?",0

; + get pillow
.byte "You don't have anywhere to",13
.byte "use it and it is rather",13
.byte "bulky, so you leave it.",0

; + give (anything not listed)
.byte 34,"We don't need that mess,",34,13
.byte "she says.",0

; + give trinket
.byte "'Did you find that thing in my yard?' she asks. 'I got that thing free in a box of Plaguezees. I need some FOR REAL riches!'",0

; + give trinket (after giving trinket to Mendelev)
.byte "'Why are you holding your hand out?' she asks. 'I told you I need riches, so I can't give em away.' You don't have a trinket to give, you realize.",0

; + give riches (after giving the riches)
.byte "We did that already, and it was sort of humiliating.",0

; + give riches (before getting the riches)
.byte 34,"That's right,",34," she",13
.byte "whines. ",34,"Find my riches,",13
.byte "and give here.",34,0

; + (leaving) [check if this is different before you talk to her]
.byte "The baby lady calls after",13
.byte "you, ",34,"Hey, you're on some",13
.byte "quest right? Well, the",13
.byte "little squirt here lost",13
.byte "something of mine in the",13
.byte "yard the other day. It's",13
.byte "yours if you can find it.",34,0

; + (leaving after she's gone)
.byte "This place is dead anyway.",0

;==================
; Inside Giant Inn
;==================

; Type any command while the pot of horse grease is on your head
.byte "You need to get out of there before that smelly octogenarian gets back.",0

; + look
.byte "What a dump! Only one bed",13
.byte "and no minibar? The",13
.byte "Innkeeper stands behind a",13
.byte "desk and there's a door",13
.byte "that's closed.",0

; + look (night)
.byte "It's still dark out. The grimey old Innkeeper is gone and he left the pantry open.",0

; + look window
.byte "Check it out! There's a",13
.byte "Peasantry out there!",0

; + talk man
.byte 34,"If you're interested in",13
.byte "staying the night, just",13
.byte "type 'get a room.'",34,0

; + give baby (before you get the baby)
.byte "You have no baby nor any",13
.byte "immediate prospects.",0

; +5 POINTS
; + give/use baby (by desk)
.byte 34,"Well lookit that little guy!",34," says the Innkeeper. ",34,"You want a treat, do ya? What do babies like?",34," He fishes around in his pockets.",0
.byte 34,"Um, how bout my medication!",34," You grab the bottle of pills before he can force them on the baby. ",34,"Hey, those were for him!",34,0

; + give baby (when you already have the pills)
.byte "You already milked that fogey for all the pills he's worth.",0

; + get a room (without robe)	
.byte 34,"I only serve peasants",13
.byte "here, fancypants!",34," barks",13
.byte "the old guy. ",34,"Where's your",13
.byte "robe?",34,0

; +3 POINTS
; + get room (with robe)
.byte 34,"Okay, youngster,",34," says the decrepit old person. ",34,"Just bed on down for the night and I'm sure I'll remember to collect the fee come morning.",34,0
.byte "Night falls like a bad power point presentation.",0
.byte "What an uncomfortable bed! You sleep for maybe 20 minutes before the extreme pain in your spine forces you to get up.",0

; + get a room (when on fire)
.byte 34,"Board of Peasant Health says I can't serve any folk that's on fire. Nothing personal. Well, I mean, I don't like you much anyway.",34,0

; +2 POINTS
; + get/take/steal pot
.byte "You reach way up to the top shelf.",0
.byte "Oh great! Now you can't see a thing and your head is covered in highly flammable horse grease. You better get out of here before that disgusting old man comes back.",0

; + get bell (after getting a room)
.byte "You can't. It looks like it's been somehow olded to the desk.",0

; + get candle (at night)
.byte "It seems like you should be able to do that, doesn't it? Sorry. No dice.",0

; + get grease (at night, already have it)
.byte "You already have a nice greasy swab of it on the corner of your hood.",0

; + get old man rub (in the inn ?? when)
.byte "You disgust me.",0

; + get paper
.byte "Naw, it might be important",13
.byte "to that wrinkly old loon.",0

; + get painting		; WIKI IS WRONG
.byte "Weird. It's actually just",13
.byte "painted right onto the",13
.byte "wall. Like, the frame and",13
.byte "everything.",0

; + get pot (if you already have it)
.byte "You already have a nice greasy swab of it on the corner of your hood.",0

; + get rug
.byte "You're not touching that",13
.byte "thing. Too many",13
.byte "questionable stains on it.",0

; + (exiting inn with pot on head)
.byte "Phew! You discard the big black pot and wipe the horse grease from your eyes. The hood of your robe is still covered in highly flammable horse grease, though.",0

; + ask about fire
.byte 34,"I've always preferred",13
.byte "being on fire at night.",13
.byte "Looks prettier and keeps",13
.byte "the butterflies away.",34,0

; + ask about naked ned
.byte 34,"He used to be such a nice,",13
.byte "clothed young man. Wonder",13
.byte "what he's done with all his",13
.byte "old clothes?",34,0

; + ask about robe
.byte 34,"I wear my robe hood-down",13
.byte "so it's easier to trim my",13
.byte "ear hairs. If you need a",13
.byte "robe, maybe try someone",13
.byte "that's not using theirs.",34,0
 

; + ask about smell
.byte 34,"Well, if you don't stink,",13
.byte "maybe find something that",13
.byte "does and wear it. Like a",13
.byte "dead carcass or summat.",34,0 

; + ask about trogdor
.byte 34,"Are you talking about that",13
.byte "young green boy that lives",13
.byte "up the street? He's always",13
.byte "tearing my roof off and",13
.byte "eating my customers.",34,0

; + ask about (unknown)
.byte 34,"I don't know nothing about",13
.byte "no whatever you just said.",34,0

; + ring bell
.byte "Instead of ringing or",13
.byte "dinging, it just goes",13
.byte "'DUNG.'",0
 
; + light candle (at night)
.byte "It seems like you should be able to do that, doesn't it? Sorry. No dice.",0

; + open door (before getting room)
.byte 34,"That's the pantry,",34," says",13
.byte "the Innkeeper. ",34,"Employees",13
.byte "only.",34,0

; + sleep/sleep on bed (man is there)
.byte "You probably want to talk",13
.byte "to that stinky old guy over",13
.byte "there about that.",0

; + get doing-sproings
.byte "That's the worst thing",13
.byte "anyone has ever tried to",13
.byte "type in this game.  Ever.",0

; + get pillow
.byte "Not a chance. There's even",13
.byte "more questionable stains",13
.byte "on that pillow than there",13
.byte "are on that rug.",0

; + look man
.byte "He's an older peasant with",13
.byte "big cotton swabs stuffed up",13
.byte "his nose. Oh wait. Those",13
.byte "are nose hairs. Grody.",0

; + look painting
.byte "It's a painting of dogs",13
.byte "playing 'Magic: The",13
.byte "Nerdening.'",0

; + look paper
.byte "It says, ",34,"Note to self:",13
.byte "Wave arms wildly!",34,0

; + look pillow
.byte "If you sleep in that bed,",13
.byte "you're NOT putting your",13
.byte "head on that nasty pillow.",0

; + look pot (after getting a room)
.byte "It's full of horse grease. I guess that sounds useful.",0

; + look rug
.byte "Maybe that used to be a",13
.byte "magic carpet. But it's sure",13
.byte "a cat pee-stained carpet",13
.byte "now.",0

; + look bed
.byte "Is that just a fitted sheet",13
.byte "over a slab of concrete?",0

; + look bell
.byte "Tis broked.",0

; + look candle (after getting a room)
.byte "That candle's not at all on fire.",0

; + look desk (man there)
.byte "There's a broken bell and",13
.byte "a piece of parchment on",13
.byte "there. And some crazy old",13
.byte "guy behind it.",0

; + look desk (night?)
.byte "There's a broken bell and",13
.byte "a piece of parchment on",13
.byte "there.",0

;===================================
; Inside Mysterious (Ned's) Cottage
;===================================

; + look
.byte "This place could use some serious sprucing of the 'up' variety. There's a dresser over there and a broom kind of silhouetted all mysterious like.",0

; + look broom
.byte "The broom is all black and artistic, implying perhaps that it is closer to the viewer's eye but unlit to avoid emphasis.",0

; + look drawer/dresser (closed)
.byte "This dresser needs a good wipe down with new Indenture(tm), the dust busting miracle spray.",0
.byte "There is an especially enticing top drawer that is currently closed.",0

; + look drawer/dresser (open)
.byte "This dresser needs a good wipe down with new Indenture(tm), the dust busting miracle spray.",0
.byte "There is a drawer open and there are some brown lumpy clothes in it.",0

; + look drawer/dresser (after robe)
.byte "This dresser needs a good wipe down with new Indenture(tm), the dust busting miracle spray.",0
.byte "There is a drawer open, but it's empty.",0

; + open drawer (it's closed, not taken)
.byte "There's a vintage peasant robe in there! Just like grampa used to wear.",0

; + open drawer (it's open)
.byte "Yeah, totally! Except it's already open you moron.",0

; + open drawer (after getting robe and closing)
.byte "You already closed it, which was nice, and so we gave you some points. Let sleeping drawers lie.",0

;+1 POINT
; + close drawer
.byte "Aww, how thoughtful and boring of you. Break into this peasant's home, steal his clothes, but remember to tidy up after yourself. You're a real saint.",0

; + close drawer (w/o taking robe)
.byte "Right, right. Wouldn't want to leave the robes out where any old guy trying to beat an adventure game could take them.",0

; + close drawer (already closed)
.byte "A riddle: What can be closed that is already closed? (hint: not this drawer)",0

; +10 points
; + get robe
.byte "Yeah! Get that robe!",0

; + get/take robe (after you've gotten it)
.byte "You still remember the time when you took them. Oh, the times have changed ... but the robes?",0

; + get/take robe (drawer closed)
.byte "You reach into the closed drawer and nearly break your hand slamming it. Just like a bird on a pane of glass minus the blamelessness.",0

; + get/take drawer/dresser
.byte "You get a hernia from lifting it. -2 Movement points, -10 Constitution. Don't do that again.",0

; + get/take broom
.byte "No, no. The broom is in the foreground and you can't take things from the foreground. You don't see me all typing 'get browser window', do you?",0
