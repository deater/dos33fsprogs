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
	sta	GAIT

	lda	#20
	sta	BUBBLES_Y
	sta	CONSOLE_Y
	sta	PHYSICIST_Y

	lda	#17
	sta	PHYSICIST_X

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

	jsr	draw_surface_ripple

	;======================
	; draw console
	;======================

	lda	#16
	sta	XPOS
	lda	CONSOLE_Y
        sta	YPOS

	lda	#<console_sprite
	sta	INL
	lda	#>console_sprite
	sta	INH
	jsr	put_sprite_crop

	;=================================
	; draw physicist
	;=================================

	lda	PHYSICIST_X
	sta	XPOS
	lda	PHYSICIST_Y
	and	#$fe
	sta	YPOS

	ldy	GAIT
	lda	swim_progression,Y
	sta	INL
	lda	swim_progression+1,Y
	sta	INH
	jsr	put_sprite_crop

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

	cmp	#'A'+$80
	beq	uw_left_pressed
	cmp	#8+$80
	beq	uw_left_pressed

	cmp	#'D'+$80
	beq	uw_right_pressed
	cmp	#$15+$80
	beq	uw_right_pressed

	cmp	#'W'+$80
	beq	uw_up_pressed
	cmp	#$0B+$80
	beq	uw_up_pressed

	cmp	#'S'+$80
	beq	uw_down_pressed
	cmp	#$0A+$80
	beq	uw_down_pressed

	jmp	underwater_done_keyboard

underwater_escape:
	lda	#$ff
	sta	GAME_OVER
	bne	underwater_done_keyboard	; bra


uw_left_pressed:
	dec	PHYSICIST_X
	jmp	underwater_done_keyboard

uw_right_pressed:
	inc	PHYSICIST_X
	jmp	underwater_done_keyboard

uw_up_pressed:
	dec	PHYSICIST_Y
	jmp	underwater_done_keyboard

uw_down_pressed:
	inc	PHYSICIST_Y
	jmp	underwater_done_keyboard


underwater_done_keyboard:
	bit	KEYRESET

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

	;===================
	; move console
	;===================

	lda	FRAMEL
	and	#$1f
	bne	no_move_console

	ldx	CONSOLE_Y
	cpx	#48
	bcs	no_move_console	; bge

	inx
	inx
	stx	CONSOLE_Y

no_move_console:


	;===================
	; move physicist
	;===================
	; gradually pull you down

	lda	FRAMEL
	and	#$f
	bne	no_move_swim

	lda	GAIT
	clc
	adc	#$2
	and	#$f
	sta	GAIT

no_move_swim:

	lda	FRAMEL
	and	#$1f
	bne	no_move_physicist

	ldx	PHYSICIST_Y
	cpx	#34
	bcs	no_move_physicist	; bge

	inx
	inx
	stx	PHYSICIST_Y

no_move_physicist:




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


	; check if leaving the pool

	lda	PHYSICIST_Y
	cmp	#$FE
	beq	done_underwater


	; loop forever

	jmp	underwater_loop

done_underwater:
	rts


	;==============================
	; draw surface ripple
	;==============================
draw_surface_ripple:

	lda	#8
	sta	XPOS
	lda	#0
        sta	YPOS

	lda	FRAMEL
	and	#$60
	lsr
	lsr
	lsr
	lsr
	tay

	lda	ripple_progression,Y
	sta	INL
	lda	ripple_progression+1,Y
	sta	INH
	jsr	put_sprite_crop

	rts



ripple_progression:
	.word ripple1_sprite
	.word ripple2_sprite
	.word ripple3_sprite
	.word ripple4_sprite

ripple1_sprite:
	.byte 24,1
	.byte $26,$22,$66,$6E,$2E,$6E,$25,$25,$66,$6E,$6E,$66
	.byte $66,$66,$66,$5E,$2F,$2F,$6F,$66,$66,$66,$26,$26

ripple2_sprite:
	.byte 24,1
	.byte $26,$22,$66,$6E,$2E,$6E,$25,$65,$66,$6E,$2E,$66
	.byte $66,$66,$26,$5E,$2F,$2F,$2F,$66,$66,$26,$26,$26

ripple3_sprite:
	.byte 24,1
	.byte $26,$22,$66,$6E,$2E,$6E,$65,$65,$66,$2E,$2E,$66
	.byte $66,$66,$66,$5E,$2F,$2F,$2F,$26,$66,$26,$26,$26

ripple4_sprite:
	.byte 24,1
	.byte $26,$22,$66,$6E,$6E,$6E,$65,$65,$25,$2E,$6E,$66
	.byte $66,$66,$26,$5E,$2F,$2F,$2F,$66,$66,$26,$26,$26


tentacle_monster_progression:
	.word tentacle_sprite1
	.word tentacle_sprite2
	.word tentacle_sprite3
	.word tentacle_sprite4
	.word tentacle_sprite5
	.word tentacle_sprite6
	.word tentacle_sprite7
	.word tentacle_sprite8

tentacle_sprite1:
	.byte 3,8
	.byte $55,$AA,$AA
	.byte $55,$AA,$AA
	.byte $55,$AA,$AA
	.byte $A5,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA

tentacle_sprite2:
	.byte 3,8
	.byte $55,$AA,$AA
	.byte $55,$5A,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA

tentacle_sprite3:
	.byte 3,8
	.byte $A5,$5A,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA

tentacle_sprite4:
	.byte 3,8
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA

tentacle_sprite5:
	.byte 3,8
	.byte $AA,$5A,$A5
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA

tentacle_sprite6:
	.byte 3,8
	.byte $AA,$5A,$A5
	.byte $AA,$55,$AA
	.byte $AA,$AA,$55
	.byte $AA,$AA,$55
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA

tentacle_sprite7:
	.byte 3,8
	.byte $5A,$A5,$AA
	.byte $55,$AA,$AA
	.byte $AA,$55,$AA
	.byte $AA,$5A,$55
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA

tentacle_sprite8:
	.byte 3,8
	.byte $AA,$55,$AA
	.byte $55,$AA,$AA
	.byte $55,$AA,$AA
	.byte $A5,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA
	.byte $AA,$55,$AA


bubbles_sprite:
	.byte 5,2
	.byte $6A,$AA,$A6,$7A,$6A
	.byte $AA,$AA,$A6,$AA,$AA



console_sprite:
	.byte 6,5
	.byte $AA,$A5,$55,$5A,$AA,$AA
	.byte $AA,$AA,$00,$05,$05,$AA
	.byte $5A,$05,$00,$00,$00,$55
	.byte $AA,$A5,$55,$00,$00,$55
	.byte $AA,$AA,$A5,$A0,$A0,$A5







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




	;=======================
	; draw Surface ripple
	;=======================

	jsr	draw_surface_ripple

	;=======================
	; draw Overall ripple
	;=======================


check_flash_done:
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





