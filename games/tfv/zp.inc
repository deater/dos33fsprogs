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

; music
LOOP            = $01
MB_VALUE        = $02
MB_ADDR_L       = $03
MB_ADDR_H       = $04
DONE_PLAYING    = $05
DONE_SONG       = $06

; rest of pt3_player
PT3_TEMP        = $07
ORNAMENT_L      = $08
ORNAMENT_H      = $09
SAMPLE_L        = $0A
SAMPLE_H        = $0B

; pt3 player registers
REGISTER_DUMP   = $50
AY_REGISTERS    = $50
A_FINE_TONE     = $50
A_COARSE_TONE   = $51
B_FINE_TONE     = $52
B_COARSE_TONE   = $53
C_FINE_TONE     = $54
C_COARSE_TONE   = $55
NOISE           = $56
ENABLE          = $57
PT3_MIXER_VAL   = $57
A_VOLUME        = $58
B_VOLUME        = $59
C_VOLUME        = $5A
ENVELOPE_FINE   = $5B
ENVELOPE_COARSE = $5C
ENVELOPE_SHAPE  = $5D
PATTERN_L       = $5E
PATTERN_H       = $5F



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
NEGATE		=	$86			; UNUSED?
LAST_SPACEX_I	=	$87
LAST_SPACEY_I	=	$88
LAST_MAP_COLOR	=	$89
COLOR_MASK	=	$8A
XMAX		=	$8B	; used by putsprite_crop

;; rotozoom (can overlap with flying routine?)
SCALE_I		=	$64	; scale of rotozoom
SCALE_F		=	$65	; 





;==================GLOBAL STATE, STORED IN SAVE GAME==========
WHICH_LOAD	=	$90	; current level
HERO_HP_LO	=	$91	; hero's hit points (lo)
HERO_HP_HI	=	$92	; hero's hit points (hi)
HERO_MP		=	$93	; hero's magic points
HERO_MP_MAX	=	$94	; heros' max magic points
HERO_LIMIT	=	$95	; hero's limit break count
HERO_LEVEL	=	$96	; hero's level, also high byte of max hp
HERO_XP		=	$97	; hero's experience points
HERO_MONEY	=	$98	; hero's money
HERO_INVENTORY1	=	$99	; hero's inventory
HERO_INVENTORY2	=	$9A	; hero's inventory
HERO_INVENTORY3	=	$9B	; hero's inventory
HERO_NAME	=	$9C	; 8 chars
HERO_NAME1	=	$9D	; 8 chars
HERO_NAME2	=	$9E	; 8 chars
HERO_NAME3	=	$9F	; 8 chars
HERO_NAME4	=	$A0	; 8 chars
HERO_NAME5	=	$A1	; 8 chars
HERO_NAME6	=	$A2	; 8 chars
HERO_NAME7	=	$A3	; 8 chars
HERO_STATE	=	$A4	; state of hero
	HERO_ON_BIRD	= $01
	HERO_ODD	= $02	; stand/walk position
	HERO_DIRECTION	= $04	; 0=left, 1=right
HERO_STEPS	=	$A5	; number of steps

TFV_X           =	$A6	; location on screen
TFV_Y           =	$A7	; location on screen
MAP_X           =	$A8	; which map region we're on



;==================GAME STATE (not in save game)==============
LEVEL_OVER	=	$B0
JOYSTICK_ENABLED=	$B1
FRAMEL		=	$B2
FRAMEH		=	$B3
MENU_RESULT	=	$B4
SOUND_STATUS    =       $B5
	SOUND_DISABLED  = $80
	SOUND_IN_LC     = $01 ; $01 sound effects in language card
	SOUND_MOCKINGBOARD = $02 ; mockingboard detected
JS_BUTTON_STATE	=	$B6
ANIMATE_LOOP	=	$B7

HERO_X		=	$C0	; used in battle
HERO_Y		=	$C1	; used in battle
BATTLE_STATE	=	$C2	; used in battle
	BATTLE_STATE_RUNNING = $01	; running from battle
BATTLE_COUNT	=	$C3	; battle counter
ENEMY_TYPE	=	$C4	; used in battle
ENEMY_HP_LO	=	$C5	; enemy hitpoints
ENEMY_HP_HI	=	$C6	; enemy hitpoints
ENEMY_LEVEL	=	$C7	; enemy level
ENEMY_X		=	$C8	; enemy X position
ENEMY_COUNT	=	$C9	; enemy countdown to attack
MENU_POSITION	=	$CA
MENU_STATE	=	$CB	; battle menu state
	MENU_NONE	= 0
	MENU_MAIN	= 1
	MENU_MAGIC	= 2
	MENU_SUMMON	= 3
	MENU_LIMIT	= 4
	MENU_FINGER	= $80
MENU_SUBMENU	=	$CC
	MENU_MAIN_ATTACK	= 0
	MENU_MAIN_SKIP		= 1
	MENU_MAIN_MAGIC		= 2
	MENU_MAIN_ESCAPE	= 3
	MENU_MAIN_SUMMON	= 4
	MENU_MAIN_LIMIT		= 5
MAGIC_TYPE	=	$CD	; same as below
MENU_TYPE	=	$CD	; same as above
	MENU_SUMMON_METROCAT	= 0
	MENU_SUMMON_VORTEX	= 1

	MENU_MAGIC_HEAL		= 0
	MENU_MAGIC_FIRE		= 1
	MENU_MAGIC_ICE		= 2
	MENU_MAGIC_MALAISE	= 3
	MENU_MAGIC_BOLT		= 4

	MENU_LIMIT_SLICE	= 0
	MENU_LIMIT_ZAP		= 1
	MENU_LIMIT_DROP		= 2

LAST_KEY	=	$CE
DAMAGE_VAL_HI	=	$CF
DAMAGE_VAL_LO	=	$D0
MAGIC_X		=	$D1
MAGIC_Y		=	$D2
FINGER_DIRECTION=	$D3
ENEMY_DEAD	=	$D4
MAGIC_COST	=	$D5
ENEMY_ATTACKING	=	$D6
HERO_MOVED	=	$D7

; worldmap
REFRESH		=	$D8
NEWX            =	$D9
NEWY            =	$DA
GROUND_COLOR    =	$DB

QUEUED_ATTACK	=	$DC
	QUEUED_DO_ATTACK = $01
	QUEUED_DO_MAGIC = $02
	QUEUED_DO_LIMIT = $03
	QUEUED_DO_SUMMON = $04


COLOR1		=	$E0
COLOR2		=	$E1
MATCH		=	$E2
XX		=	$E3
YY		=	$E4
SHIPY           =	$E4	; same as before
YADD		=	$E5
LOGO_LOOP	=	$E6
NAMEX		=	$E7
CHAR		=	$E8
DISP_PAGE       =	$E9
DRAW_PAGE       =	$EA

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

