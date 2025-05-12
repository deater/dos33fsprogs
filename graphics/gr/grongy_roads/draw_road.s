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
	cmp	#24				; if not 24 normal handling
	bne	normal_road

	; File #24 (the 25th one) is "special" and only has two frames

	inc	ROAD_COUNT			; increment
	lda	ROAD_COUNT
	and	#$1				; wrap at 2
	jmp	road_common

normal_road:
	inc	ROAD_COUNT			; increment
	lda	ROAD_COUNT
	and	#$7				; wrap at 8
road_common:
	sta	ROAD_COUNT			; store updated value

	bne	no_oflo				; if 0 on to next file

	;=============================
	; next file: start decompress

	lda	#1				; trigger decompress in
	sta	START_DECOMPRESS		; main thread

no_oflo:

	;===============================
	; can't VBLANK, waiting up to 1/60s will take too long

;	jsr	wait_vblank

	;============================
	; page flip

	jsr	gr_flip_page			; page flip

	rts

animation_main:
	.byte $0e,$12,$16,$1a,$1e,$22,$26,$2a		; plain
