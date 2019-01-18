; Ootw Pool Party

ootw_pool:
	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR


	;===========================
	; Clear both bottoms

	lda	#$4
	sta	DRAW_PAGE
	jsr     clear_bottom

	lda	#$0
	sta	DRAW_PAGE
	jsr     clear_bottom

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE


	;=============================
	; Load background to $c00

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL			; load image off-screen $c00

	lda     #>(pool_rle)
        sta     GBASH
	lda     #<(pool_rle)
        sta     GBASL
	jsr	load_rle_gr

	;=================================
	; copy to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current


	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER
	sta	TENTACLE_GRAB

	lda	#30
	sta	TENTACLE_PROGRESS

	;============================
	; Pool Loop (palindrome)
	;============================
pool_loop:

	;================================
	; copy background to current page

	jsr	gr_copy_to_current


	;=======================
	; draw pool ripples

	lda	FRAMEL
	and	#$30		; 0110 1100
	lsr
	lsr
	lsr
	tax

	lda	pool_ripples,X
	sta	INL
	lda	pool_ripples+1,X
	sta	INH

	lda	#9
	sta	XPOS
	lda	#30
	sta	YPOS

	jsr	put_sprite


	lda	FRAMEL
	and	#$30		; 0110 1100
	lsr
	lsr
	lsr
	clc
	adc	#2
	and	#$6
	tax

	lda	pool_ripples,X
	sta	INL
	lda	pool_ripples+1,X
	sta	INH


	lda	#27
	sta	XPOS
	lda	#30
	sta	YPOS

	jsr	put_sprite


	lda	FRAMEL
	and	#$30		; 0110 1100
	lsr
	lsr
	lsr
	clc
	adc	#4
	and	#$6
	tax

	lda     #18
	sta     XPOS
	lda     #28
	sta     YPOS

	jsr	put_sprite



	;==============================
	; handle being grabbed

	lda	TENTACLE_GRAB
	beq	tentacle_action

	;=================================
	; actively being grabbed

	lda	TENTACLE_PROGRESS
	tax

	lda	caught_progression,X
	sta	INL
	lda	caught_progression+1,X
	sta	INH

	lda	TENTACLE_X
	sta	XPOS
	lda	#22
	sta	YPOS

	lda	FRAMEL
	and	#$1f
	bne	no_caught_progress

	inc	TENTACLE_PROGRESS
	inc	TENTACLE_PROGRESS
no_caught_progress:
	jsr	put_sprite

	lda	TENTACLE_PROGRESS
	cmp	#24
	bne	beyond_tentacles

	lda	#$ff
	sta	GAME_OVER

	jmp	beyond_tentacles


	;===============
	; move/draw tentacle monster
tentacle_action:
	lda	FRAMEH
	and	#3
	bne	tentacle_move
	lda	FRAMEL
	cmp	#$ff
	bne	tentacle_move
tentacle_init:
	sec
	lda	PHYSICIST_X
	sbc	#2
	sta	TENTACLE_X

	lda	#0
	sta	TENTACLE_PROGRESS

tentacle_move:

	lda	TENTACLE_PROGRESS
	cmp	#26
	bpl	no_tentacle

	tax

	lda	tentacle_progression,X
	sta	INL
	lda	tentacle_progression+1,X
	sta	INH

	lda	TENTACLE_X
	sta	XPOS
	lda	#22
	sta	YPOS

	lda	FRAMEL
	and	#$3f
	bne	no_tentacle_progress

	inc	TENTACLE_PROGRESS
	inc	TENTACLE_PROGRESS
no_tentacle_progress:
	jsr	put_sprite

	; See if we are fully extended
	; if we are close enough to grab

	lda	TENTACLE_PROGRESS
	cmp	#12
	bne	no_tentacle

	sec
	lda	PHYSICIST_X
	sbc	TENTACLE_X		; want -4 to 4
	clc
	adc	#4			; want 0 to 8
	and	#$f8
	bne	no_tentacle

	lda	#0
	sta	TENTACLE_PROGRESS
	lda	#1
	sta	TENTACLE_GRAB

no_tentacle:

	;===============================
	; check keyboard

	jsr	handle_keypress_pool


	;===============
	; draw physicist

	jsr	draw_physicist


beyond_tentacles:

	;======================
	; draw foreground plant

	lda	FRAMEL
	and	#$c0		; 0110 1100
	lsr
	lsr
	lsr
	lsr
	lsr
	tax

	lda	plant_wind,X
	sta	INL
	lda	plant_wind+1,X
	sta	INH

        lda     #4
        sta     XPOS
        lda     #30
        sta     YPOS

	jsr	put_sprite

	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	frame_no_oflo
	inc	FRAMEH

frame_no_oflo:

	; pause?

	; check if done this level

	lda	GAME_OVER
	cmp	#$ff
	beq	done_pool

	; check if done this level
	cmp	#$1
	bne	not_done_pool

	lda	#0
	sta	PHYSICIST_X

	jmp	ootw_cavern

not_done_pool:

	; loop forever

	jmp	pool_loop

done_pool:
	rts

;======================================
; handle keypress (pool)
;======================================

handle_keypress_pool:

	lda	KEYPRESS						; 4
	bmi	keypress_pool						; 3

	rts

keypress_pool:
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
	lda	#0
	sta	CROUCHING

	lda	DIRECTION
	bne	face_left

	dec	PHYSICIST_X
	bpl	just_fine_left
too_far_left:
	inc	PHYSICIST_X
just_fine_left:

	inc	GAIT
	inc	GAIT

	jmp	done_keypress

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
	cmp	#37
	bne	just_fine_right
too_far_right:

	lda	#1
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


no_keypress:
	rts								; 6


