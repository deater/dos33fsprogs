
	;==========================
	; move them
	;==========================
move_lemmings:

	ldy	#0
	lda	lemming_out,Y

	bne	really_move_lemming
	jmp	done_checking_lemming

really_move_lemming:
	; bump frame
	tya
	tax
	inc	lemming_frame,X		; only can inc with X

	lda	lemming_status,Y
	cmp	#LEMMING_FALLING
	beq	do_lemming_falling
	cmp	#LEMMING_WALKING
	beq	do_lemming_walking
	cmp	#LEMMING_DIGGING
	beq	do_lemming_digging
	jmp	done_move_lemming


	;=========================
	; falling
	;=========================

do_lemming_falling:
	inc	lemming_y		; fall speed
	inc	lemming_y

	jsr	collision_check_ground

	jmp	done_move_lemming

	;=========================
	; walking
	;=========================

do_lemming_walking:


	; collision detect walls

	lda	lemming_y
	clc
	adc	#3		; waist-high?
	tay

	lda     hposn_high,Y
	clc
	adc	#$20
        sta     GBASH
        lda     hposn_low,Y
        sta     GBASL

	; increment
	; only do this every 4th frame?

	lda	lemming_frame
	and	#$3
	beq	walking_increment

	lda	lemming_x
	jmp	walking_done


walking_increment:
	; actually incrememt

	clc
	lda	lemming_x
	adc	lemming_direction
	tay

	lda	(GBASL),Y
	and	#$7f
	beq	walking_no_wall

walking_yes_wall:

	; reverse direction
	lda	lemming_direction
	eor	#$ff
	clc
	adc	#1
	sta	lemming_direction
	lda	lemming_x

walking_no_wall:
	tya

walking_done:
	sta	lemming_x

	jsr	collision_check_ground

	jmp	done_move_lemming

do_lemming_digging:
	lda	lemming_y
	clc
	adc	#9
	tay

	lda     hposn_high,Y
	clc
	adc	#$20
        sta     GBASH
        lda     hposn_low,Y
        sta     GBASL

	ldy	lemming_x
	lda	(GBASL),Y
	and	#$7f
	beq	digging_falling
digging_digging:
	lda	#$0
	sta	(GBASL),Y
;	lda	GBASH
;	clc
;	adc	#$20				; erase bg
;	sta	GBASH
;	lda	#$0
;	sta	(GBASL),Y

	inc	lemming_y

	jmp	done_digging
digging_falling:
	lda	#LEMMING_FALLING
	sta	lemming_status
done_digging:


done_move_lemming:

	; see if beat level

	lda	lemming_y
	cmp	#116
	bcc	not_done_level
	cmp	#127
	bcs	not_done_level
	lda	lemming_x
	cmp	#31
	bcc	not_done_level

	; done level

	jsr	remove_lemming

	lda	#LEVEL_WIN
	sta	LEVEL_OVER

not_done_level:

done_checking_lemming:

	rts

	;==========================
	; remove lemming from game
remove_lemming:

	lda	#0
	sta	lemming_out

	dec	LEMMINGS_OUT
	jsr	update_lemmings_out

	rts


lemming_direction:
	.byte 1

lemming_x:
	.byte 12
lemming_y:
	.byte 45

lemming_out:
	.byte $0

lemming_frame:
	.byte 0

lemming_status:
	.byte LEMMING_FALLING

lemming_exploding:
	.byte $00



	;=============================
	; collision check ground
	;=============================

collision_check_ground:
	lda	lemming_y
	clc
	adc	#9
	tay

	lda     hposn_high,Y
	clc
	adc	#$20			; check bg, not fg
        sta     GBASH
        lda     hposn_low,Y
        sta     GBASL

	ldy	lemming_x
	lda	(GBASL),Y
	and	#$7f
	beq	ground_falling
ground_walking:
;	lda	#0
;	sta	lemming_frame
	lda	#LEMMING_WALKING
	jmp	done_check_ground
ground_falling:
	lda	#LEMMING_FALLING
done_check_ground:
	sta	lemming_status

	rts
