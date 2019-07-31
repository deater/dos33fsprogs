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
	sta	MONSTER_GRAB

	lda	#20
	sta	BUBBLES_Y
	sta	CONSOLE_Y
	sta	PHYSICIST_Y

	lda	#17
	sta	PHYSICIST_X

        bit     KEYRESET		; clear keypress

	; reset tentacle monster

	lda	#60
	sta	tentacle_ypos
	sta	tentacle_ypos+1
	sta	tentacle_ypos+2
	sta	tentacle_ypos+3
	sta	tentacle_ypos+4

	lda	#10
	sta	tentacle_xpos
	lda	#15
	sta	tentacle_xpos+1
	lda	#20
	sta	tentacle_xpos+2
	lda	#25
	sta	tentacle_xpos+3
	lda	#30
	sta	tentacle_xpos+4


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

	lda	MONSTER_GRAB
	beq	swim_physicist_normal

	; draw being pulled by tentacle

	ldx	MONSTER_WHICH
	lda	tentacle_xpos,X
	sta	XPOS

	lda	tentacle_ypos,X
	sec
	sbc	#10
	and	#$fe
	sta	YPOS

	; see if game over
	cmp	#80
	bcc	not_too_far_down

	lda	#$ff
	sta	GAME_OVER

not_too_far_down:

	lda	#<swimming1
	sta	INL
	lda	#>swimming1
	jmp	swim_physicist_draw

swim_physicist_normal:
	lda	PHYSICIST_X
	sta	XPOS
	lda	PHYSICIST_Y
	and	#$fe
	sta	YPOS

	ldy	GAIT
	lda	swim_progression,Y
	sta	INL
	lda	swim_progression+1,Y

swim_physicist_draw:
	sta	INH
	jsr	put_sprite_crop

	;======================
	; draw monster
	;======================

	jsr	draw_tentacle_monster

	jsr	move_tentacle_monster



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

	lda	MONSTER_GRAB
	bne	underwater_done_keyboard

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

	; temporarily disable for monster debugging

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


	;======================
	;======================
	; move tentacle monster
	;======================
	;======================

move_tentacle_monster:
	lda	MONSTER_GRAB
	beq	move_tentacle_notgrabbed

	;====================

	lda	FRAMEL
	and	#$7
	bne	no_move_tentacle_grabbed

	ldx	#0
	jsr	random16
	lda	SEEDL
	sta	MONSTER_AI
move_tentacle_grab_loop:

	cpx	MONSTER_WHICH
	bne	tentacle_grab_random

	; pull down quickly if grabbed

	inc	tentacle_ypos,X
	inc	tentacle_ypos,X
	inc	tentacle_ypos,X

	jmp	tentacle_grab_animate

	;=====================
	; randomly adjust y
tentacle_grab_random:
	ror	MONSTER_AI
	lda	MONSTER_AI
	and	#$3
	clc
	adc	tentacle_ypos,X
	sta	tentacle_ypos,X


	; adjust place in animation
tentacle_grab_animate:

	inc	tentacle_gait,X
	lda	tentacle_gait,X
	and	#$7
	sta	tentacle_gait,X

	inx
	cpx	#5
	bne	move_tentacle_grab_loop

no_move_tentacle_grabbed:
	rts




move_tentacle_notgrabbed:

	; if (physicist_x+1<tentacle_x)  no collision
	; if (physicist_x>tentacle_x+2) no collision
	; else, colllision

	;=====================
	; check for grab

	ldx	#0
tentacle_collision_loop:

	lda	PHYSICIST_X
	clc
	adc	#1
	cmp	tentacle_xpos,X
	bcc	tentacle_no_collision		; blt

	lda	PHYSICIST_X
	ldy	tentacle_xpos,X
	iny
	iny
	sty	TEMPY
	cmp	TEMPY
	bcs	tentacle_no_collision		; bge


tentacle_collision_x:

	lda	PHYSICIST_Y
	bmi	tentacle_no_collision	; if exiting pool, no collision

	lda	tentacle_ypos,X
	sec
	sbc	#10
	cmp	PHYSICIST_Y
	bcs	tentacle_no_collision		; bge

tentacle_collision:

	stx	MONSTER_WHICH
	lda	#1
	sta	MONSTER_GRAB

	jmp	no_move_tentacle


tentacle_no_collision:

	inx
	cpx	#5
	bne	tentacle_collision_loop




	;====================


	lda	FRAMEL
	and	#$7
	bne	no_move_tentacle

	ldx	#0
	jsr	random16
	lda	SEEDL
	sta	MONSTER_AI
move_tentacle_monster_loop:


	;=====================
	; move toward swimmer

	lda	FRAMEL
	and	#$3f
	bne	tentacle_no_sideways

	lda	tentacle_xpos,X
	sec
	sbc	PHYSICIST_X

	bmi	tentacle_move_right

	dec	tentacle_xpos,X
	jmp	tentacle_no_sideways

tentacle_move_right:
	inc	tentacle_xpos,X
tentacle_no_sideways:


	;=====================
	; randomly adjust y

	ror	MONSTER_AI
	lda	MONSTER_AI
	and	#$2
	eor	#$ff
	sec
	adc	tentacle_ypos,X
	sta	tentacle_ypos,X

random_not_move:

	; adjust place in animation


	inc	tentacle_gait,X
	lda	tentacle_gait,X
	and	#$7
	sta	tentacle_gait,X

	inx
	cpx	#5
	bne	move_tentacle_monster_loop

no_move_tentacle:

	rts


	;======================
	;======================
	; draw tentacle monster
	;======================
	;======================

draw_tentacle_monster:

	ldx	#0

draw_tentacle_monster_loop:
	jsr	draw_one_tentacle

	inx
	cpx	#5
	bne	draw_tentacle_monster_loop

	rts


tentacle_xpos:
	.byte	10,15,20,25,30

tentacle_ypos:
	.byte	46,46,46,46,46

tentacle_gait:
	.byte	0,5,2,7,4

	;======================
	;======================
	; draw one tentacle
	;======================
	;======================

draw_one_tentacle:

	lda	tentacle_xpos,X
	sta	XPOS
	lda	tentacle_ypos,X
	and	#$fe
	sta	YPOS

	ldy	tentacle_gait,X

	lda	tentacle_monster_progress_lo,Y
	sta	INL
	lda	tentacle_monster_progress_hi,Y
	sta	INH

	txa
	pha

	jsr	put_sprite_crop

	pla
	tax

	lda	tentacle_ypos,X
	cmp	#32
	bcs	done_draw_tentacle	; bge

	;==========================
	; draw base of tentacle

	lda	tentacle_xpos,X
	sta	XPOS
	lda	tentacle_ypos,X
	and	#$fe
	clc
	adc	#16
	sta	YPOS

	lda	#<tentacle_base
	sta	INL
	lda	#>tentacle_base
	sta	INH

	txa
	pha

	jsr	put_sprite_crop

	pla
	tax

done_draw_tentacle:
	rts




tentacle_monster_progress_lo:
	.byte <tentacle_sprite1
	.byte <tentacle_sprite2
	.byte <tentacle_sprite3
	.byte <tentacle_sprite4
	.byte <tentacle_sprite5
	.byte <tentacle_sprite6
	.byte <tentacle_sprite7
	.byte <tentacle_sprite8

tentacle_monster_progress_hi:
	.byte >tentacle_sprite1
	.byte >tentacle_sprite2
	.byte >tentacle_sprite3
	.byte >tentacle_sprite4
	.byte >tentacle_sprite5
	.byte >tentacle_sprite6
	.byte >tentacle_sprite7
	.byte >tentacle_sprite8


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

tentacle_base:
	.byte 1,14
	.byte $55
	.byte $55
	.byte $55
	.byte $55
	.byte $55
	.byte $55
	.byte $55
	.byte $55
	.byte $55
	.byte $55
	.byte $55
	.byte $55
	.byte $55
	.byte $55
