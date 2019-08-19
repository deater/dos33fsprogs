; Sluggy Freelance


; slug behavior:
;	cavern1: three slugs: 2 on ceiling
;	cavern2: four slugs: 1 on ceiling, but 3 more will respawn on ceiling

;	Crawl forward.  When close, attack.
;	Ceiling: crawl until within X of physicist
;		then swing a few times and fall
;		face toward physicist when start crawling
;	Attacks: only attack if on ground and physicist is on ground
;		will attempt to attack if you jump over
;	Off edge of screen: will disappear but will respawn if leave/re-enter

;==================================
; draw slugs
;==================================

SLUG_STRUCT_SIZE	=	8

	; TODO: use less space?  merge some of these?

slugg0_out:	.byte	1		; 0
slugg0_attack:	.byte	0		; 1
slugg0_dying:	.byte	0		; 2
slugg0_x:	.byte	30		; 3
slugg0_y:	.byte	30		; 4
slugg0_dir:	.byte	$ff		; 5
slugg0_gait:	.byte	0		; 6
slugg0_falling:	.byte	0		; 7

slugg1_out:	.byte	1		; 8
slugg1_attack:	.byte	0
slugg1_dying:	.byte	0
slugg1_x:	.byte	30
slugg1_y:	.byte	30
slugg1_dir:	.byte	$ff
slugg1_gait:	.byte	0
slugg1_falling:	.byte	0

slugg2_out:	.byte	1
slugg2_attack:	.byte	0
slugg2_dying:	.byte	0
slugg2_x:	.byte	30
slugg2_y:	.byte	2
slugg2_dir:	.byte	$ff
slugg2_gait:	.byte	0
slugg2_falling:	.byte	0


slugg3_out:	.byte	1		; 0
slugg3_attack:	.byte	0		; 1
slugg3_dying:	.byte	0		; 2
slugg3_x:	.byte	30		; 3
slugg3_y:	.byte	30		; 4
slugg3_dir:	.byte	$ff		; 5
slugg3_gait:	.byte	0		; 6
slugg3_falling:	.byte	0		; 7

slugg4_out:	.byte	1		; 6
slugg4_attack:	.byte	0
slugg4_dying:	.byte	0
slugg4_x:	.byte	30
slugg4_y:	.byte	30
slugg4_dir:	.byte	$ff
slugg4_gait:	.byte	0
slugg4_falling:	.byte	0

slugg5_out:	.byte	1
slugg5_attack:	.byte	0
slugg5_dying:	.byte	0
slugg5_x:	.byte	30
slugg5_y:	.byte	30
slugg5_dir:	.byte	$ff
slugg5_gait:	.byte	0
slugg5_falling:	.byte	0

slugg6_out:	.byte	1
slugg6_attack:	.byte	0
slugg6_dying:	.byte	0
slugg6_x:	.byte	30
slugg6_y:	.byte	2
slugg6_dir:	.byte	$ff
slugg6_gait:	.byte	0
slugg6_falling:	.byte	0

slugg7_out:	.byte	1
slugg7_attack:	.byte	0
slugg7_dying:	.byte	0
slugg7_x:	.byte	30
slugg7_y:	.byte	2
slugg7_dir:	.byte	$ff
slugg7_gait:	.byte	0
slugg7_falling:	.byte	0


	;========================
	; Init the slug creatures
	;========================

init_slugs:

	ldx	#0
init_slug_loop:

	; Mark slug as out and alive

	lda	#1
	sta	slugg0_out,X


	; Mark slug as not attacking or dying

	lda	#0
	sta	slugg0_attack,X
	sta	slugg0_dying,X

	; Point the slug in the correct direction (left in this case)

	lda	#$ff
	sta	slugg0_dir,X

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
	sta	slugg0_x,X

	; Make the slug movement random so they don't all move in sync

	jsr	random16
	lda	SEEDL
	sta	slugg0_gait,X

	; incrememnt struct pointer until all are initialized

	clc
	txa
	adc	#SLUG_STRUCT_SIZE
	tax

	cpx	#(SLUG_STRUCT_SIZE*8)
	bne	init_slug_loop

	; FIXME: originally forced some spacing between them

	rts


	;========================
	; Draw the slug creatures
	;========================

draw_slugs:

ds_smc1:
	ldx	#0			; loop through all.  self-modify
	stx	WHICH_SLUG
draw_slugs_loop:
	ldx	WHICH_SLUG
	lda	slugg0_out,X
	bne	check_kicked		; don't draw if not there
	jmp	slug_done

check_kicked:
	lda	slugg0_out,X		; only kick if normal
	cmp	#1
	bne	check_attack

	lda	slugg0_y,X		; only kick if on ground
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
	sbc	slugg0_x,X		; -4 to +4
	clc
	adc	#4
	and	#$f8
	bne	not_kicked
kicked:
	lda	#2
	sta	slugg0_out,X
	lda	#10
	sta	slugg0_dying,X
	lda	DIRECTION
	sta	slugg0_dir,X

not_kicked:

check_attack:
	;==================
	; see if attack

	lda	slugg0_out,X		; only attack if out
	cmp	#1
	bne	no_attack

	lda	slugg0_y,X		; only attack if on ground
	cmp	#30
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
	sbc	slugg0_x,X		; -2 to +2
	clc
	adc	#2
	and	#$fc
	bne	no_attack
attack:

	;=================
	; start an attack

	lda	#1
	sta	slugg0_attack,X

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
	inc	slugg0_gait,X		; increment slug gait counter

	lda	slugg0_gait,X		; only move every 64 frames
	and	#$3f
	cmp	#$00
	bne	slug_no_move

slug_move:
	lda	slugg0_x,X
	clc
	adc	slugg0_dir,X
	sta	slugg0_x,X

slug_check_right:
	cmp	#37
	bne	slug_check_left
	jmp	remove_slug

slug_check_left:
	cmp	#0
	bne	slug_no_move
	jmp	remove_slug

slug_no_move:


	;===============================
	;===============================
	; DRAW SLUG
	;===============================
	;===============================

	;==============
	; if exploding
	;==============

	lda	slugg0_dying,X
	beq	check_draw_attacking
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

	dec	slugg0_dying,X
	dec	slugg0_dying,X
	bne	no_progress
	jmp	remove_slug

no_progress:

	jmp	slug_selected


	;==============
	; if attacking
	;==============
check_draw_attacking:
	lda	slugg0_attack,X
	beq	check_slug_ceiling
slug_attacking:

	lda	slugg0_gait,X
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
	lda	slugg0_y,X
	cmp	#30
	beq	slug_normal
slug_ceiling:

	lda	slugg0_gait,X
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
	lda	slugg0_gait,X
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

	lda	slugg0_x,X
	sta	XPOS

	lda	slugg0_y,X
	sec
	sbc	EARTH_OFFSET
	sta	YPOS

	lda	slugg0_dir,X
	stx	WHICH_SLUG
	bmi	slug_right

slug_left:
        jsr	put_sprite
	jmp	slug_done

slug_right:
	jsr	put_sprite_flipped

slug_done:
	lda	WHICH_SLUG
	clc
	adc	#SLUG_STRUCT_SIZE
	tax
	stx	WHICH_SLUG

ds_smc2:
	cpx	#(3*SLUG_STRUCT_SIZE)
	beq	slug_exit

	jmp	draw_slugs_loop

slug_exit:
	rts

remove_slug:
	lda	#0
	sta	slugg0_out,X
	jmp	slug_done







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

