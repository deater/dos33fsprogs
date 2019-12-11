; Display falling snow

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

HGR		= $F3E2

.include	"hardware.inc"


	;==================================
	;==================================

	jsr	HGR
	bit	FULLGR

display_loop:

	; 0 4 8 c 10 14 18 1c
	; 0 1 2 3 4  5  6  7

	;=========================
	; erase old snow

	ldx	#0
erase_loop:
	lda	snow_y,X
	lsr
	lsr
	and	#$fe
;	lsr
	tay
	clc
	lda	hgr_offsets,Y
	adc	snow_x,X
	sta	GBASL

	lda	snow_y,X
	asl
	asl
	and	#$1f
	clc
	adc	hgr_offsets+1,Y
	sta	GBASH

	ldy	#0
	lda	#0
	sta	(GBASL),Y

	inx
	cpx	#8
	bne	erase_loop

	;==========================
	; move snow

	ldx	#0
move_snow:
	lda	snow_y,X		; inc to next line
	cmp	#191
	bne	just_inc

	lda	#0
	sta	snow_y,X
	jmp	done_inc


just_inc:
	inc	snow_y,X
done_inc:
	inx
	cpx	#8
	bne	move_snow


	;=========================
	; draw new snow

	ldx	#0
draw_loop:
	lda	snow_y,X
	lsr
	lsr
;	lsr
	and	#$fe
	tay
	clc
	lda	hgr_offsets,Y
	adc	snow_x,X
	sta	GBASL

	lda	snow_y,X
	asl
	asl
	and	#$1f
	clc
	adc	hgr_offsets+1,Y
	sta	GBASH

	ldy	#0
	lda	#1
	sta	(GBASL),Y

	inx
	cpx	#8
	bne	draw_loop

	lda	#100
	jsr	WAIT

	jmp	display_loop				; 3


snow_x:
	.byte 2,4,6,8,10,12,14,16

snow_offset:
	.byte 0,1,2,3,4,5,6,7

snow_y:
	.byte 0,0,0,0,0,0,0,0

hgr_offsets:
.word	$2000,$2080,$2100,$2180,$2200,$2280,$2300,$2380
.word	$2028,$20A8,$2128,$21A8,$2228,$22A8,$2328,$23A8
.word	$2050,$20D0,$2150,$21D0,$2250,$22D0,$2350,$23D0
