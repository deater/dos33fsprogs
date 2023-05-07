; HARDWARE LOCATIONS / SOFT SWITCHES

KEYBOARD	=	$C000	; (read)  most recent keypress
EIGHTYSTOREOFF	=	$C000	; (write) turn off 80store
EIGHTYSTOREON	=	$C001	; (write) page2 means 400/2000 write to aux mem

CLR80COL	=	$C00C	; (write) set 40-column
SET80COL	=	$C00D	; (write) set 80-column

KEYRESET	=	$C010	; clear keyboard strobe

SPEAKER		=	$C030
SET_GR		=	$C050
SET_TEXT	=	$C051
FULLGR		=	$C052
TEXTGR		=	$C053
PAGE1		=	$C054
PAGE2		=	$C055
LORES		=	$C056	; Enable LORES graphics
HIRES		=	$C057	; Enable HIRES graphics
CLRAN3		=	$C05E	; Annunciator 3
				; (read/write) if 80 col mode, enable double graphics
SETAN3		=	$C05F	; (read/write) if 80 col mode, enable single-graphics

PADDLE_BUTTON0	=	$C061
PADDL0		=	$C064
PTRIG		=	$C070

; Language card
; C080
; C08B

;; BASIC ROUTINES

;NORMAL	=	$F273

;; MONITOR ROUTINES

;HLINE	= $F819			;; HLINE Y,$2C at A
;VLINE	= $F828			;; VLINE A,$2D at Y
;CLRSCR	= $F832			;; Clear low-res screen
;CLRTOP	= $F836			;; clear only top of low-res screen
;SETCOL	= $F864			;; COLOR=A
;TEXT	= $FB36
;TABV	= $FB5B			;; VTAB to A
;BELL	= $FBDD			;; ring the bell
;BASCALC= $FBC1			;;
;VTAB	= $FC22			;; VTAB to CV
HOME	= $FC58			;; Clear the text screen
WAIT	= $FCA8			;; delay 1/2(26+27A+5A^2) us
;SETINV	= $FE80			;; INVERSE
;SETNORM= $FE84			;; NORMAL
;COUT	= $FDED			;; output A to screen
;COUT1	= $FDF0			;; output A to screen






COLOR_BLACK		=	0
COLOR_RED		=	1
COLOR_DARKBLUE		=	2
COLOR_PURPLE		=	3
COLOR_DARKGREEN		=	4
COLOR_GREY		=	5
COLOR_MEDIUMBLUE	=	6
COLOR_LIGHTBLUE		=	7
COLOR_BROWN		=	8
COLOR_ORANGE		=	9
COLOR_GREY2		=	10
COLOR_PINK		=	11
COLOR_LIGHTGREEN	=	12
COLOR_YELLOW		=	13
COLOR_AQUA		=	14
COLOR_WHITE		=	15

COLOR_BOTH_BLACK	=	$00
COLOR_BOTH_RED		=	$11
COLOR_BOTH_DARKBLUE	=	$22
COLOR_BOTH_DARKGREEN	=	$44
COLOR_BOTH_GREY		=	$55
COLOR_BOTH_MEDIUMBLUE	=	$66
COLOR_BOTH_LIGHTBLUE	=	$77
COLOR_BOTH_BROWN	=	$88
COLOR_BOTH_ORANGE	=	$99
COLOR_BOTH_PINK		=	$BB
COLOR_BOTH_LIGHTGREEN	=	$CC
COLOR_BOTH_YELLOW	=	$DD
COLOR_BOTH_AQUA		=	$EE
COLOR_BOTH_WHITE	=	$FF

