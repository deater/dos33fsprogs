; draw/move the bad guy aliens

alien_state:
alien0:
	alien0_out:		.byte	0
	alien0_x:		.byte	0
	alien0_y:		.byte	0
	alien0_state:		.byte	0
	alien0_gait:		.byte	0
	alien0_direction:	.byte	0

alien1:
	alien1_out:		.byte	0
	alien1_x:		.byte	0
	alien1_y:		.byte	0
	alien1_state:		.byte	0
	alien1_gait:		.byte	0
	alien1_direction:	.byte	0

ALIEN_OUT	= 0
ALIEN_X		= 1
ALIEN_Y		= 2
ALIEN_STATE	= 3
ALIEN_GAIT	= 4
ALIEN_DIRECTION	= 5

A_STANDING	= 0
A_WALKING	= 1
A_RUNNING	= 2
A_CROUCHING	= 3

	;=======================================
	; Move alien based on current state
	;

move_alien:
	; FIXME: loop through all alieans
	ldx	#0

	lda	alien_state+ALIEN_OUT,X
	beq	done_move_alien

	lda	alien_state+ALIEN_STATE,X

	cmp	#P_WALKING
	beq	move_alien_walking
	cmp	#P_RUNNING
	beq	move_alien_running
done_move_alien:
	rts

	;======================
	; walking

move_alien_walking:
	inc	alien_state+ALIEN_GAIT,X	; cycle through animation

	lda     alien_state+ALIEN_GAIT,X
	and     #$7
	cmp     #$4			; only walk roughly 1/8 of time
	bne     alien_no_move_walk

	lda	alien_state+ALIEN_DIRECTION,X
	beq	a_walk_left

	inc	alien_state+ALIEN_X,X		; walk right
	rts
a_walk_left:
	dec     alien_state+ALIEN_X,X		; walk left
alien_no_move_walk:
	rts

	;======================
	; running
move_alien_running:
	inc	alien_state+ALIEN_GAIT,X	; cycle through animation

	lda     alien_state+ALIEN_GAIT,X
	and     #$3
	cmp     #$2			; only run roughly 1/4 of time
	bne     alien_no_move_run

	lda	alien_state+ALIEN_DIRECTION,X
	beq	a_run_left

	inc	alien_state+ALIEN_X,X		; run right
	rts
a_run_left:
	dec	alien_state+ALIEN_X,X		; run left
alien_no_move_run:
	rts

	;======================
	; standing

move_alien_standing:





astate_table_lo:
	.byte <alien_standing	; 00
	.byte <alien_walking	; 01
	.byte <alien_running	; 02
	.byte <alien_crouching	; 03

astate_table_hi:
	.byte >alien_standing
	.byte >alien_walking
	.byte >alien_running
	.byte >alien_crouching

; Urgh, make sure this doesn't end up at $FF or you hit the
;	NMOS 6502 bug

.align 2

ajump:
	.word	$0000

.align 1

;======================================
; draw alien
;======================================

draw_alien:
	; FIXME
	ldx	#0

	lda	alien_state+ALIEN_OUT,X
	beq	no_alien

	lda	alien_state+ALIEN_STATE,X
	tay
	lda	astate_table_lo,y
	sta	ajump
	lda	astate_table_hi,y
	sta	ajump+1
	jmp	(ajump)

no_alien:
	rts

;==================================
; STANDING
;==================================

alien_standing:

	lda	#<alien_stand
	sta	INL

	lda	#>alien_stand
	sta	INH

	jmp	finally_draw_alien


;===================================
; CROUCHING
;===================================

alien_crouching:

	; FIXME: we have an animation?

	lda	#<alien_crouch2
	sta	INL

	lda	#>alien_crouch2
	sta	INH

	jmp	finally_draw_alien


;===============================
; Walking
;================================

alien_walking:
	lda	alien_state+ALIEN_GAIT,X
	cmp	#32
	bcc	alien_gait_fine	; blt

	lda	#0
	sta	alien_state+ALIEN_GAIT,X

alien_gait_fine:
	lsr
	and	#$fe

	tay

	lda	alien_walk_progression,Y
	sta	INL

	lda	alien_walk_progression+1,Y
	sta	INH

	jmp	finally_draw_alien

;===============================
; Running
;================================

alien_running:
	lda	alien_state+ALIEN_GAIT,X
	cmp	#32
	bcc	alien_run_gait_fine	; blt

	lda	#0
	sta	alien_state+ALIEN_GAIT,X

alien_run_gait_fine:
	lsr
	and	#$fe

	tay

	lda	alien_run_progression,Y
	sta	INL

	lda	alien_run_progression+1,Y
	sta	INH

	jmp	finally_draw_alien


;=============================
; Actually Draw Alien
;=============================


finally_draw_alien:
	lda	alien_state+ALIEN_X,X
	sta	XPOS

	lda	alien_state+ALIEN_Y,X
	sta	YPOS

	lda	alien_state+ALIEN_DIRECTION,X
	bne	alien_facing_right

alien_facing_left:
        jmp	put_sprite_crop

alien_facing_right:
	jmp	put_sprite_flipped_crop




