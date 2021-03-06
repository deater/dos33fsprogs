;; Zero page monitor routines addresses

;; LZSA addresses
NIBCOUNT	= $00

WNDLFT	= $20
WNDWDTH	= $21
WNDTOP	= $22
WNDBTM	= $23
CH	= $24
CV	= $25
GBASL	= $26
GBASH	= $27
BASL	= $28
BASH	= $29
H2	= $2C
V2	= $2D
MASK	= $2E
COLOR	= $30
INVFLG	= $32

; More zero-page addresses
; we try not to conflict with anything DOS, MONITOR or BASIC related

;; Flying Routine Only

TURNING		=	$60
;SCREEN_X	=	$61		; not used?
SCREEN_Y	=	$62
ANGLE		=	$63
HORIZ_SCALE_I	=	$64
HORIZ_SCALE_F	=	$65

SCALE_I		=	$64
SCALE_F		=	$65

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
NEGATE		=	$86			; UNUSED?
LAST_SPACEX_I	=	$87
LAST_SPACEY_I	=	$88
LAST_MAP_COLOR	=	$89
COLOR_MASK	=	$8A

;; World Map Only

ODD             =     $7B
DIRECTION       =     $7C
REFRESH         =     $7D
ON_BIRD         =     $7E
MOVED           =     $7F
STEPS           =     $80
TFV_X           =     $81
TFV_Y           =     $82
NEWX            =     $83
NEWY            =     $84
MAP_X           =     $85
GROUND_COLOR    =     $86


LEVEL_OVER	=	$A0
JOYSTICK_ENABLED=	$A1
FRAMEL		=	$A2
FRAMEH		=	$A3
WHICH_LOAD	=	$A4
MENU_RESULT	=	$A5
SOUND_STATUS    =       $A6
	SOUND_DISABLED  = $80
	SOUND_IN_LC     = $01 ; $01 sound effects in language card
	SOUND_MOCKINGBOARD = $02 ; mockingboard detected
JS_BUTTON_STATE	=	$A7

CTEMP		=	$C0
COLOR1		=	$E0
COLOR2		=	$E1
MATCH		=	$E2
XX		=	$E3
YY		=	$E4
SHIPY           =	$E4
YADD		=	$E5
LOOP		=	$E6
;MEMPTRL		=	$E7
;MEMPTRH		=	$E8
NAMEL		=	$E9
NAMEH		=	$EA
NAMEX		=	$EB
CHAR		=	$EC
DISP_PAGE       =	$ED
DRAW_PAGE       =	$EE

FIRST		=	$F0
LASTKEY		=	$F1
PADDLE_STATUS	=	$F2
XPOS		=	$F3
YPOS		=	$F4
TEMP		=	$FA
RUN		=	$FA
TEMP2		=	$FB
TEMPY		=	$FB
INL		=	$FC
INH		=	$FD
OUTL		=	$FE
OUTH		=	$FF






; read any file slot 6 version
; based on FASTLD6 and RTS copyright (c) Peter Ferrie 2011-2013,2018

; modified to assemble with ca65 -- vmw
; added code to patch it to run from current disk slot -- vmw


        adrlo   =       $26     ; constant from boot prom
        adrhi   =       $27     ; constant from boot prom
        tmpsec  =       $3c     ; constant from boot prom
        reqsec  =       $3d     ; constant from boot prom
        sizelo  =       $44
        sizehi  =       $45
        secsize =       $46

        ldsizel =       $70
        ldsizeh =       $71
        namlo   =       $7b
        namhi   =       $7c
        step    =       $7d     ; state for stepper motor
        tmptrk  =       $7e     ; temporary copy of current track
        phase   =       $7f     ; current phase for /seek

