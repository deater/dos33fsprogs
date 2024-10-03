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

