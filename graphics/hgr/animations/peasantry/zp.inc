;==================
;==================
; Zero Page Usage
;==================
;==================

; ZX0 decompression addresses

ZX0_src		= $00
ZX0_dst		= $02
offset		= $04
bitr		= $06
pntr		= $07
WHICH_LOAD	= $09
CURRENT_DISK	= $0A

TEMP_SPRITE	= $10
TEMP_MASK	= $11
MASK_TEMP	= $12
SPRITE_TEMP	= $13
SPRITE_X	= $14
SPRITE_Y	= $15

; Zero page monitor routines addresses
; We don't use the monitor but we use some of these anyway

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
;INVFLG	= $32

WIPEL	= $3C	; used by input for wipes?
WIPEH	= $3D

WHICH_TRACK	= $54

;==========================
; $60-$6F
;==========================

DISP_PAGE	= $6E
DRAW_PAGE	= $6F

;================================================
; $B0 ... $BF for common things, don't mess with
;================================================

FRAME           = $B8
FRAMEL		= $B8
FRAMEH		= $B9
WHICH_SLOT	= $BA		; from boot sector
SECOND_COUNTDOWN= $BB

BTC_L		= $BC
BTC_H		= $BD		; audio


; Used when sprite drawing

CURSOR_X	= $BE
CURSOR_Y	= $BF


;==============================================
; $C0-$CF available
;==============================================

; woz

BALL_STATE	=	$C0	; C0..C7
BALL_OFFSET	=	$C8	; C8..CF

; four-color/plasma
XPOS		= $C8
YPOS		= $C9
AUXOUTL		= $CA
AUXOUTH		= $CB
MAIN1		= $CC
AUX1		= $CD
MAIN0		= $CE
AUX0		= $CF

; repack

CURRENT_COL	= $CC	; dhgr_repack
CURRENT_ROW	= $CD	; dhgr_repack

;==============================================
; $D0-$DB can re-use in each file
;==============================================

; repack
REPACK_TMP	= $D0	; $D0...$D7

COUNT		= $D6
WHICH_DROP	= $D7
WHICH_RAIN	= $D8

TEMP		= $D9

WHICH		= $DA
FRAME_RATE	= $DB

;==============================================
; $DC-$DF we use for in/out pointers
;==============================================

INL		=	$DC
INH		=	$DD
OUTL		=	$DE
OUTH		=	$DF




;==========================
; $E0-$FD for PT3 Player
;==========================

.include "../pt3lib/pt3_lib_zp.inc"
