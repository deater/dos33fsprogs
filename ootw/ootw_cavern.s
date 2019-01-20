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


	lda	WHICH_CAVE

cave_bg0:
	lda     #>(cavern_rle)
        sta     GBASH
	lda     #<(cavern_rle)
        sta     GBASL
	jmp	cave_bg_done

cave_bg1:
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
	; check for earthquake

earthquake_handler:
	lda     FRAMEH
	and	#3
	bne	earth_mover
	lda	FRAMEL
	cmp	#$ff
	bne	earth_mover
earthquake_init:
	lda	#200
	sta	EQUAKE_PROGRESS

	lda	#0
	sta	BOULDER_Y
	jsr	random16
	lda	SEEDL
	and	#$1f
	clc
	adc	#4
	sta	BOULDER_X


earth_mover:
	lda	EQUAKE_PROGRESS
	beq	earth_still

	and	#$8
	bne	earth_calm

	lda	#2
	bne	earth_decrement

earth_calm:
	lda	#0
earth_decrement:
	sta	EARTH_OFFSET
	dec	EQUAKE_PROGRESS
	jmp	earth_done


earth_still:
	lda	#0
	sta	EARTH_OFFSET

earth_done:

	;================================
	; copy background to current page

	lda	EARTH_OFFSET
	bne	shake_shake
no_shake:
	jsr	gr_copy_to_current
	jmp	done_shake
shake_shake:
	jsr	gr_copy_to_current_1000
done_shake:


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

	lda	BOULDER_Y
	cmp	#38
	bpl	no_boulder

	lda	#<boulder
	sta	INL
	lda	#>boulder
	sta	INH

	lda	BOULDER_X
	sta	XPOS
	lda	BOULDER_Y
	sta	YPOS
        jsr	put_sprite

	lda	FRAMEL
	and	#$3
	bne	no_boulder
	inc	BOULDER_Y
	inc	BOULDER_Y

no_boulder:
	;=======================
	; page flip

	jsr	page_flip

	;========================
	; inc frame count

	inc	FRAMEL
	bne	frame_no_oflo_c
	inc	FRAMEH

frame_no_oflo_c:

	; pause?

	; see if game over
	lda	GAME_OVER
	cmp	#$ff
	beq	done_cavern

	; see if left level
	cmp	#1
	bne	still_in_cavern

	lda	#37
	sta	PHYSICIST_X
	jmp	ootw_pool

still_in_cavern:
	; loop forever

	jmp	cavern_loop

done_cavern:
	rts

