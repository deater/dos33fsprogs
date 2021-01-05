
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

	lda	ASTRONAUT_STATE
	bmi	no_keypress		; ignore keypress if dying/action

	dec	KEY_COUNTDOWN
	lda	KEY_COUNTDOWN
	bne	done_keycount

	ldy	#0
	lda	(KEYPTRL),Y
	pha
	iny
	lda	(KEYPTRL),Y
	sta	KEY_COUNTDOWN

	clc
	lda	KEYPTRL
	adc	#2
	sta	KEYPTRL
	lda	#0
	adc	KEYPTRH
	sta	KEYPTRH

	pla				; restore keypress
	jmp	keypress

.if 0
	lda	KEYPRESS						; 4
	bmi	keypress						; 3
.endif

no_keypress:
	bit	KEYRESET			; clear
						; avoid keeping old keys around
done_keycount:
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
	lda	ASTRONAUT_STATE
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
	lda	ASTRONAUT_STATE
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
	lda	ASTRONAUT_STATE
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
	lda	ASTRONAUT_STATE
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
	sta	ASTRONAUT_STATE
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

	lda	ASTRONAUT_STATE		; shoot if charging
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

	lda	ASTRONAUT_STATE
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

	lda	ASTRONAUT_STATE		; shoot if charging
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
	lda	ASTRONAUT_STATE
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
	sta	ASTRONAUT_STATE
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

	lda	ASTRONAUT_STATE
	and	#STATE_CROUCHING
	beq	crouch_charge
	ldy	#P_CROUCH_SHOOTING
	bne	crouch_charge_go	; bra
crouch_charge:
	ldy	#P_SHOOTING
crouch_charge_go:
	sty	ASTRONAUT_STATE

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
	lda	ASTRONAUT_STATE		; if in stance, then shoot
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
	bit	ASTRONAUT_STATE		; crouching state in V now
	bvc	kick_standing

	lda	#P_CROUCH_KICKING
	jmp	kick_final

kick_standing:
	lda	#P_KICKING
kick_final:
	sta	ASTRONAUT_STATE
	lda	#15
	sta	GAIT
unknown:
done_keypress:
	bit	KEYRESET	; clear the keyboard strobe		; 4

	rts								; 6


change_state_clear_gait:
	sta	ASTRONAUT_STATE
	lda	#0
	sta	GAIT
	jmp	done_keypress



starbase_keypresses:
	; in room 0
	; already charging, so do nothing
	.byte	'.',80		; start charging laser, wait 180
	.byte	'L',10		; release, blasting door, wait 2
	.byte	'D',20		; walk right
	.byte	'D',135		; run right until we hit door
	.byte	'A',2		; walk left	; turn
	.byte	'A',50		; walk left	; walk left
	.byte	'D',2		; stop
	.byte	'D',2		; turn right
	.byte	'S',20		; duck
	.byte	'L',180		; start charging
	.byte	'L',20		; shoot		;blow up door
	.byte	'D',2		; stand
	; in room 1
	.byte	'D',10		; walk right
	.byte	'D',64		; run right
	.byte	'S',20		; duck
	.byte	'L',50		; start charging
	.byte	'L',20		; make shield
	.byte	'L',180		; start charging
	.byte	'L',20		; shoot
	.byte	' ',50		; shoot	; alien dead
	.byte	'D',50		; stand
	.byte	'D',5		; walk right
	.byte	'D',20		; run right
	.byte	'W',50		; run/jump right
	; in room 2
	.byte	'W',50		; run/jump right
	.byte	'D',70		; continue right
	; in room3
	.byte	'S',50		; duck
	.byte	'D',50		; stand
	.byte	'L',180		; start charging
	.byte	'L',20		; shoot clamp holder

	.byte	'D',5		; walk right
	.byte	'D',100		; run right
	.byte	'W',100		; run/jump right

	.byte	27,5		; quit

