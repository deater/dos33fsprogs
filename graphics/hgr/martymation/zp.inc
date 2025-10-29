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

;==========================
; $B0 ... $BF
;==========================


WHICH_SLOT = $BA		; from boot sector

;==============================================
; $C0-$CF use for common things, don't re-use
;==============================================
;TOTAL_RAM       = $C0
SECOND_COUNTDOWN= $C1
COUNT           = $C2
XSAVE		= $C3
TEMPY		= $C4
XPOS		= $C5	; gr_plot
YPOS		= $C6	; gr_plot
COLOR_MASK	= $C7	; gr_plot
FRAME           = $C8
FRAMEL		= $C8
FRAMEH		= $C9
MASKL		= $CA	; gr_putsprite_mask
MASKH		= $CB

CURRENT_COL	= $CC	; dhgr_repack
CURRENT_ROW	= $CD	; dhgr_repack

;==============================================
; $D0-$DB can re-use in each file
;==============================================

REPACK_TMP	= $D0	; $D0...$D7

; start/font fall

TEXT_Y		= $D2

; intro: scrolling

SCROLL_COUNT	= $D0
INDEX		= $D1
DEST_OFFSET	= $D2
SRC_OFFSET	= $D3
LENGTH		= $D4

; four-color
AUXOUTL		= $CA
AUXOUTH		= $CB
MAIN1		= $CC
AUX1		= $CD
MAIN0		= $CE
AUX0		= $CF
CURRENT		= $D0
LEFT		= $D1
XSTART		= $D2
XEND		= $D3
COLORSG		= $D4
COLORSF		= $D5
COLORSE		= $D6
COLORSD		= $D7
COLORSC		= $D8
COLORSB		= $D9
COLORSA		= $DA
ODD		= $DB

; Plasma
COMPT1		= $D0
COMPT2		= $D1
PARAM1		= $D2
PARAM2		= $D3
PARAM3		= $D4
PARAM4		= $D5

; Credits
CURSOR_X	= $CE
CURSOR_Y	= $CF
SCROLL_X	= $D0
BACKUP_OUTL	= $D2
BACKUP_OUTH	= $D3
GUITAR_FRAME	= $D4
SCROLL_DONE	= $D5
SCROLL_LINE	= $D6
STAR_X		= $D7
STAR_WHICH	= $D8
SPRITE_LIST	= $D9

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


