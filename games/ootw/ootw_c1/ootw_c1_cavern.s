; Cavern scenes (with the slugs)

ootw_cavern:
	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR

	;==================
	; setup drawing

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE

	;======================
	; setup room boundaries

	lda	#(-4+128)
	sta	LEFT_LIMIT
	sta	LEFT_WALK_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT
	sta	RIGHT_WALK_LIMIT

	;=============================
	; Load background to $c00

	jsr	cavern_load_background

	;================================
	; Load quake background to $BC00

	jsr	gr_make_quake

	;================================
	; setup per-cave variables

	lda	WHICH_CAVE
	bne	cave1

cave0:
	; set slug table to use
	lda	#0
	sta	ds_smc1+1
	lda	#3		; use slugs 0-2
	sta	ds_smc2+1

	; set right exit
	lda	#1
	sta	cer_smc+1
	lda	#<ootw_cavern
	sta	cer_smc+5
	lda	#>ootw_cavern
	sta	cer_smc+6

	; set left exit
	lda	#0
	sta	cel_smc+1
	lda	#<ootw_pool
	sta	cel_smc+5
	lda	#>ootw_pool
	sta	cel_smc+6

	jmp	cave_setup_done

cave1:

	; set slug table to use
	lda	#3
	sta	ds_smc1+1
	lda	#7			; use slugs 3-6
	sta	ds_smc2+1

	; set right exit
	lda	#1
	sta	cer_smc+1
	lda	#<ootw_mesa
	sta	cer_smc+5
	lda	#>ootw_mesa
	sta	cer_smc+6

	; set left exit
	lda	#0
	sta	cel_smc+1
	lda	#<ootw_cavern
	sta	cel_smc+5
	lda	#>ootw_cavern
	sta	cel_smc+6

cave_setup_done:


	;=================================
	; copy $c00 background to both pages $400/$800

;	jsr	gr_copy_to_current
;	jsr	page_flip
;	jsr	gr_copy_to_current


	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER
	sta	BG_BEAST	; in case it wasn't gone yet

	; make sure in range and such

	jsr	refresh_slugs

	jsr	setup_beast

	;============================
	;============================
	;============================
	; Cavern Loop (not a palindrome)
	;============================
	;============================
	;============================
cavern_loop:

	;==========================
	; handle earthquake

	jsr	earthquake_handler


	;===============
	; check keyboard

	jsr	handle_keypress


	;===============
	; move physicist

	jsr	move_physicist

	;===============
	; check room limits

	jsr	check_screen_limit

	;===============
	; draw physicist

	jsr	draw_physicist

	;================
	; handle beast

	lda	BEAST_OUT
	beq	cavern_no_beast

	;================
	; move beast

	jsr	move_beast

        ;================
        ; draw beast

        jsr     draw_beast

cavern_no_beast:


just_slugs:

	;===============
	; draw slugs

	jsr	draw_slugs

	;======================
	; draw falling boulders

	jsr	draw_boulder

	;=======================
	; page flip

	jsr	page_flip

	;========================
	; inc frame count

	inc	FRAMEL
	bne	frame_no_oflo_c
	inc	FRAMEH

frame_no_oflo_c:



	;=================
	; see if game over
	lda	GAME_OVER
	beq	still_in_cavern		; if 0, continue as per normal

	cmp	#$ff			; if $ff, we died
	beq	done_cavern

	;===========================
	; see if exited room to right
	cmp	#1
	beq	cavern_exit_left

cavern_exit_right:
	lda	#0
	sta	PHYSICIST_X
cer_smc:
	lda	#$0
	sta	WHICH_CAVE
	jmp	ootw_pool


	;==========================
	; see if exited room to left
cavern_exit_left:
	lda	#37
	sta	PHYSICIST_X
cel_smc:
	lda	#$0
	sta	WHICH_CAVE
	jmp	ootw_pool

still_in_cavern:
	; loop forever

	jmp	cavern_loop

done_cavern:
	rts



	;===============================
	; load proper background to $c00
	;===============================

cavern_load_background:

	lda	WHICH_CAVE
	bne	cave_bg1

cave_bg0:
	; load background
	lda     #>(cavern_rle)
        sta     GBASH
	lda     #<(cavern_rle)
        sta     GBASL
	jmp	cave_bg_done

cave_bg1:
	; load background
	lda     #>(cavern2_rle)
        sta     GBASH
	lda     #<(cavern2_rle)
        sta     GBASL
cave_bg_done:
	lda	#$c			; load image off-screen $c00
	jmp	load_rle_gr		; tail call
