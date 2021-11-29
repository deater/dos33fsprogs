inside_dialog_start:

;================
; Hidden Glen
;================

; (Walk in the path of Dongolev's arrows)
hidden_glen_walk_in_way_message:
.byte "Hopefully this guy will",13
.byte "have some sense and not",13
.byte "shoot you.",0
; {Dongolev shoots you in the head}
hidden_glen_walk_in_way_message2:
.byte "That guy has no sense. He",13
.byte "shot you.",0
hidden_glen_walk_in_way_message3:
.byte "Dumb, dumb, dumb. Nice one,",13
.byte "William Tell. You dead.",13
.byte "Thanks for playing.",0

; +3 points
; + haldo / say haldo
hidden_glen_say_haldo_message:
.byte "The archer stops arching",13
.byte "and turns to you. ",34,"My",13
.byte "brother told you to tell me",13
.byte "haldo? He must want to",13
.byte "start the old business back",13
.byte "up!",34,0
; he walks off

; + haldo (before talking to Mendelev)
hidden_glen_say_haldo_skip_mendelev_message:
.byte "What'd you read that in",13
.byte "the PQ Stragedy Guide? Go",13
.byte "talk to my brother first.",0

; + haldo (after Dongolev leaves)
hidden_glen_say_haldo_no_dongolev_message:
.byte 34,"Haldo?",34,". you call out...",13
.byte 34,"Hadloooooo",34,0

; + look (with Dongolev)
hidden_glen_look_message:
.byte "Well, looky here! A hidden",13
.byte "glen! You LOVE hidden",13
.byte "glens. This one has some",13
.byte "kinda archer in it.",0

; + look (w/o Dongolev)
hidden_glen_look_no_dongolev_message:
.byte "You're in a hidden glen.",13
.byte "There's a tree with",13
.byte "zillions of arrows in it.",0
 
; + look archer (when there)
hidden_glen_look_at_archer_message:
.byte "He sure looks miffed at",13
.byte "that tree. He's emptied 5",13
.byte "good quivers' worth into",13
.byte "that poor thing.",0

; + look arrow (before taken)
hidden_glen_look_at_arrow_message:
.byte "Somebody call a tree",13
.byte "doctor. Them puppies are",13
.byte "stuck in there like a, um,",13
.byte "er ... stuck pig.",0

; + look bushes
hidden_glen_look_at_bushes_message:
.byte "There's some thick 'ol",13
.byte "bushes up in this hidden",13
.byte "glen.",0

; + look fence
hidden_glen_look_at_fence_message:
.byte "Wow! There's a hole in it",13
.byte "on THIS side too!",0

; + look tree
hidden_glen_look_at_tree_message:
.byte "Dude, and then the elf,",13
.byte "like, totally climbed up",13
.byte "it. It was awesome!",0

; + climb tree
hidden_glen_climb_tree_message:
.byte "Naw, you'd probably figure",13
.byte "out some way to kill",13
.byte "yourself doing that.",0

; + climb/jump fence
hidden_glen_climb_fence_message:
.byte "Not going to dignify that",13
.byte "with a response.",0

; + 2 points
; + get arrow
hidden_glen_get_arrow_message:
.byte "You pick out a really good",13
.byte "one and yank it from the",13
.byte "tree. Hooray! Now you have",13
.byte "an arrow!",0

; + get arrow (Dogolev there) (Warning: As you can see, this kills you.)
hidden_glen_active_range_message:
.byte "Something tells me now's",13
.byte "not a good time.",0
; {you get the arrow anyway and Dongolev shoots you}
; graphically, your head gets stuck to tree
hidden_glen_active_range_message2:
.byte "It wasn't a good time. Hey,",13
.byte "my mom's making",13
.byte "peasant-kabobs for dinner",13
.byte "TOO!",0
hidden_glen_active_range_message3:
.byte "Right. Anyway. You dead.",13
.byte "Thanks for playing, and try",13
.byte "not to die.",0

; + get arrow (After you get the arrow OR get arrow from after Kerrek)
hidden_glen_get_arrow_full_message:
.byte "You're pretty much all set",13
.byte "on the arrow front. They",13
.byte "are kinda cool, though.",0

; + get arrow (after killing Kerrek)
hidden_glen_get_arrow_another_message:
.byte "You grab yet another arrow",13
.byte "from the tree hoping to get",13
.byte "some bonus points.",0

; + talk archer (NOT IN WIKI)
hidden_glen_talk_archer_message:
.byte "He refuses to speak with",13
.byte "you. He just keeps firing",13
.byte "arrows into that tree and",13
.byte "grumbling, ",34,"stupid",13
.byte "Mendelev. grumble mumble.",34,0


;==========================
; Inside Baby Lady Cottage
;==========================

; + look
inside_cottage_look_at_message:
.byte "What a depressing little",13
.byte "cottage. It reeks of single",13
.byte "parent. A lady rocks her",13
.byte "baby in a chair. A mostly",13
.byte "empty shelf sits against",13
.byte "one wall.",0

; + look (after lady leaves)
inside_cottage_look_at_gone_message:     
.byte "What a depressing little",13
.byte "cottage. It reeks of single",13
.byte "parent. There is one of",13
.byte "those self-rocking chairs.",13
.byte "A mostly empty shelf sits",13
.byte "against one wall.",0

; + look baby (lady there)
inside_cottage_look_at_baby_message:
.byte "Peasant babies are pretty",13
.byte "freaking adorable. This",13
.byte "little guy's no exception.",0

; + look baby (lady gone)
;   calls the default you no-longer have an item code

; + look chair
inside_cottage_look_at_chair_message:
.byte "One of those self-rocking",13
.byte "kind. Not bad for a",13
.byte "brown-collar peasant-type.",13
.byte "Must be trickle-down in",13
.byte "action.",0

; + look feed
inside_cottage_look_at_feed_message:
.byte "Cool Ranch. Your old",13
.byte "favorite.",0

; + look hay
inside_cottage_look_at_hay_message:
.byte "Hay is for horses!",0
 
; + look lady/woman (while she's still there)
inside_cottage_look_at_lady_message:
.byte "Typical pasty peasant",13
.byte "woman, overbearing and",13
.byte "judgemental. Obsessed",13
.byte "with goods and land.",0

; + look lady/woman (after she's gone)
inside_cottage_look_at_lady_gone_message:
.byte "I can't believe you thought",13
.byte " you had a chance with her!",0
inside_cottage_look_at_lady_gone2_message:
.byte "Dork!",0

; + look pillow
inside_cottage_look_at_pillow_message:
.byte "Swedish foam. Your",13
.byte "favorite.",0
 
; + look shelf
inside_cottage_look_at_shelf_message:
.byte "Nothing but a bag of",13
.byte "chicken feed.",0

; + talk
; + talk lady		WRONG IN WIKI
inside_cottage_talk_lady_message:
.byte 34,"Hello, I'm-",34," you start but",13
.byte "the lady cuts you off.",0
inside_cottage_talk_lady2_message:
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

; + talk lady (after she's gone)
inside_cottage_talk_lady_gone_message:
.byte "You'd call out her name and",13
.byte "let it ring through the",13
.byte "empty room, enveloping you",13
.byte "in sorrow, but you don't",13
.byte "actually know her name.",0

; + talk baby (before you get the baby) (Also after (bug?))
inside_cottage_talk_baby_message:
.byte "You say some cute, stupid",13
.byte "stuff and the baby just",13
.byte "blows snot bubbles.",0


; +1 POINT!
; + get/take/steal chicken feed    [walks you to it]
inside_cottage_get_feed_message:
.byte "You used to eat this stuff",13
.byte "like crazy when you were a",13
.byte "kid and your parents",13
.byte "weren't watching (which",13
.byte "was all too often). You",13
.byte "grab several large",13
.byte "handfuls.",0

; + get feed (after taking)  WIKI IS WRONG
inside_cottage_get_feed_already_message:
.byte "You don't need any more. It",13
.byte "might give rise to old",13
.byte "temptations.",0

; + get baby (while she still has it) WIKI IS WRONG
inside_cottage_get_baby_message:
.byte 34,"You wanna to be a part of",13
.byte "this family? GO GET US",13
.byte "THOSE RICHES!!",34," she",13
.byte "shrieks.",0

; + get chair (while she is there)
inside_cottage_get_chair_message:
.byte "No. There's a big bag of",13
.byte "something in it. Oh, that's",13
.byte "the baby lady.",0

; + get chair (after she is gone)
inside_cottage_get_chair_gone_message:
.byte "No. Too big for pants.",0

; + get gold/money
inside_cottage_get_gold_message:
.byte "Um, that's chicken feed.",0

; + get hay
inside_cottage_get_hay_message:
.byte "There's a huge bale a",13
.byte "couple of screens over from",13
.byte "here. Why bother stealing?",0

; + get stuff/food
inside_cottage_get_food_message:
.byte "Which foodstuffs?",0

; + get pillow
inside_cottage_get_pillow_message:
.byte "You don't have anywhere to",13
.byte "use it and it is rather",13
.byte "bulky, so you leave it.",0

; +5 POINTS, get baby
; + give riches
inside_cottage_give_riches_message:
.byte 34,"My riches!!",34," she screams",13
.byte "and snatches up every last",13
.byte "gold coin. ",34,"Thanks,",13
.byte "sucker! Here you go!",34," she",13
.byte "shoves the baby into your",13
.byte "hands and bolts out the door.",0

inside_cottage_give_riches2_message:
.byte "You later learn that she",13
.byte "does this all the time and",13
.byte "is wanted throughout the",13
.byte "countryside. Those riches",13
.byte "probably WERE the Jhonka's",13
.byte "and who knows whose baby",13
.byte "that is. Well, it's yours",13
.byte "now.",0

; + give riches (before getting the riches)
inside_cottage_give_riches_notyet_message:
.byte 34,"That's right,",34," she",13
.byte "whines. ",34,"Find my riches,",13
.byte "and give here.",34,0

; + give riches (after giving the riches)
inside_cottage_give_riches_already_message:
.byte "We did that already, and it",13
.byte "was sort of humiliating.",0

; + give trinket
inside_cottage_give_trinket_message:
.byte 34,"Did you find that thing in",13
.byte "my yard?",34," she asks. ",34,"I got",13
.byte "that thing free in a box of",13
.byte "Plaguezees. I need some FOR",13
.byte "REAL riches!",34,0

; + give trinket (after giving trinket to Mendelev)
inside_cottage_give_trinket_nohave_message:
.byte 34,"Why are you holding your",13
.byte "hand out?",34," she asks. ",34,"I",13
.byte "told you I need riches, so",13
.byte "I can't give em away.",34,0
inside_cottage_give_trinket_nohave2_message:
.byte "You don't have a trinket to",13
.byte "give, you realize.",0

; + give trinket (after she's gone) WIKI is WRONG
inside_cottage_give_trinket_nolady_message:
.byte "She's done left you. And",13
.byte "she ain't coming back. No",13
.byte "how. no never.",0

; + give (anything not listed)
inside_cottage_give_default_message:
.byte 34,"We don't need that mess,",34,13
.byte "she says.",0

; + ask about baby
inside_cottage_ask_baby_message:
.byte 34,"This little guy's all I",13
.byte "got left. If only someone",13
.byte "would steal back all our",13
.byte "riches from that",13
.byte "filthy Jhonka.",34,0

; + ask about fire       ; WIKI IS WRONG
inside_cottage_ask_fire_message:
.byte 34,"You need fire? A couple of",13
.byte "trees over near the",13
.byte "waterfall used to be on",13
.byte "fire. But now there's like",13
.byte "a signal lantern over there",13
.byte "or something.",34,0

inside_cottage_ask_fire2_message:
.byte 34,"So should I ask that",13
.byte "signal lantern?",34," you ask.",0

inside_cottage_ask_fire3_message:
.byte 34,"I dunno man! Whattaya want",13
.byte "from me?",34,0

; + ask about Jhonka
inside_cottage_ask_jhonka_message:
.byte 34,"That nasty thing killed my",13
.byte "husband and took my",13
.byte "riches!!",34,0

inside_cottage_ask_jhonka2_message:
.byte 34,"I thought Trogdor killed",13
.byte "your husband,",34," you",13
.byte "interject.",0

inside_cottage_ask_jhonka3_message:
.byte 34,"Oh right. Yeah. That's",13
.byte "what I said. Trogband",13
.byte "killed my husbdor.",34,0

; + ask about naked ned
inside_cottage_ask_ned_message:
.byte 34,"Don't talk about that",13
.byte "pervert in front of the",13
.byte "baby here.",34,0

; + ask about robe
inside_cottage_ask_robe_message:
.byte 34,"You can't have mine,",13
.byte "pervert! I'm not a nudist",13
.byte "peasant like that weirdo",13
.byte "over in west Peasantry!",34,0

; + ask about smell
inside_cottage_ask_smell_message:
.byte 34,"What smells is junior",13
.byte "here's drawers! I gotta quit",13
.byte "feeding him so much horse.",34,0

inside_cottage_ask_smell2_message:
.byte 34,"And don't start asking me",13
.byte "for his diapers, sicko!",34,0

; + ask about trogdor
inside_cottage_ask_trogdor_message:
.byte 34,"I hope you kill that",13
.byte "stupid dragon. My 'Wives of",13
.byte "Squished Peasants' support",13
.byte "group would bake you a Poor",13
.byte "Gary pie if you did.",34,0

; + ask about (unknown)
inside_cottage_ask_unknown_message:
.byte 34,"I dunno what you're",13
.byte "talking about.",34,0

; + sleep
inside_cottage_sleep_message:
.byte "That's probably how the",13
.byte "first baby got here. Forget",13
.byte "it.",0

; + (leaving)
inside_cottage_leaving_message:
.byte "The baby lady calls after",13
.byte "you, ",34,"Hey, you're on some",13
.byte "quest right? Well, the",13
.byte "little squirt here lost",13
.byte "something of mine in the",13
.byte "yard the other day. It's",13
.byte "yours if you can find it.",34,0

; + (leaving after you got trinket)
inside_cottage_leaving_post_trinket_message:
.byte "This place is dead anyway.",0


;===================================
; Inside Mysterious (Ned's) Cottage
;===================================

;=========
; look

; + look
inside_nn_look_at_message:
.byte "This place could use some",13
.byte "serious sprucing of the",13
.byte "'up' variety. There's a",13
.byte "dresser over there and a",13
.byte "broom kind of silhouetted",13
.byte "all mysterious like.",0

; + look broom
inside_nn_look_brook_message:
.byte "The broom is all black and",13
.byte "artistic, implying perhaps",13
.byte "that it is closer to the",13
.byte "viewer's eye but unlit to",13
.byte "avoid emphasis.",0

; + look drawer/dresser (closed)
inside_nn_look_closed_drawer_message:
.byte "This dresser needs a good",13
.byte "wipe down with new",13
.byte "Indenture(tm), the dust",13
.byte "busting miracle spray.",13
.byte "There is an especially",13
.byte "enticing top drawer that is",13
.byte "currently closed.",0

; + look drawer/dresser (open)
inside_nn_look_open_drawer_message:
.byte "This dresser needs a good",13
.byte "wipe down with new",13
.byte "Indenture(tm), the dust",13
.byte "busting miracle spray.",13
.byte "There is a drawer open and",13	; actual game "openand"
.byte "there are some brown lumpy",13
.byte "clothes in it.",0

; + look drawer/dresser (open, after robe taken)
inside_nn_look_norobe_drawer_message:
.byte "This dresser needs a good",13
.byte "wipe down with new",13
.byte "Indenture(tm), the dust",13
.byte "busting miracle spray.",13
.byte "There is a drawer open, but",13
.byte "it's empty.",0

;======
; open

; + open drawer (it's closed, not taken)
inside_nn_open_closed_drawer_message:
.byte "There's a vintage peasant",13
.byte "robe in there! Just like",13
.byte "grampa used to wear.",0

; + open drawer (it's open)
inside_nn_open_open_drawer_message:
.byte "Yeah, totally! Except it's",13
.byte "already open you moron.",0

; + open drawer (after getting robe and closing)
inside_nn_open_empty_drawer_message:
.byte "You already closed it,",13
.byte "which was nice, and so we",13
.byte "gave you some points. Let",13
.byte "sleeping drawers lie.",0

;=========
; close

;+1 POINT
; + close drawer
inside_nn_close_empty_drawer_message:
.byte "Aww, how thoughtful and",13
.byte "boring of you. Break into",13
.byte "this peasant's home, steal",13
.byte "his clothes, but remember",13
.byte "to tidy up after yourself.",13
.byte "You're a real saint.",0

; + close drawer (w/o taking robe)
inside_nn_close_full_drawer_message:
.byte "Right, right. Wouldn't",13
.byte "want to leave the robes out",13
.byte "where any old guy trying to",13
.byte "beat an adventure game",13
.byte "could take them.",0

; + close drawer (already closed)
inside_nn_close_closed_drawer_message:
.byte "A riddle: What can be",13
.byte "closed that is already",13
.byte "closed? (hint: not this",13
.byte "drawer)",0

;============
; get

; +10 points
; + get/take robe (drawer must be open)
inside_nn_get_robe_message:
.byte "Yeah! Get that robe!",0

; + get/take robe (after you've gotten it)
inside_nn_get_robe_already_message:
.byte "You still remember the time",13
.byte "when you took them. Oh, the",13
.byte "times have changed ... but",13
.byte "the robes?",0

; + get/take robe (drawer closed, whether you have it or not)
inside_nn_get_robe_drawer_closed_message:
.byte "You reach into the closed",13
.byte "drawer and nearly break",13
.byte "your hand slamming it. Just",13
.byte "like a bird on a pane of",13
.byte "glass minus the",13
.byte "blamelessness.",0

; + get/take drawer/dresser
inside_nn_get_dresser_message:
.byte "You get a hernia from",13
.byte "lifting it. -2 Movement",13
.byte "points, -10 Constitution.",13
.byte "Don't do that again.",0

; + get/take broom
inside_nn_get_broom_message:
.byte "No, no. The broom is in the",13
.byte "foreground and you can't",13
.byte "take things from the",13
.byte "foreground. You don't see",13
.byte "me all typing ",34,"get",13
.byte "computer monitor",34,", do you?",0

inside_dialog_end:

.assert (>inside_dialog_end - >inside_dialog_start) < $1E , error, "inside dialog too big"
