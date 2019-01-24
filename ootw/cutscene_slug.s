
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


slug_background:
	.byte 10,10
	.byte $22,$22,$22,$22,$22,$22,$22,$22,$22,$22
	.byte $22,$22,$22,$22,$22,$22,$22,$22,$22,$22
	.byte $22,$22,$22,$22,$22,$22,$22,$22,$22,$22
	.byte $22,$22,$22,$22,$22,$22,$22,$22,$22,$22
	.byte $22,$22,$22,$22,$22,$22,$22,$22,$22,$22
	.byte $22,$22,$22,$22,$22,$22,$22,$22,$22,$22
	.byte $22,$22,$22,$22,$22,$22,$22,$22,$22,$22
	.byte $22,$22,$22,$22,$22,$22,$22,$22,$22,$22
	.byte $22,$22,$22,$22,$22,$22,$22,$22,$22,$22
	.byte $22,$22,$22,$22,$22,$22,$22,$22,$22,$22


; sluggy freelance

slug_frames:
	.word	sluggy1
	.word	sluggy2
	.word	sluggy3
	.word	sluggy4
	.word	sluggy5
	.word	sluggy6

sluggy1:
	.byte 10,6
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$0A,$0A,$0A,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$77,$00,$00,$00
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$07,$00,$00,$00
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00

sluggy2:
	.byte 10,6
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$0A,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$77,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$07,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA

sluggy3:
	.byte 10,6
	.byte $AA,$AA,$AA,$AA,$AA,$0A,$0A,$0A,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$7A,$07,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$A1,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA

sluggy4:
	.byte 10,6
	.byte $AA,$1A,$AA,$7A,$7A,$70,$00,$00,$0A,$AA
	.byte $AA,$AA,$AA,$AA,$1A,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA

sluggy5:
	.byte 10,6
	.byte $1A,$AA,$AA,$7A,$7A,$70,$00,$00,$0A,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$1A,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA

sluggy6:
	.byte 10,6
	.byte $AA,$AA,$AA,$7A,$7A,$70,$00,$00,$0A,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$1A,$AA,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$00,$00,$00,$00,$AA


leg_background:
	.byte 10,10
	.byte $44,$cc,$cc,$cc,$77,$77,$77,$77,$77,$77
	.byte $44,$cc,$cc,$cc,$27,$27,$77,$77,$77,$77
	.byte $44,$cc,$cc,$cc,$42,$22,$77,$77,$77,$77
	.byte $44,$cc,$cc,$cc,$44,$22,$22,$22,$27,$27
	.byte $44,$4c,$cc,$cc,$c4,$42,$22,$22,$22,$22
	.byte $22,$44,$cc,$cc,$cc,$44,$22,$22,$22,$22
	.byte $22,$44,$cc,$cc,$cc,$44,$22,$22,$22,$22
	.byte $22,$44,$cc,$cc,$4c,$44,$22,$22,$22,$22
	.byte $22,$44,$cc,$cc,$c4,$44,$22,$22,$22,$22
	.byte $22,$44,$cc,$cc,$cc,$44,$22,$22,$22,$22

leg_frames:
	.word	leg1
	.word	leg2
	.word	leg3
	.word	leg4
	.word	leg5
	.word	leg5

leg1:
	.byte $5,$6
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$0A,$AA
	.byte $AA,$AA,$A7,$00,$00
	.byte $AA,$AA,$AA,$00,$00
	.byte $AA,$AA,$AA,$00,$00
	.byte $AA,$AA,$AA,$00,$00

leg2:
	.byte $4,$6
	.byte $AA,$AA,$AA,$AA
	.byte $bA,$AA,$0A,$AA
	.byte $AA,$A7,$00,$00
	.byte $AA,$AA,$00,$00
	.byte $AA,$AA,$00,$00
	.byte $AA,$AA,$00,$00

leg3:
	.byte $4,$6
	.byte $AA,$AA,$AA,$AA
	.byte $bA,$AA,$AA,$AA
	.byte $bb,$AA,$0A,$AA
	.byte $AB,$A7,$00,$00
	.byte $AA,$AA,$00,$00
	.byte $AA,$AA,$00,$00

leg4:
	.byte $4,$6
	.byte $AA,$AA,$AA,$AA
	.byte $bA,$AA,$AA,$AA
	.byte $1B,$AA,$AA,$AA
	.byte $BB,$AA,$0A,$AA
	.byte $AA,$A7,$00,$00
	.byte $AA,$AA,$00,$00
leg5:
	.byte $1,$4
	.byte $AA
	.byte $bA
	.byte $11
	.byte $b1
