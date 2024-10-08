; HARDWARE LOCATIONS

KEYPRESS	=	$C000
KEYRESET	=	$C010

; SOFT SWITCHES
CLR80COL	=	$C000	; PAGE1/PAGE1 normal
SET80COL	=	$C001	; PAGE1/PAGE2 switches PAGE1 in Aux instead
READMAINMEM	=	$C002	; (w) to read from main mem ($0200..$BFFF)
READAUXMEM	=	$C003	; (w) to read from aux mem ($0200..$BFFF)
WRITEMAINMEM	=	$C004	; (w) to write to main mem ($0200..$BFFF)
WRITEAUXMEM	=	$C005	; (w)to write to aux mem ($0200..$BFFF)
SETSTDZP	=	$C008	; (w) to use main mem stack/zp ($00FF-$01FF)
EIGHTYCOLOFF	=	$C00C
EIGHTYCOLON	=	$C00D
PRIMARYCHARSET	=	$C00E	; (w) to disable mousetext
TBCOLOR		=	$C022	; IIgs text foreground / background colors
NEWVIDEO	=	$C029	; IIgs graphics modes
SPEAKER		=	$C030
CLOCKCTL	=	$C034	; bits 0-3 are IIgs border color
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

LCBANK2		=	$C083
LCBANK1		=	$C08B

; APPLESOFT BASIC ROUTINES

;NORMAL		= $F273
;HGR2		= $F3D8
;HGR		= $F3E2
;BKGND0		= $F3F4		; clear current page to A
;HPOSN		= $F411		; (Y,X),(A)  (values stores in HGRX,XH,Y)
HPLOT0		= $F457		; plot at (Y,X), (A)
;COLOR_SHIFT	= $F47E
;HLINRL		= $F530         ; (X,A),(Y)
;HGLIN		= $F53A         ; line to (X,A),(Y)
;COLORTBL	= $F6F6


; MONITOR ROUTINES

;HLINE	= $F819			; HLINE Y,$2C at A
;VLINE	= $F828			; VLINE A,$2D at Y
;CLRSCR	= $F832			; Clear low-res screen
;CLRTOP	= $F836			; clear only top of low-res screen
;SETCOL	= $F864			; COLOR=A
;ROM_TEXT2COPY = $F962		; iigs
INIT_TEXT = $FB2F		; set lo-res/page1 and call text
TEXT	= $FB36							; qboot
;TABV	= $FB5B			; VTAB to A
ROM_MACHINEID = $FBB3		; iigs
;BELL	= $FBDD			; ring the bell
;BASCALC	= $FBC1			;
;VTAB	= $FC22			; VTAB to CV
HOME	= $FC58			; Clear the text screen		; qboot
;WAIT	= $FCA8			; delay 1/2(26+27A+5A^2) us
;CROUT1	= $FD8B
SETINV	= $FE80			; INVERSE
SETNORM	= $FE84			; NORMAL
COUT	= $FDED			; output A to screen		; qboot
COUT1	= $FDF0			; output A to screen		; qload
SETKBD	= $FE89			; set input to keyboard
SETVID	= $FE93			; set output to video screen





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

