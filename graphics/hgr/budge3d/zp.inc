OpDEY	=	$88		; DEY opcode
OpINY	=	$c8		; INY opcode
OpDEX	=	$ca		; DEX opcode
OpINX	=	$e8		; INX opcode
OpNOP	=	$ea		; NOP opcode

; zero page addresses

MON_WNDLEFT	=	$20	; left column of scroll window
MON_WNDWDTH	=	$21	; width of scroll window
MON_WNDTOP	=	$22	; top of scroll window
MON_WNDBTM	=	$23	; bottom of scroll window
MON_CH		=	$24	; cursor horizontal displacement
MON_CV		=	$25	; cursor vertical displacement
MON_CSWL	=	$36	; character output hook (lo)
MON_CSWH	=	$37	; character output hook (hi)
BAS_ARYTAB	=	$6b	; pointer to start of Applesoft array space (2b)

; Clear variables

HPTR		=	$06
HPAGE		=	$18   ; hi-res page ($20 or $40)
XSTART		=	$1c
YSTART		=	$1d
XEND		=	$1e
YEND		=	$1f
DELTA_X		=	$3c
DELTA_Y		=	$3d
LINE_ADJ	=	$3e
LINE_INDEX	=	$43
YSAVE		=	$00
FIRST_LINE	=	$45
LAST_LINE	=	$46
