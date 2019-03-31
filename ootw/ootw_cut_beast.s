
beast_cutscene:

	;====================
	; beast dropping in

	lda	#$8
	sta	DRAW_PAGE
        jsr	clear_top

	lda	#<beast_background
	sta	INL
	lda	#>beast_background
	sta	INH

	lda	#15
	sta     XPOS

	lda	#10
	sta	YPOS

	jsr	put_sprite

	lda	#$0
	sta	DRAW_PAGE

	jsr     gr_copy_to_current
        jsr     page_flip
        jsr     gr_copy_to_current
	jsr	page_flip

	ldx	#0
	stx	CUTFRAME
beast_loop:
        jsr     gr_copy_to_current

	ldx	CUTFRAME

	lda	beast_frames,X
	sta	INL
	lda	beast_frames+1,X
	sta	INH

	lda	#15
	sta     XPOS

	lda	#10
	sta	YPOS

	jsr	put_sprite

	jsr	page_flip

	ldx	#2
beast_long_delay:
	lda	#250
	jsr	WAIT
	dex
	bne	beast_long_delay


	ldx	CUTFRAME
	inx
	inx
	stx	CUTFRAME

	cpx	#28
	beq	beast_end

	jmp	beast_loop

beast_end:

	;=============================
	; Restore background to $c00

	lda	#>(cavern3_rle)
	sta	GBASH
	lda	#<(cavern3_rle)
	sta	GBASL
	lda	#$c			; load image off-screen $c00
	jmp	load_rle_gr

beast_frames:
	.word	beast_frame1		; 0
	.word	beast_frame2		; 1
	.word	beast_frame3		; 2
	.word	beast_frame4		; 3
	.word	beast_frame5		; 4
	.word	beast_frame6		; 5
	.word	beast_frame7		; 6
	.word	beast_frame8		; 7
	.word	beast_frame9		; 8
	.word	beast_frame10		; 9
	.word	beast_frame11		; 10
	.word	beast_frame12		; 11
	.word	beast_frame8		; 12
	.word	beast_frame8		; 13


