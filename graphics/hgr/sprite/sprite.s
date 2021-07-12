
.include "hardware.inc"

XX		= $00
YY		= $01
NIBCOUNT	= $09

GBASL		= $26
GBASH		= $27

sprite_test:

	jsr	HGR		; Hi-res graphics
	bit	FULLGR		; full screen


	lda	#<(mona_lzsa)
	sta	getsrc_smc+1
	lda	#>(mona_lzsa)
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast



	;==================
	; sprite stuff

	lda	#10
	sta	XX
	lda	#10
	sta	YY

forever:
	jsr	save_bg			; save bg

	jsr	draw_sprite		; draw sprite

keyloop:
	lda	KEYPRESS
	bpl	keyloop

	pha
	jsr	restore_bg		; restore bg
	pla

check_right:
	cmp	#'D'|$80
	bne	check_left

	inc	XX
	jmp	done_key

check_left:
	cmp	#'A'|$80
	bne	check_up

	dec	XX
	jmp	done_key

check_up:
	cmp	#'W'|$80
	bne	check_down

	dec	YY
	dec	YY
	dec	YY
	dec	YY
	dec	YY

	jmp	done_key

check_down:
	cmp	#'S'|$80
	bne	done_key

	inc	YY
	inc	YY
	inc	YY
	inc	YY
	inc	YY

	jmp	done_key

done_key:
	lda	KEYRESET
nokey:

	jmp	forever


	;======================
	; draw sprite
	;======================

draw_sprite:

	ldx	#0
sprite_yloop:
	txa
	pha

	clc
	adc	YY

	ldx	#0
	ldy	#0

	; calc GBASL/GBASH
	jsr	HPOSN	; (Y,X),(A)  (values stored in HGRX,XH,Y)

	pla
	tax

	ldy	XX

	lda	(GBASL),Y
	and	hand_mask_l,X
	ora	hand_sprite_l,X
	sta	(GBASL),Y

	iny

	lda	(GBASL),Y
	and	hand_mask_r,X
	ora	hand_sprite_r,X
	sta	(GBASL),Y

	inx
	cpx	#14
	bne	sprite_yloop

	rts



	;======================
	; save bg
	;======================

save_bg:

	ldx	#0
save_yloop:
	txa
	pha

	clc
	adc	YY

	ldx	#0
	ldy	#0

	; calc GBASL/GBASH
	jsr	HPOSN	; (Y,X),(A)  (values stored in HGRX,XH,Y)

	pla
	tax

	ldy	XX

	lda	(GBASL),Y
	sta	save_left,X

	iny

	lda	(GBASL),Y
	sta	save_right,X

	inx
	cpx	#14
	bne	save_yloop

	rts

	;======================
	; restore bg
	;======================

restore_bg:

	ldx	#0
restore_yloop:
	txa
	pha

	clc
	adc	YY

	ldx	#0
	ldy	#0

	; calc GBASL/GBASH
	jsr	HPOSN	; (Y,X),(A)  (values stored in HGRX,XH,Y)

	pla
	tax

	ldy	XX

	lda	save_left,X
	sta	(GBASL),Y

	iny

	lda	save_right,X
	sta	(GBASL),Y


	inx
	cpx	#14
	bne	restore_yloop

	rts



.include "decompress_fast_v2.s"

.include "graphics/graphics.inc"


; hand sprite

hand_mask_l:			; X 654 3 210
.byte	$9f			; 1 001 1 111
.byte	$8f			; 1 000 1 111
.byte	$8f			; 1 000 1 111
.byte	$8f			; 1 000 1 111
.byte	$88			; 1 000 1 000
.byte	$80			; 1 000 0 000
.byte	$80			; 1 000 0 000
.byte	$80			; 1 000 0 000
.byte	$81			; 1 000 0 001
.byte	$81			; 1 000 0 001
.byte	$83			; 1 000 0 011
.byte	$87			; 1 000 0 111
.byte	$8f			; 1 000 1 111
.byte	$8f			; 1 000 1 111

hand_sprite_l:			; X 654 3 210
.byte	$00			; 0 000 0 000
.byte	$60			; 0 110 0 000
.byte	$60			; 0 110 0 000
.byte	$60			; 0 110 0 000
.byte	$60			; 0 110 0 000
.byte	$63			; 0 110 0 011
.byte	$66			; 0 110 0 110
.byte	$2c			; 0 010 1 100
.byte	$6c			; 0 110 1 100
.byte	$78			; 0 111 1 000
.byte	$70			; 0 111 0 000
.byte	$70			; 0 111 0 000
.byte	$60			; 0 110 0 000
.byte	$60			; 0 110 0 000

hand_mask_r:			; X 654 3 210
.byte	$ff			; 1 111 1 111
.byte	$fe			; 1 111 1 110
.byte	$fe			; 1 111 1 110
.byte	$fe			; 1 111 1 110
.byte	$e0			; 1 110 0 000
.byte	$80			; 1 000 0 000
.byte	$80			; 1 000 0 000
.byte	$80			; 1 000 0 000
.byte	$80			; 1 000 0 000
.byte	$80			; 1 000 0 000
.byte	$80			; 1 000 0 000
.byte	$80			; 1 000 0 000
.byte	$c0			; 1 100 0 000
.byte	$c0			; 1 100 0 000

hand_sprite_r:			; X 654 3 210
.byte	$00			; 0 000 0 000
.byte	$00			; 0 000 0 000
.byte	$00			; 0 000 0 000
.byte	$00			; 0 000 0 000
.byte	$00			; 0 000 0 000
.byte	$0A			; 0 000 1 010
.byte	$2A			; 0 010 1 010
.byte	$2D			; 0 010 1 101
.byte	$37			; 0 011 0 111
.byte	$3F			; 0 011 1 111
.byte	$3F			; 0 011 1 111
.byte	$1F			; 0 001 1 111
.byte	$1F			; 0 001 1 111
.byte	$1F			; 0 001 1 111


save_right:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

save_left:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
