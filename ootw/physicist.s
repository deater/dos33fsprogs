pstate_table_lo:
	.byte <physicist_standing	; 00
	.byte <physicist_walking	; 01
	.byte <physicist_running	; 02
	.byte <physicist_crouching	; 03
	.byte <physicist_kicking	; 04
	.byte <physicist_jumping	; 05
	.byte <physicist_collapsing	; 06
	.byte <physicist_falling	; 07
pstate_table_hi:
	.byte >physicist_standing
	.byte >physicist_walking
	.byte >physicist_running
	.byte >physicist_crouching
	.byte >physicist_kicking
	.byte >physicist_jumping
	.byte >physicist_collapsing
	.byte >physicist_falling

; Urgh, make sure this doesn't end up at $FF or you hit the
;	NMOS 6502 bug

.align 2

pjump:
	.word	$0000

.align 1

;======================================
; draw physicist
;======================================

draw_physicist:

	ldx	PHYSICIST_STATE
	lda	pstate_table_lo,x
	sta	pjump
	lda	pstate_table_hi,x
	sta	pjump+1
	jmp	(pjump)


;==================================
; STANDING
;==================================

physicist_standing:

	lda	#<phys_stand
	sta	INL

	lda	#>phys_stand
	sta	INH

	jmp	finally_draw_him

;==================================
; KICKING
;==================================

physicist_kicking:
	lda	#<kick1
	sta	INL

	lda	#>kick1
	sta	INH

	; If kicking long enough, return to standing

	dec	GAIT
	bne	short_draw

	lda	#P_STANDING
	sta	PHYSICIST_STATE

short_draw:
	jmp	finally_draw_him

;===================================
; CROUCHING
;===================================

physicist_crouching:

	; FIXME: we have an animation?

	lda	#<crouch2
	sta	INL

	lda	#>crouch2
	sta	INH

	jmp	finally_draw_him

;===================================
; JUMPING
;===================================

physicist_jumping:

	lda	GAIT
	cmp	#32
	bcc	still_jumping	; blt

	lda	#0
	sta	GAIT
	lda	#P_STANDING
	sta	PHYSICIST_STATE
	jmp	physicist_walking

still_jumping:

	lsr
	and	#$fe

	tax

	lda	phys_jump_progression,X
	sta	INL

	lda	phys_jump_progression+1,X
	sta	INH

	inc	GAIT

	lda	GAIT
	and	#$7
	bne	jump_no_move

	lda	DIRECTION
	beq	jump_left

jump_right:
	inc	PHYSICIST_X
	jmp	finally_draw_him

jump_left:
	dec	PHYSICIST_X

jump_no_move:
	jmp	finally_draw_him



;===============================
; Walking
;================================

physicist_walking:
	lda	GAIT
	cmp	#40
	bcc	gait_fine	; blt

	lda	#0
	sta	GAIT

gait_fine:
	lsr
	and	#$fe

	tax

	lda	phys_walk_progression,X
	sta	INL

	lda	phys_walk_progression+1,X
	sta	INH

	jmp	finally_draw_him

;===============================
; Running
;================================

physicist_running:
	lda	GAIT
	cmp	#40
	bcc	run_gait_fine	; blt

	lda	#0
	sta	GAIT

run_gait_fine:
	lsr
	and	#$fe

	tax

	lda	phys_run_progression,X
	sta	INL

	lda	phys_run_progression+1,X
	sta	INH

	jmp	finally_draw_him


;==================================
; COLLAPSING
;==================================

physicist_collapsing:

	lda	GAIT
	cmp	#18
	bne	collapse_not_done

really_dead:
	lda	#$ff
	sta	GAME_OVER
	jmp	finally_draw_him

collapse_not_done:

	ldx	GAIT

	lda	collapse_progression,X
	sta	INL
	lda	collapse_progression+1,X
	sta	INH

	lda	FRAMEL
	and	#$1f
	bne	no_collapse_progress

	inc	GAIT
	inc	GAIT

no_collapse_progress:


	jmp	finally_draw_him


;==================================
; FALLING
;==================================

physicist_falling:


	lda	FRAMEL
	and	#$3
	bne	no_fall_progress

	inc	PHYSICIST_X
	inc	PHYSICIST_Y	; must me mul of 2
	inc	PHYSICIST_Y

no_fall_progress:

	lda	PHYSICIST_Y
	cmp	#22
	bne	still_falling
done_falling:
;	lda	#0
;	sta	GAIT

	lda	#P_CROUCHING
	sta	PHYSICIST_STATE
	jmp	physicist_crouching

still_falling:

	lda	#<phys_falling
	sta	INL

	lda	#>phys_falling
	sta	INH

	jmp	finally_draw_him


;=============================
; Actually Draw Him
;=============================


finally_draw_him:
	lda	PHYSICIST_X
	sta	XPOS

	lda	PHYSICIST_Y
	sec
	sbc	EARTH_OFFSET	; adjust for earthquakes
	sta	YPOS

	lda	DIRECTION
	bne	facing_right

facing_left:
        jmp	put_sprite_crop

facing_right:
	jmp	put_sprite_flipped



;======================================
; Check screen limits
;======================================

check_screen_limit:

	lda	PHYSICIST_X
	cmp	LEFT_LIMIT
	bpl	just_fine_left		; (bge==bcs)

too_far_left:
;	inc	PHYSICIST_X

	lda	#1
	sta	GAME_OVER
	rts

just_fine_left:

	; Check right edige of screen

	lda	PHYSICIST_X
	cmp	RIGHT_LIMIT
	bcc	just_fine_right		; blt

too_far_right:

;	dec	PHYSICIST_X

	lda	#2
	sta	GAME_OVER

just_fine_right:

	rts
