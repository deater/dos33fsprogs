; Sluggy Freelance


; slug behavior from game:
;	cavern1: three slugs (2 on ceiling)
;	cavern2: four slugs (1 on ceiling) but 3 more will respawn on ceiling
;		as you kill them
;	so 7 total to track

;	Crawl forward.  When close, attack.
;	Ceiling: crawl until within X of physicist
;		then swing a few times and fall
;		face toward physicist when start crawling
;	Attacks: only attack if on ground and physicist is on ground
;		will attempt to attack if you jump over
;	Off edge of screen: will disappear but will respawn if leave/re-enter
;	Fall from ceiling when get too close, also earthquakes?
;		algorithm unclear

;==================================
; draw slugs
;==================================

NUM_SLUGS	=	7

; 1 is out, 2 is respawn?
slugg_out:
slugg0_out:	.byte	1		; 0
slugg1_out:	.byte	1		; 0
slugg2_out:	.byte	1		; 0

slugg3_out:	.byte	1		; 0
slugg4_out:	.byte	1		; 0
slugg5_out:	.byte	1		; 0
slugg6_out:	.byte	1		; 0

slugg_attack:
slugg0_attack:	.byte	0		; 1
slugg1_attack:	.byte	0
slugg2_attack:	.byte	0
slugg3_attack:	.byte	0		; 1
slugg4_attack:	.byte	0
slugg5_attack:	.byte	0
slugg6_attack:	.byte	0

slugg_dying:
slugg0_dying:	.byte	0		; 2
slugg1_dying:	.byte	0
slugg2_dying:	.byte	0
slugg3_dying:	.byte	0		; 2
slugg4_dying:	.byte	0
slugg5_dying:	.byte	0
slugg6_dying:	.byte	0

slugg_x:
slugg0_x:	.byte	30		; 3
slugg1_x:	.byte	30
slugg2_x:	.byte	30
slugg3_x:	.byte	30		; 3
slugg4_x:	.byte	30
slugg5_x:	.byte	30
slugg6_x:	.byte	30

slugg_y:
slugg0_y:	.byte	30		; 4
slugg1_y:	.byte	30
slugg2_y:	.byte	2
slugg3_y:	.byte	30		; 4
slugg4_y:	.byte	30
slugg5_y:	.byte	30
slugg6_y:	.byte	2

slugg_dir:
slugg0_dir:	.byte	$ff		; 5
slugg1_dir:	.byte	$ff
slugg2_dir:	.byte	$ff
slugg3_dir:	.byte	$ff		; 5
slugg4_dir:	.byte	$ff
slugg5_dir:	.byte	$ff
slugg6_dir:	.byte	$ff

slugg_gait:
slugg0_gait:	.byte	0		; 6
slugg1_gait:	.byte	0
slugg2_gait:	.byte	0
slugg3_gait:	.byte	0		; 6
slugg4_gait:	.byte	0
slugg5_gait:	.byte	0
slugg6_gait:	.byte	0

slugg_falling:
slugg0_falling:	.byte	0		; 7
slugg1_falling:	.byte	0
slugg2_falling:	.byte	0
slugg3_falling:	.byte	0		; 7
slugg4_falling:	.byte	0
slugg5_falling:	.byte	0
slugg6_falling:	.byte	0



	;========================
	; Init the slug creatures
	;========================

init_slugs:

	; outside loop, init ceiling-ness

	; ground slugs
	lda	#30
	sta	slugg0_y
	sta	slugg3_y
	sta	slugg4_y
	sta	slugg5_y

	; ceiling slugs
	lda	#2
	sta	slugg1_y
	sta	slugg2_y
	sta	slugg6_y

	ldx	#0
init_slug_loop:

	; Mark slug as out and alive
	; if slugs 4,5,6 then get 2 for respawn

	lda	#1
	cpx	#4
	bcc	regular_slug		; blt
	lda	#2
regular_slug:
	sta	slugg_out,X

	; Put 1st slug on floor, rest on ceiling

	; Mark slug as not attacking, dying, or falling

	lda	#0
	sta	slugg_attack,X
	sta	slugg_dying,X
	sta	slugg_falling,X

	; Point the slug in the correct direction (left in this case)

	lda	#$ff
	sta	slugg_dir,X

	; pick X

	jsr	init_slug_x


	; Make the slug movement random so they don't all move in sync

	jsr	random16
	lda	SEEDL
	sta	slugg_gait,X

	; incrememnt struct pointer until all are initialized

	inx
	cpx	#NUM_SLUGS

	bne	init_slug_loop

	; FIXME: originally forced some spacing between them

	rts

init_slug_x:
	; Randomly pick an X value to appear at

	jsr	random16
	lda	SEEDL
	and	#$1f
	clc
	adc	#8		; appear from x = 8..32

	cmp	#32
	bcc	slugx_not_too_high		; blt
	lsr			; div by two if too large
slugx_not_too_high:
	sta	slugg_x,X

	rts



	;========================
	; Refresh slugs
	;========================
	; call when re-enter room
	; any falling slugs put on ground
	; any off-screen slugs, respawn
refresh_slugs:

	ldx	#0
refresh_slug_loop:

	; put falling slugs on ground
	lda	#0
	sta	slugg_falling,X

	lda	slugg_y,X
	cmp	#2
	beq	refresh_y_ok

	lda	#30
	sta	slugg_y,X

refresh_y_ok:

	; if X out of range, redo

	lda	slugg_x,X
	bmi	refresh_x
	cmp	#38
	bcs	refresh_x

	jmp	refresh_x_fine
refresh_x:
	jsr	init_slug_x

refresh_x_fine:

	; should also do something about attack/destroy
	; but that only an issue if they leave the room
	; really suddenly somehow

	inx
	cpx	#NUM_SLUGS
	bne	refresh_slug_loop

	rts




	;========================
	;========================
	; Draw the slug creatures
	;========================
	;========================

draw_slugs:

ds_smc1:
	ldx	#0			; loop through all.  self-modify
	stx	WHICH_SLUG
draw_slugs_loop:
	ldx	WHICH_SLUG
	lda	slugg_out,X
	bne	check_kicked		; don't draw if not there
	jmp	slug_done

check_kicked:
	lda	slugg_dying,X		; only kick if alive
	bne	check_attack

	lda	slugg_y,X		; only kick if on ground
	cmp	#30
	bne	check_attack

	;==================
	; see if kicked

	lda	PHYSICIST_STATE
	cmp	#P_KICKING
	beq	were_kicking
	cmp	#P_CROUCH_KICKING
	bne	check_attack

were_kicking:
	lda	PHYSICIST_X
	sec
	sbc	slugg_x,X		; -4 to +4
	clc
	adc	#4
	and	#$f8
	bne	not_kicked
kicked:
;	lda	#2
;	sta	slugg_out,X
	lda	#10
	sta	slugg_dying,X
	lda	DIRECTION
	sta	slugg_dir,X

not_kicked:

check_attack:
	;==================
	; see if attack

	lda	slugg_out,X		; only attack if out
	beq	no_attack

	lda	slugg_y,X		; only attack if on ground
	cmp	#30
	bne	no_attack

	lda	slugg_dying,X		; only attack if not exploding
	bne	no_attack

	lda	slugg_falling,X		; only attack if not falling
	bne	no_attack

;	lda	PHYSICIST_Y		; only attack if physicist on ground
;	cmp	#22
;	bne	no_attack

	lda	PHYSICIST_STATE		; don't attack if jumping
	cmp	#P_JUMPING
	beq	no_attack
	cmp	#P_JUMPING|STATE_RUNNING
	beq	no_attack

	lda	PHYSICIST_X
	sec
	sbc	slugg_x,X		; -2 to +2
	clc
	adc	#2
	and	#$fc
	bne	no_attack
attack:

	;=================
	; start an attack

	lda	#1
	sta	slugg_attack,X

	lda	PHYSICIST_STATE		; don't re-attack if already dead
	cmp	#P_COLLAPSING
	beq	no_attack

	lda	#P_COLLAPSING		; start collapsing
	sta	PHYSICIST_STATE
	lda	#0
	sta	GAIT

	stx	WHICH_SLUG
	jsr	slug_cutscene
	ldx	WHICH_SLUG

no_attack:

	;====================
	; see if should fall

	lda	slugg_y,X		; first see if on ceiling
	cmp	#30
	beq	no_falling

	lda	slugg_falling,X
	bne	no_falling

	lda	slugg_x,X		; see if near physicist
	sec
	sbc	PHYSICIST_X
	clc
	adc	#8			; fall if within 8 of physicist
	cmp	#16
	bcs	no_falling		; bge

	lda	#1
	sta	slugg_falling,X

	lda	#0
	sta	slugg_gait,X

no_falling:

	inc	slugg_gait,X		; increment slug gait counter

	lda	slugg_gait,X		; only move every 64 frames
	and	#$3f
	cmp	#$00
	bne	slug_no_move

	lda	slugg_falling,X		; don't move X if falling
	bne	slug_no_move		; move Y instead in some cases

slug_move:
	lda	slugg_x,X
	clc
	adc	slugg_dir,X
	sta	slugg_x,X
;
; we let slugs go off the end, we catch it on room re-init
; though in theory if we wait long enough the slug will wrap

;slug_check_right:
;	cmp	#39
;	bne	slug_check_left
;	jmp	remove_slug

;slug_check_left:
;	cmp	#0
;	bne	slug_no_move
;	jmp	remove_slug

slug_no_move:


	;===============================
	;===============================
	; DRAW SLUG
	;===============================
	;===============================

	;==============
	; if exploding
	;==============

	lda	slugg_dying,X
	beq	check_draw_falling
slug_exploding:
	stx	WHICH_SLUG
	tax					; urgh can't forget tax
	lda	slug_die_progression,X
	sta	INL
	lda	slug_die_progression+1,X
	sta	INH
	ldx	WHICH_SLUG

	bit	SPEAKER

	lda	FRAMEL
	and	#$f
	bne	no_progress

	bit	SPEAKER

	dec	slugg_dying,X
	dec	slugg_dying,X
	bne	no_progress
	jmp	remove_slug

no_progress:

	jmp	slug_selected


	;===============
	; if falling
	;===============
check_draw_falling:
	lda	slugg_falling,X
	beq	check_draw_attacking

	tay
	dey

	lda	FRAMEL			; slow things down
	and	#$7
	bne	done_falling_slugs

	; actually fall
	cpy	#7
	beq	falling_slugs

falling_slug_inc:

	inc	slugg_falling,X

	lda	slugg_falling,X
	cmp	#13
	bne	done_falling_slugs

	; transition to ground slug
	lda	#0
	sta	slugg_falling,X

	; set direction
	lda	slugg_x,X
	cmp	PHYSICIST_X
	bpl	slug_transition_left

	lda	#1
	bne	slug_transition_store

slug_transition_left:
	lda	#$ff
slug_transition_store:
	sta	slugg_dir,X

	jmp	done_falling_slugs
falling_slugs:

	lda	slugg_y,X
	cmp	#30
	beq	falling_slug_inc

	clc
	adc	#2
	sta	slugg_y,X

done_falling_slugs:

	lda	slug_falling_progression_lo,Y
	sta	INL
	lda	slug_falling_progression_hi,Y
	sta	INH

	jmp	slug_selected

	;==============
	; if attacking
	;==============
check_draw_attacking:
	lda	slugg_attack,X
	beq	check_slug_ceiling
slug_attacking:

	lda	slugg_gait,X
	stx	WHICH_SLUG
	and	#$70
	lsr
	lsr
	lsr
	tax

	lda	slug_attack_progression,X
	sta	INL
	lda	slug_attack_progression+1,X
	sta	INH

	ldx	WHICH_SLUG

	jmp	slug_selected


	;==============
	; if on ceiling
	;==============
check_slug_ceiling:
	lda	slugg_y,X
	cmp	#30
	beq	slug_normal


	;=====================
	; ceiling slug
	;=====================
slug_ceiling:

	lda	slugg_gait,X
	and	#$20
	beq	slug_ceiling_squinched

slug_ceiling_flat:
	lda	#<slug_ceiling1
	sta	INL
	lda	#>slug_ceiling1
	sta	INH
	bne	slug_selected

slug_ceiling_squinched:
	lda	#<slug_ceiling2
	sta	INL
	lda	#>slug_ceiling2
	sta	INH

	jmp	slug_selected




	;==============
	; if normal
	;==============
slug_normal:
	lda	slugg_gait,X
	and	#$20
	beq	slug_squinched

slug_flat:
	lda	#<slug1
	sta	INL
	lda	#>slug1
	sta	INH
	bne	slug_selected

slug_squinched:
	lda	#<slug2
	sta	INL
	lda	#>slug2
	sta	INH

	;================
	; end slug normal
	;================

slug_selected:

	lda	slugg_x,X
	sta	XPOS

	lda	slugg_y,X
	sec
	sbc	EARTH_OFFSET
	sta	YPOS

	lda	slugg_dir,X
	stx	WHICH_SLUG
	bmi	slug_right

slug_left:
        jsr	put_sprite_crop
	jmp	slug_done

slug_right:
	jsr	put_sprite_flipped_crop

slug_done:
	ldx	WHICH_SLUG
	inx
	stx	WHICH_SLUG

ds_smc2:
	cpx	#3
	beq	slug_exit

	jmp	draw_slugs_loop

slug_exit:
	rts


remove_slug:

	dec	slugg_out,X
	beq	slug_removed

	; was higher, so re-spawn

	; respawn on ceiling
	lda	#2
	sta	slugg_y,X

	; direction=left
	lda	#$ff
	sta	slugg_dir,X

	; put in random spot
	jsr	init_slug_x

slug_removed:
	jmp	slug_done




	;===========================
	;===========================
	; slug cutscene
	;===========================
	;===========================

slug_cutscene:

	;====================
	; First the slug part

	lda	#$8
	sta	DRAW_PAGE
        jsr	clear_top

	lda	#<slug_background
	sta	INL
	lda	#>slug_background
	sta	INH

	lda	#15
	sta     XPOS

	lda	#10
	sta	YPOS

	jsr	put_sprite

	lda	#$0
	sta	DRAW_PAGE

	jsr     gr_copy_to_current
        jsr     page_flip
        jsr     gr_copy_to_current
	jsr	page_flip

	ldx	#0
	stx	CUTFRAME
sluggy_loop:
        jsr     gr_copy_to_current

	ldx	CUTFRAME

	lda	slug_frames,X
	sta	INL
	lda	slug_frames+1,X
	sta	INH

	lda	#15
	sta     XPOS

	lda	#18
	sta	YPOS

	jsr	put_sprite

	jsr	page_flip

	ldx	#2
long_delay:
	lda	#250
	jsr	WAIT
	dex
	bne	long_delay


	ldx	CUTFRAME
	inx
	inx
	stx	CUTFRAME

	cpx	#12
	beq	sluggy_end

	jmp	sluggy_loop

sluggy_end:


	;====================
	; Then the leg part

	lda	#$8
	sta	DRAW_PAGE
        jsr	clear_top

	lda	#<leg_background
	sta	INL
	lda	#>leg_background
	sta	INH

	lda	#15
	sta     XPOS

	lda	#10
	sta	YPOS

	jsr	put_sprite

	lda	#$0
	sta	DRAW_PAGE

	jsr     gr_copy_to_current
        jsr     page_flip
        jsr     gr_copy_to_current
	jsr	page_flip

	ldx	#0
	stx	CUTFRAME
leg_loop:
        jsr     gr_copy_to_current

	ldx	CUTFRAME

	lda	leg_frames,X
	sta	INL
	lda	leg_frames+1,X
	sta	INH

	lda	#18
	sta     XPOS

	lda	#18
	sta	YPOS

	jsr	put_sprite

	jsr	page_flip

	ldx	#4
long_delay2:
	lda	#250
	jsr	WAIT
	dex
	bne	long_delay2

	ldx	CUTFRAME
	inx
	inx
	stx	CUTFRAME

	cpx	#12
	beq	leg_end

	jmp	leg_loop

leg_end:

	;=============================
	; Restore background to $c00

	jmp	cavern_load_background

;	rts		; tail call?

; sluggy freelance

slug_frames:
	.word	sluggy1
	.word	sluggy2
	.word	sluggy3
	.word	sluggy4
	.word	sluggy5
	.word	sluggy6

leg_frames:
	.word	leg1
	.word	leg2
	.word	leg3
	.word	leg4
	.word	leg5
	.word	leg5

