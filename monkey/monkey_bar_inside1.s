; stuff regarding 1st room in scumm bar

	; if x<5 goto MONKEY_BAR at 10,20
	; if x>35 goto MONKEY_BAR_INSIDE2 at 5,20

bar_inside1_check_exit:

	lda	GUYBRUSH_X
	cmp	#5
	bcc	bar_inside1_to_bar
	cmp	#35
	bcs	bar_inside1_to_bar_inside2
	bcc	bar_inside1_no_exit

bar_inside1_to_bar:

	; check if leave for first time
	lda	FIRST_TIME
	and	#FIRST_TIME_LEAVE_BAR
	bne	left_bar_before

	jsr	lechuck_cutscene

left_bar_before:

	lda	#MONKEY_BAR
	sta	LOCATION
	lda	#10
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	lda	#DIR_DOWN
	sta	GUYBRUSH_DIRECTION
	jsr	change_location
	jmp	bar_inside1_no_exit

bar_inside1_to_bar_inside2:
	lda	#MONKEY_BAR_INSIDE2
	sta	LOCATION
	lda	#3
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	lda	#24
	sta	DESTINATION_Y
	jsr	change_location
	jmp	bar_inside1_no_exit

bar_inside1_no_exit:
	rts



	;=================================
	;=================================
	; bar_inside1 adjust destination
	;=================================
	;=================================
bar_inside1_adjust_destination:
	; just make Y always 22

mb1_check_y:
	; if x < 28, Y must be between 16 and 18
	; if x < 35, Y must be between  8 and 28

mb1_y_too_small:
	lda	#24
	sta	DESTINATION_Y

done_mb1_adjust:
	rts



	;=================================
	;=================================
	; bar_inside1 draw foreground
	;=================================
	;=================================

bar_inside1_foreground:

	lda	GUYBRUSH_X
	cmp	#12
	bcs	bar_inside_rightside

bar_inside_leftside:

	lda	#<bar1_table_sprite
	sta	INL
	lda	#>bar1_table_sprite
	sta	INH

	lda	#4
	sta	XPOS
	lda	#32
	sta	YPOS

	jsr	put_sprite_crop

	jmp	bar_animate_ceiling

bar_inside_rightside:

	lda	#<bar1_table2_sprite
	sta	INL
	lda	#>bar1_table2_sprite
	sta	INH

	lda	#20
	sta	XPOS
	lda	#26
	sta	YPOS

	jsr	put_sprite_crop

	; I can't spell chandelier
bar_animate_ceiling:

	lda	FRAMEL
	and	#$30
	lsr
	lsr
	lsr
	tay

	lda	ceiling_sprites,Y
	sta	INL
	lda	ceiling_sprites+1,Y
	sta	INH

	lda	#19
	sta	XPOS
	lda	#8
	sta	YPOS

	jmp	put_sprite_crop





bar1_table_sprite:
	.byte 6,3
	.byte $8A,$8A,$1A,$8A,$AA,$AA
	.byte $b8,$00,$0b,$b8,$88,$88
	.byte $88,$90,$00,$88,$8b,$A8

bar1_table2_sprite:
	.byte 11,6
	.byte $AA,$AA,$0A,$0A,$AA,$AA,$9A,$9A,$AA,$AA,$AA
	.byte $AA,$00,$0b,$AA,$AA,$AA,$99,$bb,$AA,$b2,$0A
	.byte $AA,$0A,$6b,$0A,$7A,$5A,$b2,$62,$AA,$9b,$00
	.byte $8A,$00,$b5,$20,$67,$dd,$db,$7b,$db,$d0,$A0
	.byte $A8,$88,$26,$66,$db,$d2,$db,$d7,$8d,$8b,$AA
	.byte $AA,$88,$22,$26,$2b,$88,$A8,$08,$00,$88,$AA

ceiling_sprites:
	.word	ceiling1_sprite
	.word	ceiling2_sprite
	.word	ceiling3_sprite
	.word	ceiling4_sprite

ceiling1_sprite:
	.byte	6,6
	.byte	$AA,$2A,$62,$AA,$9d,$AA
	.byte	$22,$26,$b8,$88,$A5,$AA
	.byte	$AA,$00,$00,$28,$88,$9d
	.byte	$cc,$00,$00,$82,$A8,$85
	.byte	$AA,$cb,$00,$02,$22,$AA
	.byte	$AA,$AA,$AA,$00,$08,$AA

ceiling2_sprite:
	.byte	7,6
	.byte	$AA,$AA,$9d,$AA,$62,$22,$AA
	.byte	$AA,$AA,$dA,$88,$8b,$AA,$AA
	.byte	$AA,$2A,$59,$88,$2b,$AA,$cA
	.byte	$AA,$A8,$a8,$88,$62,$00,$cc
	.byte	$AA,$AA,$AA,$88,$66,$AA,$Ac
	.byte	$AA,$AA,$AA,$08,$00,$AA,$AA

ceiling3_sprite:
	.byte	8,6
	.byte	$AA,$9d,$AA,$AA,$AA,$9d,$62,$2A
	.byte	$dA,$A8,$00,$08,$28,$08,$bb,$62
	.byte	$59,$2A,$9d,$99,$22,$22,$02,$AA
	.byte	$A8,$A8,$25,$28,$22,$AA,$00,$cc
	.byte	$AA,$AA,$02,$88,$66,$AA,$CC,$Ab
	.byte	$AA,$0A,$00,$A8,$AA,$AA,$AA,$AA

ceiling4_sprite:
	.byte	6,6
	.byte	$AA,$AA,$9d,$62,$22,$22
	.byte	$AA,$dA,$2A,$28,$0b,$A6
	.byte	$AA,$29,$52,$c2,$00,$AA
	.byte	$AA,$A8,$28,$cb,$A0,$AA
	.byte	$AA,$AA,$A2,$00,$AA,$AA
	.byte	$AA,$AA,$A0,$A0,$AA,$AA


	;===================================
	;===================================
	; actions
	;===================================
	;===================================


;=============================
bar1_left_pirate_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	left_pirate_actions,Y
	cmp	#$ff
	beq	left_pirate_nothing

	sta	MESSAGE_L
	lda	left_pirate_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

left_pirate_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

left_pirate_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   cant_pick_up	; pick_up
	.word   left_pirate_look; look_at
	.word   left_pirate_look; talk_to
	.word   doesnt_work	; use
	.word   icant_move	; push
	.word   icant_move	; pull

;                              01234567890123456789012345678901234567890
left_pirate_look: .byte 00,21,"IT'S NOT WISE TO WAKE A SLEEPING PIRATE",0

; red pirate
; fancy graphic??

;=============================
bar1_red_pirate_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	red_pirate_actions,Y
	cmp	#$ff
	beq	red_pirate_nothing

	sta	MESSAGE_L
	lda	red_pirate_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

red_pirate_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

red_pirate_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   cant_pick_up	; pick_up
	.word   red_pirate_look	; look_at
	.word   red_pirate_look	; talk_to
	.word   doesnt_work	; use
	.word   icant_move	; push
	.word   icant_move	; pull


red_pirate_look:	.byte 03,21,"AHOY THERE STRANGER, NEW IN TOWN?",0

; pirates at table with red
;=============================
bar1_right_pirate_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	right_pirate_actions,Y
	cmp	#$ff
	beq	right_pirate_nothing

	sta	MESSAGE_L
	lda	right_pirate_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

right_pirate_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

right_pirate_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   cant_pick_up	; pick_up
	.word   right_pirate_look	; look_at
	.word   right_pirate_look	; talk_to
	.word   doesnt_work	; use
	.word   icant_move	; push
	.word   icant_move	; pull

right_pirate_look:	.byte 03,21,"THEY'RE BUSY TALKING TO GUY ON LEFT",0

; black foreground
; zooms in

; pirates at left of fg table
;=============================
bar1_fg_left_pirate_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	fg_left_pirate_actions,Y
	cmp	#$ff
	beq	fg_left_pirate_nothing

	sta	MESSAGE_L
	lda	fg_left_pirate_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

fg_left_pirate_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

fg_left_pirate_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   cant_pick_up	; pick_up
	.word   fg_left_pirate_look	; look_at
	.word   fg_left_pirate_look	; talk_to
	.word   doesnt_work	; use
	.word   icant_move	; push
	.word   icant_move	; pull

fg_left_pirate_look:	.byte 05,21,"WHAT'RE YOU LOOKING AT ME FOR?",0

; guy with girl
;=============================
bar1_fg_busy_pirate_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	fg_busy_pirate_actions,Y
	cmp	#$ff
	beq	fg_busy_pirate_nothing

	sta	MESSAGE_L
	lda	fg_busy_pirate_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

fg_busy_pirate_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

fg_busy_pirate_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   cant_pick_up	; pick_up
	.word   fg_busy_pirate_look	; look_at
	.word   fg_busy_pirate_look	; talk_to
	.word   doesnt_work	; use
	.word   icant_move	; push
	.word   icant_move	; pull

fg_busy_pirate_look:	.byte 10,21,"I THINK THEY'RE BUSY.",0

; skinny loom guy
;=============================
bar1_loom_pirate_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	loom_pirate_actions,Y
	cmp	#$ff
	beq	loom_pirate_nothing

	sta	MESSAGE_L
	lda	loom_pirate_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

loom_pirate_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

loom_pirate_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   cant_pick_up	; pick_up
	.word   loom_pirate_look	; look_at
	.word   loom_pirate_look	; talk_to
	.word   doesnt_work	; use
	.word   icant_move	; push
	.word   icant_move	; pull

loom_pirate_look:	.byte 10,21,"ASK ME ABOUT LOOM",0

; dog
;=============================
bar1_dog_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	dog_pirate_actions,Y
	cmp	#$ff
	beq	dog_pirate_nothing

	sta	MESSAGE_L
	lda	dog_pirate_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

dog_pirate_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

dog_pirate_actions:
	.word   $FFFF		; give
	.word   doesnt_open	; open
	.word   doesnt_work	; close
	.word   cant_pick_up	; pick_up
	.word   dog_look	; look_at
	.word   dog_look	; talk_to
	.word   doesnt_work	; use
	.word   icant_move	; push
	.word   icant_move	; pull

dog_look:	.byte 18,21,"GRRRRR",0



;=============================
bar1_door_action:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

	;============================
	;============================
	; check bounds
	;============================
	;============================

bar_inside1_check_bounds:
	rts
