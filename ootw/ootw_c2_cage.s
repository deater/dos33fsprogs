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

        lda     #<cage_center_sprite
        sta     INL
        lda     #>cage_center_sprite
        sta     INH

        jsr     put_sprite_crop

	;===============================
	; check keyboard

	lda	KEYPRESS
        bpl	cage_no_keypress

	;===========================
	; Done with cage, enter jail


        bit     KEYRESET		; clear keyboard


	rts

cage_no_keypress:


	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	cage_frame_no_oflo
	inc	FRAMEH

cage_frame_no_oflo:

	; pause?

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



cage_center_sprite:
	.byte	11,12
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
	.byte	$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA,$AA

