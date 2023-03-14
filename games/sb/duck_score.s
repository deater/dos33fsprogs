
draw_score:
	ldy	#0


	ldx	#10

draw_score_1_loop:

	lda	#42
	sta	YPOS

	lda	score_xpos,Y
	sta	XPOS

	lda	score1_l,Y
	sta	INL
	lda	score1_h,Y
	sta	INH

	lda	mask1_l,Y
	sta	MASKL
	lda	mask1_h,Y
	sta	MASKH


	txa
	pha
	tya
	pha

	jsr	gr_put_sprite_mask

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


mask1_l:
	.byte <d_mask
	.byte <one_mask
	.byte <colon_mask
	.byte <space_mask
	.byte <zero_mask
mask2_l:
	.byte <d_mask
	.byte <two_mask
	.byte <colon_mask
	.byte <four_mask
	.byte <zero_mask

mask1_h:
	.byte >d_mask
	.byte >one_mask
	.byte >colon_mask
	.byte >space_mask
	.byte >zero_mask
mask2_h:
	.byte >d_mask
	.byte >two_mask
	.byte >colon_mask
	.byte >four_mask
	.byte >zero_mask


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

	; update ones digit

	lda	D1_SCORE
	and	#$f
	tay
	lda	number_sprites_l,Y
	sta	score1_l+4
	lda	number_sprites_h,Y
	sta	score1_h+4
	lda	number_masks_l,Y
	sta	mask1_l+4
	lda	number_masks_h,Y
	sta	mask1_h+4

	; check if leading zero

	lda	D1_SCORE_H
	and	#$f
	bne	d1_score_no_lead_zero

	lda	D1_SCORE
	and	#$f0
	bne	d1_score_no_lead_zero

	lda	#<space_sprite
	sta	score1_l+3
	lda	#>space_sprite
	sta	score1_h+3

	lda	#<space_mask
	sta	mask1_l+3
	lda	#>space_mask
	sta	mask1_h+3

	jmp	done_d1_score

d1_score_no_lead_zero:

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

	lda	number_masks_l,Y
	sta	mask1_l+3
	lda	number_masks_h,Y
	sta	mask1_h+3


done_d1_score:


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

number_masks_l:
	.byte <zero_mask
	.byte <one_mask
	.byte <two_mask
	.byte <three_mask
	.byte <four_mask
	.byte <five_mask
	.byte <six_mask
	.byte <seven_mask
	.byte <eight_mask
	.byte <nine_mask

number_masks_h:
	.byte >zero_mask
	.byte >one_mask
	.byte >two_mask
	.byte >three_mask
	.byte >four_mask
	.byte >five_mask
	.byte >six_mask
	.byte >seven_mask
	.byte >eight_mask
	.byte >nine_mask



