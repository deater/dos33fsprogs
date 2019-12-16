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

.include	"hardware.inc"


	;==================================
	;==================================

	bit	SET_GR
	bit	FULLGR
	bit	LORES
	bit	PAGE0


display_loop:

	;=========================
	; erase old lines

	jsr	clear_lores				; 6+1749

	;==========================
	; move line

	inc	which_line_y				; 6
	lda	which_line_y				; 4
	and	#$7f					; 2
	sta	which_line_y				; 4
							;=====
							; 16


	;=========================
	; draw new line

	ldx	#0
draw_line_loop:

	ldy	which_line_y
sine_table_smc:
	lda	sine_table5,Y
	tay

	jsr	draw_line

	inx
	cpx	#10
	bne	draw_line_loop

	lda	#100
	jsr	WAIT

	jmp	display_loop				; 3


	;=================================
	;=================================
	; draw line
	;=================================
	;=================================
	; Y = y position
	; X = which

draw_line:
	tya
	and	#$1
	bne	draw_line_odd

draw_line_even:
	lda	#$0f
	sta	ll_smc1+1
	lda	#$f0
	sta	ll_smc2+1
	jmp	draw_line_actual

draw_line_odd:
	lda	#$f0
	sta	ll_smc1+1
	lda	#$0f
	sta	ll_smc2+1

draw_line_actual:
	tya
	and	#$fe
	tay
	lda	gr_offsets,Y

	clc
	adc	#10
	sta	GBASL

	lda	gr_offsets+1,Y
	sta	GBASH

	ldy	#0

	lda	#$CC
ll_smc1:
	and	#$0f
	sta	COLOR
line_loop:
	lda	(GBASL),Y
ll_smc2:
	and	#$f0
	ora	COLOR
	sta	(GBASL),Y
	iny
	cpy	#20
	bne	line_loop

	rts


	;=====================================
	;=====================================

	; clear the top 4 lines (eventually)
	; clear 10-30 on lines 8-38

	; 4+(80+7)*20+5 = 1749 cycles
clear_lores:

	lda	#$0						; 2
	ldx	#10						; 2
							;===========
							;	  4
clear_lores_loop:
	sta	$600,X		; 8				; 5
	sta	$680,X		; 10				; 5
	sta	$700,X		; 12				; 5
	sta	$780,X		; 14				; 5
	sta	$428,X		; 16				; 5
	sta	$4A8,X		; 18				; 5
	sta	$528,X		; 20				; 5
	sta	$5A8,X		; 22				; 5
	sta	$628,X		; 24				; 5
	sta	$6A8,X		; 26				; 5
	sta	$728,X		; 28				; 5
	sta	$7A8,X		; 30				; 5
	sta	$450,X		; 32				; 5
	sta	$4D0,X		; 34				; 5
	sta	$550,X		; 36				; 5
	sta	$5D0,X		; 38				; 5
							;===========
							;	80

	inx							; 2
	cpx	#30						; 2
	bne	clear_lores_loop				; 3
							;===========
							;	  7

								; -1
	rts							; 6


tree:
	;	color	start	stop		; 01234567890123456789
	.byte	$DD,	19,	20,	$00	;          YY
	.byte	$44,	17,	22,	$00	;        DDDDDD
	.byte	$CC,	16,	23,	$00	;       LLLLLLLL
	.byte	$44,	15,	24,	$00	;      DDDDDDDDDD
	.byte	$CC,	14,	25,	$00	;     LLLLLLLLLLLL
	.byte	$44,	13,	26,	$00	;    DDDDDDDDDDDDDD
	.byte	$CC,	12,	27,	$00	;   LLLLLLLLLLLLLLLL
	.byte	$44,	11,	28,	$00	;  DDDDDDDDDDDDDDDDDD
	.byte	$CC,	10,	29,	$00	; LLLLLLLLLLLLLLLLLLLL
	.byte	$88,	19,	20,	$00	;          BB

gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0

which_line_y:
	.byte 0

.include "sines.inc"
