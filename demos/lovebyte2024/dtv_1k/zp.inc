ZP=$00
offset          = ZP+0
ZX0_src         = ZP+2
ZX0_dst         = ZP+4
bitr            = ZP+6
pntr            = ZP+7


; zero page locations
CH		=	$24
GBASL		=	$26
GBASH		=	$27
H2		=	$2C
V2		=	$2D
COLOR		=	$30

; These are all "Free" zero page locations
FREQ1           =     $06
FREQ2           =     $07
DURATION        =     $08
INSTRUMENT1     =     $09
INSTRUMENT2     =     $1D
MADDRL          =     $1E
MADDRH          =     $1F
LOC4E           =     $4E
COUNT256        =     $4F

CX	=	$70
CY	=	$71
SHAPE_L	=	$72
SHAPE_H	=	$73

FRAME		=	$90
MOVEMENT	=	$91

HGR_X		=	$E0
HGR_Y		=	$E2
HGR_SCALE	=	$E7

TEMPY		=	$F0
HGR_ROTATION	=	$F9

SAVEY		=	$FA
INL		=	$FE
INH		= 	$FF

KEYPRESS        =       $C000
KEYRESET        =       $C010

SET_TEXT        =       $C051


; ROM locations

HOME    = $FC58                 ; Clear the text screen
TEXT    = $FB36
HLINE   = $F819                 ; HLINE Y,$2C at A
VLINE   = $F828                 ; VLINE A,$2D at Y
TABV    = $FB5B			; go to A

WAIT    = $FCA8                 ; delay 1/2(26+27A+5A^2) us

HGR2		=	$F3D8
HGR		=	$F3E2
BKGND0          =       $F3F4
HPOSN		=	$F411
XDRAW0		=	$F65D
XDRAW1		=	$F661
HPLOT0		=	$F457
COUT1		=	$FDF0

hposn_low	=	$8000
hposn_high	=	$8100
