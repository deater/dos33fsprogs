
	; FIXME, if beast gets close and you pull away, it should trip

	;=======================================
	;=======================================
	; Setup Beast Running -- for each room
	;=======================================
	;=======================================

setup_beast:
	; only move beast if out

	lda	BEAST_OUT
	beq	setup_no_beast

	; have the beast wait standing offscreen a bit??
	; what were you thinking, 6-months-ago Vince?

	lda	#30
	sta	BEAST_COUNT
	lda	#B_STANDING
	sta	BEAST_STATE

	; set Y position
	lda	#26
	sta	BEAST_Y


	; what we do is based on direction
	lda	BEAST_DIRECTION
	beq	setup_beast_left

setup_beast_right:
	; after rope scene, put beast further back so you
	; have time to run a bit

	lda	WHICH_CAVE
	cmp	#4
	beq	beast_right_rope

	jmp	beast_right_set_normal

beast_right_rope:
	lda	#240
	jmp	beast_right_set_x

	; adjust for distance
beast_right_set_normal:
	lda	BEAST_X
	bpl	right_set_not_neg	; how fast are you?
	lda	#0
right_set_not_neg:
	lsr
	lsr
	adc	#236		;

beast_right_set_x:
	sta	BEAST_X
	jmp	setup_no_beast

	;==============================
	; running left
setup_beast_left:

	; adjust for how far was on last screen
	; /4
	lda	BEAST_X
	lsr
	lsr

	clc
	adc	#40
	sta	BEAST_X

setup_no_beast:
	rts

	;=======================================
	;=======================================
	; Move Beast
	;=======================================
	;=======================================
	; stop if catch physicist
	; also stop if swinging
	; run just every slightly faster than physicist

move_beast:
	lda	BEAST_STATE
	cmp	#B_RUNNING
	beq	move_beast_running
	cmp	#B_STANDING
	beq	move_beast_standing
	rts

	;======================
	; running
move_beast_running:

	;=======================
	; stop at edge or at physicist

	lda	BEAST_DIRECTION
	beq	check_beast_left

check_beast_right:
		;  Bbbb^b
		;         Pp^pp
		; if  (B+6)==P
		; if  B=P-6
	sec
	lda     PHYSICIST_X
	sbc	#$6
	cmp	BEAST_X
        bne	beast_no_stop
	beq	beast_caught

check_beast_left:

	; stop if in rope room and at edge

	lda	WHICH_CAVE
	cmp	#3
	bne	beast_not_rope_room
beast_rope_room:
	lda	BEAST_X
	cmp	#11
	bcs	beast_not_rope_room	; bge

	lda	#B_STANDING
	sta	BEAST_STATE

	lda	#0
	sta	BEAST_COUNT
	rts

beast_not_rope_room:

	; no attack if swinging
	lda	PHYSICIST_STATE
	cmp	#P_SWINGING
	beq	skip_if_swinging

		; Pp^pp Bbbbbb
		; if B=p
	clc
	lda	PHYSICIST_X
	adc	#$2
	cmp     BEAST_X

	bne	beast_no_stop
	beq	beast_caught

skip_if_swinging:

beast_no_stop:
	inc	BEAST_GAIT		; cycle through animation

	lda	BEAST_GAIT
	and	#$7
	cmp	#5
	beq	b_run
	and	#$3			; only run roughly 3/8 of time
	bne	b_no_move_run

b_run:
	lda	BEAST_DIRECTION
	beq	b_run_left

	inc	BEAST_X			; run right
	rts
b_run_left:
	dec	BEAST_X			; run left
b_no_move_run:
	rts


beast_caught:
	jmp	beast_slash_cutscene



	;======================
	; standing

	; need to check for collision here so physicist
	; doesn't just run past beast at arrival

move_beast_standing:
	lda	BEAST_COUNT
	beq	beast_stand_done	; if 0, perma-stand

	dec	BEAST_COUNT
	bne	beast_stand_done

	lda	#B_RUNNING
	sta	BEAST_STATE

beast_stand_done:

	lda	PHYSICIST_X
	cmp	BEAST_X

	bne	p_not_foolish

	jmp	beast_slash_cutscene

p_not_foolish:
	rts

;======================================
;======================================
; draw beast
;======================================
;======================================

draw_beast:

	lda	BEAST_STATE
	cmp	#B_STANDING
	beq	b_standing
	cmp	#B_RUNNING
	beq	b_running
	rts


	;==================================
	; STANDING
	;==================================

b_standing:

	lda	#<beast_standing
	sta	INL

	lda	#>beast_standing
	sta	INH

	jmp	finally_draw_beast

	;===============================
	; Running
	;================================

b_running:
	lda	BEAST_GAIT
	cmp	#18
	bcc	brun_gait_fine	; blt

	lda	#0
	sta	BEAST_GAIT

brun_gait_fine:
;	lsr
	and	#$fe

	tax

	lda	beast_run_progression,X
	sta	INL

	lda	beast_run_progression+1,X
	sta	INH

	jmp	finally_draw_beast


	;=============================
	; Actually Draw Beast
	;=============================

finally_draw_beast:
	lda	BEAST_X
	sta	XPOS

	lda	BEAST_Y		; was 26
	sec
	sbc	EARTH_OFFSET	; adjust for earthquakes
	sta	YPOS

	lda	BEAST_DIRECTION
	bne	b_facing_right

b_facing_left:
        jmp	put_sprite_crop

b_facing_right:
	jmp	put_sprite_flipped_crop





	;========================
	;========================
	; beast arrival cutscene
	;========================
	;========================
beast_arrival_cutscene:

	;====================
	; beast dropping in

	lda	#$8
	sta	DRAW_PAGE
        jsr	clear_top

	lda	#<beast_background
	sta	INL
	lda	#>beast_background
	sta	INH

	lda	#15
	sta     XPOS

	lda	#10
	sta	YPOS

	jsr	put_sprite

	lda	#$0
	sta	DRAW_PAGE

	jsr     gr_copy_to_current
        jsr     page_flip
        jsr     gr_copy_to_current
	jsr	page_flip

	ldx	#0
	stx	CUTFRAME
beast_loop:
        jsr     gr_copy_to_current

	ldx	CUTFRAME

	lda	beast_frames,X
	sta	INL
	lda	beast_frames+1,X
	sta	INH

	lda	#15
	sta     XPOS

	lda	#10
	sta	YPOS

	jsr	put_sprite

	jsr	page_flip

	ldx	#2
beast_long_delay:
	lda	#250
	jsr	WAIT
	dex
	bne	beast_long_delay


	ldx	CUTFRAME
	inx
	inx
	stx	CUTFRAME

	cpx	#28
	beq	beast_end

	jmp	beast_loop

beast_end:

	;=============================
	; Restore background to $c00

	lda	#>(cavern3_rle)
	sta	GBASH
	lda	#<(cavern3_rle)
	sta	GBASL
	lda	#$c			; load image off-screen $c00
	jmp	load_rle_gr

beast_frames:
	.word	beast_frame1		; 0
	.word	beast_frame2		; 1
	.word	beast_frame3		; 2
	.word	beast_frame4		; 3
	.word	beast_frame5		; 4
	.word	beast_frame6		; 5
	.word	beast_frame7		; 6
	.word	beast_frame8		; 7
	.word	beast_frame9		; 8
	.word	beast_frame10		; 9
	.word	beast_frame11		; 10
	.word	beast_frame12		; 11
	.word	beast_frame8		; 12
	.word	beast_frame8		; 13




	;========================
	;========================
	; beast slash cutscene
	;========================
	;========================
beast_slash_cutscene:

	lda	#<beast_bg_rle
	sta	GBASL
	lda	#>beast_bg_rle
	sta	GBASH

	lda	#$c
	jsr	load_rle_gr

        ldx	#0

beast_slash_loop:
	lda	beast_slash_frames,X
	sta	GBASL
	lda	beast_slash_frames+1,X
	sta	GBASH

	txa
	pha

	lda     #$10
	jsr     load_rle_gr

	jsr     gr_overlay

	lda     #200
	jsr     WAIT

	jsr     page_flip



	pla
	tax

	inx
	inx
	cmp     #40
	bne     beast_slash_loop

beast_slash_end:

	lda	#$ff
	sta	GAME_OVER

	rts


beast_slash_frames:
	.word	beast_slash07_rle	; 0
	.word	beast_slash08_rle	; 1
	.word	beast_slash09_rle	; 2
	.word	beast_slash10_rle	; 3
	.word	beast_slash11_rle	; 4
	.word	beast_slash12_rle	; 5
	.word	beast_slash13_rle	; 6
	.word	beast_slash14_rle	; 7
	.word	beast_slash15_rle	; 8
	.word	beast_slash16_rle	; 9
	.word	beast_slash17_rle	; 10
	.word	beast_slash18_rle	; 11
	.word	beast_slash19_rle	; 12
	.word	beast_slash20_rle	; 13
	.word	beast_slash20_rle	; 14
	.word	beast_slash20_rle	; 15
	.word	beast_slash20_rle	; 16
	.word	beast_slash20_rle	; 17
	.word	beast_slash20_rle	; 18
	.word	beast_slash20_rle	; 19
	.word	beast_slash20_rle	; 20

