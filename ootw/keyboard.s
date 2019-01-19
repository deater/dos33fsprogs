;======================================
; handle keypress
;======================================

handle_keypress:

	lda	KEYPRESS						; 4
	bmi	keypress						; 3

	rts	; nothing pressed, return

keypress:
									; -1

	and	#$7f		; clear high bit

check_quit:
	cmp	#'Q'
	beq	quit
	cmp	#27
	bne	check_left
quit:
	lda	#$ff		; could just dec
	sta	GAME_OVER
	rts

check_left:
	cmp	#'A'
	beq	left
	cmp	#$8		; left arrow
	bne	check_right
left:

	; walk left

	lda	#0
	sta	CROUCHING		; stanid crouching

	lda	DIRECTION		; if facing right, turn to face left
	bne	face_left

	dec	PHYSICIST_X		; walk left

	lda	PHYSICIST_X
	cmp	LEFT_LIMIT
	bpl	just_fine_left
too_far_left:
	inc	PHYSICIST_X
	lda	#1
	sta	GAME_OVER

just_fine_left:

	inc	GAIT			; cycle through animation
	inc	GAIT

	jmp	done_keypress		; done

face_left:
	lda	#0
	sta	DIRECTION
	sta	GAIT
	jmp	done_keypress

check_right:
	cmp	#'D'
	beq	right
	cmp	#$15
	bne	check_down
right:
	lda	#0
	sta	CROUCHING

	lda	DIRECTION
	beq	face_right

	inc	PHYSICIST_X
	lda	PHYSICIST_X
	cmp	RIGHT_LIMIT
	bne	just_fine_right
too_far_right:

	lda	#2
	sta	GAME_OVER
	rts

just_fine_right:
	inc	GAIT
	inc	GAIT
	jmp	done_keypress

face_right:
	lda	#0
	sta	GAIT
	lda	#1
	sta	DIRECTION
	jmp	done_keypress

check_down:
	cmp	#'S'
	beq	down
	cmp	#$0A
	bne	check_space
down:
	lda	#48
	sta	CROUCHING
	lda	#0
	sta	GAIT

	jmp	done_keypress

check_space:
	cmp	#' '
	beq	space
	cmp	#$15
	bne	unknown
space:
	lda	#15
	sta	KICKING
	lda	#0
	sta	GAIT
unknown:
done_keypress:
	bit	KEYRESET	; clear the keyboard strobe		; 4

	rts								; 6


