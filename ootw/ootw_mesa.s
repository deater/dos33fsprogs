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

	lda     #>(cavern3_rle)
        sta     GBASH
	lda     #<(cavern3_rle)
        sta     GBASL
	lda	#$c			; load image off-screen $c00
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
mesa_check_right:
	cmp	#$2
	bne	mesa_check_left

	lda	BEAST_OUT			; trigger beast
	bne	not_done_mesa

	lda	#1
	sta	BEAST_OUT

	jsr	beast_cutscene

	jmp	not_done_mesa

mesa_check_left:
	cmp	#$1
	bne	not_done_mesa

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
