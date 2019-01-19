; Ootw Rope course

ootw_rope:
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

	;===========================
	; Setup right/left exit paramaters

	lda	#37
	sta	RIGHT_LIMIT
	lda	#22		; until we learn to climb slopes?
	sta	LEFT_LIMIT

	;=============================
	; Load background to $c00

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL			; load image off-screen $c00

	lda     #>(rope_rle)
        sta     GBASH
	lda     #<(rope_rle)
        sta     GBASL
	jsr	load_rle_gr

	;=================================
	; copy to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current


	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER

	;============================
	; Rope Loop
	;============================
rope_loop:

	;================================
	; copy background to current page

	jsr	gr_copy_to_current


	;===============================
	; check keyboard

	jsr	handle_keypress


	;===============
	; draw physicist

	jsr	draw_physicist


	;======================
	; draw foreground plant

	lda	#<foreground_spikes
	sta	INL
	lda	#>foreground_spikes
	sta	INH

        lda     #30
        sta     XPOS
        lda     #30
        sta     YPOS

	jsr	put_sprite

	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	rope_frame_no_oflo
	inc	FRAMEH

rope_frame_no_oflo:

	; pause?

	; check if done this level

	lda	GAME_OVER
	cmp	#$ff
	beq	done_rope

	; check if done this level
	cmp	#$2
	bne	not_done_rope

	lda	#0
	sta	PHYSICIST_X

	jmp	ootw_pool

not_done_rope:

	; loop forever

	jmp	rope_loop

done_rope:
	rts
