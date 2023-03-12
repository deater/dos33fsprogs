
draw_score:
	ldy	#0

	lda	#42
	sta	YPOS

	ldx	#10

draw_score_1_loop:

	lda	score_xpos,Y
	sta	XPOS

	lda	score1_l,Y
	sta	INL
	lda	score1_h,Y
	sta	INH

	txa
	pha
	tya
	pha

	jsr	gr_put_sprite

	pla
	tay
	pla
	tax

	iny

	dex
	bne	draw_score_1_loop

	rts

score1_l:
	.byte <d_sprite
	.byte <one_sprite
	.byte <colon_sprite
	.byte <space_sprite
	.byte <zero_sprite
score2_l:
	.byte <d_sprite
	.byte <two_sprite
	.byte <colon_sprite
	.byte <four_sprite
	.byte <zero_sprite

score1_h:
	.byte >d_sprite
	.byte >one_sprite
	.byte >colon_sprite
	.byte >space_sprite
	.byte >zero_sprite
score2_h:
	.byte >d_sprite
	.byte >two_sprite
	.byte >colon_sprite
	.byte >four_sprite
	.byte >zero_sprite

score_xpos:
	.byte  1, 5, 8,11,15
	.byte 22,26,29,32,36



score_inc_d1:
	lda	D1_SCORE
	clc

	sed				; enter decimal mode
	adc	#1
	sta	D1_SCORE

	lda	#0			; handle overflow to hundreds
	adc	D1_SCORE_H
	sta	D1_SCORE_H

	cld				; back from decimal mode

update_d1_score:
	lda	D1_SCORE
	and	#$f
	tay
	lda	number_sprites_l,Y
	sta	score1_l+4
	lda	number_sprites_h,Y
	sta	score1_h+4

	lda	D1_SCORE
	lsr
	lsr
	lsr
	lsr
	tay
	lda	number_sprites_l,Y
	sta	score1_l+3
	lda	number_sprites_h,Y
	sta	score1_h+3

	rts


number_sprites_l:
	.byte <zero_sprite
	.byte <one_sprite
	.byte <two_sprite
	.byte <three_sprite
	.byte <four_sprite
	.byte <five_sprite
	.byte <six_sprite
	.byte <seven_sprite
	.byte <eight_sprite
	.byte <nine_sprite

number_sprites_h:
	.byte >zero_sprite
	.byte >one_sprite
	.byte >two_sprite
	.byte >three_sprite
	.byte >four_sprite
	.byte >five_sprite
	.byte >six_sprite
	.byte >seven_sprite
	.byte >eight_sprite
	.byte >nine_sprite


