rocket_away:

	jsr	clear_bottom

	jsr	HGR2		; Hi-res graphics, no text at bottom
				; Y=0, A=0 after this called

	lda	#<(outline_space_lzsa)
	sta	getsrc_smc+1
	lda	#>(outline_space_lzsa)
	sta	getsrc_smc+2

	lda	#$20

	jsr	decompress_lzsa2_fast

	lda	#<(outline_space_lzsa)
	sta	getsrc_smc+1
	lda	#>(outline_space_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast


	lda	#16		; 112 / 7 = 16
	sta	XX

rocket_movement:

	;=======================================
	; draw new
	;=======================================
	; start at 112,80

	lda	HGR_PAGE
	cmp	#$20
	bne	draw_odd

	lda	#<rocket_sprite_even
	sta	INL
	lda	#>rocket_sprite_even
	jmp	done_draw_odd

draw_odd:
	lda	#<rocket_sprite_odd
	sta	INL
	lda	#>rocket_sprite_odd

done_draw_odd:
	sta	INH


	lda	#80
	sta	YY

hsprite_yloop:
	ldy	#0
	ldx	#0
	lda	YY
	jsr	HPOSN	; X= (y,x) Y=(a)	now in GBASL with Y

	; handle if negative

	lda	XX
	bpl	not_offscreen

	; blurgh

	clc
	adc	GBASL
	sta	GBASL

	lda	XX
	eor	#$ff
	clc
	adc	#1
	tay

	jmp	hsprite_xloop

not_offscreen:
	clc
	adc	GBASL
	sta	GBASL

	ldy	#0
hsprite_xloop:
	lda	(INL),Y
	sta	(GBASL),Y
	iny
	cpy	#8
	bne	hsprite_xloop

	lda	INL
	clc
	adc	#8
	sta	INL
	lda	#0
	adc	INH
	sta	INH

	inc	YY
	lda	YY
	cmp	#92
	bne	hsprite_yloop

	;=======================================
	; delay a few seconds
	;=======================================

	jsr	hgr_page_flip

	ldx	#10
	jsr	long_wait

	;=======================================
	; erase old
	;=======================================
	; start at 112,80

	lda	#80
	sta	YY

herase_yloop:
	ldy	#0
	ldx	#0
	lda	YY
	jsr	HPOSN	; X= (y,x) Y=(a)	now in GBASL with Y

	lda	XX
	clc
	adc	GBASL
	sta	GBASL

	ldy	#0
herase_xloop:
	lda	#0
	sta	(GBASL),Y
	iny
	cpy	#8		; erase + 1
	bne	herase_xloop

	lda	INL
	clc
	adc	#7
	sta	INL
	lda	#0
	adc	INH
	sta	INH

	inc	YY
	lda	YY
	cmp	#92
	bne	herase_yloop


	dec	XX
	lda	XX
	cmp	#$f8
	beq	donedone
	jmp	rocket_movement

donedone:
;	jmp	donedone

	ldx	#50
	jsr	long_wait

	rts

	; 46x12, 46/7 = 7 roughly?
	; all orange is 1 0 10 10 10     1 1 01 01 01
	;		$AA,$D5

	;                  1 100 0101  1 010 0000
	; 		1 000 1000	1 101 0101
	;				1 101 0001
	;	1 000 1000	1001 0101
	;	0001000

rocket_sprite_even:
;.byte	7,12
.byte	$00,$00,$00,$00,$AA,$81,$00,$00
.byte	$00,$00,$00,$C0,$8A,$00,$00,$00
.byte	$00,$00,$00,$00,$00,$00,$00,$00
.byte	$A0,$C5,$AA,$D5,$8A,$00,$00,$00
.byte	$88,$D5,$AA,$95,$AA,$55,$2A,$00
.byte	$AA,$D1,$80,$D5,$AA,$D5,$AA,$00
.byte	$AA,$D5,$AA,$D5,$AA,$55,$2A,$00
.byte	$A8,$D1,$88,$95,$AA,$00,$00,$00
.byte	$A0,$C5,$AA,$D5,$8A,$00,$00,$00
.byte	$00,$00,$00,$00,$00,$00,$00,$00
.byte	$00,$00,$00,$C0,$8A,$00,$00,$00
.byte	$00,$00,$00,$00,$AA,$81,$00,$00


; shift pixels right by 1

rocket_sprite_odd:
.byte $00,$00,$00,$00,$D4,$82,$00,$00
.byte $00,$00,$00,$80,$95,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $C0,$8A,$D5,$AA,$95,$00,$00,$00
.byte $90,$AA,$D5,$AA,$D4,$2A,$55,$00
.byte $D4,$A2,$81,$AA,$D5,$AA,$D5,$00
.byte $D4,$AA,$D5,$AA,$D5,$2A,$55,$00
.byte $D0,$A2,$91,$AA,$D4,$00,$00,$00
.byte $C0,$8A,$D5,$AA,$95,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$80,$95,$00,$00,$00
.byte $00,$00,$00,$00,$D4,$82,$00,$00
