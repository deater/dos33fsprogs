
draw_road:

	;================================
	; copy in MAIN graphics

	ldy	ROAD_COUNT
	ldx	animation_main,Y
	jsr	copy_to_400_main

	;==============================
	; move to next animation frame

	lda	ROAD_FILE
	cmp	#24
	bne	normal_road

	; urgh only 2 here

	inc	ROAD_COUNT
	lda	ROAD_COUNT
	and	#$1
	jmp	road_common

normal_road:
	inc	ROAD_COUNT
	lda	ROAD_COUNT
	and	#$7
road_common:
	sta	ROAD_COUNT	; wrap at 8

	bne	no_oflo


	; start decompress


	lda	#1
	sta	START_DECOMPRESS

no_oflo:

;	jsr	wait_vblank

	;============================
	; page flip

	jsr	gr_flip_page

	rts

animation_main:
	.byte $0e,$12,$16,$1a,$1e,$22,$26,$2a		; plain
