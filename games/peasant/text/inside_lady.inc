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

