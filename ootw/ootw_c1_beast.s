	;=======================================
	; Setup Beast Running -- for each room
	;

	; FIXME: distance for count should be related
	;	to X distance behind on previous screen

setup_beast:
	lda	BEAST_OUT
	beq	setup_no_beast

	lda	#30
	sta	BEAST_COUNT
	lda	#B_STANDING
	sta	BEAST_STATE

	lda	BEAST_DIRECTION
	beq	setup_beast_left

setup_beast_right:
	lda	#248		; -8 = 248
	sta	BEAST_X
	jmp	setup_no_beast

setup_beast_left:
	lda	#41
	sta	BEAST_X

setup_no_beast:
	rts

	;=======================================
	; Move Beast
	;
	; FIXME: stop at edge of screen, or at physicist

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

	clc
	lda     BEAST_X
	adc     #$80

	cmp     RIGHT_LIMIT
        bcc	beast_no_stop          ; (blt==bcc)
	bcs	stop_beast

check_beast_left:

	clc
	lda     BEAST_X
	adc     #$80

	cmp     LEFT_LIMIT
        bcs     beast_no_stop          ; (bge==bcs)

stop_beast:
	lda	#B_STANDING
	sta	BEAST_STATE
	rts



beast_no_stop:
	inc	BEAST_GAIT		; cycle through animation

	lda	BEAST_GAIT
	and	#$3
	cmp	#$2			; only run roughly 1/4 of time
	bne	b_no_move_run

	lda	BEAST_DIRECTION
	beq	b_run_left

	inc	BEAST_X			; run right
	rts
b_run_left:
	dec	BEAST_X			; run left
b_no_move_run:
	rts

	;======================
	; standing

move_beast_standing:
	lda	BEAST_COUNT
	beq	beast_stand_done	; if 0, perma-stand

	dec	BEAST_COUNT
	bne	beast_stand_done

	lda	#B_RUNNING
	sta	BEAST_STATE

beast_stand_done:
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

	lda	#26
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

