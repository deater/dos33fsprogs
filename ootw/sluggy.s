; Sluggy Freelance

;==================================
; draw slugs
;==================================

	; out-state 0=dead 1=normal (2=falling?)

slugg0_out:	.byte	1		; 0
slugg0_attack:	.byte	0		; 1
slugg0_dying:	.byte	0		; 2
slugg0_x:	.byte	30		; 3
slugg0_dir:	.byte	$ff		; 4
slugg0_gait:	.byte	0		; 5

slugg1_out:	.byte	1		; 6
slugg1_attack:	.byte	0
slugg1_dying:	.byte	0
slugg1_x:	.byte	30
slugg1_dir:	.byte	$ff
slugg1_gait:	.byte	0

slugg2_out:	.byte	1
slugg2_attack:	.byte	0
slugg2_dying:	.byte	0
slugg2_x:	.byte	30
slugg2_dir:	.byte	$ff
slugg2_gait:	.byte	0



slugg3_out:	.byte	1		; 0
slugg3_attack:	.byte	0		; 1
slugg3_dying:	.byte	0		; 2
slugg3_x:	.byte	30		; 3
slugg3_dir:	.byte	$ff		; 4
slugg3_gait:	.byte	0		; 5

slugg4_out:	.byte	1		; 6
slugg4_attack:	.byte	0
slugg4_dying:	.byte	0
slugg4_x:	.byte	30
slugg4_dir:	.byte	$ff
slugg4_gait:	.byte	0

slugg5_out:	.byte	1
slugg5_attack:	.byte	0
slugg5_dying:	.byte	0
slugg5_x:	.byte	30
slugg5_dir:	.byte	$ff
slugg5_gait:	.byte	0

slugg6_out:	.byte	1
slugg6_attack:	.byte	0
slugg6_dying:	.byte	0
slugg6_x:	.byte	30
slugg6_dir:	.byte	$ff
slugg6_gait:	.byte	0



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
	adc	#8		; appear from x = 8..36

	cmp	#36
	bcc	slugx_not_too_high		; blt
	lda	#36		; max out at 36
slugx_not_too_high:
	sta	slugg0_x,X

	; Make the slug movement random so they don't all move in sync

	jsr	random16
	lda	SEEDL
	sta	slugg0_gait,X

	; incrememnt struct pointer until all are initialized

	clc
	txa
	adc	#6
	tax

	cpx	#42
	bne	init_slug_loop

	; FIXME: originally forced some spacing between them

	rts


	;========================
	; Draw the slug creatures
	;========================

draw_slugs:

ds_smc1:
	ldx	#0
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

	;==================
	; see if kicked

	lda	KICKING
	beq	check_attack

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

	lda	slugg0_out,X
	cmp	#1
	bne	no_attack

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

	lda	SLUGDEATH		; don't re-attack if already dead
	bne	no_attack

	lda	#$1
	sta	SLUGDEATH
	lda	#0
	sta	SLUGDEATH_PROGRESS

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
	beq	slug_normal
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

	lda	#30
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
	adc	#6
	tax
	stx	WHICH_SLUG

ds_smc2:
	cpx	#18
	beq	slug_exit

	jmp	draw_slugs_loop

slug_exit:
	rts

remove_slug:
	lda	#0
	sta	slugg0_out,X
	jmp	slug_done

