;; HARDWARE LOCATIONS

KEYPRESS	=	$C000
KEYRESET	=	$C010

;; SOFT SWITCHES
CLR80COL	=	$C000	; PAGE0/PAGE1 normal
SET80COL	=	$C001	; PAGE0/PAGE1 switches PAGE0 in Aux instead
EIGHTYCOLOFF	=	$C00C
EIGHTYCOLON	=	$C00D
SPEAKER		=	$C030
SET_GR		=	$C050
SET_TEXT	=	$C051
FULLGR		=	$C052
TEXTGR		=	$C053
PAGE1		=	$C054
PAGE2		=	$C055
LORES		=	$C056	; Enable LORES graphics
HIRES		=	$C057	; Enable HIRES graphics
AN3		=	$C05E	; Annunciator 3

PADDLE_BUTTON0	=	$C061
PADDL0		=	$C064
PTRIG		=	$C070

;; BASIC ROUTINES

NORMAL		= $F273
HGR		= $F3E2
HGR2		= $F3D8
HCLR		= $F3F2
BKGND		= $F3F6
HPOSN		= $F411         ; (Y,X),(A)  (values stores in HGRX,XH,Y)
HPLOT0          = $F457         ; plot at (Y,X), (A)
HCOLOR1         = $F6F0         ; set HGR_COLOR to value in X       
HGLIN		= $F53A         ; line to (X,A),(Y)
DRAW0		= $F601
XDRAW0		= $F65D
XDRAW1		= $F661


;; MONITOR ROUTINES

HLINE	= $F819			;; HLINE Y,$2C at A
VLINE	= $F828			;; VLINE A,$2D at Y
CLRSCR	= $F832			;; Clear low-res screen
CLRTOP	= $F836			;; clear only top of low-res screen
SETGR	= $FB40			;; GR
SETCOL	= $F864			;; COLOR=A
TEXT	= $FB36
TABV	= $FB5B			;; VTAB to A
BELL	= $FBDD			;; ring the bell
BASCALC	= $FBC1			;;
VTAB	= $FC22			;; VTAB to CV
HOME	= $FC58			;; Clear the text screen
WAIT	= $FCA8			;; delay 1/2(26+27A+5A^2) us
CROUT1	= $FD8B
SETINV	= $FE80			;; INVERSE
SETNORM	= $FE84			;; NORMAL
COUT	= $FDED			;; output A to screen
COUT1	= $FDF0			;; output A to screen
RESTORE         =       $FF3F





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

