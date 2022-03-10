
move_lemmings:

	lda	lemming_out
	beq	done_move_lemming

	lda	lemming_status
	cmp	#LEMMING_FALLING
	beq	do_lemming_falling
	cmp	#LEMMING_WALKING
	beq	do_lemming_walking
	cmp	#LEMMING_DIGGING
	beq	do_lemming_digging
	jmp	done_move_lemming

do_lemming_falling:
	inc	lemming_y

	lda	lemming_y
	clc
	adc	#9
	tay

	lda     hposn_high,Y
        sta     GBASH
        lda     hposn_low,Y
        sta     GBASL

	ldy	lemming_x
	lda	(GBASL),Y
	and	#$7f
	beq	done_move_lemming

	lda	#LEMMING_WALKING
	sta	lemming_status

	jmp	done_move_lemming


do_lemming_walking:

do_lemming_digging:

done_move_lemming:
	rts

lemming_x:
	.byte 12
lemming_y:
	.byte 45

lemming_out:
	.byte $0


LEMMING_FALLING = 1
LEMMING_WALKING = 2
LEMMING_DIGGING = 3

lemming_status:
	.byte LEMMING_FALLING

lemming_job:
	.byte $00
