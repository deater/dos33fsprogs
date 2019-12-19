; Display awesome tree

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
CH		= $24
CV		= $25
GBASL		= $26
GBASH		= $27
BASL		= $28
BASH		= $29
HGR_COLOR	= $E4
SNOWX		= $F0
COLOR		= $F1
CMASK1		= $F2
CMASK2		= $F3
WHICH_Y		= $F4

TREESIZE	= 12

.include	"hardware.inc"


	;==================================
	;==================================

	bit	SET_GR
	bit	FULLGR
	bit	LORES
	bit	PAGE0


display_loop:

	;==========================================================
	;==========================================================
	; erase old lines
	;==========================================================
	;==========================================================
	; clear 10-30 on lines 8-38

	; 4+(80+5)*20+5-1 = 1708 cycles
clear_lores:

	lda	#$0						; 2
	ldx	#19						; 2
							;===========
							;	  4
clear_lores_loop:
	sta	$600+10,X	; 8				; 5
	sta	$680+10,X	; 10				; 5
	sta	$700+10,X	; 12				; 5
	sta	$780+10,X	; 14				; 5
	sta	$428+10,X	; 16				; 5
	sta	$4A8+10,X	; 18				; 5
	sta	$528+10,X	; 20				; 5
	sta	$5A8+10,X	; 22				; 5
	sta	$628+10,X	; 24				; 5
	sta	$6A8+10,X	; 26				; 5
	sta	$728+10,X	; 28				; 5
	sta	$7A8+10,X	; 30				; 5
	sta	$450+10,X	; 32				; 5
	sta	$4D0+10,X	; 34				; 5
	sta	$550+10,X	; 36				; 5
	sta	$5D0+10,X	; 38				; 5
							;===========
							;	80

	dex							; 2
	bpl	clear_lores_loop				; 3
							;===========
							;	  5
								; -1


	;============================================================
	;============================================================
	; move line
	;============================================================
	;============================================================

	inc	WHICH_Y					; 5
	lda	WHICH_Y					; 3
	and	#$7f					; 2
	sta	WHICH_Y					; 3
							;=====
							; 13


	;==========================================================
	;==========================================================
	; draw new line
	;==========================================================
	;==========================================================
	;NEW: 2,4,6,8,10,12,14,16,18,2,2,2
	;
	; 2-1 + 7*TREESIZE + 85*TREESIZE +
	;			18*(2+4+6+8+10+12+14+16+18+2+2+2)
	;
	; 1 + 84 + 1020 + 18*92 = 1105 + 1656 = 2761


	ldx	#0					; 2
draw_line_loop:

	;=================================
	;=================================
	; draw line
	;=================================
	;=================================
	; X = which

	; optimized:	34 + 18 + 34 +      18*len + -1 = 85+(18*len)

draw_line:

	; set up proper sine table
	ldy	tree_line,X					; 4+
	lda	sine_table_l,Y					; 4+
	sta	sine_table_smc+1				; 4
	lda	sine_table_h,Y					; 4+
	sta	sine_table_smc+2				; 4

	ldy	WHICH_Y						; 3
sine_table_smc:
	lda	sine_table5,Y					; 4+
	lsr							; 2
	tay							; 2
	bcs	draw_line_odd					; 3
								;======
								; 34
draw_line_even:
								; -1
	lda	tree_color,X					; 4+
	and	#$0f						; 2
	sta	ll_smc1+1					; 4
	lda	#$f0						; 2
	sta	ll_smc2+1					; 4
	jmp	draw_line_actual				; 3
								;====
								; 18

draw_line_odd:
	lda	tree_color,X					; 4+
	and	#$f0						; 2
	sta	ll_smc1+1					; 4
	lda	#$0f						; 2
	sta	ll_smc2+1					; 4
	nop							; 2
								;====
								; 18

draw_line_actual:
	lda	gr_offsets_l,Y					; 4+
	clc							; 2
	adc	tree_start,X					; 4+
	sta	ll_smc3+1					; 4
	sta	ll_smc4+1					; 4

	lda	gr_offsets_h,Y					; 4+
	sta	ll_smc3+2					; 4
	sta	ll_smc4+2					; 4

	ldy	tree_len,X					; 4+
								;=====
								; 34

line_loop:
ll_smc3:
	lda	$400,Y						; 4+
ll_smc2:
	and	#$f0						; 2
ll_smc1:
	ora	#$0f						; 2
ll_smc4:
	sta	$400,Y						; 5
	dey							; 2
	bpl	line_loop					; 3
								;=====
								; 18

								; -1

	inx						; 2
	cpx	#TREESIZE				; 2
	bne	draw_line_loop				; 3


							; -1

	;==============================================================
	;==============================================================

;	lda	#100
;	jsr	WAIT

	jmp	display_loop				; 3







tree:
	;	color	start	stop		; 01234567890123456789
;	.byte	$DD,	19,	20,	$00	;          YY
;	.byte	$44,	17,	22,	$00	;         DDDD
;	.byte	$CC,	16,	23,	$00	;        LLLLLL
;	.byte	$44,	15,	24,	$00	;       DDDDDDDD
;	.byte	$CC,	14,	25,	$00	;      LLLLLRRLLL
;	.byte	$44,	13,	26,	$00	;     DDDDDDDDDDDD
;	.byte	$CC,	12,	27,	$00	;    LLLLLLLLLLLLLL
;	.byte	$44,	11,	28,	$00	;   DDDDRRDDDDDDDDDD
;	.byte	$CC,	10,	29,	$00	;  LLLLLLLLLLLLLLLLLL
;	.byte	$88,	19,	20,	$00	;          BB

tree_color:	.byte	$DD,$44,$CC,$44, $CC,$11, $44, $CC, $44,$11, $CC, $88
tree_line:	.byte	  0,  1,  2,  3,   4,  4,   5,   6,   7,  7,   8,   9
tree_start:	.byte	 19, 18, 17, 16,  15, 20,  14,  13,  12, 16,  11,  19
tree_len:	.byte	2-1,4-1,6-1,8-1,10-1,2-1,12-1,14-1,16-1,2-1,18-1, 2-1

gr_offsets_l:
	.byte	<$400,<$480,<$500,<$580,<$600,<$680,<$700,<$780
	.byte	<$428,<$4a8,<$528,<$5a8,<$628,<$6a8,<$728,<$7a8
	.byte	<$450,<$4d0,<$550,<$5d0,<$650,<$6d0,<$750,<$7d0

gr_offsets_h:
	.byte	>$400,>$480,>$500,>$580,>$600,>$680,>$700,>$780
	.byte	>$428,>$4a8,>$528,>$5a8,>$628,>$6a8,>$728,>$7a8
	.byte	>$450,>$4d0,>$550,>$5d0,>$650,>$6d0,>$750,>$7d0

sine_table_l:
	.byte	<sine_table5, <sine_table6, <sine_table7, <sine_table8
	.byte	<sine_table9, <sine_table10,<sine_table11,<sine_table12
	.byte	<sine_table13,<sine_table14,<sine_table15

sine_table_h:
	.byte	>sine_table5, >sine_table6, >sine_table7, >sine_table8
	.byte	>sine_table9, >sine_table10,>sine_table11,>sine_table12
	.byte	>sine_table13,>sine_table14,>sine_table15


.align	$100
.include "sines.inc"
