; Ootw Pool Party

ootw_pool:
	;================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR

	;===================
	; disable earthquake

	lda	#0
	sta	EARTH_OFFSET

	lda	#4
	sta	WHICH_CAVE

	;===========================
	; Setup pages (is this necessary?)

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE

	;===========================
	; Setup right/left exit paramaters

	lda	#(39+128)
	sta	RIGHT_LIMIT
	sta	RIGHT_WALK_LIMIT
	lda	#(-4+128)
	sta	LEFT_LIMIT
	sta	LEFT_WALK_LIMIT

	;=============================
	; Load background to $c00

	lda     #>(pool_rle)
        sta     GBASH
	lda     #<(pool_rle)
        sta     GBASL
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr


	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER
	sta	TENTACLE_GRAB

	lda	#30
	sta	TENTACLE_PROGRESS

	;==================================
	; setup beast if we're running from it

	jsr	setup_beast


	;============================
	;============================
	;============================
	; Pool Loop (palindrome)
	;============================
	;============================
	;============================
pool_loop:

	;================================
	; copy background to current page

	jsr	gr_copy_to_current

	;================================
	; draw bg beast, if needed

	jsr	draw_bg_beast


	;=======================
	; draw pool ripples

	jsr	draw_ripples


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

	jsr	handle_keypress


	;===============================
	; move physicist

	jsr	move_physicist

	;===============================
	; check limits

	jsr	check_screen_limit

	;===============
	; draw physicist

	jsr	draw_physicist

	;================
	; handle beast

	lda	BEAST_OUT
	beq	pool_no_beast

	;================
	; move beast

	jsr	move_beast

	;================
	; draw beast

	jsr	draw_beast

pool_no_beast:


beyond_tentacles:

	;======================
	; draw foreground plant

	jsr	draw_fg_plant

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
	cmp	#$2
	bne	not_to_right

	; exit to right

	lda	#0
	sta	PHYSICIST_X
	sta	WHICH_CAVE

	jmp	ootw_cavern

not_to_right:
	cmp	#$1
	bne	not_done_pool

	lda	#36
	sta	PHYSICIST_X

	jmp	ootw_rope

not_done_pool:

	; loop forever

	jmp	pool_loop

done_pool:
	rts








	;=======================
	; draw pool ripples

draw_ripples:
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

	jmp	put_sprite		; tail call
	; rts


	;======================
	; draw foreground plant

draw_fg_plant:
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

	jmp	put_sprite
	; rts


	;============================
	;============================
	; exit pool
	;============================
	;============================

exit_pool:
	lda	#0
	sta	BG_BEAST
	sta	EXIT_COUNT

	;=============================
	; Load background to $c00

	lda     #>(pool_rle)
        sta     GBASH
	lda     #<(pool_rle)
        sta     GBASL
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr


exit_pool_loop:

	;================================
	; copy background to current page

	jsr	gr_copy_to_current


	;=======================
	; draw pool ripples

	jsr	draw_ripples


	;================
	; draw background beast

	jsr	draw_bg_beast


	;===============
	; draw physicist

	lda	EXIT_COUNT
	and	#$fe
	tay

	lda	#20
	sta	XPOS
	lda	#22
	sta	YPOS

	lda	pool_exit_progression,Y
	sta	INL
	lda	pool_exit_progression+1,Y
	sta	INH

	jsr	put_sprite


	;=================
	; draw foreground plant

	jsr	draw_fg_plant

	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	framee_no_oflo
	inc	FRAMEH

framee_no_oflo:

	; increment exit count

	lda	FRAMEL
	and	#$0f
	bne	exit_count_same

	inc	EXIT_COUNT


exit_count_same:


	; see if start bg beast going

	lda	EXIT_COUNT
	cmp	#(14*2)
	bne	check_done_exiting_pool

	lda	#2
	sta	BG_BEAST

check_done_exiting_pool:

	; check if done

	lda	EXIT_COUNT
	cmp	#(26*2)
	beq	done_exit_pool

	jmp	exit_pool_loop

done_exit_pool:
	bit	KEYRESET

	rts









	;=========================
	; draw background beast
	;=========================

draw_bg_beast:

	; if 0, skip altogether
	lda	BG_BEAST
	beq	done_draw_bg_beast

	cmp	#14
	bcc	bg_beast_incoming	; blt

	cmp	#$44
	bcs	bg_beast_outgoing	; bge

bg_beast_just_standing:

	; FIXME: look at you when close

	lda	PHYSICIST_X
	cmp	#30
	bcs	beast_staring	; bge

	lda	#<beast_bg7
	sta	INL
	lda     #>beast_bg7
        sta     INH
	lda     #33
        sta     XPOS
	jmp	bg_beast_callsprite

beast_staring:
	lda	#<beast_bg8
	sta	INL
	lda     #>beast_bg8
        sta     INH
	lda     #33
        sta     XPOS
	jmp	bg_beast_callsprite



bg_beast_incoming:

	lda	BG_BEAST
	and	#$fe
	asl
	tay

	lda     beast_incoming,Y
	sta	INL
	lda     beast_incoming+1,Y
        sta     INH
	lda     beast_incoming+2,Y
	jmp	bg_beast_callsprite

bg_beast_outgoing:

	lda	BG_BEAST
	sec
	sbc	#$44
	and	#$fe
	asl
	tay

	lda     beast_outgoing,Y
	sta	INL
	lda     beast_outgoing+1,Y
        sta     INH
	lda     beast_outgoing+2,Y
	jmp	bg_beast_callsprite


bg_beast_callsprite:
	sta	XPOS
	lda	#8
	sta	YPOS
        jsr	put_sprite_crop

	lda	FRAMEL
	and	#$7
	bne	done_draw_bg_beast

	inc	BG_BEAST

	lda	BG_BEAST
	cmp	#$50
	bcc	done_draw_bg_beast

	; disable if hit $50

	lda	#0
	sta	BG_BEAST

done_draw_bg_beast:

	rts






