

; TODO: auto-size this based on MAX_LEMMINGS

lemming_x:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_y:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_direction:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_out:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_frame:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_status:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_exploding:
	.byte 0,0,0,0,0,0,0,0,0,0
lemming_fall_distance:
	.byte 0,0,0,0,0,0,0,0,0,0





	;==========================
	; move them
	;==========================
move_lemmings:

	ldy	#0
	sty	CURRENT_LEMMING
move_lemming_loop:

	ldy	CURRENT_LEMMING
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
	tya
	tax
	inc	lemming_y,X		; fall speed
	inc	lemming_y,X

	inc	lemming_fall_distance,X	; how far

	jsr	collision_check_ground

	jmp	done_move_lemming

	;=========================
	; walking
	;=========================

do_lemming_walking:

	; see if ground has risen up

	jsr	collision_check_hill

	; collision detect walls

	ldy	CURRENT_LEMMING
	lda	lemming_y,Y
	clc
	adc	#3		; waist-high?
	tax

	lda     hposn_high,X
	clc
	adc	#$20
        sta     GBASH
        lda     hposn_low,X
        sta     GBASL

	; increment
	; only do this every 4th frame?

	lda	lemming_frame,Y
	and	#$3
	beq	walking_increment

	bne	walking_done


walking_increment:
	; actually incrememt

	clc				; increment/decrement X
	lda	lemming_x,Y
	adc	lemming_direction,Y	; A is now incremented version
;	sta	lemming_x,Y
	tay				; Y is now incremented version

	lda	(GBASL),Y		; collision check
	and	#$7f
	beq	walking_no_wall

walking_yes_wall:
	;  we hit a wall, reverse course, undo the increment
	; Y is updated

	jsr	check_at_exit_xiny

	; reverse direction
	ldy	CURRENT_LEMMING
	lda	lemming_direction,Y
	eor	#$ff
	clc
	adc	#1
	sta	lemming_direction,Y
	jmp	walking_no_increment

walking_no_wall:
	; y is incremented version
	tya
	ldy	CURRENT_LEMMING
	sta	lemming_x,Y

walking_no_increment:

	jsr	collision_check_ground

walking_done:
	jmp	done_move_lemming

	;=====================
	; digging
	;=====================
do_lemming_digging:
	lda	lemming_y,Y
	clc
	adc	#9
	tax

	lda     hposn_high,X
	clc
	adc	#$20
        sta     GBASH
        lda     hposn_low,X
        sta     GBASL

	lda	lemming_x,Y
	tay
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

	ldx	CURRENT_LEMMING
	inc	lemming_y,X

	jmp	done_digging
digging_falling:
	ldy	CURRENT_LEMMING
	lda	#LEMMING_FALLING
	sta	lemming_status,Y
done_digging:


done_move_lemming:


done_checking_lemming:

	inc     CURRENT_LEMMING
	lda     CURRENT_LEMMING
	cmp     #MAX_LEMMINGS
	beq     really_done_checking_lemming
	jmp	move_lemming_loop
really_done_checking_lemming:

	rts

	;==========================
	; remove lemming from game
	;==========================
	; Y points to CURRENT_LEMMING
	; if C set it means they exited

remove_lemming:

	bcc	didnt_exit

	sed
	lda	PERCENT_RESCUED_L
	clc
	adc	PERCENT_ADD
	sta	PERCENT_RESCUED_L
	bcc	no_percent_oflo

	inc	PERCENT_RESCUED_H

	cld

no_percent_oflo:

didnt_exit:

	sed			; decrement BCD value
	lda	LEMMINGS_OUT
	sec
	sbc	#1
	sta	LEMMINGS_OUT
	cld

	jsr	click_speaker

	lda	#0
	sta	lemming_out,Y

	jsr	update_lemmings_out

	; if that was the last one, then level over

	lda	LEMMINGS_OUT
	bne	not_last_lemming

	lda	#LEVEL_WIN
	sta	LEVEL_OVER
not_last_lemming:

	rts



	;=============================
	; collision check ground
	;=============================

collision_check_ground:
	lda	lemming_y,Y
	clc
	adc	#9
	tax

	lda     hposn_high,X
	clc
	adc	#$20			; check bg, not fg
        sta     GBASH
        lda     hposn_low,X
        sta     GBASL

	lda	lemming_x,Y
	tay
	lda	(GBASL),Y
	and	#$7f
	beq	ground_falling		; if empty space below us, fall
ground_walking:

	; hit ground walking

	ldy	CURRENT_LEMMING

	lda	lemming_fall_distance,Y
	cmp	#32
	bcs	lemming_goes_splat

	lda	#0
	sta	lemming_fall_distance,Y

	lda	#LEMMING_WALKING	; else, walk
	jmp	done_check_ground

ground_falling:
	lda	#LEMMING_FALLING
done_check_ground:
	ldy	CURRENT_LEMMING
	sta	lemming_status,Y

	rts

lemming_goes_splat:

	clc
	jsr	remove_lemming

	rts


	;=============================
	; collision check hill
	;=============================

collision_check_hill:
	lda	lemming_y,Y
	clc
	adc	#8
	tax

	lda     hposn_high,X
	clc
	adc	#$20			; check bg, not fg
        sta     GBASH
        lda     hposn_low,X
        sta     GBASL

	lda	lemming_x,Y
	tay
	lda	(GBASL),Y
	and	#$7f
	beq	on_ground		; if empty space below us, good
underground:
	ldx	CURRENT_LEMMING
	dec	lemming_y,X		; bump us up

on_ground:

	rts


	;=============================
	; check at exit
	;=============================
check_at_exit_xiny:
	tya
	ldy	CURRENT_LEMMING
	jmp	check_at_exit_y

check_at_exit:

	; see if at exit

	ldy	CURRENT_LEMMING

	; check X

	lda	lemming_x,Y
check_at_exit_y:

exit_x1_smc:
	cmp	#31
	bcc	not_done_level
exit_x2_smc:
	cmp	#35
	bcs	not_done_level

	; check Y

	lda	lemming_y,Y
exit_y1_smc:
	cmp	#116
	bcc	not_done_level
exit_y2_smc:
	cmp	#127
	bcs	not_done_level

	; done level
	sec
	jsr	remove_lemming


not_done_level:
	rts

