; Ootw Checkpoint2 -- Despite all my Rage...

ootw_cage:
	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR

	;===========================
	; Setup pages (is this necessary?)

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE

	;=============================
	; Load background to $c00

	lda     #>(cage_rle)
        sta     GBASH
	lda     #<(cage_rle)
        sta     GBASL
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr

	;=================================
	; copy to screen

	jsr	gr_copy_to_current
	jsr	page_flip

	;=================================
	; setup vars

	lda	#0
	sta	GAME_OVER
	sta	CAGE_AMPLITUDE
	sta	CAGE_OFFSET

        bit     KEYRESET		; clear keypress

	;============================
	; Cage Loop
	;============================
cage_loop:

	;================================
	; copy background to current page

	jsr	gr_copy_to_current


	;=======================
	; draw miners mining

	jsr	ootw_draw_miners

	;======================
	; draw cage

	lda	#11
	sta	XPOS
	lda     #0
        sta     YPOS

	lda	CAGE_AMPLITUDE
	cmp	#2
	beq	cage_amp_2
	cmp	#1
	beq	cage_amp_1

cage_amp_0:

        lda     #<cage_center_sprite
        sta     INL
        lda     #>cage_center_sprite
        sta     INH

        jsr     put_sprite_crop
	jmp	done_drawing_cage

cage_amp_1:
	lda	CAGE_OFFSET
	and	#$0e
	tay

        lda     cage_amp1_sprites,Y
        sta     INL
        lda     cage_amp1_sprites+1,Y
        sta     INH

        jsr     put_sprite_crop

	jmp	done_drawing_cage

cage_amp_2:

	lda	CAGE_OFFSET
	and	#$0e
	tay

        lda     cage_amp2_sprites,Y
        sta     INL
        lda     cage_amp2_sprites+1,Y
        sta     INH

        jsr     put_sprite_crop


done_drawing_cage:

	;===============================
	; check keyboard

	lda	KEYPRESS
        bpl	cage_continue

	inc	CAGE_AMPLITUDE
	lda	CAGE_AMPLITUDE
	cmp	#3
	bne	cage_continue


	;===========================
	; Done with cage, enter jail


        bit     KEYRESET		; clear keyboard
	rts

cage_continue:
        bit     KEYRESET		; clear keyboard


	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	cage_frame_no_oflo
	inc	FRAMEH

cage_frame_no_oflo:


	;================
	; move cage

	lda	FRAMEL		; slow down a bit
	and	#$7
	bne	no_move_cage

	lda	CAGE_AMPLITUDE
	beq	no_move_cage

	inc	CAGE_OFFSET

no_move_cage:



	; check if done this level

	lda	GAME_OVER
	cmp	#$ff
	beq	done_cage

	; check if done this level
;	cmp	#$2
;	bne	not_to_right

	; exit to right

;	lda	#0
;	sta	PHYSICIST_X
;	sta	WHICH_CAVE

;	jmp	ootw_cavern

;not_to_right:
;	cmp	#$1
;	bne	not_done_pool

;	lda	#37
;	sta	PHYSICIST_X

;	jmp	ootw_rope



	; loop forever

	jmp	cage_loop

done_cage:
	rts


cage_amp1_sprites:
	.word	cage_center_sprite
	.word	cage_right1_sprite
	.word	cage_right1_sprite
	.word	cage_right1_sprite
	.word	cage_center_sprite
	.word	cage_left1_sprite
	.word	cage_left1_sprite
	.word	cage_left1_sprite


cage_amp2_sprites:
	.word	cage_center_sprite
	.word	cage_right1_sprite
	.word	cage_right2_sprite
	.word	cage_right1_sprite
	.word	cage_center_sprite
	.word	cage_left1_sprite
	.word	cage_left2_sprite
	.word	cage_left1_sprite



cage_center_sprite:
	.byte	11,11
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$58,$A8,$98,$58,$A8,$A8,$58,$AA,$AA
	.byte	$AA,$AA,$55,$AA,$BB,$55,$AA,$AA,$55,$AA,$AA
	.byte	$AA,$AA,$55,$AB,$00,$55,$77,$77,$55,$AA,$AA
	.byte	$AA,$AA,$55,$AA,$00,$55,$07,$07,$55,$AA,$AA
	.byte	$AA,$AA,$55,$AA,$44,$55,$00,$50,$55,$AA,$AA
	.byte	$AA,$AA,$55,$AA,$44,$55,$05,$00,$55,$AA,$AA
	.byte	$AA,$AA,$85,$8A,$87,$85,$80,$80,$85,$AA,$AA

cage_right1_sprite:
	.byte	11,11
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$A5,$5A,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$AA,$85,$8A,$8A,$8A,$AA
	.byte	$AA,$AA,$AA,$58,$A8,$98,$55,$AA,$AA,$55,$AA
	.byte	$AA,$AA,$AA,$55,$AA,$BB,$55,$AA,$AA,$55,$AA
	.byte	$AA,$AA,$AA,$55,$AB,$00,$55,$77,$77,$55,$AA
	.byte	$AA,$AA,$AA,$55,$AA,$00,$55,$07,$57,$55,$AA
	.byte	$AA,$AA,$AA,$55,$AA,$44,$55,$05,$50,$55,$AA
	.byte	$AA,$AA,$AA,$55,$AA,$44,$55,$00,$00,$55,$AA
	.byte	$AA,$AA,$AA,$85,$87,$87,$85,$80,$80,$55,$AA

cage_right2_sprite:
	.byte	11,11
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$AA,$A5,$5A,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$AA,$8A,$85,$A8,$5A,$AA
	.byte	$AA,$AA,$AA,$AA,$58,$98,$55,$AA,$AA,$55,$AA
	.byte	$AA,$AA,$AA,$AA,$55,$BB,$55,$AA,$AA,$55,$AA
	.byte	$AA,$AA,$AA,$AA,$55,$00,$55,$77,$77,$55,$AA
	.byte	$AA,$AA,$AA,$AA,$55,$00,$55,$07,$57,$58,$5A
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$44,$55,$50,$00,$55
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$44,$55,$00,$80,$85
	.byte	$AA,$AA,$AA,$AA,$AA,$85,$87,$A8,$A8,$AA,$AA

cage_left1_sprite:
	.byte	11,11
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$5A,$A5,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$8A,$8A,$8A,$85,$AA,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$B9,$55,$A8,$A8,$58,$AA,$AA,$AA
	.byte	$AA,$55,$BA,$0B,$55,$AA,$AA,$55,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$00,$55,$7A,$7A,$55,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$40,$55,$77,$77,$55,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$44,$55,$00,$00,$55,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$74,$55,$00,$05,$55,$AA,$AA,$AA
	.byte	$AA,$A8,$A8,$A8,$A8,$80,$80,$85,$AA,$AA,$AA

cage_left2_sprite:
	.byte	11,11
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$5A,$A5,$AA,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$58,$A8,$85,$8A,$AA,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$B9,$55,$A8,$58,$AA,$AA,$AA,$AA
	.byte	$AA,$55,$BA,$0B,$55,$AA,$55,$AA,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$00,$55,$7A,$55,$AA,$AA,$AA,$AA
	.byte	$5A,$A5,$4A,$40,$55,$77,$55,$AA,$AA,$AA,$AA
	.byte	$55,$AA,$44,$55,$55,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$85,$8A,$74,$55,$00,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$A8,$A8,$80,$85,$AA,$AA,$AA,$AA,$AA

