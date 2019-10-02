	;=======================================
	; Move astronaut based on current state
	;

move_astronaut:
	lda	ASTRONAUT_STATE
	cmp	#P_WALKING
	beq	move_astronaut_walking
	cmp	#P_RUNNING
	beq	move_astronaut_running
	rts

	;======================
	; walking

move_astronaut_walking:
	inc     GAIT			; cycle through animation

	lda     GAIT
	and     #$7
	cmp     #$4			; only walk roughly 1/8 of time
	bne     no_move_walk

	lda	DIRECTION
	beq	p_walk_left

	inc	ASTRONAUT_X		; walk right
	rts
p_walk_left:
	dec     ASTRONAUT_X		; walk left
no_move_walk:
	rts

	;======================
	; running
move_astronaut_running:
;	inc	GAIT			; cycle through animation
	inc	GAIT			; cycle through animation

	lda     GAIT
	and     #$3
	cmp     #$2			; only run roughly 1/4 of time
	bne     no_move_run

	lda	DIRECTION
	beq	p_run_left

	inc	ASTRONAUT_X		; run right
	rts
p_run_left:
	dec	ASTRONAUT_X		; run left
no_move_run:
	rts
	;======================
	; standing

move_astronaut_standing:





pstate_table_lo:
	.byte <astronaut_standing	; 00
	.byte <astronaut_walking	; 01
	.byte <astronaut_running	; 02
	.byte <astronaut_crouching	; 03
	.byte <astronaut_kicking	; 04
	.byte <astronaut_jumping	; 05
	.byte <astronaut_collapsing	; 06
	.byte <astronaut_falling_sideways; 07
	.byte <astronaut_standing	; 08 swinging
	.byte <astronaut_standing	; 09 elevator up
	.byte <astronaut_standing	; 0A elevator down
	.byte <astronaut_shooting	; 0B
	.byte <astronaut_falling_down	; 0C
	.byte <astronaut_impaled	; 0D
	.byte <astronaut_crouch_shooting; 0E
	.byte <astronaut_crouch_kicking	; 0F
	.byte <astronaut_disintegrating	; 10


pstate_table_hi:
	.byte >astronaut_standing
	.byte >astronaut_walking
	.byte >astronaut_running
	.byte >astronaut_crouching
	.byte >astronaut_kicking
	.byte >astronaut_jumping
	.byte >astronaut_collapsing
	.byte >astronaut_falling_sideways
	.byte >astronaut_standing	; 08 swinging
	.byte >astronaut_standing	; 09 elevator up
	.byte >astronaut_standing	; 0A elevator down
	.byte >astronaut_shooting	; 0B
	.byte >astronaut_falling_down	; 0C
	.byte >astronaut_impaled	; 0D
	.byte >astronaut_crouch_shooting; 0E
	.byte >astronaut_crouch_kicking	; 0F
	.byte >astronaut_disintegrating	; 10

; Urgh, make sure this doesn't end up at $FF or you hit the
;	NMOS 6502 bug

.align 2

pjump:
	.word	$0000

.align 1

;======================================
; draw astronaut
;======================================

draw_astronaut:

	lda	ASTRONAUT_STATE
	and	#$1f			; mask off high state bits
	tax
	lda	pstate_table_lo,x
	sta	pjump
	lda	pstate_table_hi,x
	sta	pjump+1
	jmp	(pjump)


;==================================
; STANDING
;==================================

astronaut_standing:

	lda	#<astro_stand
	sta	INL

	lda	#>astro_stand
	sta	INH

	jmp	finally_draw_him

;==================================
; SHOOTING
;==================================

astronaut_shooting:

	lda	#<shooting1
	sta	INL

	lda	#>shooting1
	sta	INH

	jmp	finally_draw_him


;==================================
; KICKING
;==================================

astronaut_kicking:
	lda	#<kick1
	sta	INL

	lda	#>kick1
	sta	INH

	; If kicking long enough, return to standing

	dec	GAIT
	bne	short_draw

	lda	#P_STANDING
	sta	ASTRONAUT_STATE

short_draw:
	jmp	finally_draw_him

;===================================
; CROUCHING
;===================================

astronaut_crouching:

	; FIXME: we have an animation?

	; if we have some gait left, slide a bit
	lda	GAIT
	beq	crouch_done_slide

	dec	GAIT
	bne	crouch_done_slide

	lda	DIRECTION
	beq	p_slide_left
	inc	ASTRONAUT_X
	jmp	crouch_done_slide
p_slide_left:
	dec	ASTRONAUT_X

crouch_done_slide:

	lda	#<crouch2
	sta	INL

	lda	#>crouch2
	sta	INH

	jmp	finally_draw_him

;===================================
; CROUCH KICKING
;===================================

astronaut_crouch_kicking:

	dec	GAIT
	lda	GAIT
	bpl	still_kicking

	lda	#P_CROUCHING
	sta	ASTRONAUT_STATE

still_kicking:

	lda	#<crouch_kicking
	sta	INL

	lda	#>crouch_kicking
	sta	INH

	jmp	finally_draw_him

;===================================
; CROUCH SHOOTING
;===================================

astronaut_crouch_shooting:

	lda	#<crouch_shooting
	sta	INL

	lda	#>crouch_shooting
	sta	INH

	jmp	finally_draw_him


;===================================
; JUMPING
;===================================

astronaut_jumping:

	lda	GAIT
	cmp	#32
	bcc	still_jumping	; blt

	; done juming
	lda	#STATE_RUNNING
	bit	ASTRONAUT_STATE
	beq	jump_to_stand

jump_to_run:
	lda	#0
	sta	GAIT
	lda	#P_RUNNING
	sta	ASTRONAUT_STATE
	jmp	astronaut_running

jump_to_stand:
	lda	#0
	sta	GAIT
	lda	#P_STANDING
	sta	ASTRONAUT_STATE
	jmp	astronaut_standing

still_jumping:

	lsr
	and	#$fe

	tax

	lda	astro_jump_progression,X
	sta	INL

	lda	astro_jump_progression+1,X
	sta	INH

	inc	GAIT

	lda	#STATE_RUNNING
	bit	ASTRONAUT_STATE
	beq	jump_change_x_regular

jump_change_x_running:
	lda	GAIT
					; 1/4 not enough, 1/2 too much
					; 3/8?
	and	#$7
	cmp	#5
	bcc	jump_no_move
	jmp	jump_change_x

	; only change X every 8th frame
jump_change_x_regular:
	lda	GAIT
	and	#$7
	bne	jump_no_move
jump_change_x:
	lda	DIRECTION
	beq	jump_left

jump_right:
	inc	ASTRONAUT_X
	jmp	finally_draw_him

jump_left:
	dec	ASTRONAUT_X

jump_no_move:
	jmp	finally_draw_him



;===============================
; Walking
;================================

astronaut_walking:
	lda	GAIT
	cmp	#40
	bcc	gait_fine	; blt

	lda	#0
	sta	GAIT

gait_fine:
	lsr
	and	#$fe

	tax

	lda	astro_walk_progression,X
	sta	INL

	lda	astro_walk_progression+1,X
	sta	INH

	jmp	finally_draw_him

;===============================
; Running
;================================

astronaut_running:
	lda	GAIT
	cmp	#40
	bcc	run_gait_fine	; blt

	lda	#0
	sta	GAIT

run_gait_fine:
	lsr
	and	#$fe

	tax

	lda	astro_run_progression,X
	sta	INL

	lda	astro_run_progression+1,X
	sta	INH

	jmp	finally_draw_him


;==================================
; COLLAPSING
;==================================

astronaut_collapsing:

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
; DISINTEGRATING
;==================================

astronaut_disintegrating:

	lda	GAIT
	cmp	#28
	bne	disintegrate_not_done

disintegrate_really_dead:
	lda	#$ff
	sta	GAME_OVER
	jmp	finally_draw_him

disintegrate_not_done:

	ldx	GAIT

	lda	disintegrate_progression,X
	sta	INL
	lda	disintegrate_progression+1,X
	sta	INH

	lda	FRAMEL
	and	#$7
	bne	no_disintegrate_progress

	inc	GAIT
	inc	GAIT

no_disintegrate_progress:


	jmp	finally_draw_him



;==================================
; FALLING SIDEWAYS
;==================================

astronaut_falling_sideways:


	lda	FRAMEL
	and	#$3
	bne	no_fall_progress

	inc	ASTRONAUT_X
	inc	ASTRONAUT_Y	; must me mul of 2
	inc	ASTRONAUT_Y

no_fall_progress:

	lda	ASTRONAUT_Y
fall_sideways_destination_smc:
	cmp	#22
	bne	still_falling
done_falling:
;	lda	#0
;	sta	GAIT

	lda	#P_CROUCHING
	sta	ASTRONAUT_STATE
	jmp	astronaut_crouching

still_falling:

	lda	#<astro_falling
	sta	INL

	lda	#>astro_falling
	sta	INH

	jmp	finally_draw_him


;==================================
; FALLING DOWN
;==================================

astronaut_falling_down:

falling_stop_smc:	; $2C to fall, $4C for not
	bit	still_falling_down

	lda	FRAMEL
	and	#$1
	bne	no_fall_down_progress

	inc	ASTRONAUT_Y	; must be mul of 2
	inc	ASTRONAUT_Y

no_fall_down_progress:

	lda	ASTRONAUT_Y
fall_down_destination_smc:
	cmp	#22
	bne	still_falling_down
done_falling_down:

	lda	#P_CROUCHING
	sta	ASTRONAUT_STATE
	jmp	astronaut_crouching

still_falling_down:

	lda	#<astro_stand
	sta	INL

	lda	#>astro_stand
	sta	INH

	jmp	finally_draw_him



;==================================
; IMPALED
;==================================

astronaut_impaled:

	lda	GAIT
	cmp	#$80
	bne	impale_not_done

impale_really_dead:
	lda	#$ff
	sta	GAME_OVER
	jmp	finally_draw_him

impale_not_done:

	cmp	#2		; slide down one more
	bne	impale_enough
	inc	ASTRONAUT_Y
	inc	ASTRONAUT_Y

impale_enough:
	inc	GAIT

	lda	#<astronaut_spike_sprite
	sta	INL

	lda	#>astronaut_spike_sprite
	sta	INH

	jmp	finally_draw_him

;=============================
; Actually Draw Him
;=============================


finally_draw_him:
	lda	ASTRONAUT_X
	sta	XPOS

	lda	ASTRONAUT_Y
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
	lda	ASTRONAUT_X
	adc	#$80
	cmp	LEFT_WALK_LIMIT
	bcs	just_fine_left		; (bge==bcs)

left_on_screen:

	; if limit was -4, means we are off screen
	; otherwise, stop astronaut at limit

	lda	LEFT_WALK_LIMIT
	cmp	#($80 - 4)
	beq	too_far_left

left_stop_at_barrier:
	lda     #0
        sta     ASTRONAUT_STATE

        lda     LEFT_WALK_LIMIT
        sec
        sbc     #$7f
        sta     ASTRONAUT_X

	rts

too_far_left:
	lda	#1
	sta	GAME_OVER
	rts

just_fine_left:

	; Check right edge of screen

;	lda	ASTRONAUT_X
	cmp	RIGHT_WALK_LIMIT
	bcc	just_fine_right		; blt


right_on_screen:

	; if limit was 39, means we are off screen
	; otherwise, stop astronaut at limit

	lda	RIGHT_WALK_LIMIT
	cmp	#($80 + 39)
	beq	too_far_right

right_stop_at_barrier:
	lda	#0
	sta	ASTRONAUT_STATE

	lda	RIGHT_WALK_LIMIT
	clc
	adc	#$7f
	sta	ASTRONAUT_X
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
