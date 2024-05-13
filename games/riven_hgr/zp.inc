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

TILEMAP_X		= $81		; upper left corner of tilemap
TILEMAP_Y		= $82


KEEN_TILEX		= $83
KEEN_TILEY		= $84
KEEN_X			= $85		; location of protagonist
KEEN_XL			= $86		; 8.8 fixed point?
KEEN_Y			= $87
KEEN_DIRECTION		= $88
KEEN_WALKING		= $89
KEEN_JUMPING		= $8A

LASER_OUT		= $8B
LASER_TILEX		= $8C
LASER_TILEY		= $8D
LASER_DIRECTION		= $8E

RAYGUNS			= $8F
KEYCARDS		= $90
	INV_RED_KEY		= $01
	INV_BLUE_KEY		= $02
	INV_YELLOW_KEY		= $04
	INV_GREEN_KEY		= $08

KEENS			= $91
SCORE0			= $92
SCORE1			= $93
SCORE2			= $94

SHIP_PARTS		= $95
	PARTS_BOTTLE		= $01
	PARTS_VACUUM		= $02
	PARTS_BATTERY		= $04
	PARTS_JOYSTICK		= $08

KEEN_FALLING		= $96
KEEN_SHOOTING		= $97
SOUND_OFFSET		= $98
SUPPRESS_WALK		= $99
POGO			= $9A
LASER_TILE		= $9B
TILE_TEMP		= $9C

TILEY			= $9D
TILE_ODD		= $9E
TILEMAP_OFFSET		= $9F

MARS_X			= $A0
MARS_Y			= $A1
MARS_TILEX		= $A2
MARS_TILEY		= $A3
INITIAL_SOUND		= $A4
PLAY_END_SOUND		= $A5
APPLEII_MODEL		= $A6
CURRENT_LEVEL		= $A7
ORACLE_SPOKEN		= $A8

MAX_TILE_X		= $A9
MAX_TILE_Y		= $AA
;START_KEEN_TILEX	= $AB
;START_KEEN_TILEY	= $AC
;START_TILEMAP_X		= $AD
;START_TILEMAP_Y		= $AE
NUM_ENEMIES		= $AF
HARDTOP_TILES		= $B0
ALLHARD_TILES		= $B1
SOUNDL			= $B2
SOUNDH			= $B3
START_LINE_L		= $B4	; story
START_LINE_H		= $B5	; story
SPRITE_Y		= $B6	; title
CURRENT_ROW		= $B7	; title
SPRITE_X		= $B8	; title
HGR_PAGE		= $B9	; title
MENU_OPTION		= $BA	; title
WHICH_CURSOR		= $BB	; title
CURSOR_X		= $BC
CURSOR_Y		= $BD
UPDATE_POINTER		= $BE

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
	TOUCHED_ENEMY	=	$80
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

