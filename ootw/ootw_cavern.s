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

	lda	#0
	sta	LEFT_LIMIT
	lda	#37
	sta	RIGHT_LIMIT

	;=============================
	; Load background to $c00

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL			; load image off-screen $c00


	; Setup some stuff based on which cave we are in


	lda	WHICH_CAVE
	bne	cave_bg1

cave_bg0:
	; set slug table to use
	lda	#0
	sta	ds_smc1+1
	lda	#18
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


	; load background
	lda     #>(cavern_rle)
        sta     GBASH
	lda     #<(cavern_rle)
        sta     GBASL
	jmp	cave_bg_done

cave_bg1:

	; set slug table to use
	lda	#18
	sta	ds_smc1+1
	lda	#36
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

	; load background
	lda     #>(cavern2_rle)
        sta     GBASH
	lda     #<(cavern2_rle)
        sta     GBASL
cave_bg_done:
	jsr	load_rle_gr


	;================================
	; Load quake background to $1000

	jsr	gr_make_quake


	;=================================
	; copy $c00 background to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current


	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER

	;============================
	; Cavern Loop (not a palindrome)
	;============================
cavern_loop:

	;==========================
	; handle earthquake

	jsr	earthquake_handler

	;===============
	; handle slug death

	lda	SLUGDEATH
	beq	still_alive

collapsing:
	lda     SLUGDEATH_PROGRESS
        cmp     #18
        bmi     still_collapsing

really_dead:
	lda	#$ff
	sta	GAME_OVER
	jmp	just_slugs


still_collapsing:
        tax

        lda     collapse_progression,X
        sta     INL
        lda     collapse_progression+1,X
        sta     INH

        lda     PHYSICIST_X
        sta     XPOS
        lda     PHYSICIST_Y
	sec
	sbc	EARTH_OFFSET
        sta     YPOS

	jsr	put_sprite

        lda     FRAMEL
        and     #$1f
        bne     no_collapse_progress

        inc     SLUGDEATH_PROGRESS
        inc     SLUGDEATH_PROGRESS
no_collapse_progress:


	jmp	just_slugs

still_alive:

	;===============
	; check keyboard

	jsr	handle_keypress

	;===============
	; draw physicist

	jsr	draw_physicist

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

