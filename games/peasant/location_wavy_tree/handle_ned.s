	;======================
	; init ned
	;	randomly waits 126-64 frames
init_ned:
	jsr	random8
	and	#$3f

;	lda	#64
	sta	NED_STATUS
	rts


	;======================
	; handle ned
	;======================
handle_ned:

	;====================
	; update ned status
	;===================
	; this broke with the new engine, figuring out how things work

	; Status 0...125 don't draw anything
	;	126 -- draw ned1 (hand)
	;	127 -- draw ned2 (hand)
	;	128...253 draw ned3 (full ned)
	;	254 -- draw ned2 (back to hand)
	;	255 -- draw ned1

	; we actually freeze at 128 with ned out until we try talking
	;	to him, which restarts the counter and counts down to
	;	going away

	; once seen he doesn't come back unless you leave and come back

	; if 0 or 128, do nothing

	lda	NED_STATUS
	beq	leave_ned_alone
	cmp	#128
	beq	leave_ned_alone

	inc	NED_STATUS

leave_ned_alone:

	lda	NED_STATUS		; check status

	cmp	#125
	bcc	no_draw_ned		;  blt, don't draw

draw_ned:
	lda	NED_STATUS
	cmp	#125
	beq	draw_ned_hands
	cmp	#255
	beq	draw_ned_hands

	cmp	#126
	beq	draw_ned_half
	cmp	#254
	beq	draw_ned_half

draw_ned_out:
	lda	#25
	sta	CURSOR_X
	lda	#88
	sta	CURSOR_Y

	lda	#<ned3_sprite
	sta	INL
	lda	#>ned3_sprite
	jmp	draw_ned_common

draw_ned_hands:
	lda	#28
	sta	CURSOR_X
	lda	#96
	sta	CURSOR_Y

	lda	#<ned1_sprite
	sta	INL
	lda	#>ned1_sprite
	jmp	draw_ned_common

draw_ned_half:
	lda	#28
	sta	CURSOR_X
	lda	#81
	sta	CURSOR_Y

	lda	#<ned2_sprite
	sta	INL
	lda	#>ned2_sprite

draw_ned_common:

	sta	INH

	jsr	hgr_draw_sprite

no_draw_ned:
	rts


