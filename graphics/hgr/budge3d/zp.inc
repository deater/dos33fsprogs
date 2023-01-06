; defines

OpDEY	=	$88		; DEY opcode
OpINY	=	$c8		; INY opcode
OpDEX	=	$ca		; DEX opcode
OpINX	=	$e8		; INX opcode
OpNOP	=	$ea		; NOP opcode

; zero page addresses

YSAVE		=	$00
HPTR		=	$06

HPAGE		=	$18	; hi-res page ($20 or $40) ; FIXME
PTR1		=	$1a
PTR2		=	$1c
XSTART		=	$1c
YSTART		=	$1d
XEND		=	$1e
YEND		=	$1f
MON_WNDLEFT	=	$20	; left column of scroll window
MON_WNDWDTH	=	$21	; width of scroll window
MON_WNDTOP	=	$22	; top of scroll window
MON_WNDBTM	=	$23	; bottom of scroll window
MON_CH		=	$24	; cursor horizontal displacement
MON_CV		=	$25	; cursor vertical displacement

MON_CSWL	=	$36	; character output hook (lo)
MON_CSWH	=	$37	; character output hook (hi)

DELTA_X		=	$3c
DELTA_Y		=	$3d
LINE_ADJ	=	$3e

LINE_INDEX	=	$43
FIRST_LINE	=	$45	; FIXME: what if interrupt?
LAST_LINE	=	$46

BAS_ARYTAB	=	$6b	; pointer to start of Applesoft array space (2b)



; Clear variables
XC		= $19	; transformed X coordinate
YC		= $1a	; transformed Y coordinate
ZC		= $1b	; transformed Z coordinate
SCALE		= $1c	; $00-0F, where $0F is full size
XPOSN		= $1d	; X coordinate (0-255)
YPOSN		= $1e	; Y coordinate (0-191)
ZROT		= $1f	; Z rotation ($00-1B)
YROT		= $3c	; Y rotation ($00-1B)
XROT		= $3d	; X rotation ($00-1B)
ROT_TMP		= $3f	; 4 bytes long
OUT_INDEX	= $43
FIRST_POINT	= $45
LAST_POINT	= $46







