LOAD_TITLE      =       0
LOAD_OUTSIDE	=	1
LOAD_PROJECTOR	=	2
LOAD_MAGSTEPS	=	3
LOAD_MAGLEV	=	4
LOAD_MOVIE1	=	5
LOAD_MOVIE2	=	6

div7_table     = $BC00
mod7_table     = $BD00
hposn_high     = $BE00
hposn_low      = $BF00


;=============================
; common stuff

;===============================================
; level data structure definitions
;===============================================
; 24 bytes each location
; we put special at end as it's ignored if not set

LOCATION_NORTH_EXIT=0			; new room when heading north
LOCATION_SOUTH_EXIT=1			; new room when heading south
LOCATION_EAST_EXIT=2			; new room when heading east
LOCATION_WEST_EXIT=3			; new room when heading west
LOCATION_NORTH_EXIT_DIR=4		; direction faced in new room when N
LOCATION_SOUTH_EXIT_DIR=5		; direction faced in new room when S
LOCATION_EAST_EXIT_DIR=6		; direction faced in new room when E
LOCATION_WEST_EXIT_DIR=7		; direction faced in new room when W
LOCATION_NORTH_BG=8			; pointer to north background image
LOCATION_SOUTH_BG=10			; pointer to south background image
LOCATION_EAST_BG=12			; pointer to east background image
LOCATION_WEST_BG=14			; pointer to west background image
LOCATION_BGS	= 16			; bitmap saying which backgrounds valid
	BG_NORTH = 1
	BG_SOUTH = 2
	BG_WEST = 4
	BG_EAST = 8
LOCATION_SPECIAL_EXIT=17		; if we have something clickable
					; $FF if not, direction if so
LOCATION_SPECIAL_X1=18			; collision box for the thing to click
LOCATION_SPECIAL_X2=19
LOCATION_SPECIAL_Y1=20
LOCATION_SPECIAL_Y2=21
LOCATION_SPECIAL_FUNC=22		; pointer-1 of function to call on click


;================================
; Level definitions

; Outside

RIVEN_MAGLEV1	=	0

; Projector

RIVEN_PROJECTOR	=	0
RIVEN_PROJ_DOOR	=	1

; Magsteps

RIVEN_MAGSTEPS2	=	0
RIVEN_MAGSTEPS3	=	1

; Maglev

RIVEN_LOOKIN	=	0
RIVEN_INSEAT	=	1
