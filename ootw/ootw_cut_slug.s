
slug_cutscene:

	;====================
	; First the slug part

	lda	#$8
	sta	DRAW_PAGE
        jsr	clear_top

	lda	#<slug_background
	sta	INL
	lda	#>slug_background
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
sluggy_loop:
        jsr     gr_copy_to_current

	ldx	CUTFRAME

	lda	slug_frames,X
	sta	INL
	lda	slug_frames+1,X
	sta	INH

	lda	#15
	sta     XPOS

	lda	#18
	sta	YPOS

	jsr	put_sprite

	jsr	page_flip

	ldx	#2
long_delay:
	lda	#250
	jsr	WAIT
	dex
	bne	long_delay


	ldx	CUTFRAME
	inx
	inx
	stx	CUTFRAME

	cpx	#12
	beq	sluggy_end

	jmp	sluggy_loop

sluggy_end:


	;====================
	; Then the leg part

	lda	#$8
	sta	DRAW_PAGE
        jsr	clear_top

	lda	#<leg_background
	sta	INL
	lda	#>leg_background
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
leg_loop:
        jsr     gr_copy_to_current

	ldx	CUTFRAME

	lda	leg_frames,X
	sta	INL
	lda	leg_frames+1,X
	sta	INH

	lda	#18
	sta     XPOS

	lda	#18
	sta	YPOS

	jsr	put_sprite

	jsr	page_flip

	ldx	#4
long_delay2:
	lda	#250
	jsr	WAIT
	dex
	bne	long_delay2

	ldx	CUTFRAME
	inx
	inx
	stx	CUTFRAME

	cpx	#12
	beq	leg_end

	jmp	leg_loop

leg_end:

	;=============================
	; Restore background to $c00

	jmp	cavern_load_background

;	rts		; tail call?

; sluggy freelance

slug_frames:
	.word	sluggy1
	.word	sluggy2
	.word	sluggy3
	.word	sluggy4
	.word	sluggy5
	.word	sluggy6

leg_frames:
	.word	leg1
	.word	leg2
	.word	leg3
	.word	leg4
	.word	leg5
	.word	leg5

