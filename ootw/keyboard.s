;======================================
; handle keypress
;======================================

; A or <-   : start moving left
; D or ->   : start moving right
; W or up   : jump
; S or down : crouch or pickup
; space     : action
; escape    : quit

; if left: if running right, walk right
;          if walk right, stand right
;          if stand right, stand left
;	   if stand left, walk left
;	   if walk left, run left



handle_keypress:

	lda	PHYSICIST_STATE
	cmp	#P_COLLAPSING		; ignore keypress if dying
	beq	no_keypress
	cmp	#P_JUMPING		; ignore keypress if jumping
	beq	no_keypress
	cmp	#P_SWINGING
	beq	no_keypress
	cmp	#P_FALLING
	beq	no_keypress

	lda	KEYPRESS						; 4
	bmi	keypress						; 3
no_keypress:
	bit	KEYRESET			; clear
						; avoid keeping old keys around
	rts	; nothing pressed, return

keypress:
									; -1

	and	#$7f		; clear high bit

check_quit:
	cmp	#27		; quit if ESCAPE pressed
	bne	check_walk_left

	;=====================
	; QUIT
	;=====================
quit:
	lda	#$ff		; could just dec
	sta	GAME_OVER
	rts

check_walk_left:
	cmp	#'A'
	beq	walk_left
	cmp	#$8		; left arrow
	bne	check_walk_right


	;====================
	; Walk left
	;====================
walk_left:

	lda	#P_WALKING
	sta	PHYSICIST_STATE		; stand from crouching

	lda	DIRECTION		; if facing right, turn to face left
	bne	face_left

	inc	GAIT			; cycle through animation

	lda	GAIT
	and	#$7
	cmp	#$4
	bne	no_move_left

	dec	PHYSICIST_X		; walk left

no_move_left:

;	lda	PHYSICIST_X
;	cmp	LEFT_LIMIT
;	bpl	just_fine_left
;too_far_left:
;	inc	PHYSICIST_X
;	lda	#1
;	sta	GAME_OVER

;just_fine_left:

	jmp	done_keypress		; done

face_left:
	lda	#0
	sta	DIRECTION
	sta	GAIT
	jmp	done_keypress

check_walk_right:
	cmp	#'D'
	beq	walk_right
	cmp	#$15
	bne	check_run_left


	;===================
	; Walk Right
	;===================
walk_right:
	lda	#P_WALKING
	sta	PHYSICIST_STATE

	lda	DIRECTION
	beq	face_right

	inc	GAIT

	lda	GAIT
	and	#$7
	cmp	#$4
	bne	no_move_right

	inc	PHYSICIST_X
no_move_right:

;	lda	PHYSICIST_X
;	cmp	RIGHT_LIMIT
;	bne	just_fine_right
;too_far_right:

;	dec	PHYSICIST_X

;	lda	#2
;	sta	GAME_OVER


;just_fine_right:

	jmp	done_keypress

face_right:
	lda	#0
	sta	GAIT
	lda	#1
	sta	DIRECTION
	jmp	done_keypress



check_run_left:
	cmp	#'Q'
	bne	check_run_right


	;====================
	; Run left
	;====================
run_left:

	lda	#P_RUNNING
	sta	PHYSICIST_STATE		; stand from crouching

	lda	DIRECTION		; if facing right, turn to face left
	bne	face_left

	inc	GAIT			; cycle through animation
	inc	GAIT			; cycle through animation

	dec	PHYSICIST_X		; walk left

	jmp	no_move_left


check_run_right:
	cmp	#'E'
	bne	check_up

	;===================
	; Run Right
	;===================
run_right:
	lda	#P_RUNNING
	sta	PHYSICIST_STATE

	lda	DIRECTION
	beq	face_right

	inc	GAIT
	inc	GAIT

	inc	PHYSICIST_X

	jmp	no_move_right

check_up:
	cmp	#'W'
	beq	up
	cmp	#$0B
	bne	check_down
up:
	;========================
	; Jump
	;========================

	lda	#P_JUMPING
	sta	PHYSICIST_STATE
	lda	#0
	sta	GAIT

	jmp	done_keypress

check_down:
	cmp	#'S'
	beq	down
	cmp	#$0A
	bne	check_space

	;======================
	; Crouch
	;======================
down:
	lda	#P_CROUCHING
	sta	PHYSICIST_STATE
	lda	#0
	sta	GAIT

	jmp	done_keypress

check_space:
	cmp	#' '
	beq	space
	cmp	#$15
	bne	unknown

	;======================
	; Kick
	;======================
space:
	lda	#P_KICKING
	sta	PHYSICIST_STATE
	lda	#15
	sta	GAIT
unknown:
done_keypress:
	bit	KEYRESET	; clear the keyboard strobe		; 4

	rts								; 6


