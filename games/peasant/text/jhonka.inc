;=============
; Jhonka cave
;=============

; + look (at anything, while hiding inside the bale of hay)
hay_look_while_in_hay_message:
.byte "Right now, you see a bunch",13
.byte "of hay.",0

; + (walk in haystack)
jhonka_in_hay_message:
.byte "Hey, nice disguise! The",13
.byte "Jhonka doesn't seem to",13
.byte "notice you.",0


; kerrek alive

; + look (kerrek alive)
jhonka_look_at_message:
.byte "There's a little cave with",13
.byte "a little door with a little",13
.byte "note on it.",0

; + look door (kerrek alive)		; not in WIKI
jhonka_look_at_door_message:
.byte "There's a little note on it.",0

; + look cave
jhonka_look_at_cave_message:
.byte "Just a little cave. Calm",13
.byte "down.",0

; + look fence
jhonka_look_at_fence_message:
.byte "A standard peasant fence.",13
.byte "Trogdor makes milk's meat",13
.byte "outta these things.",0

; + look/read note (before killing Kerrek) [ will walk to it if far away]
jhonka_read_note_message:
.byte "It says ",34,"scared of kerrek.",13
.byte "go way. -j",34,0

; + open door [ will walk you there] {before jhonka out, if jhonka out nothing)
jhonka_open_door_message:
.byte "It's locked. With one o'",13
.byte "them SCHLAGE deadbolts,",13
.byte "too. Those things are hard",13
.byte "core.",0


; + knock (while he's inside) [ will walk over]
jhonka_knock_message1:
.byte "A gravelly voice inside",13
.byte "yells,  'JUST US CHICKENS'",0

jhonka_knock_message2:
.byte "A gravelly voice inside",13
.byte "yells, 'NO FOR RENT'",0

jhonka_knock_message3:
.byte "A gravelly voice inside",13
.byte "yells, 'I GIVE LAST YEAR!'",0

jhonka_knock_message4:
.byte "A gravelly voice inside",13
.byte "yells, 'GAVE AT OFFICE'",0

jhonka_knock_message5:
.byte "A gravelly voice inside",13
.byte "yells, 'GO WAY!'",0

; + get note (kerrek alive)
jhonka_get_note_message:
.byte "It's been magically sealed",13
.byte "to the door with a",13
.byte "wondrously whimsical spell.",0

; + climb/jump fence
jhonka_climb_fence_message:
.byte "No, you have business to",13
.byte "attend to here in",13
.byte "Peasantry.",0


;================================
; kerrek dead


; + look (kerrek dead, before riches)
jhonka_look_at_with_riches_message:
.byte "There's a disgusting",13
.byte "little Jhonka hopping",13
.byte "around outside a little",13
.byte "cave.A fat pile of riches",13
.byte "lies next to him.",0

; + look (after kerrek dead, after take riches)
jhonka_look_at_no_riches_message:
.byte "There's a disgusting",13
.byte "little Jhonka hopping",13
.byte "around outside a small",13	; WIKI wrong
.byte "cave.",0


; + look club/turkey leg (when he's outside)
jhonka_look_at_club_message:
.byte "Turkey leg or no, it looks",13
.byte "like the Jhonka's been",13
.byte "gnawing on it.",0

; + look cave
; same as alive

; + look door (after kerrek)		; not in WIKI
jhonka_look_at_door_out_message:
.byte "Just a door, nothing more.",0

; + look riches (if riches are there)
jhonka_look_at_riches_message:
.byte "That's one fat pile of",13
.byte "riches alright.",0

; + look fence
; same as alive

; + look jhonka (when he's outside)
jhonka_look_at_jhonka_out_message:
.byte "The Jhonka is gray and",13
.byte "grody. He's got a cromagnon",13
.byte "forehead and jaw with a",13
.byte "pair of wicked incisors. He",13
.byte "sports an old loin-cheese",13
.byte "cloth and carries either",13
.byte "a big club or one of those",13
.byte "roasted turkey legs you got",13
.byte "at the Ren Fest.",0


; + get club / leg  (when he's out)
jhonka_get_club_message:
.byte "Now there's a surefire way",13
.byte "to get yourself killed.",0

; + get riches (before jumping in hay, also even after taking them)
jhonka_get_riches_no_hay_message:
.byte "The Jhonka will see you!",13
.byte "And rip out your jugular",13
.byte "with his teeth or something",13
.byte "equally horrible.",0

; + steal/get riches (in hay)
jhonka_steal_riches_message:
.byte "Oh OH! A stiff breeze blew",13
.byte "all the hay and,",13
.byte "surprisingly, the mud off",13
.byte "of you! ",34,"You take my",13
.byte "riches?!",34," growls the",13
.byte "Jhonka.",0


; + 7 POINTS
; + no
jhonka_no_message:
.byte 34,"Okay. Lemme know if you",13
.byte "see riches anywhere,",34," he",13
.byte "grunts and goes back to his",13
.byte "hopping. You smooth",13
.byte "talker, you.",0

; + yes (to the Jhonka when he asks you about his riches)
jhonka_yes_message:
.byte 34,"I KILL YOU!!",34," screams the",13
.byte "Jhonka.",0

; {The Jhonka clubs you to death}  (Warning: Obviously, you will die.) 
jhonka_yes_message2:
.byte "Club or turkey leg, the",13
.byte "Jhonka sure just beat you",13
.byte "senseless with whatever he",13
.byte "was holding. You dead.",13
.byte "Thanks for playing!",0

; + Type any command other than "yes" or "no" 
; after the Jhonka asks if you stole the riches
; you can't walk while waiting here
jhonka_answer_him_message:
.byte "Just answer him, yes or no,",13
.byte "you fool!",0


; + ask about fire
jhonka_ask_about_fire_message:
.byte 34,"Burninator make fire!",13
.byte "Barbecue all peasants!",34,0

; + ask about Jhonka
jhonka_ask_about_jhonka_message:
.byte 34,"The Kerrek is dead!",34," he",13
.byte "cries and hops around some",13
.byte "more. You wonder how",13
.byte "someone this primitive",13
.byte "could have made that much",13
.byte "dough.",0

; + ask about naked ned (or) robe
jhonka_ask_about_ned_message:
.byte 34,"Filthy naked peasant!",13
.byte "Stay away from my",13
.byte "cave-hole!",34," Who's he",13
.byte "calling naked? HE'S the one",13
.byte "wearing the string bikini.",0

; + ask about smell
jhonka_ask_about_smell_message:
.byte 34,"Kerrek smell! Now Kerrek",13
.byte "dead!",34," screeches the",13
.byte "Jhonka. So you can infer",13
.byte "from this that all smells",13
.byte "are dead? You always sucked",13
.byte "at the analytical",13
.byte "questions.",0

; + ask about trogdor
jhonka_ask_about_trogdor_message:
.byte 34,"All hail Burninator!",13
.byte "Trogdor Number One! Beat",13
.byte "Peasant Tech!",34," says the",13
.byte "grimy Jhonka.",0

; + ask about (unknown)
jhonka_ask_about_unknown_message:
.byte 34,"Jhonka don't know nothing",13
.byte "bout that!",34,0

; + kill jhonka (outside)
jhonka_kill_message:
.byte "No way! Jhonka's are born",13	; [sic]
.byte "scrappers. He may be",13
.byte "little, but he'll crawl ya.",0

; + give / give {anything}
jhonka_give_message:
.byte 34,"Don't need nothing from no",13
.byte "filthy peasantses!!",34,0

; + talk jhonka (while inside the hay)
jhonka_talk_in_hay_message:
.byte "Not now! You'll blow your",13
.byte "cover!",0

; + talk
; + talk jhonka (jhonka there, not in hay)
; same as ask about jhonka
;.byte 34,"The Kerrek is dead!",34," he",13
;.byte "cries and hops around some",13
;.byte "more. You wonder how",13
;.byte "someone this primitive",13
;.byte "could have made that much",13
;.byte "dough.",0

; + climb/jump fence
; same as alive

