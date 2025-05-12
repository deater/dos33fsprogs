
draw_road:

	;================================
	; copy in MAIN graphics

	ldy	ROAD_COUNT
	ldx	animation_main,Y
	jsr	copy_to_400_main

	;==============================
	; move to next animation frame

	inc	ROAD_COUNT
	lda	ROAD_COUNT
	and	#$7
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
        .byte $d0,$d4,$d8,$dc,$e0,$e4,$e8,$ec           ; plain
