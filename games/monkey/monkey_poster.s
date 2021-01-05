	; if x<3 goto MONKEY_POSTER at 28,30 with destination 28,24
        ; if x>35 goto MONKEY_DOCK at 5,20

poster_check_exit:
	lda	GUYBRUSH_X
	cmp	#4
	bcc	poster_to_lookout
	cmp	#35
	bcs	poster_to_dock
	bcc	poster_no_exit

poster_to_lookout:

	; check y position
	lda	GUYBRUSH_FEET
	cmp	#22
	bcs	poster_no_exit

	lda	#GUYBRUSH_BIG
	sta	GUYBRUSH_SIZE

	lda	#MONKEY_LOOKOUT
	sta	LOCATION
	lda	#28
	sta	GUYBRUSH_X
	lda	#26
	sta	GUYBRUSH_Y
	lda	#28
	sta	DESTINATION_X
	lda	#18
	sta	DESTINATION_Y
	lda	#DIR_UP
	sta	GUYBRUSH_DIRECTION
	jsr	change_location
	jmp	poster_no_exit

poster_to_dock:
	lda	#MONKEY_DOCK
	sta	LOCATION
	lda	#5
	sta	DESTINATION_X
	sta	GUYBRUSH_X
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	change_location

poster_no_exit:
	rts


	;===============================
	;===============================
	; adjust destination
	;===============================
	;===============================
poster_adjust_destination:

	rts





draw_house:

	lda	#<house_sprite
	sta	INL
	lda	#>house_sprite
	sta	INH

	lda	#9
	sta	XPOS
	lda	#20
	sta	YPOS

	jsr	put_sprite_crop

	rts

house_sprite:
	.byte 18,7
	;line 1
	.byte $AA,$5A,$55,$55,$55,$55,$55,$55,$55,$55
	.byte $55,$55,$55,$57,$7A,$7A,$AA,$AA

	.byte $00,$00,$00,$00,$00,$00,$00,$05,$05,$05
	.byte $05,$05,$05,$05,$05,$05,$07,$7A

	.byte $22,$22,$22,$22,$20,$80,$80,$00,$80,$80
	.byte $22,$72,$A7,$AA,$AA,$AA,$77,$AA

	.byte $22,$22,$22,$22,$22,$88,$d8,$00,$d8,$88
	.byte $22,$77,$AA,$AA,$AA,$77,$AA,$AA

	.byte $22,$22,$22,$22,$22,$08,$0d,$00,$0d,$22
	.byte $22,$77,$AA,$AA,$AA,$77,$AA,$AA

	.byte $22,$22,$22,$22,$22,$88,$dd,$00,$dd,$22
	.byte $22,$77,$7A,$7A,$7A,$77,$AA,$AA

	.byte $22,$22,$22,$22,$22,$28,$20,$2d,$28,$22
	.byte $77,$AA,$77,$AA,$77,$AA,$AA,$AA


	;=================================
	;=================================
	; poster check bounds
	;=================================
	;=================================

poster_check_bounds:

	jsr	update_feet_location

ps_check_x:

	lda     GUYBRUSH_X
        cmp     #4
        bcc     ps_x_cliff

	; otherwise normal height, on path
ps_x_main:
	lda	#GUYBRUSH_BIG
	sta	GUYBRUSH_SIZE
	lda	#20
	sta	GUYBRUSH_Y
	sta	DESTINATION_Y
	jsr	update_feet_location
	jmp	poster_adjust_height


ps_x_cliff:

	jmp     poster_adjust_height


;			Y	FEET
;	20	BIG	20	34
;	18	MEDIUM	26	32
;		MEDIUM	24	30
;		MEDIUM	22	28
;		SMALL	24	26
;		SMALL	22	24
;		SMALL	20	22
;		TINY	20	22

poster_adjust_height:

	lda     GUYBRUSH_FEET
        cmp     #34		; if >=$22 (34) then big
        bcs     poster_big
        cmp     #28		; >= $1E, (28) then medium
        bcs     poster_medium
        cmp     #22		; >= $1A  (22), small
        bcs     poster_small
                                ; else, tiny
poster_tiny:
        lda     #GUYBRUSH_TINY
        jmp     poster_done_set_height
poster_big:
        lda     #GUYBRUSH_BIG
        jmp     poster_done_set_height
poster_medium:
        lda     #GUYBRUSH_MEDIUM
        jmp     poster_done_set_height
poster_small:
        lda     #GUYBRUSH_SMALL
poster_done_set_height:
	jmp	set_height

