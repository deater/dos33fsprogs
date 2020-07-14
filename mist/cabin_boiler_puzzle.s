	; this is a painful one

goto_safe:
	lda	#CABIN_SAFE
	sta	LOCATION
	jmp	change_location



control_panel_pressed:

	lda	CURSOR_Y
	cmp	#26		; blt
	bcc	panel_inc
	cmp	#30		; blt
	bcc	panel_dec

panel_latch:

	lda	VIEWER_CHANNEL
	sta	VIEWER_LATCHED	; latch value into pool state

	lda	#VIEWER_POOL
	sta	LOCATION

	lda	#DIRECTION_W
	sta	DIRECTION
	jmp	change_location

panel_inc:
	lda	CURSOR_X
	cmp	#18
	bcs	right_arrow_pressed

	; 19-23 left arrow

	lda	VIEWER_CHANNEL
	and	#$f0
	cmp	#$90
	bcs	done_panel_press	; bge
	lda	VIEWER_CHANNEL
	clc
	adc	#$10
	sta	VIEWER_CHANNEL
	rts

right_arrow_pressed:
	; 13-17 right arrow

	lda	VIEWER_CHANNEL
	and	#$f
	cmp	#9
	bcs	done_panel_press	; bge
	inc	VIEWER_CHANNEL
	rts

panel_dec:
	lda	CURSOR_X
	cmp	#18
	bcs	right_arrow_pressed_dec

	; 19-23 left arrow

	lda	VIEWER_CHANNEL
	and	#$f0
	beq	done_panel_press
	lda	VIEWER_CHANNEL
	sec
	sbc	#$10
	sta	VIEWER_CHANNEL
	rts

right_arrow_pressed_dec:
	; 13-17 right arrow

	lda	VIEWER_CHANNEL
	and	#$f
	beq	done_panel_press
	dec	VIEWER_CHANNEL

done_panel_press:
	rts


display_panel_code:

	; ones digit

	lda	VIEWER_CHANNEL
	and	#$f
	asl
	tay

	lda	number_sprites,Y
	sta	INL
	lda	number_sprites+1,Y
	sta	INH

	lda	#21
	sta	XPOS
	lda	#8
	sta	YPOS

	jsr	put_sprite_crop

	; tens digit

	lda	VIEWER_CHANNEL
	and	#$f0
	lsr
	lsr
	lsr
	tay

	lda	number_sprites,Y
	sta	INL
	lda	number_sprites+1,Y
	sta	INH

	lda	#15
	sta	XPOS
	lda	#8
	sta	YPOS

	jsr	put_sprite_crop

	rts

