	;=======================================
	; Move physicist based on current state
	;
	; TODO: only update on even frames to slow things down?

move_physicist:
	lda	PHYSICIST_STATE
	cmp	#P_WALKING
	beq	move_physicist_walking
	cmp	#P_RUNNING
	beq	move_physicist_running
	rts

	;======================
	; walking

move_physicist_walking:
	inc     GAIT			; cycle through animation

	lda     GAIT
	and     #$7
	cmp     #$4			; only walk roughly 1/8 of time
	bne     no_move_walk

	lda	DIRECTION
	beq	p_walk_left

	inc	PHYSICIST_X		; walk right
	rts
p_walk_left:
	dec     PHYSICIST_X		; walk left
no_move_walk:
	rts

	;======================
	; running
move_physicist_running:
;	inc	GAIT			; cycle through animation
	inc	GAIT			; cycle through animation

	lda     GAIT
	and     #$3
	cmp     #$2			; only run roughly 1/4 of time
	bne     no_move_run

	lda	DIRECTION
	beq	p_run_left

	inc	PHYSICIST_X		; run right
	rts
p_run_left:
	dec	PHYSICIST_X		; run left
no_move_run:
	rts
	;======================
	; standing

move_physicist_standing:





pstate_table_lo:
	.byte <physicist_standing	; 00
	.byte <physicist_walking	; 01
	.byte <physicist_running	; 02
	.byte <physicist_crouching	; 03
	.byte <physicist_kicking	; 04
	.byte <physicist_jumping	; 05
	.byte <physicist_collapsing	; 06
	.byte <physicist_falling	; 07
	.byte <physicist_standing	; 08 swinging
	.byte <physicist_standing	; 09 elevator up
	.byte <physicist_standing	; 0A elevator down

pstate_table_hi:
	.byte >physicist_standing
	.byte >physicist_walking
	.byte >physicist_running
	.byte >physicist_crouching
	.byte >physicist_kicking
	.byte >physicist_jumping
	.byte >physicist_collapsing
	.byte >physicist_falling
	.byte >physicist_standing	; 08 swinging
	.byte >physicist_standing	; 09 elevator up
	.byte >physicist_standing	; 0A elevator down

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
	jmp	put_sprite_flipped_crop



;======================================
;======================================
; Check screen limits
;======================================
;======================================
; If too far right or left, stop at boundary
; If also > 39 or < -4 then exit room

check_screen_limit:

	clc
	lda	PHYSICIST_X
	adc	#$80
	cmp	LEFT_LIMIT
	bcs	just_fine_left		; (bge==bcs)

left_on_screen:

	; if limit was -4, means we are off screen
	; otherwise, stop physicist at limit

	lda	LEFT_LIMIT
	cmp	#($80 - 4)
	beq	too_far_left

left_stop_at_barrier:
	lda     #0
        sta     PHYSICIST_STATE

        lda     LEFT_LIMIT
        sec
        sbc     #$7f
        sta     PHYSICIST_X

	rts

too_far_left:
	lda	#1
	sta	GAME_OVER
	rts

just_fine_left:

	; Check right edge of screen

;	lda	PHYSICIST_X
	cmp	RIGHT_LIMIT
	bcc	just_fine_right		; blt


right_on_screen:

	; if limit was 39, means we are off screen
	; otherwise, stop physicist at limit

	lda	RIGHT_LIMIT
	cmp	#($80 + 39)
	beq	too_far_right

right_stop_at_barrier:
	lda	#0
	sta	PHYSICIST_STATE

	lda	RIGHT_LIMIT
	clc
	adc	#$7f
	sta	PHYSICIST_X
	rts

too_far_right:
	lda	#2
	sta	GAME_OVER

just_fine_right:

	rts



; LIMIT		VALUE		FLAGS
; 0		10		-----
; 0		0		Z----
; 0		FF		


; 1 -> 129
; 0 -> 128
; -1 -> 127    FF + 80 = 7f



; XPOS    XSIZE		XMAX
;  -5	    8		3
;  -4			4
;  -3			5
;  -2			6
;  -1			7
;   0			8
;   1			9
;   2
;   3
;   4
;   5
