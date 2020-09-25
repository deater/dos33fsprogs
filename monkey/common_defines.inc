;=============================
; common stuff

VERB_GIVE	= 0
VERB_OPEN	= 1
VERB_CLOSE	= 2
VERB_PICK_UP	= 3
VERB_LOOK_AT	= 4
VERB_TALK_TO	= 5
VERB_USE	= 6
VERB_PUSH	= 7
VERB_PULL	= 8 
VERB_WALK	= 9

;===============================================
; level data structure definitions
;===============================================

LOCATION_BACKGROUND=0			; background
LOCATION_DESTINATION = 2
LOCATION_EXIT	= 4
LOCATION_SIZE	= 6
LOCATION_NUM_AREAS=7
LOCATION_AREAS=8			; each area 8 in size


;================================
; Loader definitions

LOAD_TITLE	= 0
LOAD_MONKEY	= 1

;================================
; Level definitions

; Title

; Monkey

MONKEY_LOOKOUT		=	0
MONKEY_POSTER		=	1
MONKEY_DOCK		=	2
MONKEY_BAR		=	3
MONKEY_TOWN		=	4
MONKEY_MAP		=	5
MONKEY_BAR_INSIDE1	=	6
MONKEY_BAR_INSIDE2	=	7
MONKEY_CHURCH		=	8
MONKEY_MANSION_PATH	=	9
MONKEY_MANSION		=	10
MONKEY_ZIPLINE		=	11
