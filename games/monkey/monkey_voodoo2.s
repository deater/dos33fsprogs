; voodoo lady

	; if x<8 goto MONKEY_VOODOO1

voodoo2_check_exit:

	lda	GUYBRUSH_X
	cmp	#8
	bcc	voodoo2_to_voodoo1
	bcs	voodoo2_no_exit

voodoo2_to_voodoo1:
	lda	#MONKEY_VOODOO1
	sta	LOCATION
	lda	#30
	sta	GUYBRUSH_X
	sta	DESTINATION_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location
	jmp	voodoo2_no_exit

voodoo2_no_exit:
	rts



	;==========================
	;==========================
	; voodoo2 adjust destination
	;==========================
	;==========================
voodoo2_adjust_destination:
	; just make Y always 20

v2_check_y:
	; if x < 28, Y must be between 16 and 18
	; if x < 35, Y must be between  8 and 28

v2_y_too_small:
	lda	#20
	sta	DESTINATION_Y

done_v2_adjust:
	rts



draw_smoke:

	lda	FRAMEL
	and	#$10
	beq	smoke2

smoke1:
	lda	#<smoke_sprite1
	sta	INL
	lda	#>smoke_sprite1
	jmp	actually_draw_smoke
smoke2:
	lda	#<smoke_sprite2
	sta	INL
	lda	#>smoke_sprite2
actually_draw_smoke:
	sta	INH

	lda	#18
	sta	XPOS
	lda	#0
	sta	YPOS

	jmp	put_sprite_crop

smoke_sprite1:
	.byte 4,14
	.byte $ff,$cc,$AA,$AA
	.byte $AA,$ff,$cA,$AA
	.byte $AA,$ff,$cc,$AA
	.byte $AA,$ff,$AA,$cc
	.byte $AA,$ff,$cA,$AA
	.byte $AA,$ff,$Ac,$AA
	.byte $AA,$ff,$AA,$AA
	.byte $cc,$Af,$fA,$AA
	.byte $cc,$AA,$Af,$fA
	.byte $AA,$Ac,$cc,$ff
	.byte $AA,$AA,$cc,$ff
	.byte $AA,$cc,$fA,$ff
	.byte $AA,$cc,$ff,$AA
	.byte $AA,$cc,$ff,$AA

smoke_sprite2:
	.byte 4,14
	.byte $AA,$ff,$cA,$AA
	.byte $ff,$aa,$cc,$AA
	.byte $ff,$cc,$AA,$AA
	.byte $ff,$cc,$AA,$AA
	.byte $ff,$ac,$cA,$AA
	.byte $AA,$ff,$cc,$AA
	.byte $AA,$ff,$AA,$cc
	.byte $AA,$ff,$AA,$cc
	.byte $AA,$ff,$fc,$AA
	.byte $AA,$cc,$ff,$AA
	.byte $cc,$AA,$ff,$AA
	.byte $Ac,$cA,$ff,$AA
	.byte $AA,$fc,$cf,$AA
	.byte $7A,$ff,$cc,$A7




voodoo2_check_bounds:
	rts


;=============================
voodoo_lady_action:
	lda	CURRENT_VERB
	asl
	tay

	lda	voodoo_lady_actions,Y
	cmp	#$ff
	beq	voodoo_lady_nothing

	sta	MESSAGE_L
	lda	voodoo_lady_actions+1,Y
	sta	MESSAGE_H

	jmp	do_display_message

voodoo_lady_nothing:
	lda	#VERB_WALK
	sta	CURRENT_VERB
	rts

voodoo_lady_actions:
	.word 	$FFFF		; give
	.word	doesnt_open	; open
	.word	doesnt_work	; close
	.word	cant_pick_up	; pick_up
	.word	$FFFF		; look_at
	.word	voodoo_talk	; talk_to
	.word	for_what	; use
	.word	icant_move	; push
	.word	icant_move	; pull

voodoo_talk:
.byte 6,21,"WHAT MAY I HELP YOU WITH SON?",0

