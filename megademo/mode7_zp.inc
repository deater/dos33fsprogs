;; Zero page monitor routines addresses

;; Flying Routine Only

TURNING		=	$60
;SCREEN_X	=	$61		; not used?
SCREEN_Y	=	$62
ANGLE		=	$63
HORIZ_SCALE_I	=	$64
HORIZ_SCALE_F	=	$65
FACTOR_I	=	$66
FACTOR_F	=	$67
DX_I		=	$68
DX_F		=	$69
SPACEX_I	=	$6A
SPACEX_F	=	$6B
CX_I		=	$6C
CX_F		=	$6D
DY_I		=	$6E
DY_F		=	$6F
SPACEY_I	=	$70
SPACEY_F	=	$71
CY_I		=	$72
CY_F		=	$73
TEMP_I		=	$74
TEMP_F		=	$75
DISTANCE_I	=	$76
DISTANCE_F	=	$77
SPACEZ_I	=	$78
SPACEZ_F	=	$79
DRAW_SPLASH	=	$7A
SPEED		=	$7B
SPLASH_COUNT	=	$7C
OVER_LAND	=	$7D
NUM1L		=	$7E
NUM1H		=	$7F
NUM2L		=	$80
NUM2H		=	$81
RESULT		=	$82 ; 83,84,85
;NEGATE		=	$86			; UNUSED?
LAST_SPACEX_I	=	$87
LAST_SPACEY_I	=	$88
LAST_MAP_COLOR	=	$89
DRAW_SKY	=	$8A
COLOR_MASK	=	$8B
KEY_COUNT	=	$8C
KEY_OFFSET	=	$8D
DRAW_BLUE_SKY	=	$8E
RANDOM_POINTER	=	$8F

MB_DETECTED	= $96
WHICH_CHUNK	= $97


; More zero-page addresses
; we try not to conflict with anything DOS, MONITOR or BASIC related

COLOR1		=	$E0
COLOR2		=	$E1
MATCH		=	$E2
;XX		=	$E3


SHIPY           =     $E4

YADD		=	$E5
LOOP		=	$E6
MEMPTRL		=	$E7
MEMPTRH		=	$E8
NAMEL		=	$E9
NAMEH		=	$EA
NAMEX		=	$EB
CHAR		=	$EC


FIRST		=	$F0











