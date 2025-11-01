; start
FONT_DROP_LENGTH	= 60	; frames
; intro
TITLE_WAIT_TIME		= 5	; seconds
PEASANT_DOOR_WAIT	= 1	; seconds
PEASANT_MESSAGE_WAIT	= 2	; seconds

; Monsters
MONSTER2_WAIT1		= 3	; seconds
MONSTER2_WAIT2		= 3	; seconds
; woz
NUM_ORBITS		= 2	; orbits
HGR8_LISTING_TIME	= 3	; seconds
HGR8_LENGTH		= 6	; frames
MARTY_LENGTH		= 64	; frames
; 4 color
PLASMA_LENGTH		= 100	; frames
SPLASHED_MESSAGE_TIME	= 3	; seconds

zp_save		= $c00

drop_yadd       = $800	; run at start? need 1k free?
drop_y          = $c00	; run at start? need 1k free?
div7_table	= $d00
mod7_table	= $e00

repack_src	= $a000

hposn_low       = $fd00
hposn_high      = $fe00


PART_MUSIC	=	0
PART_EXTRA	=	1
PART_INTRO	=	2
PART_MONSTERS	=	3
PART_WOZ	=	4
PART_FOURCOLOR	=	5
PART_CREDITS	=	6
PART_MONSTERS2	=	7
