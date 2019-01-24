
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
beast_long_delay:
	lda	#250
	jsr	WAIT
	dex
	bne	beast_long_delay


	ldx	CUTFRAME
	inx
	inx
	stx	CUTFRAME

	cpx	#12
	beq	beast_end

	jmp	beast_loop

beast_end:

	;=============================
	; Restore background to $c00

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image off-screen $c00

	lda	#>(cavern3_rle)
	sta	GBASH
	lda	#<(cavern3_rle)
	sta	GBASL

	jmp	load_rle_gr


beast_background:
	.byte 10,10
	.byte $22,$82,$55,$66,$66,$66,$66,$55,$55,$88
	.byte $88,$55,$66,$66,$66,$66,$66,$66,$55,$88
	.byte $88,$55,$66,$66,$66,$66,$66,$66,$55,$88
	.byte $88,$55,$66,$66,$66,$66,$66,$66,$55,$88
	.byte $88,$55,$66,$66,$66,$66,$66,$66,$55,$88
	.byte $88,$55,$66,$66,$66,$66,$66,$66,$55,$88
	.byte $88,$55,$86,$66,$66,$66,$66,$66,$55,$88
	.byte $88,$28,$88,$56,$56,$56,$56,$56,$85,$28
	.byte $28,$22,$22,$28,$28,$28,$28,$28,$22,$22
	.byte $22,$22,$22,$22,$22,$22,$22,$22,$22,$22


beast_frames:
	.word	beast_frame1
	.word	beast_frame2
	.word	beast_frame3
	.word	beast_frame4
	.word	beast_frame5
	.word	beast_frame6
	.word	beast_frame7
	.word	beast_frame8
	.word	beast_frame9
	.word	beast_frame10
	.word	beast_frame11
	.word	beast_frame12
	.word	beast_frame9
	.word	beast_frame9


beast_frame1: ; piskel2
	.byte 9,2
	.byte $AA,$00,$00,$AA,$AA,$AA,$AA,$00,$00
	.byte $AA,$00,$00,$AA,$AA,$AA,$AA,$00,$00


beast_frame2: ; piskel3
	.byte 9,4
	.byte $AA,$00,$00,$AA,$A0,$A0,$AA,$00,$00
	.byte $AA,$00,$00,$AA,$AA,$AA,$AA,$00,$00
	.byte $AA,$00,$00,$AA,$AA,$AA,$AA,$00,$00
	.byte $AA,$00,$00,$AA,$AA,$AA,$AA,$00,$00


beast_frame3: ; piskel4
	.byte 9,6
	.byte $AA,$00,$01,$10,$00,$00,$10,$01,$00
	.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $AA,$00,$00,$AA,$00,$00,$AA,$00,$00
	.byte $AA,$00,$00,$AA,$AA,$AA,$AA,$00,$00
	.byte $AA,$00,$00,$AA,$AA,$AA,$AA,$00,$00


beast_frame4: ; piskel5
	.byte 9,8
	.byte $AA,$AA,$00,$00,$00,$00,$10,$01,$AA
	.byte $AA,$0A,$00,$00,$00,$00,$00,$00,$0A
	.byte $AA,$00,$01,$10,$00,$00,$10,$01,$00
	.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $AA,$00,$00,$AA,$00,$00,$AA,$00,$00
	.byte $AA,$00,$00,$AA,$A0,$A0,$AA,$00,$00
	.byte $AA,$00,$00,$AA,$AA,$AA,$AA,$00,$00

beast_frame5: ; piskel6
	.byte 9,9
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$0A,$00,$00,$00,$00,$00,$AA
	.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $AA,$00,$01,$10,$00,$00,$10,$01,$00
	.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $AA,$00,$00,$A0,$00,$00,$A0,$00,$00
	.byte $AA,$00,$00,$AA,$00,$00,$AA,$00,$00
	.byte $AA,$00,$00,$AA,$A0,$A0,$AA,$00,$00
	.byte $AA,$00,$00,$AA,$22,$22,$AA,$00,$00

beast_frame6: ; piskel7
	.byte 10,9
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$0A,$00,$00,$00,$00,$0A,$AA,$AA
	.byte $AA,$00,$10,$00,$00,$00,$00,$10,$00,$AA
	.byte $AA,$00,$00,$01,$00,$00,$01,$00,$00,$AA
	.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00,$AA
	.byte $AA,$00,$00,$A0,$00,$00,$A0,$00,$00,$AA
	.byte $AA,$00,$00,$AA,$00,$00,$AA,$00,$00,$AA
	.byte $00,$00,$00,$AA,$20,$20,$AA,$00,$00,$00

beast_frame7: ; piskel8
	.byte 10,9
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$AA,$0A,$0A,$0A,$0A,$AA,$AA,$AA
	.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00,$AA
	.byte $AA,$00,$01,$10,$00,$00,$10,$01,$00,$AA
	.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00,$AA
	.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00,$AA
	.byte $AA,$00,$00,$AA,$00,$00,$AA,$00,$00,$AA
	.byte $AA,$00,$00,$AA,$00,$00,$AA,$00,$00,$AA
	.byte $00,$00,$00,$A0,$A0,$A0,$A0,$00,$00,$00

beast_frame8: ; piskel9
	.byte 10,9
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$0A,$0A,$0A,$0A,$0A,$0A,$AA,$AA
	.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00,$AA
	.byte $AA,$00,$01,$10,$00,$00,$10,$01,$00,$AA
	.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00,$AA
	.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00,$AA
	.byte $AA,$00,$00,$AA,$00,$00,$AA,$00,$00,$AA
	.byte $AA,$00,$00,$AA,$00,$00,$AA,$00,$00,$AA
	.byte $00,$00,$00,$A0,$A0,$A0,$A0,$00,$00,$00

beast_frame9: ; piskel10
	.byte 10,9
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$AA,$0A,$0A,$00,$00,$0A,$0A,$AA,$AA
	.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00,$AA
	.byte $AA,$00,$01,$10,$00,$00,$10,$01,$00,$AA
	.byte $AA,$00,$00,$00,$00,$00,$00,$00,$00,$AA
	.byte $AA,$00,$00,$07,$0f,$07,$0f,$00,$00,$AA
	.byte $AA,$00,$00,$AA,$00,$00,$AA,$00,$00,$AA
	.byte $AA,$00,$00,$0A,$00,$00,$0A,$00,$00,$AA
	.byte $00,$00,$00,$A0,$A0,$A0,$A0,$00,$00,$00

beast_frame10: ; piskel11
	.byte 10,9
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$A0,$00,$00,$00,$00,$00,$00,$A0,$AA
	.byte $AA,$00,$10,$00,$00,$00,$00,$10,$00,$AA
	.byte $AA,$00,$00,$01,$00,$00,$01,$00,$00,$AA
	.byte $AA,$00,$00,$07,$ff,$07,$ff,$00,$00,$AA
	.byte $AA,$00,$00,$77,$f0,$77,$f0,$00,$00,$AA
	.byte $AA,$00,$00,$AA,$00,$00,$AA,$00,$00,$AA
	.byte $0A,$00,$00,$AA,$00,$00,$AA,$00,$00,$0A
	.byte $00,$00,$00,$A0,$A0,$A0,$A0,$00,$00,$00

beast_frame11: ; piskel12
	.byte 10,9
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$A0,$00,$00,$00,$00,$00,$00,$A0,$AA
	.byte $AA,$00,$10,$00,$00,$00,$00,$10,$00,$AA
	.byte $AA,$00,$00,$01,$00,$00,$01,$00,$00,$AA
	.byte $AA,$00,$00,$77,$ff,$77,$ff,$00,$00,$AA
	.byte $AA,$00,$00,$07,$0f,$07,$0f,$00,$00,$AA
	.byte $AA,$00,$00,$AA,$00,$00,$AA,$00,$00,$AA
	.byte $0A,$00,$00,$AA,$00,$00,$AA,$00,$00,$0A
	.byte $00,$00,$00,$A0,$A0,$A0,$A0,$00,$00,$00

beast_frame12: ; piskel13
	.byte 10,9
	.byte $AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA
	.byte $AA,$A0,$00,$00,$00,$00,$00,$00,$A0,$AA
	.byte $AA,$00,$10,$00,$00,$00,$00,$10,$00,$AA
	.byte $AA,$00,$00,$01,$00,$00,$01,$00,$00,$AA
	.byte $AA,$00,$00,$70,$f0,$70,$f0,$00,$00,$AA
	.byte $AA,$00,$00,$A0,$00,$00,$A0,$00,$00,$AA
	.byte $AA,$00,$00,$AA,$00,$00,$AA,$00,$00,$AA
	.byte $0A,$00,$00,$AA,$00,$00,$AA,$00,$00,$0A
	.byte $00,$00,$00,$A0,$A0,$A0,$A0,$00,$00,$00

