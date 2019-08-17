
;======================================
; handle keypress
;======================================

; A or <-   : start moving left
; D or ->   : start moving right
; W or up   : jump or elevator/transporter up
; S or down : crouch or pickup or elevator/transporter down
; L         : charge gun
; space     : action
; escape    : quit

; if left: if running right, walk right
;          if walk right, stand right
;          if stand right, stand left
;	   if stand left, walk left
;	   if walk left, run left
; if up:   if crouching, stand up
;	   if standing, jump
;	   if walking, jump
;	   if running, run-jump
; if down: if standing, crouch
;	   if walking, crouch
;	   if if running, slide-crouch


handle_keypress:

	lda	PHYSICIST_STATE
	bmi	no_keypress		; ignore keypress if dying/action

	lda	KEYPRESS						; 4
	bmi	keypress						; 3
no_keypress:
	bit	KEYRESET			; clear
						; avoid keeping old keys around
	rts	; nothing pressed, return

keypress:
									; -1

	and	#$7f		; clear high bit

	;======================
	; check escape

check_quit:
	cmp	#27		; quit if ESCAPE pressed
	bne	check_left

	;=====================
	; QUIT
	;=====================
quit:
	lda	#$ff		; could just dec
	sta	GAME_OVER
	rts

	;======================
	; check left
check_left:
	cmp	#'A'
	beq	left_pressed
	cmp	#$8		; left arrow
	bne	check_right


	;====================
	;====================
	; Left/A Pressed
	;====================
	;====================
left_pressed:
	inc	GUN_FIRE		; fire gun if charging

					; left==0
	lda	DIRECTION		; if facing right, turn to face left
	bne	left_going_right

left_going_left:
	lda	PHYSICIST_STATE
	cmp	#P_STANDING
	beq	walk_left
	cmp	#P_SHOOTING
	beq	walk_left
	cmp	#P_WALKING
	beq	run_left
	and	#STATE_CROUCHING
	bne	stand_left

	;=============================
	; already running, do nothing?
	jmp	done_keypress

left_going_right:
	lda	PHYSICIST_STATE
	cmp	#P_RUNNING
	beq	walk_right
	cmp	#P_WALKING
	beq	stand_right
	cmp	#P_STANDING
	beq	stand_left
	cmp	#P_SHOOTING
	beq	stand_left
	and	#STATE_CROUCHING
	bne	stand_left

	;===========================
	; otherwise?
	jmp	done_keypress

	;========================
	; check for right pressed

check_right:
	cmp	#'D'
	beq	right_pressed
	cmp	#$15
	bne	check_up

	;===================
	;===================
	; Right/D Pressed
	;===================
	;===================
right_pressed:
	inc	GUN_FIRE		; fire if charging

					; right==1
	lda	DIRECTION		; if facing left, turn to face right
	beq	right_going_left


right_going_right:
	lda	PHYSICIST_STATE
	cmp	#P_STANDING
	beq	walk_right
	cmp	#P_SHOOTING
	beq	walk_right
	cmp	#P_WALKING
	beq	run_right
	and	#STATE_CROUCHING
	bne	stand_right

	;=============================
	; already running, do nothing?
	jmp	done_keypress

right_going_left:
	lda	PHYSICIST_STATE
	cmp	#P_RUNNING
	beq	walk_left
	cmp	#P_WALKING
	beq	stand_left
	cmp	#P_STANDING
	beq	stand_right
	cmp	#P_SHOOTING
	beq	stand_right
	and	#STATE_CROUCHING
	bne	stand_right


	;===========================
	; otherwise?
	jmp	done_keypress


	;=====================
	; Left, direction=0
	; Right, direction=1

stand_left:
	lda	#0		; left
	sta	DIRECTION
	sta	GAIT
	lda	#P_STANDING
	beq	update_state

walk_left:
	lda	#P_WALKING
	bne	update_state

run_left:
	lda	#P_RUNNING
	bne	update_state


stand_right:
	lda	#0
	sta	GAIT
	lda	#1		 ; just inc DIRECTION?
	sta	DIRECTION
	lda	#P_STANDING
	beq	update_state

walk_right:
	lda	#P_WALKING
	bne	update_state

run_right:
	lda	#P_RUNNING
	bne	update_state

update_state:
	sta	PHYSICIST_STATE
	jmp	done_keypress




	;=====================
	; check up

check_up:
	cmp	#'W'
	beq	up
	cmp	#$0B
	bne	check_down
up:
	;=============================
	;=============================
	; Up/W Pressed -- Jump, Get up
	;=============================
	;=============================

	lda	PHYSICIST_STATE		; shoot if charging
	cmp	#P_CROUCH_SHOOTING
	beq	up_no_fire

	inc	GUN_FIRE
up_no_fire:

	lda	ON_ELEVATOR
	beq	up_not_elevator

up_on_elevator:
	lda	#P_ELEVATING_UP
	jmp	change_state_clear_gait

up_not_elevator:

	lda	PHYSICIST_STATE
	cmp	#P_CROUCHING
	beq	stand_up
	cmp	#P_CROUCH_SHOOTING
	beq	stand_up_shoot
	cmp	#P_RUNNING
	beq	run_jump

up_jump:
	lda	#P_JUMPING
	jmp	change_state_clear_gait

run_jump:
	lda	#P_JUMPING|STATE_RUNNING
	jmp	change_state_clear_gait

stand_up:
	lda	#P_STANDING
	jmp	change_state_clear_gait

stand_up_shoot:
	lda	#P_SHOOTING
	jmp	change_state_clear_gait


	;==========================
check_down:
	cmp	#'S'
	beq	down
	cmp	#$0A
	bne	check_gun

	;==========================
	;==========================
	; Down/S Pressed -- Crouch
	;==========================
	;==========================
down:

	lda	PHYSICIST_STATE		; shoot if charging
	cmp	#P_SHOOTING
	beq	down_no_fire

	inc	GUN_FIRE
down_no_fire:

	lda	ON_ELEVATOR
	beq	down_not_elevator

down_on_elevator:
	lda	#P_ELEVATING_DOWN
	jmp	change_state_clear_gait

down_not_elevator:
	lda	PHYSICIST_STATE
	cmp	#P_SHOOTING
	bne	start_crouch

start_crouch_shoot:
	and	#STATE_RUNNING
	ora	#P_CROUCH_SHOOTING
	jmp	change_state_clear_gait

start_crouch:
	and	#STATE_RUNNING
	beq	start_crouch_norun

	ldx	#4		; slide a bit
	stx	GAIT
	ora	#P_CROUCHING
	sta	PHYSICIST_STATE
	jmp	done_keypress

start_crouch_norun:
	ora	#P_CROUCHING
	jmp	change_state_clear_gait


	;==========================

check_gun:
	cmp	#'L'
	bne	check_space

	;======================
	; 'L' to charge gun
	;======================
charge_gun:
	lda	HAVE_GUN		; only if have gun
	beq	done_keypress

	lda	GUN_STATE
	beq	not_already_firing

	inc	GUN_FIRE		; if charging, fire

	jmp	done_keypress

not_already_firing:

	inc	GUN_STATE

	lda	PHYSICIST_STATE
	and	#STATE_CROUCHING
	beq	crouch_charge
	ldy	#P_CROUCH_SHOOTING
	bne	crouch_charge_go	; bra
crouch_charge:
	ldy	#P_SHOOTING
crouch_charge_go:
	sty	PHYSICIST_STATE

	jmp	shoot


check_space:
	cmp	#' '
	beq	space
;	cmp	#$15		; ascii 21=??
	jmp	unknown

	;======================
	; SPACE -- Kick or shoot
	;======================
space:
	lda	HAVE_GUN
	beq	kick

	; shoot pressed

	inc	GUN_FIRE			; if charging, shoot
shoot:
	lda	PHYSICIST_STATE		; if in stance, then shoot
	cmp	#P_SHOOTING
	beq	in_position
	cmp	#P_CROUCH_SHOOTING
	bne	no_stance

in_position:
	lda	#1
	sta	LASER_OUT
	jmp	done_keypress

no_stance:
	and	#STATE_CROUCHING
	beq	stand_stance

crouch_stance:
	lda	#P_CROUCH_SHOOTING
	jmp	change_state_clear_gait

stand_stance:
	lda	#P_SHOOTING
	jmp	change_state_clear_gait

kick:
	bit	PHYSICIST_STATE		; crouching state in V now
	bvc	kick_standing

	lda	#P_CROUCH_KICKING
	jmp	kick_final

kick_standing:
	lda	#P_KICKING
kick_final:
	sta	PHYSICIST_STATE
	lda	#15
	sta	GAIT
unknown:
done_keypress:
	bit	KEYRESET	; clear the keyboard strobe		; 4

	rts								; 6


change_state_clear_gait:
	sta	PHYSICIST_STATE
	lda	#0
	sta	GAIT
	jmp	done_keypress
