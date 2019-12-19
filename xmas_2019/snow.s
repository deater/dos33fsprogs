; Display falling snow

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
CH		= $24
CV		= $25
GBASL		= $26
GBASH		= $27
BASL		= $28
BASH		= $29

SEEDL		= $4E
SEEDH		= $4F

HGR_COLOR	= $E4
SNOWX		= $F0

HGR		= $F3E2


NUMFLAKES	= 10


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
	lda	snow_y,X			; get Y
	lsr
	lsr
	lsr					; divide by 8
	tay

	clc
	lda	hgr_offsets_l,Y
	adc	snow_x,X
	sta	GBASL				; point GBASL to right location

	lda	snow_y,X
	asl
	asl
	and	#$1f
	clc
	adc	hgr_offsets_h,Y
	sta	GBASH

	ldy	#0
	lda	#0
	sta	(GBASL),Y

	inx
	cpx	#NUMFLAKES
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

	jsr	random16
	lda	SEEDL
	and	#$f

	beq	snow_left
	cmp	#$1
	beq	snow_right

	inc	snow_y,X

	jmp	snow_no

snow_right:
	inc	snow_offset,X
	jmp	snow_no

snow_left:
	dec	snow_offset,X
snow_no:

done_inc:
	inx
	cpx	#NUMFLAKES
	bne	move_snow


	;=========================
	; draw new snow

	ldx	#0
draw_loop:
	lda	snow_y,X
	lsr
	lsr
	lsr
	tay
	clc
	lda	hgr_offsets_l,Y
	adc	snow_x,X
	sta	GBASL

	lda	snow_y,X
	asl
	asl
	and	#$1f
	clc
	adc	hgr_offsets_h,Y
	sta	GBASH

	ldy	#0
	lda	#1
	sta	(GBASL),Y

	inx
	cpx	#NUMFLAKES
	bne	draw_loop

	lda	#100
	jsr	WAIT

	jmp	display_loop				; 3


snow_x:
	.byte 2,4,6,8,10,12,14,16,18,20

snow_offset:
	.byte 0,1,2,3,4,5,6,7,0,1

snow_y:
	.byte 0,0,0,0,0,0,0,0,0,0

hgr_offsets_h:
.byte	>$2000,>$2080,>$2100,>$2180,>$2200,>$2280,>$2300,>$2380
.byte	>$2028,>$20A8,>$2128,>$21A8,>$2228,>$22A8,>$2328,>$23A8
.byte	>$2050,>$20D0,>$2150,>$21D0,>$2250,>$22D0,>$2350,>$23D0

hgr_offsets_l:
.byte	<$2000,<$2080,<$2100,<$2180,<$2200,<$2280,<$2300,<$2380
.byte	<$2028,<$20A8,<$2128,<$21A8,<$2228,<$22A8,<$2328,<$23A8
.byte	<$2050,<$20D0,<$2150,<$21D0,<$2250,<$22D0,<$2350,<$23D0


.include "random16.s"
