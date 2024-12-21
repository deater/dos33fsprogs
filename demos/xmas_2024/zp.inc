;==================
;==================
; Zero Page Usage
;==================
;==================

;00..71 for effect? blurgh

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

;==========================
; $60-$6F unused currently
;==========================


;==========================
; $80-$8F for PT3 Player
;==========================

AY_REGISTERS    = $80
A_FINE_TONE     = $80
A_COARSE_TONE   = $81
B_FINE_TONE     = $82
B_COARSE_TONE   = $83
C_FINE_TONE     = $84
C_COARSE_TONE   = $85
NOISE           = $86
ENABLE          = $87
PT3_MIXER_VAL   = $87
A_VOLUME        = $88
B_VOLUME        = $89
C_VOLUME        = $8A
ENVELOPE_FINE   = $8B
ENVELOPE_COARSE = $8C
ENVELOPE_SHAPE  = $8D
PATTERN_L       = $8E
PATTERN_H       = $8F

;============================
; $90-$9D rest of pt3_player
;============================

PT3_TEMP        = $90
ORNAMENT_L      = $91
ORNAMENT_H      = $92
SAMPLE_L        = $93
SAMPLE_H        = $94
LOOP            = $95
MB_VALUE        = $96
MB_ADDR_L       = $97
MB_ADDR_H       = $98
DONE_PLAYING    = $99
DONE_SONG       = $9A
APPLEII_MODEL   = $9B
SOUND_STATUS    = $9C
        SOUND_DISABLED  = $80
        SOUND_IN_LC     = $01 ; $01 sound effects in language card
        SOUND_MOCKINGBOARD = $02 ; mockingboard detected

;=============================
; not sure why these are here
;=============================

DISP_PAGE	= $9D
DRAW_PAGE	= $9E
TOTAL_RAM       = $9F

;=============================
; $A0-$CF currently free
;=============================

;=============================
; $D0-$D9 = hgr move
;=============================
HGR_X1	= $D0
HGR_X2	= $D1
HGR_Y1	= $D2
HGR_Y2	= $D3
HGR_DEST= $D4
BOARD_COUNT	= $D5


WHICH_SLOT = $DA		; from boot sector


;==============================================
; $E0-$EF use for common things, don't re-use
;==============================================
IRQ_COUNTDOWN	= $E0
SECOND_COUNTDOWN= $E1
COUNT           = $E2
XSAVE		= $E3
TEMPY		= $E4
XPOS		= $E5	; gr_plot
YPOS		= $E6	; gr_plot
COLOR_MASK	= $E7	; gr_plot
FRAMEL		= $E8
FRAMEH		= $E9
BTC_L		= $EA	; audio
BTC_H		= $EB	; audio
MASKL		= $EC	; gr_putsprite_mask
MASKH		= $ED
FRAME           = $EE

;==============================================
; $F0-$FB can re-use in each file
;==============================================

; tunnel
XX		= $F2
MINUSXX         = $F3
YY		= $F4
MINUSYY         = $F5
D               = $F6
R               = $F7
CX              = $F8
CY              = $F9
RR              = $FA

; Scroll

SCROLL_OFFSET   = $F0
SCROLL_START    = $F1
SCROLL_ODD      = $F2
PLASMA_GROW     = $F3
SCROLL_SUBSCROLL= $F4
FONT1           = $F5
FONT2           = $F6
SCROLL_ROW      = $F7
SCROLL_COL      = $F8


;==============================================
; $FC-$FF we use for in/out pointers
;==============================================

INL		=	$FC
INH		=	$FD
OUTL		=	$FE
OUTH		=	$FF
