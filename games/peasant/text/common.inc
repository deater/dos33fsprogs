;==================
; Anywhere
;==================

; Type any command while the pot of horse grease is on your head
inside_inn_pot_on_head_message:
.byte "You need to get out of",13
.byte "there before that smelly",13
.byte "octogenarian gets back.",0

; After jumping in the haystack, go to any screen except Jhonka
; both hay and mud go away
hay_blown_away_message:
.byte "Drat. The winds are heavy",13
.byte "on all but a couple of key",13
.byte "screens... looks like",13
.byte "you're no longer in stealth",13
.byte "mode.",0

; TODO
; when it's night
; after you've walked through (???) screens?
; unclear how this works
.byte "Man, screens sure get light",13
.byte "fast around here.",0

; + get/wear belt (after getting it)
wear_belt_message:
.byte "You're already wearing it.",13
.byte "Too bad you smell like the",13
.byte "trash barge off Peasant",13
.byte "Isle.",0

; + wear mask (after getting it)
wear_mask_message:
.byte "Not on this screen. You've",13
.byte "got your image to think",13
.byte "about. Actually, you might",13
.byte "want to start deliberating",13
.byte "on that right now.",0

; +3 points
; + wear robe (after getting it)
wear_robe_message:
.byte "You slip into the vintage",13
.byte "robe. It smells like",13
.byte "grampa's lap. Now you're",13
.byte "lookin like a serious",13
.byte "peasant.",0

; + wear robe (already wearing)
wear_robe_already_message:
.byte "You're already in the old",13
.byte "skool robe. Represent.",0

; + wear robe (not in inventory)
wear_robe_none_message:
.byte "You don't have anything but",13
.byte "your 'Scalding Lake'",13
.byte "t-shirt.",0

wear_robe_none_message2:
.byte "And pants. Forgot to",13
.byte "mention the pants.",0
 
; + look trees
look_trees_message:
.byte "You are an incredibly",13
.byte "boring person.",0

; + ask about (unknown)
unknown_ask_message:
.byte "Ask about what?",0
 
; + boo
boo_message:
.byte "Scared me.",0

; + cheat
cheat_message:
.byte "Meh.",0

; + dan (or any phrase involving Dan; anywhere)
dan_message:
.byte "Dan's still okay. Got a",13
.byte "place on Dekalb with Rick",13
.byte "and his wife. Slimmed up a",13
.byte "bit and looking towards the",13
.byte "future.",0

; + dance (anywhere)
dance_message:
.byte "You'd rather just stand",13
.byte "here and soak up the scene.",0

; + die (anywhere) (Warning: This kills you.)
die_message:
.byte "That wasn't very smart. You",13
.byte "dead.",0

; + drink
drink_message:
.byte "For simplicity's sake you",13
.byte "are immune to hunger and",13
.byte "thirst in this game. So you",13
.byte "got that going for you.",0
drink_message2:
.byte "Which is nice.",0
 
; + quit  (Warning: The game actually does quit.) 
quit_message:
.byte "Well fine Boring Sanders!",13
.byte "Hope you saved your game",13
.byte "cause it is OVER between",13
.byte "us!",0

; + map (before you find it)
map_message:
.byte "We are neither confirming",13
.byte "nor denying the presence of",13
.byte "a map in this game, but",13
.byte "irridisregardless, you",13
.byte "don't have one.",0

; + party
party_message:
.byte "You are part of the Whig",13
.byte "party. They are making",13
.byte "gangrene-awareness their",13
.byte "number one campaign",13
.byte "priority.",0

; + what the f- / this sucks
what_message:
.byte "Come now. Don't get",13
.byte "discouraged.",0

; + where (offset 22)
where_message:
.byte "You're hanging out in",13
where_message_offset:
.byte "                         ",0

; + why
why_message:
.byte "I wish I knew.",0

; + haldo
haldo_message:
.byte "That's totally not",13
.byte "Dongolev.",0

; + smell/sniff
smell_message:
.byte "Smells like a computer",13
.byte "game.",0

; + pwd (offset 17)
pwd_message:
.byte "~peasantsquest/",13
pwd_message_offset:
.byte "                         ",0

; + go _____
go_message:
.byte "Use the arrow keys, pal.",13
.byte "Just like a joypad only",13
.byte "more like your day job.",0

; + ditch/drop baby (if you have it)
ditch_baby_message:
.byte "Quit tryin to ditch the baby!",0

; + ditch/drop/deploy/use baby (after baby left)
; + drop baby, throw baby (before getting the baby)
no_baby_message:
.byte "You don't even have two",13
.byte "babies to rub together.",0

; + climb cliff (screens where cliff is there [pass doesn't count?])
climb_cliff_message:
.byte "There aren't enough",13
.byte "footholds and you don't",13
.byte "have any carabeaners on",13
.byte "you.",0

; + climb tree
climb_tree_message:
.byte "But then your hands would",13
.byte "get all sappy.",0

; + climb tree (after getting room at inn)
.byte "Naw. That's dumb. Do better.",0

; ???? steal
; + get/take
get_message:
.byte "You probably WISH you could",13
.byte "get that.",0

; + get pebbles/rocks (after you've gotten them)
get_pebbles_message:
.byte "Come now. We've been",13
.byte "through this jaunty little",13
.byte "bit before. You took them",13
.byte "from the half lake screen",13
.byte "with the cattail and stuff.",0

; + give
give_message:
.byte "You don't need to give",13
.byte "that now.",0

; + throw baby (anywhere but the west side of the lake)
.byte "Hmmm. Maybe try someplace else.",0

; + talk
talk_noone_message:
.byte "It's sad when you have to",13
.byte "make up people to talk to.",0

; + look (at anything irrelevant)
look_irrelevant_message:
.byte "You don't need to look at",13
.byte "that.",0

; + look (at something previously in your inventory but now gone)
.byte "You used to have one,",13
.byte "before the great item",13
.byte "blight of 402. Check your",13
.byte "INVENTORY to read about it.",0

; + look (at something currently in your inventory)
.byte "You've totally got one of",13
.byte "those! Check your",13
.byte "INVENTORY to give'r a",13
.byte "serious looksee.",0

; + load
; + save
; + show priority
; + version
; + copy

unknown_message:
.byte "I don't understand. Type",13
.byte "HELP for assistances.",0

help_message:
.byte "Type LOOK to see your",13
.byte "surroundings.  Type",13
.byte "INVENTORY or INV to see",13
.byte "your stuff. Type WHERE to",13
.byte "see the name of the place",13
.byte "you're in. Type SAVE or",13
.byte "LOAD to save or load your",13
.byte "game.",0
