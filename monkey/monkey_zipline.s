; stuff regarding the zipline

	; if x<4 goto MONKEY_MAP at 23,4

zipline_check_exit:

	lda	GUYBRUSH_X
	cmp	#4
	bcc	zipline_to_map
	bcs	zipline_no_exit

zipline_to_map:
	lda	#MONKEY_MAP
	sta	LOCATION
	lda	#23
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#4
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location

zipline_no_exit:
	rts



	;==========================
	;==========================
	; zipline adjust destination
	;==========================
	;==========================
zipline_adjust_destination:
	; just make Y always 26

zp_check_y:

zp_y_too_small:
	lda	#26
	sta	DESTINATION_Y

done_zp_adjust:
	rts




;draw_sign:

;	lda	#<wall_sprite
;	sta	INL
;	lda	#>wall_sprite
;	sta	INH

;	lda	#18
;	sta	XPOS
;	lda	#22
;	sta	YPOS

;	jsr	put_sprite_crop

;	rts

;house_sprite:

;=============================

sign_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	sign_actions,Y
	cmp     #$ff
	beq	sign_nothing

	sta	MESSAGE_L
	lda	sign_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

sign_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts


sign_actions:
        .word   $FFFF		; give
        .word   doesnt_open	; open
        .word   doesnt_work	; close
        .word   cant_pick_up	; pick_up
        .word   sign_look	; look_at
        .word   $FFFF		; talk_to
        .word   doesnt_work	; use
        .word   icant_move	; push
        .word   icant_move	; pull



sign_look:	.byte 2,21,"GAUDY BUT IN A CHEERFUL SORT OF WAY",0

;=============================

cable_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	cable_actions,Y
	cmp     #$ff
	beq	cable_nothing

	sta	MESSAGE_L
	lda	cable_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

cable_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts


cable_actions:
        .word   $FFFF           ; give
        .word	doesnt_open	; open
        .word	doesnt_work	; close
        .word	cant_pick_up	; pick_up
        .word   cable_look	; look_at
        .word	$FFFF		; talk_to
        .word   $FFFF           ; use
        .word	icant_move	; push
        .word   icant_move	; pull

cable_look:	.byte 1,21,"HMM I THINK IT COULD SUPPORT MY WEIGHT",0

;=============================

pole_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	pole_actions,Y
	cmp     #$ff
	beq	pole_nothing

	sta	MESSAGE_L
	lda	pole_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

pole_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts


pole_actions:
        .word	$FFFF		; give
        .word	doesnt_open	; open
        .word	doesnt_work	; close
        .word	cant_pick_up	; pick_up
        .word	pole_look	; look_at
        .word	$FFFF		; talk_to
        .word	$FFFF           ; use		; FIXME, use pool climbs ladder
        .word	icant_move	; push
        .word	icant_move	; pull


pole_look: .byte	6,21,"IT'S JUST LIKE THE OTHER ONE",0
