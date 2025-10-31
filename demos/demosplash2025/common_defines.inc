FONT_DROP_LENGTH	= 60	; frames
HGR8_LENGTH		= 8	; frames
MARTY_LENGTH		= 64	; frames
PLASMA_LENGTH		= 100	; frames


zp_save		= $c00

drop_y          = $c00	; run at start? need 1k free?
div7_table	= $d00
mod7_table	= $e00

drop_yadd       = $b800 ; extra only 6k so starting at 7k should be fine?

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
