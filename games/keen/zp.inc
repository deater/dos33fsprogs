;; Zero Page

;; ZX02 addresses

ZP=$00

offset          = ZP+0
ZX0_src         = ZP+2
ZX0_dst         = ZP+4
bitr            = ZP+6
pntr            = ZP+7



;; Zero page monitor routines addresses

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
X_LEFT	= $2C
V2	= $2D
MASK	= $2E
COLOR_MASK = $2F
COLOR	= $30

SEEDL	= $4e
SEEDH	= $4f
XMAX	= $50



; MIST zero page addresses

FRAMEL			= $60
FRAMEH			= $61
;CURSOR_X		= $62
;CURSOR_Y		= $63
XPOS			= $64
YPOS			= $65
LOCATION_STRUCT_L	= $66
LOCATION_STRUCT_H	= $67
IN_SPECIAL		= $68
CURSOR_VISIBLE		= $69
IN_LEFT			= $6A
IN_RIGHT		= $6B
BTC_L			= $6C
BTC_H			= $6D

; pt3 player registers
REGISTER_DUMP   = $70
AY_REGISTERS    = $70
A_FINE_TONE     = $70
A_COARSE_TONE   = $71
B_FINE_TONE     = $72
B_COARSE_TONE   = $73
C_FINE_TONE     = $74
C_COARSE_TONE   = $75
NOISE           = $76
ENABLE          = $77
PT3_MIXER_VAL   = $77
A_VOLUME        = $78
B_VOLUME        = $79
C_VOLUME        = $7A
ENVELOPE_FINE   = $7B
ENVELOPE_COARSE = $7C
ENVELOPE_SHAPE  = $7D
COPY_OFFSET     = $7E
DECODER_STATE   = $7F

PATTERN_L       = $7E
PATTERN_H       = $7F


; note 70-7f also used by disk code

; note: rest are up at $f0

; We have to save/restore the following values
; when loading/storing from disk

WHICH_LOAD		= $80		; which file to load

KEEN_XL			= $81
KEEN_X			= $82		; location of protagonist
KEEN_Y			= $83
KEEN_DIRECTION		= $84
KEEN_WALKING		= $85
KEEN_JUMPING		= $86

LASER_OUT		= $87
LASER_X			= $88
LASER_Y			= $89
LASER_DIRECTION		= $8A
TILEMAP_X		= $8B
TILEMAP_Y		= $8C

KEEN_FOOT_OFFSET	= $8D

RAYGUNS			= $8E
KEYCARDS		= $8F
	INV_RED_KEY		= $01
	INV_BLUE_KEY		= $02
	INV_YELLOW_KEY		= $04
	INV_GREEN_KEY		= $08

KEENS			= $90
SCORE0			= $91
SCORE1			= $92
SCORE2			= $93

SHIP_PARTS		= $94
	PARTS_BOTTLE		= $01
	PARTS_VACUUM		= $02
	PARTS_BATTERY		= $04
	PARTS_JOYSTICK		= $08

KEEN_FALLING		= $95
KEEN_SHOOTING		= $96
KICK_UP_DUST		= $97
SUPPRESS_WALK		= $98
ENEMY_DATAL		= $99
ENEMY_DATAH		= $9A
POGO			= $9B
LASER_TILE		= $9C
TILE_TEMP		= $9D

TILEY			= $9E
TILE_ODD		= $9F
TILEMAP_OFFSET		= $A0

; done game puzzle state


WHICH_SLOT	=	$DA
JS_BUTTON_STATE	=	$DB
CURRENT_DISK	=	$DC
JOYSTICK_ENABLED=	$DD
SOUND_STATUS	=	$DE
	SOUND_DISABLED	= $80
	SOUND_IN_LC	= $01 ; $01 sound effects in language card
	SOUND_MOCKINGBOARD = $02 ; mockingboard detected

GRID_PAGE	=	$DF
ANIMATE_FRAME	=	$E0
LEVEL_OVER	=	$E1
	GAME_OVER	=	$FF
	NEXT_LEVEL	=	$01
LOCATIONS_L	=	$E2
LOCATIONS_H	=	$E3

; temp var per-world define
LONG_FRAME	=	$E4	; nibel
CURRENT_DISPLAY	=	$E4	; selena
LAST_PLAYED	=	$E4	; selena

STAR_CYCLE	=	$E5

DISP_PAGE	=	$ED	; ALL
DRAW_PAGE	=	$EE	; ALL

; rest of pt3_player
MB_DETECTED	= $EF
WHICH_CHUNK	= $F0
MB_CHUNK_OFFSET	= $F1
LOOP		= $F4
MB_VALUE	= $F5
MB_ADDR_L	= $F6
MB_ADDR_H	= $F7
DONE_PLAYING	= $F8
DONE_SONG	= $F9

; rest of pt3_player
PT3_TEMP        = $EF
ORNAMENT_L      = $F0
ORNAMENT_H      = $F1
SAMPLE_L        = $F2
SAMPLE_H        = $F3



MUSIC_PTR	=	$F7
LEADING_ZERO	=	$F8
TEMP_STATUS	=	$F9
TEMP		=	$FA
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

