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

	lda	BEAST_OUT		; if beast out, we can go full right
	beq	beast_not_out_yet


	lda	#37			; beast trigger
	sta	RIGHT_LIMIT
	jmp	mesa_left

beast_not_out_yet:
	lda	#20			; beast trigger
	sta	RIGHT_LIMIT

mesa_left:
	lda	#0
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
	; copy to screen

	jsr	gr_copy_to_current
	jsr	page_flip

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

	;===============================
	; check limits

	jsr	check_screen_limit



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

	;=====================
	; off screen to right

	lda	BEAST_OUT		; if beast out trigger end
	beq	trigger_beast		; otherwise trigger beast

	;=====================
	; trigger ending

	lda	#66
	sta	LEVELEND_PROGRESS

	lda	#0
	sta	GAME_OVER

	lda	#30
	sta	PHYSICIST_X		; debugging

	jmp	not_done_mesa

trigger_beast:
	;=======================
	; trigger beast emerging
	lda	#1
	sta	BEAST_OUT

	lda	#0
	sta	GAME_OVER

	lda	#37			; update right side of screen
	sta	RIGHT_LIMIT		; this is mostly for testing

	jsr	beast_cutscene

	jmp	not_done_mesa

mesa_check_left:
	cmp	#$1
	bne	not_done_mesa

	;============================
	; off screen to left
mesa_off_left:
	lda	#37
	sta	PHYSICIST_X
	lda	#1
	sta	WHICH_CAVE	; go left one screen

	jmp	ootw_cavern

not_done_mesa:

	; loop forever

	jmp	mesa_loop

done_mesa:
	rts



endl1_progression:
.word   l1end33_rle,l1end32_rle,l1end31_rle,l1end30_rle
.word   l1end29_rle,l1end28_rle,l1end27_rle,l1end26_rle,l1end25_rle
.word   l1end24_rle,l1end23_rle,l1end22_rle,l1end21_rle,l1end20_rle
.word   l1end19_rle,l1end18_rle,l1end17_rle,l1end16_rle,l1end15_rle
.word   l1end14_rle,l1end13_rle,l1end12_rle,l1end11_rle,l1end10_rle
.word   l1end09_rle,l1end08_rle,l1end07_rle,l1end06_rle,l1end05_rle
.word   l1end04_rle,l1end03_rle,l1end02_rle,l1end01_rle


