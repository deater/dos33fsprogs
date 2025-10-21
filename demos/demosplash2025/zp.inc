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
; $60-$6F unused currently
;==========================


;==========================
; $70-$7F for PT3 Player
;==========================

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
PATTERN_L       = $7E
PATTERN_H       = $7F

;============================
; $80-$8D rest of pt3_player
;============================

PT3_TEMP        = $80
ORNAMENT_L      = $81
ORNAMENT_H      = $82
SAMPLE_L        = $83
SAMPLE_H        = $84
LOOP            = $85
MB_VALUE        = $86
MB_ADDR_L       = $87
MB_ADDR_H       = $88
DONE_PLAYING    = $89
DONE_SONG       = $8A
APPLEII_MODEL   = $8B
SOUND_STATUS    = $8C
        SOUND_DISABLED  = $80
        SOUND_IN_LC     = $01 ; $01 sound effects in language card
        SOUND_MOCKINGBOARD = $02 ; mockingboard detected

;=============================
; not sure why these are here
;=============================

DISP_PAGE	= $8D
DRAW_PAGE	= $8E
TOTAL_RAM       = $8F

;=============================
; $90-$BF currently free
;=============================

; for plasma?
;Table1  = $A0   ; 40 bytes ($28) A0-C7
;Table2  = $C8   ; 40 bytes ($28) C8-EF

;===========================
; $C0-$CF = wipe
;===========================
; use $C0-$CF for wipes

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
FRAME           = $E8
FRAMEL		= $E8
FRAMEH		= $E9
MASKL		= $EA	; gr_putsprite_mask
MASKH		= $EB

;==============================================
; $F0-$FB can re-use in each file
;==============================================

; start/font fall

TEXT_Y		= $F2

; bear
AUXOUTL		= $EA
AUXOUTH		= $EB
MAIN1		= $EC
AUX1		= $ED
MAIN0		= $EE
AUX0		= $EF
CURRENT		= $F0
LEFT		= $F1
XSTART		= $F2
XEND		= $F3
COLORSG		= $F4
COLORSF		= $F5
COLORSE		= $F6
COLORSD		= $F7
COLORSC		= $F8
COLORSB		= $F9
COLORSA		= $FA
ODD		= $FB

; headphones
SCROLL_COUNT	= $F0
INDEX		= $F1
OFFSET		= $F2
LENGTH		= $F3

; dancing
DANCE_COUNT	= $F0


;==============================================
; $FC-$FF we use for in/out pointers
;==============================================

INL		=	$FC
INH		=	$FD
OUTL		=	$FE
OUTH		=	$FF


