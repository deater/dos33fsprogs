

;======================
; draw the clock face

draw_clock_face:


	lda	CLOCK_HOUR
	asl
	tay
	lda	clock_hour_sprites,Y
	sta	INL
	lda	clock_hour_sprites+1,Y
	sta	INH

	lda	#20
	sta	XPOS
	lda	#6
	sta	YPOS
	jsr	put_sprite_crop

	lda	CLOCK_MINUTE
	asl
	tay
	lda	clock_minute_sprites,Y
	sta	INL
	lda	clock_minute_sprites+1,Y
	sta	INH

	lda	#20
	sta	XPOS
	lda	#6
	sta	YPOS
	jsr	put_sprite_crop


	rts





.include "clock_sprites.inc"
