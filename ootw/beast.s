	;=======================================
	; Move Beast

move_beast:
;	lda	PHYSICIST_STATE
;	cmp	#P_WALKING
;	beq	move_physicist_walking
;	cmp	#P_RUNNING
;	beq	move_physicist_running
	rts

	;======================
	; running
move_beast_running:
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


;======================================
; draw beast
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
	cmp	#16
	bcc	brun_gait_fine	; blt

	lda	#0
	sta	GAIT

brun_gait_fine:
	lsr
	and	#$fe

	tax

	lda	beast_run_progression,X
	sta	INL

	lda	beast_run_progression+1,X
	sta	INH

	jmp	finally_draw_beast

;==================================
; COLLAPSING
;==================================

;physicist_collapsing:

;	lda	GAIT
;	cmp	#18
;	bne	collapse_not_done

;really_dead:
;	lda	#$ff
;	sta	GAME_OVER
;	jmp	finally_draw_him

;collapse_not_done:

;	ldx	GAIT

;	lda	collapse_progression,X
;	sta	INL
;	lda	collapse_progression+1,X
;	sta	INH

;	lda	FRAMEL
;	and	#$1f
;	bne	no_collapse_progress

;	inc	GAIT
;	inc	GAIT

;no_collapse_progress:


;	jmp	finally_draw_him


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



;======================================
; Check beast limit
;======================================

check_beast_limit:

;	clc
;	lda	PHYSICIST_X
;	adc	#$80
;	cmp	LEFT_LIMIT
;	bcs	just_fine_left		; (bge==bcs)

;too_far_left:
;	lda	#1
;	sta	GAME_OVER
;	rts

;just_fine_left:

	; Check right edge of screen

;	cmp	RIGHT_LIMIT
;	bcc	just_fine_right		; blt

;too_far_right:
;	lda	#2
;	sta	GAME_OVER

;just_fine_right:

;	rts
