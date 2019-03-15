pstate_table_lo:
	.byte <physicist_standing
	.byte <physicist_walking
	.byte <physicist_running
	.byte <physicist_crouching
	.byte <physicist_kicking
	.byte <physicist_jumping
pstate_table_hi:
	.byte >physicist_standing
	.byte >physicist_standing
	.byte >physicist_running
	.byte >physicist_crouching
	.byte >physicist_kicking
	.byte >physicist_jumping

pjump:
	.word	$0000

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
	bne	finally_draw_him

	lda	#P_STANDING
	sta	PHYSICIST_STATE

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

	; FIXME: we have an animation?

	lda	#<crouch2
	sta	INL

	lda	#>crouch2
	sta	INH

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



;=============================
; Actuall Draw Him
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
        jmp	put_sprite

facing_right:
	jmp	put_sprite_flipped

