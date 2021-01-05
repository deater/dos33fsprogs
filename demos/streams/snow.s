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
TEMPY		= $F1

HGR		= $F3E2


NUMFLAKES	= 10


.include	"hardware.inc"


	;==================================
	;==================================

	jsr	HGR
	bit	FULLGR


	;==================================
	; init snow
	;==================================

	ldx	#NUMFLAKES-1
snow_init_loop:

	jsr	random16

	lda	SEEDL
	and	#$3f
	sta	snow_x,X

	lda	SEEDH
	and	#$7f
	sta	snow_y,X

	dex
	bpl	snow_init_loop


display_loop:

	; 0 4 8 c 10 14 18 1c
	; 0 1 2 3 4  5  6  7

	;=========================
	; erase old snow
	;=========================
	; 2 + (35+29+7)*NUMFLAKES - 1
	; 1 +71*NUMFLAKES = 711

	ldx	#0					; 2
erase_loop:
	lda	snow_y,X	; get Y			; 4+
	lsr						; 2
	lsr						; 2
	lsr			; divide by 8		; 2
	sta	TEMPY					; 3
	lda	snow_x,X				; 4+
	tay						; 2
	lda	div_7_q,Y				; 4+
	ldy	TEMPY					; 3
	clc						; 2
	adc	hgr_offsets_l,Y				; 4+
	sta	GBASL					; 3
	adc	#30
	sta	BASL
						;=============
						;         35

	lda	snow_y,X				; 4+
	asl						; 2
	asl						; 2
	and	#$1f					; 2
	clc						; 2
	adc	hgr_offsets_h,Y				; 4
	sta	GBASH					; 3
	sta	BASH
	lda	#0					; 2
	tay						; 2
	sta	(GBASL),Y				; 6
	sta	(BASL),Y

						;============
						;        29

	inx						; 2
	cpx	#NUMFLAKES				; 2
	bne	erase_loop				; 3
						;============
						;	  7

							; -1

	;==========================
	; move snow
	;
	; 2 + 

	ldx	#0					; 2
move_snow:
	lda	snow_y,X				; 4+
	cmp	#160					; 2
	bne	just_inc				; 3
							; -1

	; out of bounds, get new
	lda	#30					; 2
	sta	snow_y,X				; 5
	lda	SEEDH
	and	#$3f
	sta	snow_x,X
	jmp	done_inc				; 3


just_inc:

	jsr	random16				; 6+42
	lda	SEEDL					; 3
	and	#$f					; 2

	beq	snow_left				; 3
							; -1
	cmp	#$1					; 2
	beq	snow_right				; 3
							; -1

	inc	snow_y,X				; 6

	jmp	snow_no					; 3

snow_right:
	inc	snow_x,X				; 6
	jmp	snow_no					; 3

snow_left:
	dec	snow_x,X				; 6
snow_no:
	lda	snow_x,X
	and	#$3f
	sta	snow_x,X

done_inc:
	inx						; 2
	cpx	#NUMFLAKES				; 2
	bne	move_snow				; 3
							; -1

	;=========================
	; draw new snow
	;=========================
	; 2+ (35+22+19+7)*NUMFLAKES -1
	; 1+83*NUMFLAKES = 831

	ldx	#0					; 2
draw_loop:
	lda	snow_y,X				; 4+
	lsr						; 2
	lsr						; 2
	lsr						; 2
	sta	TEMPY					; 3
	lda	snow_x,X				; 4+
	tay						; 2
	lda	div_7_q,Y				; 4+
	ldy	TEMPY					; 3
	clc						; 2
	adc	hgr_offsets_l,Y				; 4+
	sta	GBASL					; 3
	adc	#32
	sta	BASL
						;===========
						;	35

	lda	snow_y,X				; 4+
	asl						; 2
	asl						; 2
	and	#$1f					; 2
	clc						; 2
	adc	hgr_offsets_h,Y				; 4+
	sta	GBASH					; 3
	sta	BASH
						;=============
						;	19

	ldy	snow_x,X				; 4+
	lda	div_7_r,Y				; 4+
	tay						; 2
	lda	pixel_lookup,Y				; 4+

	ldy	#0					; 2
	sta	(GBASL),Y				; 6
	sta	(BASL),Y
						;=============
						;	22

	inx						; 2
	cpx	#NUMFLAKES				; 2
	bne	draw_loop				; 3
						;=============
						;	  7

							; -1
	lda	#100
	jsr	WAIT

	jmp	display_loop				; 3


snow_x:
	.byte 0,0,0,0,0,0,0,0,0,0

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


div_7_q:
	.byte 0,0,0,0,0,0,0		; 0..6
	.byte 1,1,1,1,1,1,1		; 7..13
	.byte 2,2,2,2,2,2,2		; 14..20
	.byte 3,3,3,3,3,3,3		; 21..27
	.byte 4,4,4,4,4,4,4		; 28..34
	.byte 5,5,5,5,5,5,5		; 35..41
	.byte 6,6,6,6,6,6,6		; 42..48
	.byte 7,7,7,7,7,7,7		; 49..55
	.byte 8,8,8,8,8,8,8		; 56..62
	.byte 9				; 63

div_7_r:
	.byte 0,1,2,3,4,5,6		; 0..6
	.byte 0,1,2,3,4,5,6		; 7..13
	.byte 0,1,2,3,4,5,6		; 14..20
	.byte 0,1,2,3,4,5,6		; 21..27
	.byte 0,1,2,3,4,5,6		; 28..34
	.byte 0,1,2,3,4,5,6		; 35..41
	.byte 0,1,2,3,4,5,6		; 42..48
	.byte 0,1,2,3,4,5,6		; 49..55
	.byte 0,1,2,3,4,5,6		; 56..62
	.byte 0				; 63

pixel_lookup:
	.byte $01,$02,$04,$08,$10,$20,$40

.include "random16.s"
