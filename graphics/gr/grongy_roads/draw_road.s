	;=================================================
	; 194 frames to draw.  This is an annoying number
	;=================================================
	; this runs in the interrupt handler?
	;=================================================
	; 8 frames at a time are decompressed to a buffer
	;   this code copies the next one to the proper lo-res page
	;   if it is frame #7 (the last frame) then it starts decompressing
	;   the next one.  The hope is it's done the 1st 1k (1 frame)
	;   before it is time to display that one

draw_road:
	;==============================
	; copy in frame

	ldy	ROAD_COUNT			; get current frame count
	ldx	animation_main,Y		; get offset to copy from
	jsr	copy_to_400_main		; copy to proper page

	;==============================
	; move to next animation frame

	lda	ROAD_FILE			; check which of 0..24 we're in
	cmp	#22				; if < 22 normal handling
	bcc	normal_road			; blt

special_road:
	; Files 22,23,24 are "special" and only have 6 frames
	;   this is all because 194 is not a nice multiple of 8

	inc	ROAD_COUNT			; increment
	lda	ROAD_COUNT

	cmp	#5
	beq	road_start_decompress

	cmp	#6
	beq	wrap_road
	bne	done_draw_road

normal_road:
	inc	ROAD_COUNT			; increment
	lda	ROAD_COUNT

	cmp	#7
	beq	road_start_decompress

	cmp	#8
	beq	wrap_road
	bne	done_draw_road


wrap_road:
	inc	ROAD_FILE
	lda	ROAD_FILE
	cmp	#25
	bne	road_file_ok
road_file_wrap:
	lda	#0
	sta	ROAD_FILE

road_file_ok:
	lda	#0
	sta	ROAD_COUNT
	beq	done_draw_road			; bra


	;=============================
	; next file: start decompress
road_start_decompress:
	;   it takes roughly 5 frames to decompress 8 frames


	lda	#1				; trigger decompress in
	sta	START_DECOMPRESS		; main thread

done_draw_road:

	;===============================
	; can't VBLANK, waiting up to 1/60s will take too long

;	jsr	wait_vblank

	;============================
	; page flip

	jsr	gr_flip_page			; page flip

	rts

animation_main:
	.byte $0e,$12,$16,$1a,$1e,$22,$26,$2a		; plain
