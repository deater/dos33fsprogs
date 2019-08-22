; draw/move our friend

friend_room:		.byte	0	; $FF means not out
friend_x:		.byte	0
friend_y:		.byte	0
friend_state:		.byte	0
friend_gait:		.byte	0
friend_direction:	.byte	0
friend_ai_state:	.byte	0

FAI_FOLLOWING		=	0
FAI_RUNTO_PANEL		=	1
FAI_OPENING_PANEL	=	2
FAI_DISINTEGRATING	=	3
FAI_END_L2		= 	4


F_STANDING	= 0
F_WALKING	= 1
F_RUNNING	= 2
F_CROUCHING	= 3
F_TURNING	= 4
F_KEYPAD	= 5
F_OPEN_VENT	= 6
F_DISINTEGRATING= 7

fai_table_lo:
	.byte <friend_ai_following	; 00
	.byte <friend_ai_runto_panel	; 01
	.byte <friend_ai_opening_panel	; 02
	.byte <friend_ai_disintegrating	; 03
	.byte <friend_ai_end_l2		; 04

fai_table_hi:
	.byte >friend_ai_following	; 00
	.byte >friend_ai_runto_panel	; 01
	.byte >friend_ai_opening_panel	; 02
	.byte >friend_ai_disintegrating	; 03
	.byte >friend_ai_end_l2		; 04


	;=======================================
	; Process friend AI
	;

handle_friend_ai:

	lda	friend_ai_state
	tay
	lda	fai_table_lo,y
	sta	fjump
	lda	fai_table_hi,y
	sta	fjump+1
	jmp	(fjump)

	rts

friend_ai_end_l2:
	; FAI_END_L2
	;    crouch, holding panel open
	rts

friend_ai_following:
	; FAI_FOLLOWING
	;    if x> phys_x by more than 8, walk left
	;    if x< phys_x by more than 8, walk right

friend_ai_runto_panel:
	; FAI_RUNTO_PANEL
	;    otherwise, if not in ROOM#2, run right
	;    if in room#2, run to panel

	lda	#1
	sta	friend_direction

	lda	#F_RUNNING
	sta	friend_state

	lda	WHICH_ROOM
	cmp	#3
	bne	ai_runto_panel_done

	lda	friend_x
	cmp	#30
	bcc	ai_runto_panel_done

	; hack, if running stop wrong place?
	lda	#31
	sta	friend_x

	lda	#FAI_OPENING_PANEL
	sta	friend_ai_state

	lda	#0
	sta	friend_direction

ai_runto_panel_done:
	jmp	friend_ai_done

friend_ai_opening_panel:
	; FAI_OPENING_PANEL
	;    if door2 unlocked -> FAI_FOLLOWING

	; FIXME: open panel for a bit, then open door and continue
	lda	#F_KEYPAD
	sta	friend_state

friend_ai_disintegrating:
friend_ai_done:
	rts


	;=======================================
	; Move friend based on current state
	;

move_friend:
	lda	friend_room
	cmp	WHICH_ROOM
	bne	done_move_friend

	jsr	handle_friend_ai

	lda	friend_state
	beq	done_move_friend

	lda	friend_state

	cmp	#F_WALKING
	beq	move_friend_walking
	cmp	#F_RUNNING
	beq	move_friend_running

done_move_friend:
	rts

	;======================
	; walking

move_friend_walking:
	inc	friend_gait	; cycle through animation

	lda     friend_gait
	and     #$f
	cmp     #$8			; only walk roughly 1/8 of time
	bne     friend_no_move_walk

	lda	friend_direction
	beq	f_walk_left

	inc	friend_x		; walk right
	rts
f_walk_left:
	dec     friend_x		; walk left
friend_no_move_walk:
	rts

	;======================
	; running
move_friend_running:
	inc	friend_gait	; cycle through animation

	lda     friend_gait
	and     #$7
	cmp	#5		; only run roughly 3/8 of time
	bcc	friend_no_move_run

	lda	friend_direction
	beq	f_run_left

	inc	friend_x		; run right
	jmp	friend_running_check_limits
f_run_left:
	dec	friend_x		; run left
friend_no_move_run:

friend_running_check_limits:
	lda	friend_x
	cmp	#39
	bcc	friend_done_running	; blt

	; move to next room
	lda	#0
	sta	friend_x

	inc	friend_room

friend_done_running:
	rts

	;======================
	; standing

move_friend_standing:





fstate_table_lo:
	.byte <friend_standing	; 00
	.byte <friend_walking	; 01
	.byte <friend_running	; 02
	.byte <friend_crouching	; 03
	.byte <friend_turning	; 04
	.byte <friend_keypad	; 05 KEYPAD
	.byte <friend_open_vent	; 06
	.byte <friend_disintegrating	; 07

fstate_table_hi:
	.byte >friend_standing	; 00
	.byte >friend_walking	; 01
	.byte >friend_running	; 02
	.byte >friend_crouching	; 03
	.byte >friend_turning	; 04
	.byte >friend_keypad	; 05 KEYPAD
	.byte >friend_open_vent	; 06
	.byte >friend_disintegrating	; 07

; Urgh, make sure this doesn't end up at $FF or you hit the
;	NMOS 6502 bug

.align 2

fjump:
	.word	$0000
.align 1

;======================================
; draw friend
;======================================

draw_friend:

	lda	friend_room
	cmp	WHICH_ROOM
	bne	no_friend

	lda	friend_state
	tay
	lda	fstate_table_lo,y
	sta	fjump
	lda	fstate_table_hi,y
	sta	fjump+1
	jmp	(fjump)

no_friend:
	rts

;==================================
; STANDING
;==================================

friend_standing:

	lda	#<friend_stand
	sta	INL

	lda	#>friend_stand
	sta	INH

	jmp	finally_draw_friend


;===================================
; CROUCHING
;===================================

friend_crouching:

	; FIXME: we have an animation?

	lda	#<friend_crouch2
	sta	INL

	lda	#>friend_crouch2
	sta	INH

	jmp	finally_draw_friend

;===================================
; OPEN_VENT
;===================================

friend_open_vent:

	; draw vent -- HACK

	lda	#1
	sta	VENT_OPEN

	lda	#$00
	sta	COLOR

	; X, V2 at Y
        ; from x=top, v2=bottom


	ldy	#18
	lda	#48
	sta	V2
	ldx	#24
	jsr	vlin

	ldy	#19
	lda	#48
	sta	V2
	ldx	#24
	jsr	vlin



	lda	#21
	sta	friend_x
	lda	#8
	sta	friend_y

	lda	#<friend_crouch2
	sta	INL

	lda	#>friend_crouch2
	sta	INH

	jmp	finally_draw_friend



;===============================
; Walking
;================================

friend_walking:
	lda	friend_gait
	cmp	#64
	bcc	friend_gait_fine	; blt

	lda	#0
	sta	friend_gait

friend_gait_fine:
	lsr
	lsr
	and	#$fe

	tay

	lda	friend_walk_progression,Y
	sta	INL

	lda	friend_walk_progression+1,Y
	sta	INH

	jmp	finally_draw_friend

;===============================
; Running
;================================

friend_running:
	lda	friend_gait
	cmp	#32
	bcc	friend_run_gait_fine	; blt

	lda	#0
	sta	friend_gait

friend_run_gait_fine:
	lsr
	and	#$fe

	tay

	lda	friend_run_progression,Y
	sta	INL

	lda	friend_run_progression+1,Y
	sta	INH

	jmp	finally_draw_friend

;===============================
; Turning
;================================

friend_turning:

	dec	friend_gait
	bpl	friend_draw_turning

	lda	#0
	sta	friend_gait

	; switch direction
	lda	friend_direction
	eor	#$1
	sta	friend_direction

	lda	#F_WALKING
	sta	friend_state

friend_draw_turning:
	lda	#<friend_turning_sprite
	sta	INL

	lda	#>friend_turning_sprite
	sta	INH

	jmp	finally_draw_friend


;===============================
; Using Keypad
;================================

friend_keypad:

	inc	friend_gait

	lda	friend_gait
	and	#$10
	lsr
	lsr
	lsr
	tay

friend_draw_keypad:
	lda	friend_keypad_progression,Y
	sta	INL

	lda	friend_keypad_progression+1,Y
	sta	INH

	jmp	finally_draw_friend

;===============================
; Disintegrating
;================================

friend_disintegrating:
	lda	friend_gait
	cmp	#13
	bne	friend_keep_disintegrating

	lda	#$ff
	sta	friend_room

        rts

friend_keep_disintegrating:
	asl
	tay

	; re-use alien sprites

	lda	alien_disintegrating_progression,Y
	sta	INL

	lda	alien_disintegrating_progression+1,Y
	sta	INH

	lda	FRAMEL
	and	#$7
	bne	slow_friend_disintegration

	inc	friend_gait
slow_friend_disintegration:

	jmp     finally_draw_friend



;=============================
; Actually Draw Friend
;=============================


finally_draw_friend:
	lda	friend_x
	sta	XPOS

	lda	friend_y
	sta	YPOS

	lda	friend_direction
	bne	friend_facing_right

friend_facing_left:
        jmp	put_sprite_crop

friend_facing_right:
	jmp	put_sprite_flipped_crop

