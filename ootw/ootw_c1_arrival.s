; Ootw Checkpoint1 -- arriving with a splash

ootw_c1_arrival:
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

	lda     #>(underwater_rle)
        sta     GBASH
	lda     #<(underwater_rle)
        sta     GBASL
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr


	;=================================
	; do intro flash

	jsr	do_flash


	;=================================
	; setup vars

	lda	#0
	sta	GAME_OVER

	lda	#20
	sta	BUBBLES_Y



        bit     KEYRESET		; clear keypress

	;============================
	; Underwater Loop
	;============================
underwater_loop:

	;================================
	; copy background to current page
	;================================

	jsr	gr_copy_to_current


	;=======================
	; draw Surface ripple
	;=======================

;	jsr	ootw_draw_miners

	;======================
	; draw console
	;======================

	lda	#11
	sta	XPOS
	lda	#0
        sta	YPOS

;	lda	#<cage_center_sprite
;	sta	INL
;	lda	#>cage_center_sprite
;	sta	INH
;	jsr	put_sprite_crop
;	jmp	done_drawing_cage


	;=================================
	; draw physicist
	;=================================

	;======================
	; draw monster
	;======================

	;======================
	; draw bubbles
	;======================

	lda	BUBBLES_Y
	cmp	#2
	bcc	no_draw_bubbles	; blt

        sta	YPOS

	lda	#17
	sta	XPOS


	lda	#<bubbles_sprite
	sta	INL
	lda	#>bubbles_sprite
	sta	INH
	jsr	put_sprite_crop
no_draw_bubbles:




	;===============================
	; check keyboard
	;===============================

	lda	KEYPRESS
        bpl	underwater_done_keyboard

	cmp	#27+$80
	beq	underwater_escape

;	cmp	#'A'+$80
;	beq	cage_left_pressed
;	cmp	#8+$80
;	beq	cage_left_pressed

;	cmp	#'D'+$80
;	beq	cage_right_pressed
;	cmp	#$15+$80
;	beq	cage_right_pressed

	jmp	underwater_done_keyboard

underwater_escape:
	lda	#$ff
	sta	GAME_OVER
	bne	underwater_done_keyboard	; bra


;cage_left_pressed:
;	lda	CAGE_AMPLITUDE
;	bne	cage_left_already_moving
;	lda	#8			; *2
;	sta	CAGE_OFFSET
;	jmp	cage_inc_amplitude

underwater_done_keyboard:


	;=================================
	; move things
	;=================================

	;===================
	; move bubbles
	;===================

	lda	FRAMEL
	and	#$f
	bne	no_move_bubbles

	ldx	BUBBLES_Y
	beq	no_move_bubbles

	dex
	dex
	stx	BUBBLES_Y

no_move_bubbles:


	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	underwater_frame_no_oflo
	inc	FRAMEH

underwater_frame_no_oflo:


	;==========================
	; check if done this level
	;==========================

	lda	GAME_OVER
	cmp	#$ff
	beq	done_underwater



	; loop forever

	jmp	underwater_loop

done_underwater:
	rts









bubbles_sprite:
	.byte 5,2
	.byte $6A,$AA,$A6,$7A,$6A
	.byte $AA,$AA,$A6,$AA,$AA











	;============================
	; Do Flash
	;============================
do_flash:

	lda	#0
	sta	FRAMEL

	;============================
	; Flash Loop
	;============================
flash_loop:



	;================================
	; Handle Flash
	;================================

	lda	FRAMEL
	cmp	#180
	bcc	no_flash		; blt
	cmp	#182
	bcc	first_flash
	bcs	second_flash

first_flash:

	; Load background to $1000

	lda     #>(uboot_flash1_rle)
        sta     GBASH
	lda     #<(uboot_flash1_rle)
        sta     GBASL
	lda	#$10			; load image off-screen $c00
	jsr	load_rle_gr

	jsr	gr_overlay

	jmp	check_flash_done
second_flash:

	; Load background to $1000

	lda     #>(uboot_flash2_rle)
        sta     GBASH
	lda     #<(uboot_flash2_rle)
        sta     GBASL
	lda	#$10			; load image off-screen $c00
	jsr	load_rle_gr

	jsr	gr_overlay

	jmp	check_flash_done

no_flash:
	;================================
	; copy background to current page
	;================================

	jsr	gr_copy_to_current

check_flash_done:


	;=======================
	; draw Surface ripple
	;=======================

;	jsr	ootw_draw_miners

	;=======================
	; draw Overall ripple
	;=======================



	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	flash_frame_no_oflo
	inc	FRAMEH

flash_frame_no_oflo:


	;==========================
	; check if done this level
	;==========================

	lda	FRAMEL
	cmp	#184
	beq	done_flash



	; loop forever

	jmp	flash_loop

done_flash:
	rts





