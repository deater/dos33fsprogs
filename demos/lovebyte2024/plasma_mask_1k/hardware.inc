;; HARDWARE LOCATIONS

KEYPRESS	=	$C000
KEYRESET	=	$C010

;; SOFT SWITCHES
CLR80COL	=	$C000	; PAGE0/PAGE1 normal
SET80COL	=	$C001	; PAGE0/PAGE1 switches PAGE0 in Aux instead
EIGHTYCOLOFF	=	$C00C
EIGHTYCOLON	=	$C00D
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

; BASIC ROUTINES

NORMAL	=	$F273
HGR     =       $F3E2

; MONITOR ROUTINES

PLOT	= $F800			;; PLOT AT Y,A
PLOT1	= $F80E			;; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
HLINE	= $F819			;; HLINE Y,$2C at A
VLINE	= $F828			;; VLINE A,$2D at Y
CLRSCR	= $F832			;; Clear low-res screen
CLRTOP	= $F836			;; clear only top of low-res screen
GBASCALC= $F847			;; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)
SETCOL	= $F864			;; COLOR=A
ROM_TEXT2COPY = $F962		;; iigs
SETTXT	= $FB36
SETGR	= $FB40
TABV	= $FB5B			;; VTAB to A
ROM_MACHINEID = $FBB3		;; iigs
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




