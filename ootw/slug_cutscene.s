
slug_cutscene:

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

	ldx	#6
long_delay:
	lda	#250
	jsr	WAIT
	dex
	bne	long_delay

	jsr	page_flip

	ldx	CUTFRAME
	inx
	inx
	stx	CUTFRAME

	cpx	#12
	beq	slug_end

	jmp	leg_loop

slug_end:
;	lda	KEYPRESS
;	bpl	slug_end

;	lda	KEYRESET

	;=============================
	; Restore background to $c00

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL

	lda	#>(cavern_rle)
	sta	GBASH
	lda	#<(cavern_rle)
	sta	GBASL
	jsr	load_rle_gr

	rts


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
	.byte $bA,$AA,$00,$AA
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
