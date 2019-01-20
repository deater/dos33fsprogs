; Ootw mesa at far right

ootw_mesa:
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

	lda	#20
	sta	RIGHT_LIMIT
	lda	#0		; until we learn to climb slopes?
	sta	LEFT_LIMIT

	;=============================
	; Load background to $c00

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL			; load image off-screen $c00

	lda     #>(cavern3_rle)
        sta     GBASH
	lda     #<(cavern3_rle)
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
mesa_loop:

	;================================
	; copy background to current page

	jsr	gr_copy_to_current


	;===============================
	; check keyboard

	jsr	handle_keypress


	;===============
	; draw physicist

	jsr	draw_physicist

	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	mesa_frame_no_oflo
	inc	FRAMEH

mesa_frame_no_oflo:


	; check if done this level

	lda	GAME_OVER
	beq	not_done_mesa

	cmp	#$ff			; check if dead
	beq	done_mesa

	;====================
	; check if leaving room

	cmp	#$2			
	beq	not_done_mesa		; we can't, dead end

	; off screen to left
mesa_off_left:
	lda	#37
	sta	PHYSICIST_X
	lda	#1
	sta	WHICH_CAVE

	jmp	ootw_cavern

not_done_mesa:

	; loop forever

	jmp	mesa_loop

done_mesa:
	rts
