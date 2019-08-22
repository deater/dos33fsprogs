; Ootw Checkpoint2 -- Despite all my Rage...

ootw_cage:
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

	lda     #>(cage_rle)
        sta     GBASH
	lda     #<(cage_rle)
        sta     GBASL
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr

	;=================================
	; setup vars

	lda	#0
	sta	GAME_OVER
	sta	CAGE_AMPLITUDE
	sta	CAGE_OFFSET
	sta	CAGE_GUARD
	sta	SHOOTING_BOTTOM
	sta	SHOOTING_TOP
	sta	LITTLEGUY_OUT
	sta	WHICH_ROOM

	; disable other aliens
	lda	#$ff
	sta	alien1_room
	sta	alien2_room

        bit     KEYRESET		; clear keypress

	;============================
	; Cage Loop
	;============================
cage_loop:

	;================================
	; copy background to current page
	;================================

	jsr	gr_copy_to_current


	;=======================
	; draw miners mining
	;=======================

	jsr	ootw_draw_miners

	;=======================
	; draw little guy
	;=======================

	lda	LITTLEGUY_OUT
	beq	done_bg_draw_lg

	cmp	#7
	bcc	lg_in1
	cmp	#15
	bcc	lg_in2

	ldx	#<little_guy_in_sprite
	ldy	#>little_guy_in_sprite
	jmp	bg_draw_lg

lg_in1:
	ldx	#<little_guy_in1_sprite
	ldy	#>little_guy_in1_sprite
	jmp	bg_draw_lg_inc

lg_in2:
	ldx	#<little_guy_in2_sprite
	ldy	#>little_guy_in2_sprite

bg_draw_lg_inc:
	inc	LITTLEGUY_OUT

bg_draw_lg:
	lda	#28
	sta	XPOS
	lda	#34
	sta	YPOS

	stx     INL
	sty     INH
	jsr     put_sprite_crop

done_bg_draw_lg:


	;======================
	; draw cage
	;======================

	lda	#11
	sta	XPOS
	lda     #0
        sta     YPOS

	lda	CAGE_AMPLITUDE
	cmp	#2
	bcs	cage_amp_2		; bge
	cmp	#1
	beq	cage_amp_1

cage_amp_0:

        lda     #<cage_center_sprite
        sta     INL
        lda     #>cage_center_sprite
        sta     INH

        jsr     put_sprite_crop
	jmp	done_drawing_cage

cage_amp_1:
	lda	CAGE_OFFSET
	and	#$0e
	tay

        lda     cage_amp1_sprites,Y
        sta     INL
        lda     cage_amp1_sprites+1,Y
        sta     INH

        jsr     put_sprite_crop

	jmp	done_drawing_cage

cage_amp_2:

	lda	CAGE_OFFSET
	and	#$0e
	tay

        lda     cage_amp2_sprites,Y
        sta     INL
        lda     cage_amp2_sprites+1,Y
        sta     INH

        jsr     put_sprite_crop


done_drawing_cage:

	;======================
	; draw laser
	;======================

	jsr	draw_up_laser

	;======================
	; draw guard
	;======================

	lda	CAGE_GUARD
	cmp	#15
	bcs	guard_patrol	; bge

	; guard changing uniform
	;  CAGE_GUARD=0..14

	lda	#34
	sta	XPOS
	lda     #28
        sta     YPOS

	lda	CAGE_GUARD
	asl
	tay

        lda     changing_guard_sprites,Y
        sta     INL
        lda     changing_guard_sprites+1,Y
        sta     INH

        jsr     put_sprite_crop

	jmp	done_cage_guard

guard_patrol:

	; guard patroling
	;   CAGE_GUARD=15+

	; switch direction if at end
	lda	alien0_direction
	bne	patrolling_right
patrolling_left:
	lda	alien0_x
	cmp	#22
	bcs	patrolling_move		; bge

	lda	#A_TURNING
	sta	alien0_state

	jmp	patrolling_move
patrolling_right:

	lda	alien0_x
	cmp	#34
	bcc	patrolling_move		; blt

	lda	#A_TURNING
	sta	alien0_state

patrolling_move:

	lda	CAGE_AMPLITUDE
	cmp	#2
	beq	guard_yelling

	cmp	#3
	beq	guard_shooting

	cmp	#4
	beq	guard_shooting

	jmp	guard_move_and_draw

guard_yelling:

	lda	alien0_x
	cmp	#21
	bne	guard_move_and_draw

	lda	#A_YELLING
	sta	alien0_state
	jmp	guard_move_and_draw

guard_shooting:

	; guard shooting

	lda	alien0_x
	cmp	#21
	bne	guard_move_and_draw

	lda	#A_SHOOTING_UP
	sta	alien0_state


guard_move_and_draw:

	jsr	move_alien
	jsr	draw_alien


done_cage_guard:

	;===============================
	; check keyboard
	;===============================

	lda	KEYPRESS
        bpl	cage_done_keyboard

	cmp	#27+$80
	beq	cage_escape

	cmp	#'A'+$80
	beq	cage_left_pressed
	cmp	#8+$80
	beq	cage_left_pressed

	cmp	#'D'+$80
	beq	cage_right_pressed
	cmp	#$15+$80
	beq	cage_right_pressed

	jmp	cage_done_keyboard

cage_escape:
	lda	#$ff
	sta	GAME_OVER
	bne	cage_done_keyboard	; bra


cage_left_pressed:
	lda	CAGE_AMPLITUDE
	bne	cage_left_already_moving
	lda	#8			; *2
	sta	CAGE_OFFSET
	jmp	cage_inc_amplitude

cage_left_already_moving:
	; if moving left ($80) inc amp
	; if moving right ($1) dec amp

	ldy	CAGE_OFFSET
	lda	cage_direction_lookup,Y
	beq	cage_done_amplitude
	bmi	cage_inc_amplitude
	bpl	cage_dec_amplitude

cage_right_pressed:
	; if moving left ($80) dec amplitude
	; if moving right ($1) inc amplitude
	ldy	CAGE_OFFSET
	lda	cage_direction_lookup,Y
	beq	cage_done_amplitude
	bmi	cage_dec_amplitude
	bpl	cage_inc_amplitude

cage_inc_amplitude:
	lda	CAGE_AMPLITUDE
	cmp	#4
	beq	cage_done_amplitude
	inc	CAGE_AMPLITUDE
	jmp	cage_done_amplitude

cage_dec_amplitude:
	lda	CAGE_AMPLITUDE
	beq	cage_done_amplitude
	dec	CAGE_AMPLITUDE

cage_done_amplitude:

cage_done_keyboard:


	;=================================
	; cage swinging behavior

	lda	CAGE_AMPLITUDE
check_amp1:
	cmp	#1
	bne	check_amp4

;	lda	#1			; if amp=1, guard gets gun out
	sta	alien0_gun
	jmp	cage_continue

check_amp2:
;	cmp	#2
;	bne	check_amp3
;					; if amp=2, guard shouts
;	jmp	cage_continue

;check_amp3:
;	cmp	#3
;	bne	check_amp4		; if amp=3, guard shoots

check_amp4:
	cmp	#4			; if amp=4, cage falls
	bne	cage_continue

	; only fall if at far right position and also guard is in place

	lda	CAGE_OFFSET
	cmp	#4			; it's *2
	bne	cage_continue

	lda	alien0_x
	cmp	#21
	bne	cage_continue		; only if yelling


	;===========================
	; Done with cage, run ending sequence

	jmp	cage_ending

cage_continue:
        bit     KEYRESET		; clear keyboard


	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	cage_frame_no_oflo
	inc	FRAMEH

cage_frame_no_oflo:


	;================
	; move cage

	lda	FRAMEL		; slow down a bit
	and	#$7
	bne	no_move_cage

	lda	CAGE_AMPLITUDE
	beq	no_move_cage

	; actual value is CAGE_OFFSET/2

	inc	CAGE_OFFSET
	lda	CAGE_OFFSET
	and	#$f
	sta	CAGE_OFFSET

no_move_cage:

	;=====================
	; move cage guard

	lda	FRAMEL		; slow down a bit
	and	#$f
	bne	no_move_cage_guard

	lda	CAGE_GUARD
	cmp	#15
	bcc	guard_ch		; blt, 0..14
	jmp	no_move_cage_guard	; 15+


guard_ch:
	; CAGE_GUARD = 0..14

	inc	CAGE_GUARD
;	jmp	no_move_cage_guard

guard_done_change:
	lda	CAGE_GUARD
	cmp	#15
	bne	no_move_cage_guard

	; start patrol

	lda	#0
	sta	alien0_room

	lda	#33
	sta	alien0_x

	lda	#30
	sta	alien0_y

	lda	#A_WALKING
	sta	alien0_state

	lda	#0
	sta	alien0_gait

	lda	#0
	sta	alien0_direction

	inc	CAGE_GUARD		; now 16

no_move_cage_guard:


	;===========================
	; check if done this level

	lda	GAME_OVER
	cmp	#$ff
	beq	done_cage



	; loop forever

	jmp	cage_loop

done_cage:
	rts


	;======================
	; Draw Laser
	;======================

draw_up_laser:
	lda	SHOOTING_BOTTOM
	beq	done_draw_up_laser

	; 30 - 27, 30-24, 30-21

	lda	#$11
	sta	COLOR

	ldx	SHOOTING_BOTTOM
	stx	V2

	ldx	SHOOTING_TOP

	ldy	#21		; X location
	jsr	vlin

	; if shooting top < 10, decrement Y2
	lda	SHOOTING_TOP
	cmp	#10
	bcs	shoot_up_noadj	; bge

	dec	SHOOTING_BOTTOM
	dec	SHOOTING_BOTTOM
	dec	SHOOTING_BOTTOM
	dec	SHOOTING_BOTTOM
shoot_up_noadj:


	lda	SHOOTING_TOP
	beq	done_draw_up_laser

	dec	SHOOTING_TOP
	dec	SHOOTING_TOP
	dec	SHOOTING_TOP
	dec	SHOOTING_TOP

done_draw_up_laser:
	rts

cage_amp1_sprites:
	.word	cage_center_sprite
	.word	cage_right1_sprite
	.word	cage_right1_sprite
	.word	cage_right1_sprite
	.word	cage_center_sprite
	.word	cage_left1_sprite
	.word	cage_left1_sprite
	.word	cage_left1_sprite


cage_amp2_sprites:
	.word	cage_center_sprite
	.word	cage_right1_sprite
	.word	cage_right2_sprite
	.word	cage_right1_sprite
	.word	cage_center_sprite
	.word	cage_left1_sprite
	.word	cage_left2_sprite
	.word	cage_left1_sprite



cage_center_sprite:
	.byte	11,11
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$58,$A8,$98,$58,$A8,$A8,$58,$AA,$AA
	.byte	$AA,$AA,$55,$AA,$BB,$55,$AA,$AA,$55,$AA,$AA
	.byte	$AA,$AA,$55,$AB,$00,$55,$77,$77,$55,$AA,$AA
	.byte	$AA,$AA,$55,$AA,$00,$55,$07,$07,$55,$AA,$AA
	.byte	$AA,$AA,$55,$AA,$44,$55,$00,$50,$55,$AA,$AA
	.byte	$AA,$AA,$55,$AA,$44,$55,$05,$00,$55,$AA,$AA
	.byte	$AA,$AA,$85,$8A,$87,$85,$80,$80,$85,$AA,$AA

cage_right1_sprite:
	.byte	11,11
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$A5,$5A,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$AA,$85,$8A,$8A,$8A,$AA
	.byte	$AA,$AA,$AA,$58,$A8,$98,$55,$AA,$AA,$55,$AA
	.byte	$AA,$AA,$AA,$55,$AA,$BB,$55,$AA,$AA,$55,$AA
	.byte	$AA,$AA,$AA,$55,$AB,$00,$55,$77,$77,$55,$AA
	.byte	$AA,$AA,$AA,$55,$AA,$00,$55,$07,$57,$55,$AA
	.byte	$AA,$AA,$AA,$55,$AA,$44,$55,$05,$50,$55,$AA
	.byte	$AA,$AA,$AA,$55,$AA,$44,$55,$00,$00,$55,$AA
	.byte	$AA,$AA,$AA,$85,$87,$87,$85,$80,$80,$55,$AA

cage_right2_sprite:
	.byte	11,11
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$AA,$A5,$5A,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$AA,$8A,$85,$A8,$5A,$AA
	.byte	$AA,$AA,$AA,$AA,$58,$98,$55,$AA,$AA,$55,$AA
	.byte	$AA,$AA,$AA,$AA,$55,$BB,$55,$AA,$AA,$55,$AA
	.byte	$AA,$AA,$AA,$AA,$55,$00,$55,$77,$77,$55,$AA
	.byte	$AA,$AA,$AA,$AA,$55,$00,$55,$07,$57,$58,$5A
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$44,$55,$50,$00,$55
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$44,$55,$00,$80,$85
	.byte	$AA,$AA,$AA,$AA,$AA,$85,$87,$A8,$A8,$AA,$AA

cage_left1_sprite:
	.byte	11,11
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$5A,$A5,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$8A,$8A,$8A,$85,$AA,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$B9,$55,$A8,$A8,$58,$AA,$AA,$AA
	.byte	$AA,$55,$BA,$0B,$55,$AA,$AA,$55,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$00,$55,$7A,$7A,$55,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$40,$55,$77,$77,$55,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$44,$55,$00,$00,$55,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$74,$55,$00,$05,$55,$AA,$AA,$AA
	.byte	$AA,$A8,$A8,$A8,$A8,$80,$80,$85,$AA,$AA,$AA

cage_left2_sprite:
	.byte	11,11
	.byte	$AA,$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$5A,$A5,$AA,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$58,$A8,$85,$8A,$AA,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$B9,$55,$A8,$58,$AA,$AA,$AA,$AA
	.byte	$AA,$55,$BA,$0B,$55,$AA,$55,$AA,$AA,$AA,$AA
	.byte	$AA,$55,$AA,$00,$55,$7A,$55,$AA,$AA,$AA,$AA
	.byte	$5A,$A5,$4A,$40,$55,$77,$55,$AA,$AA,$AA,$AA
	.byte	$55,$AA,$44,$55,$55,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$85,$8A,$74,$55,$00,$55,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$A8,$A8,$80,$85,$AA,$AA,$AA,$AA,$AA



changing_guard_sprites:
	.word changing_guard1_sprite		; 0
	.word changing_guard2_sprite		; 1
	.word changing_guard3_sprite		; 2
	.word changing_guard4_sprite		; 3
	.word changing_guard5_sprite		; 4
	.word changing_guard6_sprite		; 5
	.word changing_guard7_sprite		; 6
	.word changing_guard8_sprite		; 7
	.word changing_guard9_sprite		; 8
	.word changing_guard10_sprite		; 9
	.word changing_guard11_sprite		; 10
	.word changing_guard11_sprite		; 11
	.word changing_guard11_sprite		; 12
	.word changing_guard12_sprite		; 13
	.word changing_guard13_sprite		; 14



changing_guard1_sprite:
	.byte	4,9
	.byte	$AA,$AA,$AA,$AA
	.byte	$AA,$0A,$00,$AA
	.byte	$AA,$00,$00,$0A
	.byte	$0A,$00,$00,$00
	.byte	$A0,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$AA,$00,$00,$00

changing_guard2_sprite:
	.byte	4,9
	.byte	$AA,$AA,$AA,$AA
	.byte	$AA,$0A,$00,$0A
	.byte	$00,$00,$00,$00
	.byte	$A0,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$AA,$00,$00,$00

changing_guard3_sprite:
	.byte	4,9
	.byte	$AA,$AA,$AA,$AA
	.byte	$AA,$0A,$00,$00
	.byte	$00,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$AA,$AA,$00,$00
	.byte	$AA,$0A,$00,$00

changing_guard4_sprite:
	.byte	4,9
	.byte	$AA,$AA,$AA,$AA
	.byte	$AA,$0A,$00,$AA
	.byte	$AA,$00,$00,$00
	.byte	$00,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$AA,$A0,$00,$00
	.byte	$AA,$AA,$00,$00
	.byte	$AA,$AA,$07,$05
	.byte	$AA,$0A,$00,$00

changing_guard5_sprite:
	.byte	4,9
	.byte	$AA,$AA,$AA,$AA
	.byte	$AA,$0A,$00,$AA
	.byte	$AA,$00,$00,$00
	.byte	$0A,$00,$00,$00
	.byte	$00,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$AA,$A0,$00,$50
	.byte	$AA,$AA,$07,$05
	.byte	$AA,$0A,$00,$00

changing_guard6_sprite:
	.byte	4,9
	.byte	$AA,$AA,$AA,$AA
	.byte	$AA,$0A,$00,$AA
	.byte	$AA,$00,$00,$00
	.byte	$AA,$00,$00,$00
	.byte	$00,$00,$00,$00
	.byte	$00,$00,$70,$50
	.byte	$00,$AA,$77,$55
	.byte	$A0,$AA,$07,$05
	.byte	$AA,$0A,$00,$00

changing_guard7_sprite:
	.byte	4,9
	.byte	$AA,$AA,$AA,$AA
	.byte	$AA,$77,$75,$AA
	.byte	$0A,$07,$00,$00
	.byte	$00,$50,$00,$00
	.byte	$00,$00,$00,$00
	.byte	$00,$00,$70,$50
	.byte	$00,$AA,$77,$55
	.byte	$A0,$AA,$07,$05
	.byte	$AA,$0A,$00,$00

changing_guard8_sprite:
	.byte	4,9
	.byte	$AA,$AA,$AA,$AA
	.byte	$AA,$77,$75,$AA
	.byte	$AA,$A7,$00,$00
	.byte	$00,$50,$00,$00
	.byte	$00,$00,$00,$00
	.byte	$00,$00,$70,$50
	.byte	$00,$A0,$77,$55
	.byte	$00,$AA,$07,$05
	.byte	$AA,$0A,$00,$00

changing_guard9_sprite:
	.byte	4,9
	.byte	$AA,$AA,$AA,$AA
	.byte	$AA,$77,$77,$AA
	.byte	$0A,$00,$00,$0A
	.byte	$70,$00,$00,$50
	.byte	$77,$00,$00,$55
	.byte	$A7,$00,$00,$A5
	.byte	$7A,$A0,$A0,$5A
	.byte	$07,$AA,$AA,$05
	.byte	$00,$AA,$AA,$00

changing_guard10_sprite:
	.byte	4,9
	.byte	$22,$A2,$A2,$22
	.byte	$22,$77,$77,$22
	.byte	$02,$00,$00,$02
	.byte	$70,$00,$00,$50
	.byte	$77,$00,$00,$55
	.byte	$A7,$00,$00,$A5
	.byte	$7A,$A0,$00,$5A
	.byte	$07,$AA,$A0,$05
	.byte	$00,$AA,$AA,$00

changing_guard11_sprite:
	.byte	4,9
	.byte	$22,$02,$02,$22
	.byte	$22,$77,$77,$22
	.byte	$02,$00,$00,$02
	.byte	$70,$00,$00,$50
	.byte	$77,$00,$00,$55
	.byte	$A7,$00,$00,$AA
	.byte	$7A,$A0,$A0,$5A
	.byte	$07,$AA,$AA,$05
	.byte	$00,$AA,$AA,$00

changing_guard12_sprite:
	.byte	4,9
	.byte	$22,$A2,$A2,$22
	.byte	$72,$f7,$7f,$22
	.byte	$77,$07,$00,$A2
	.byte	$AA,$77,$00,$AA
	.byte	$AA,$77,$10,$AA
	.byte	$AA,$00,$00,$AA
	.byte	$AA,$77,$A0,$55
	.byte	$AA,$07,$AA,$05
	.byte	$0A,$00,$0A,$00

changing_guard13_sprite:
	.byte	4,9
	.byte	$22,$A2,$A2,$22
	.byte	$72,$f7,$7f,$22
	.byte	$77,$07,$00,$A2
	.byte	$AA,$00,$77,$AA
	.byte	$AA,$77,$10,$AA
	.byte	$AA,$00,$00,$AA
	.byte	$AA,$77,$A0,$55
	.byte	$AA,$07,$AA,$05
	.byte	$0A,$00,$0A,$00



little_guy_in1_sprite:
	.byte 4,5
	.byte $AA,$AA,$AA,$77
	.byte $AA,$AA,$50,$00
	.byte $AA,$AA,$77,$70
	.byte $AA,$AA,$AA,$A7
	.byte $AA,$AA,$AA,$AA

little_guy_in2_sprite:
	.byte 4,5
	.byte $AA,$AA,$77,$AF
	.byte $AA,$A5,$00,$00
	.byte $AA,$AA,$77,$AA
	.byte $AA,$AA,$55,$07
	.byte $AA,$AA,$AA,$A0

little_guy_in_sprite:
	.byte 4,5
	.byte $AA,$77,$AA,$AA
	.byte $55,$00,$77,$AA
	.byte $A5,$00,$07,$AA
	.byte $AA,$07,$0A,$AA
	.byte $A0,$AA,$A0,$AA

little_guy_out1_sprite:
	.byte 4,5
	.byte $AA,$AA,$77,$AA
	.byte $AA,$77,$00,$55
	.byte $AA,$00,$07,$AA
	.byte $AA,$07,$05,$AA
	.byte $A0,$AA,$A0,$AA

little_guy_out2_sprite:
	.byte 4,5
	.byte $AA,$AA,$A7,$A7
	.byte $AA,$AA,$AA,$A5
	.byte $AA,$AA,$AA,$5A
	.byte $AA,$AA,$A7,$A7
	.byte $AA,$AA,$AA,$AA



	;============================
	;============================
	; Cage Ending
	;============================
	;============================
cage_ending:
	lda	#0
	sta	FRAMEL

cage_ending_loop:

	;================================
	; copy background to current page
	;================================

	jsr	gr_copy_to_current


	;================
	; draw cage parts
	;================
	; frame 12+13 == draw debris1
	; frame 14+15 == draw debris2
	; frame 16+17 == draw debris3


	lda	FRAMEL
	cmp	#12
	bcc	done_debris		; blt

	cmp	#18
	bcs	done_debris		; bge

	sec
	sbc	#12
	and	#$fe
	tay

	lda	debris_list,Y
	sta	GBASL
	lda	debris_list+1,Y
	sta	GBASH

	lda     #$10
        jsr     load_rle_gr

	jsr	gr_overlay

done_debris:


	;=======================
	; draw miners mining
	;=======================

	jsr	ootw_draw_miners


	;================
	; draw physicist
	;================
	; frame 18 crouching
	; frame 40 getting up one step?
	; frame 60 all stood up
	; frame 70 jump -- 90
	; frame 90 standing right (taps)
	; frame 100 turn left

	lda	#20
	sta	XPOS
	lda	#28
	sta	YPOS

	lda	FRAMEL
	cmp	#18
	bcc	ce_done_physicist	; blt

	cmp	#100
	bcs	ce_stand_left		; bge

	cmp	#90
	bcs	ce_stand_right		; bge

	cmp	#70
	bcs	ce_jump			; bge

	cmp	#60
	bcs	ce_stand_cage		; bge

	cmp	#40
	bcs	ce_half_stand_cage	; bge

ce_crouch_cage:

	ldx	#<crouch2
	ldy	#>crouch2
	jmp	ce_draw_physicist_right

ce_half_stand_cage:

	ldx	#<crouch1
	ldy	#>crouch1
	jmp	ce_draw_physicist_right

ce_stand_cage:

	ldx	#<phys_stand
	ldy	#>phys_stand
	jmp	ce_draw_physicist_right

ce_jump:

	sec
	sbc	#70
	and	#$fe
	asl
	tay

	lda	ce_phys_jump,Y
	sta	XPOS
	lda	ce_phys_jump+1,Y
	sta	YPOS

	lda	ce_phys_jump+2,Y
	tax

	lda	ce_phys_jump+3,Y
	tay

	jmp	ce_draw_physicist_right



ce_stand_right:
	lda	#28
	sta	XPOS
	lda	#30
	sta	YPOS

	ldx	#<phys_stand
	ldy	#>phys_stand
	jmp	ce_draw_physicist_right


ce_stand_left:
	lda	#28
	sta	XPOS
	lda	#30
	sta	YPOS

	ldx	#<phys_stand
	ldy	#>phys_stand

ce_draw_physicist_left:
	stx	INL
	sty	INH
        jsr     put_sprite_crop
	jmp	ce_done_physicist

ce_draw_physicist_right:
	stx	INL
	sty	INH
        jsr     put_sprite_flipped_crop

ce_done_physicist:




	;============
	; draw friend
	;============
	; frame 18 crouching
	; frame 34 getting up one step?
	; frame 38 all stood up (right)
	; frame 60 turns
	; frame 62 standing left
	; frame 74 turns
	; frame 76 standing right
	; frame 90-100 taps
	; frame 116 points, my tuba

	lda	#24
	sta	XPOS
	lda	#30
	sta	YPOS

	lda	FRAMEL
	cmp	#18
	bcs	ce_friend_keep		; bge

	jmp	ce_done_friend		; too far to branch
ce_friend_keep:
	cmp	#120
	bcs	ce_friend_stand_right	; bge

	cmp	#110
	bcs	ce_friend_point		; bge

	cmp	#100
	bcs	ce_friend_stand_right	; bge

	cmp	#90
	bcs	ce_friend_tap		; bge

	cmp	#76
	bcs	ce_friend_stand_right	; bge

	cmp	#74
	bcs	ce_friend_turn		; bge

	cmp	#62
	bcs	ce_friend_stand_left	; bge

	cmp	#60
	bcs	ce_friend_turn		; bge

	cmp	#38
	bcs	ce_friend_stand_right	; bge

	cmp	#34
	bcs	ce_friend_half_stand_cage	; bge



ce_friend_crouch_cage:
	lda	#22
	sta	XPOS

	ldx	#<friend_crouch2
	ldy	#>friend_crouch2
	jmp	ce_draw_friend_right

ce_friend_half_stand_cage:

	ldx	#<friend_crouch1
	ldy	#>friend_crouch1
	jmp	ce_draw_friend_right

ce_friend_tap:

	sec
	sbc	#90
	and	#$fe
	tay


	lda	tap_sequence,Y
	tax
	lda	tap_sequence+1,Y
	tay

	lda	#25		; one off
	sta	XPOS


	jmp	ce_draw_friend_right

ce_friend_point:

	cmp	#115
	bne	no_audio
	jsr	playaud
no_audio:

	lda	FRAMEL
	sec
	sbc	#110
	and	#$fe
	tay


	lda	point_sequence,Y
	tax
	lda	point_sequence+1,Y
	tay

	lda	#25		; one off
	sta	XPOS

	jmp	ce_draw_friend_right


ce_friend_stand_cage:

	ldx	#<friend_stand
	ldy	#>friend_stand
	jmp	ce_draw_friend_right

ce_friend_turn:

	ldx	#<friend_turning_sprite
	ldy	#>friend_turning_sprite
	jmp	ce_draw_friend_right

ce_friend_stand_right:

	ldx	#<friend_stand
	ldy	#>friend_stand
	jmp	ce_draw_friend_right


ce_friend_stand_left:

	ldx	#<friend_stand
	ldy	#>friend_stand

ce_draw_friend_left:
	stx	INL
	sty	INH
        jsr     put_sprite_crop
	jmp	ce_done_friend

ce_draw_friend_right:
	stx	INL
	sty	INH
        jsr     put_sprite_flipped_crop
ce_done_friend:



	;===========
	; draw guard
	;===========

	; frame 0-5  : standing
	; frame 6-11 : falling
	; frame 12+   : on ground

	lda	FRAMEL
	cmp	#5
	bcs	ce_guard_not_standing	; bge

	lda	#21
	sta	XPOS
	lda     #30
	sta     YPOS

	ldx	#<alien_shooting_up_sprite
	ldy	#>alien_shooting_up_sprite
	jmp	done_guard_endcage

ce_guard_not_standing:

	cmp	#10
	bcs	ce_guard_not_falling	; bge

	lda	#19
	sta	XPOS
	lda     #30
	sta     YPOS

	ldx	#<guard_crashing_sprite
	ldy	#>guard_crashing_sprite
	jmp	done_guard_endcage

ce_guard_not_falling:

	lda	#17
	sta	XPOS
	lda     #42
	sta     YPOS

	ldx	#<guard_dead_sprite
	ldy	#>guard_dead_sprite


done_guard_endcage:
	stx	INL
	sty	INH
	jsr	put_sprite_crop


	;===========
	; draw cage
	;===========
	; frame 0 ..  9 falling
	; frame 10 - 19 sproinging
	; frame 20 -- permanent


	lda	FRAMEL
	cmp	#10
	bcs	done_cage_ground	; bge

	lda	FRAMEL
	asl
	clc
	adc	#2

cage_set_ypos:
        sta     YPOS

	lda     #17
	sta	XPOS

	ldx	#<cage_center_sprite
	ldy	#>cage_center_sprite

	jmp	done_cage_endcage

done_cage_ground:

	lda     #17
	sta	XPOS
	lda	#32
        sta     YPOS

	lda	FRAMEL
	cmp	#20
	bcs	cage_on_ground	; bge

	sec
	sbc	#10
	and	#$fe
	tay

	lda	cage_sprites,Y
	tax
	lda	cage_sprites+1,Y
	tay

	jmp	done_cage_endcage

cage_on_ground:
	ldx	#<cage_ground_sprite
	ldy	#>cage_ground_sprite

done_cage_endcage:
	stx	INL
	sty	INH
        jsr     put_sprite_crop






	;==========================
	; draw little dude
	;==========================
	; frame 0 - 17 : watching
	; frame 18- 20 : out1
	; frame 20- 23 : out2
	; frame 24 : gone

	lda     #28
	sta	XPOS

	lda	#34
        sta     YPOS

	lda	FRAMEL
	cmp	#24
	bcs	done_cage_draw_lg	; bge

	ldx	#<little_guy_out2_sprite
	ldy	#>little_guy_out2_sprite

	cmp	#20
	bcs	cage_draw_lg

	ldx	#<little_guy_out1_sprite
	ldy	#>little_guy_out1_sprite

	cmp	#18
	bcs	cage_draw_lg

	ldx	#<little_guy_in_sprite
	ldy	#>little_guy_in_sprite

cage_draw_lg:

	stx	INL
	sty	INH
        jsr     put_sprite_crop

done_cage_draw_lg:

	;======================
	; draw laser
	;======================
	; continue drawing in case a shot was fired as we fell

	jsr	draw_up_laser




	;===============
	; draw gun
	;===============
	; frame 0 - 9 no draw
	; frame 10 -- in air		28,36
	; frame 12 -- lower		28,40
	; frame 14 -- on ground		29,44
	; frame 16 -- bounce		29,42
	; frame 18 -- ground		30,44
	; frame 20 -- left2		31,44
	; frame 22 -- left2		32,44
	; frame 24 -- left1		33,44
	; frame 26 -- left1 (done)	34,44

	lda	FRAMEL
	cmp	#5
	bcc	ce_done_gun		; blt

	cmp	#21
	bcs	ce_default_gun		; bge

	sec
	sbc	#5
	and	#$fe
	tay
	lda	gun_arc,Y
	sta	XPOS
	lda	gun_arc+1,Y
	sta	YPOS

	jmp	ce_draw_gun

ce_default_gun:
	lda	#35
	sta	XPOS
	lda	#44
	sta	YPOS

ce_draw_gun:
	jsr	draw_floor_gun

ce_done_gun:

	;===============
	; page flip

	jsr	page_flip


	;================
	; delay

	lda	#150
	jsr	WAIT

wuk:
;	lda	KEYPRESS
;	bpl	wuk
;	bit	KEYRESET



	;================
	; inc frame count

	inc	FRAMEL

	bmi	done_cage_end

	jmp	cage_ending_loop


done_cage_end:

        bit     KEYRESET		; clear keyboard
	rts



; at 19,42
guard_dead_sprite:
.byte	9,3
.byte	$AA,$AA,$AA,$0A,$1A,$0A,$0A,$7A,$7A
.byte	$00,$77,$77,$00,$11,$00,$70,$07,$77
.byte	$AA,$AA,$AA,$AA,$AA,$AA,$77,$AA,$AA

guard_crashing_sprite:
.byte	7,8
.byte	$AA,$AA,$AA,$AA,$AA,$AA,$AA
.byte	$AA,$AA,$AA,$AA,$AA,$AA,$AA
.byte	$AA,$AA,$AA,$AA,$7A,$77,$AA
.byte	$AA,$AA,$AA,$00,$07,$57,$55
.byte	$AA,$AA,$AA,$10,$05,$AA,$AA
.byte	$AA,$AA,$AA,$70,$77,$AA,$AA
.byte	$AA,$AA,$77,$A7,$05,$AA,$AA
.byte	$0a,$00,$AA,$0A,$A0,$AA,$AA

cage_sprites:
	.word cage_sprite_1
	.word cage_sprite_2
	.word cage_sprite_3
	.word cage_sprite_4
	.word cage_sprite_4

cage_sprite_1:
.byte 9,6
.byte $AA,$AA,$55,$AA,$AA,$55,$AA,$55,$AA
.byte $AA,$55,$AA,$AA,$55,$AA,$AA,$55,$AA
.byte $AA,$55,$AA,$99,$55,$77,$AA,$AA,$55
.byte $AA,$55,$AA,$00,$55,$00,$55,$AA,$55
.byte $AA,$55,$AA,$44,$55,$00,$55,$55,$AA
.byte $AA,$85,$8A,$A8,$A8,$A8,$A8,$A8,$AA

cage_sprite_2:
.byte 9,6
.byte $AA,$55,$AA,$AA,$AA,$55,$AA,$AA,$AA
.byte $AA,$55,$AA,$AA,$55,$AA,$AA,$55,$AA
.byte $AA,$55,$AA,$9A,$55,$AA,$77,$55,$AA
.byte $AA,$55,$AA,$09,$55,$00,$55,$55,$AA
.byte $AA,$55,$AA,$44,$55,$00,$55,$55,$AA
.byte $AA,$85,$8A,$A8,$A8,$A8,$A8,$A8,$AA

cage_sprite_3:
.byte 9,6
.byte $AA,$55,$AA,$AA,$AA,$55,$AA,$AA,$55
.byte $AA,$55,$AA,$AA,$55,$AA,$AA,$55,$AA
.byte $AA,$55,$AA,$9A,$55,$AA,$77,$55,$AA
.byte $AA,$55,$AA,$09,$55,$00,$55,$55,$AA
.byte $AA,$55,$AA,$44,$55,$00,$55,$55,$AA
.byte $AA,$85,$8A,$A8,$A8,$A8,$A8,$A8,$AA

cage_sprite_4:
.byte 9,6
.byte $55,$AA,$AA,$AA,$55,$AA,$AA,$AA,$55
.byte $AA,$55,$AA,$AA,$55,$AA,$AA,$55,$AA
.byte $AA,$55,$AA,$9A,$55,$AA,$7f,$55,$AA
.byte $AA,$55,$AA,$09,$55,$00,$00,$55,$AA
.byte $AA,$55,$AA,$44,$55,$00,$55,$55,$AA
.byte $AA,$85,$8A,$A8,$A8,$A8,$A8,$A8,$AA


; at 18,32
cage_ground_sprite:
.byte 9,6
.byte $55,$AA,$AA,$AA,$55,$AA,$AA,$AA,$AA
.byte $AA,$55,$AA,$AA,$55,$AA,$AA,$55,$AA
.byte $AA,$55,$AA,$AA,$55,$AA,$AA,$55,$AA
.byte $AA,$55,$AA,$AA,$55,$AA,$AA,$55,$AA
.byte $AA,$55,$AA,$AA,$55,$AA,$AA,$55,$AA
.byte $AA,$85,$8A,$A8,$A8,$A8,$A8,$A8,$AA


gun_arc:
	.byte 28,36	; frame 10 -- in air		28,36
	.byte 29,40	; frame 12 -- lower		28,40
	.byte 30,44	; frame 14 -- on ground		29,44
	.byte 31,42	; frame 16 -- bounce		29,42
	.byte 32,44	; frame 18 -- ground		30,44
	.byte 33,44	; frame 20 -- left2		31,44
	.byte 34,44	; frame 22 -- left2		32,44
	.byte 35,44	; frame 24 -- left1		33,44





debris_list:
	.word	debris1_rle
	.word	debris2_rle
	.word	debris3_rle

ce_phys_jump:
.byte	20,28		; 70
.word jump1
.byte	21,28		; 72
.word jump2
.byte	22,26		; 74
.word jump3
.byte	23,26		; 76
.word jump4
.byte	24,26		; 78
.word jump5
.byte	25,26		; 80
.word jump6
.byte	26,28		; 82
.word jump7
.byte	27,30		; 84
.word jump8
.byte	28,30		; 86
.word crouch2
.byte	29,30		; 88
.word crouch1

tap_sequence:
.word	friend_tap1	; 90
.word	friend_tap2	; 92
.word	friend_tap3	; 94
.word	friend_tap2	; 96
.word	friend_tap3	; 98

point_sequence:
.word	friend_tap1	; 110
.word	friend_mouth	; 112
.word	friend_tap3	; 114
.word	friend_tap2	; 116
.word	friend_tap3	; 118


friend_tap1:
	.byte 5,8
	.byte $AA,$AA,$fa,$ff,$f7
	.byte $AA,$AA,$ff,$0f,$0f
	.byte $AA,$fA,$fA,$f0,$0f
	.byte $AA,$AA,$AA,$00,$00
	.byte $AA,$AA,$AA,$00,$00
	.byte $AA,$AA,$AA,$ff,$77
	.byte $AA,$AA,$AA,$0f,$07
	.byte $AA,$AA,$0A,$00,$00

friend_tap2:
	.byte 5,8
	.byte $AA,$AA,$fa,$ff,$f7
	.byte $AA,$AA,$ff,$0f,$0f
	.byte $Af,$Af,$Af,$0f,$0f
	.byte $AA,$AA,$AA,$00,$00
	.byte $AA,$AA,$AA,$00,$00
	.byte $AA,$AA,$AA,$ff,$77
	.byte $AA,$AA,$AA,$0f,$07
	.byte $AA,$AA,$0A,$00,$00

friend_tap3:
	.byte 5,8
	.byte $AA,$AA,$fa,$ff,$f7
	.byte $AA,$AA,$ff,$0f,$0f
	.byte $AA,$fA,$fA,$0f,$0f
	.byte $AA,$AA,$AA,$00,$00
	.byte $AA,$AA,$AA,$00,$00
	.byte $AA,$AA,$AA,$ff,$77
	.byte $AA,$AA,$AA,$0f,$07
	.byte $AA,$AA,$0A,$00,$00

friend_mouth:
	.byte 5,8
	.byte $AA,$AA,$fa,$ff,$f7
	.byte $AA,$AA,$ff,$0f,$0f
	.byte $AA,$AA,$Af,$ff,$ff
	.byte $AA,$AA,$AA,$00,$0f
	.byte $AA,$AA,$AA,$00,$00
	.byte $AA,$AA,$AA,$ff,$77
	.byte $AA,$AA,$AA,$0f,$07
	.byte $AA,$AA,$0A,$00,$00



cage_direction_lookup:
	.byte 1		; 0000 = right
	.byte 1		; 0001 = right
	.byte 1		; 0010 = right
	.byte 1		; 0011 = right
	.byte 0		; 0100 = peak
	.byte 0		; 0101 = peak
	.byte $80	; 0110 = left
	.byte $80	; 0111 = left
	.byte $80	; 1000 = left
	.byte $80	; 1001 = left
	.byte $80	; 1010 = left
	.byte $80	; 1011 = left
	.byte 0		; 1100 = peak
	.byte 0		; 1101 = peak
	.byte 1		; 1110 = right
	.byte 1		; 1111 = right
