	;==================
	;==================
	; erase lemmings
	;==================
	;==================
erase_lemming:
	ldy	#0
	sty	CURRENT_LEMMING
erase_lemming_loop:

	ldy	CURRENT_LEMMING

	lda	lemming_out,Y
	beq	done_erase_lemming

	; don't erase blockers?
	lda	lemming_status,Y
	cmp	#LEMMING_STOPPING
	beq	done_erase_lemming


	lda	lemming_y,Y
	sec
	sbc	#6
	sta	SAVED_Y1
	clc
	adc	#15
	sta	SAVED_Y2

	lda	lemming_x,Y
	tax
	inx
	jsr	hgr_partial_restore

done_erase_lemming:
	inc	CURRENT_LEMMING
	lda	CURRENT_LEMMING
	cmp	#MAX_LEMMINGS
	bne	erase_lemming_loop

	rts




	;=========================
	;=========================
	; draw lemming
	;=========================
	;=========================
draw_lemming:
	ldy	#0
	sty	CURRENT_LEMMING

draw_lemming_loop:

	ldy	CURRENT_LEMMING

	lda	lemming_out,Y			; if lemming not out, skip
	beq	done_draw_lemming

	;===============================
	; draw countdown if applicable

do_draw_countdown:
	lda	lemming_exploding,Y
	beq	do_draw_lemming

	ldx	lemming_exploding,Y
	dex

	lda	countdown_sprites_l,X
	sta	INL
	lda	countdown_sprites_h,X
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
	sec
	sbc	#6
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift


do_draw_lemming:

	; set up jump table
	ldy	CURRENT_LEMMING
	lda	lemming_status,Y
	tax

	lda	draw_lemming_jump_h,X
	pha
	lda	draw_lemming_jump_l,X
	pha
	rts					; jump to it


draw_lemming_common:
	sta	YPOS

	jsr	hgr_draw_sprite_or_autoshift

done_draw_lemming:

	inc	CURRENT_LEMMING
	lda	CURRENT_LEMMING
	cmp	#MAX_LEMMINGS
	bne	draw_lemming_loop

really_done_draw_lemming:
	rts


draw_lemming_jump_l:
	.byte	<(draw_falling_sprite-1)
	.byte	<(draw_walking_sprite-1)
	.byte	<(draw_digging_sprite-1)
	.byte	<(draw_exploding_sprite-1)
	.byte	<(draw_particles-1)
	.byte	<(draw_splatting_sprite-1)
	.byte	<(draw_floating_sprite-1)
	.byte	<(draw_climbing_sprite-1)
	.byte	<(draw_bashing_sprite-1)
	.byte	<(draw_stopping_sprite-1)
	.byte	<(draw_mining_sprite-1)
	.byte	<(draw_building_sprite-1)
	.byte	<(draw_shrugging_sprite-1)
	.byte	<(draw_pullup_sprite-1)

draw_lemming_jump_h:
	.byte	>(draw_falling_sprite-1)
	.byte	>(draw_walking_sprite-1)
	.byte	>(draw_digging_sprite-1)
	.byte	>(draw_exploding_sprite-1)
	.byte	>(draw_particles-1)
	.byte	>(draw_splatting_sprite-1)
	.byte	>(draw_floating_sprite-1)
	.byte	>(draw_climbing_sprite-1)
	.byte	>(draw_bashing_sprite-1)
	.byte	>(draw_stopping_sprite-1)
	.byte	>(draw_mining_sprite-1)
	.byte	>(draw_building_sprite-1)
	.byte	>(draw_shrugging_sprite-1)
	.byte	>(draw_pullup_sprite-1)


	;=========================
	;=========================
	; draw walking
	;=========================
	;=========================

draw_walking_sprite:

	lda	lemming_frame,Y
	and	#$7
	tax

	lda	lemming_direction,Y
	bpl	draw_walking_right

draw_walking_left:
	lda	lwalk_sprite_l,X
	sta	INL
	lda	lwalk_sprite_h,X
	jmp	draw_walking_common

draw_walking_right:
	lda	rwalk_sprite_l,X
	sta	INL
	lda	rwalk_sprite_h,X

draw_walking_common:
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
	jmp	draw_lemming_common



	;=========================
	;=========================
	; draw climbing
	;=========================
	;=========================

draw_climbing_sprite:

	lda	lemming_frame,Y
	and	#$7
	tax

	lda	lemming_direction,Y
	bpl	draw_climbing_right

draw_climbing_left:
	lda	lclimb_sprite_l,X
	sta	INL
	lda	lclimb_sprite_h,X
	jmp	draw_climbing_common

draw_climbing_right:
	lda	rclimb_sprite_l,X
	sta	INL
	lda	rclimb_sprite_h,X

draw_climbing_common:
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
	jmp	draw_lemming_common



	;=========================
	;=========================
	; draw bashing
	;=========================
	;=========================

draw_bashing_sprite:

	lda	lemming_frame,Y
	and	#$7
	tax

	lda	lemming_direction,Y
	bpl	draw_bashing_right

draw_bashing_left:
	lda	lbash_sprite_l,X
	sta	INL
	lda	lbash_sprite_h,X
	jmp	draw_bashing_common

draw_bashing_right:
	lda	rbash_sprite_l,X
	sta	INL
	lda	rbash_sprite_h,X

draw_bashing_common:
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
	jmp	draw_lemming_common


	;=========================
	;=========================
	; draw mining
	;=========================
	;=========================

draw_mining_sprite:

	lda	lemming_frame,Y
	and	#$7
	tax

	lda	lemming_direction,Y
	bpl	draw_mining_right

draw_mining_left:
	lda	lmine_sprite_l,X
	sta	INL
	lda	lmine_sprite_h,X
	jmp	draw_mining_common

draw_mining_right:
	lda	rmine_sprite_l,X
	sta	INL
	lda	rmine_sprite_h,X

draw_mining_common:
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
;	jmp	draw_lemming_common


	; special case, don't OR so we aren't embedded in dirt
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift

	jmp	done_draw_lemming



	;=========================
	;=========================
	; draw building
	;=========================
	;=========================

draw_building_sprite:

	lda	lemming_frame,Y
	and	#$7
	tax

	lda	lemming_direction,Y
	bpl	draw_building_right

draw_building_left:
	lda	lbuild_sprite_l,X
	sta	INL
	lda	lbuild_sprite_h,X
	jmp	draw_building_common

draw_building_right:
	lda	rbuild_sprite_l,X
	sta	INL
	lda	rbuild_sprite_h,X

draw_building_common:
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
	jmp	draw_lemming_common


	;=========================
	;=========================
	; draw shrugging
	;=========================
	;=========================

draw_shrugging_sprite:

	lda	lemming_frame,Y
	and	#$7
	tax

	lda	lemming_direction,Y
	bpl	draw_shrugging_right

draw_shrugging_left:
	lda	lshrug_sprite_l,X
	sta	INL
	lda	lshrug_sprite_h,X
	jmp	draw_shrugging_common

draw_shrugging_right:
	lda	rshrug_sprite_l,X
	sta	INL
	lda	rshrug_sprite_h,X

draw_shrugging_common:
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
	clc
	adc	#1			; offset by 1 for some reason

	jmp	draw_lemming_common


	;=========================
	;=========================
	; draw pullup
	;=========================
	;=========================

draw_pullup_sprite:

	lda	lemming_frame,Y
	and	#$7
	tax

	lda	lemming_direction,Y
	bpl	draw_pullup_right

draw_pullup_left:
	lda	lpullup_sprite_l,X
	sta	INL
	lda	lpullup_sprite_h,X
	jmp	draw_pullup_common

draw_pullup_right:
	lda	rpullup_sprite_l,X
	sta	INL
	lda	rpullup_sprite_h,X

draw_pullup_common:
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
	jmp	draw_lemming_common








	;=========================
	;=========================
	; draw floating
	;=========================
	;=========================

draw_floating_sprite:

	lda	lemming_frame,Y
	cmp	#4
	bcc	umbrella_opening		; blt
						; if <4 then draw first 4
						; frames

	and	#3				; otherwise repeat frames
	clc					; 4..7
	adc	#4

umbrella_opening:
	tax

	lda	umbrella_sprite_l,X
	sta	INL
	lda	umbrella_sprite_h,X
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
	sec
	sbc	#4

	jmp	draw_lemming_common


	;=========================
	;=========================
	; draw falling
	;=========================
	;=========================

draw_falling_sprite:

	lda	lemming_frame,Y
	and	#$3
	tax

	lda	lemming_direction,Y
	bpl	draw_falling_right

draw_falling_left:
	lda	lfall_sprite_l,X
	sta	INL
	lda	lfall_sprite_h,X
	jmp	draw_falling_common

draw_falling_right:
	lda	rfall_sprite_l,X
	sta	INL
	lda	rfall_sprite_h,X

draw_falling_common:
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y

	jmp	draw_lemming_common


	;=========================
	;=========================
	; draw exploding
	;=========================
	;=========================

draw_exploding_sprite:

	lda	lemming_frame,Y
	cmp	#$10
;	bcc	exploding_animation
	beq	draw_explosion
	bcs	start_particles
	jmp	exploding_animation

start_particles:

	lda	#0
	sta	lemming_frame,Y

	jsr	init_particles

	; erase explosion

	ldy	CURRENT_LEMMING

	lda	lemming_y,Y
	sec
	sbc	#16
	sta	SAVED_Y1
	clc
	adc	#32
	sta	SAVED_Y2

	lda	lemming_x,Y
	sec
	sbc	#1
	tax
	inx
	inx
	inx
	jsr	hgr_partial_restore

	; start particles

	ldy	CURRENT_LEMMING
	lda	#LEMMING_PARTICLES
	sta	lemming_status,Y

	jmp	done_draw_lemming

draw_explosion:

	; first erase pit in background art

	ldx	#0
	stx	HGR_COLOR

	; (X,A) to (X,A+Y) where X is xcoord/7
	jsr     hgr_box_page_toggle
	ldy	CURRENT_LEMMING
	lda	lemming_x,Y
	tax
	lda	lemming_y,Y
	ldy     #11
	jsr	hgr_box

	ldy	CURRENT_LEMMING
	lda	lemming_x,Y
	tax
	inx
	lda	lemming_y,Y
	ldy     #8
	jsr	hgr_box

	ldy	CURRENT_LEMMING
	lda	lemming_x,Y
	tax
	dex
	lda	lemming_y,Y
	ldy     #8
	jsr	hgr_box


	jsr	hgr_box_page_toggle

	ldy	CURRENT_LEMMING
	lda	lemming_x,Y
	tax
	lda	lemming_y,Y
	ldy     #11
	jsr	hgr_box

	ldy	CURRENT_LEMMING
	lda	lemming_x,Y
	tax
	inx
	lda	lemming_y,Y
	ldy     #8
	jsr	hgr_box

	ldy	CURRENT_LEMMING
	lda	lemming_x,Y
	tax
	dex
	lda	lemming_y,Y
	ldy     #8
	jsr	hgr_box


	jsr	click_speaker

	ldy	#0
	lda	#<explosion_sprite
	sta	INL
	lda	#>explosion_sprite
	sta	INH

	ldy	CURRENT_LEMMING
	ldx	lemming_x,Y
	dex
        stx     XPOS
	lda	lemming_y,Y
	sec
	sbc	#5

	jmp	done_handle_exploding

exploding_animation:
;	and	#$f
	tax

	lda	exploding_sprite_l,X
	sta	INL
	lda	exploding_sprite_h,X
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y

done_handle_exploding:
	jmp	draw_lemming_common

;	sta	YPOS

;	jsr	hgr_draw_sprite_autoshift

;	jmp	done_draw_lemming

	;====================
	;====================
	; draw splatting
	;====================
	;====================
draw_splatting_sprite:

	lda	lemming_frame,Y
	cmp	#$8
	beq	done_splatting

draw_splatting:
	jsr	click_speaker

	tax

	lda	splatting_sprite_l,X
	sta	INL
	lda	splatting_sprite_h,X
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift

	jmp	done_draw_lemming

done_splatting:
	clc
	jsr	remove_lemming		; FIXME: tail call

	jmp	done_draw_lemming


	;====================
	;====================
	; draw stopping
	;====================
	;====================

draw_stopping_sprite:

	lda	lemming_frame,Y
	and	#$f
	tax

	lda	stopper_sprite_l,X
	sta	INL
	lda	stopper_sprite_h,X
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y

;	jmp	draw_lemming_common

	; special case, don't or so we hide background spike
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift

	jmp	done_draw_lemming

;	sta	YPOS

;	jsr	hgr_draw_sprite_autoshift

;	jmp	done_draw_lemming



	;====================
	;====================
	; draw particles
	;====================
	;====================

draw_particles:

	jsr	hgr_draw_particles

	ldy	CURRENT_LEMMING

	lda	lemming_frame,Y
	cmp	#16
	bne	still_going

	; TODO: partway through make lemming not out?

	lda	#0
	sta	lemming_out,Y

	clc				; mark as not exiting via door
	jsr	remove_lemming		; remove the lemming

still_going:

not_done_particle:
	jmp	done_draw_lemming



	;======================
	;======================
	; digging
	;======================
	;======================

draw_digging_sprite:

	lda	lemming_frame,Y
	and	#$7
	tax

	lda	dig_sprite_l,X
	sta	INL
	lda	dig_sprite_h,X
	sta	INH

	ldx	lemming_x,Y
        stx     XPOS
	lda	lemming_y,Y
	sec
	sbc	#2

	jmp	draw_lemming_common



;===============
; sprite tables
;===============



lfall_sprite_l:
	.byte <lemming_lfall1_sprite,<lemming_lfall2_sprite
	.byte <lemming_lfall3_sprite,<lemming_lfall4_sprite
lfall_sprite_h:
	.byte >lemming_lfall1_sprite,>lemming_lfall2_sprite
	.byte >lemming_lfall3_sprite,>lemming_lfall4_sprite

rfall_sprite_l:
	.byte <lemming_rfall1_sprite,<lemming_rfall2_sprite
	.byte <lemming_rfall3_sprite,<lemming_rfall4_sprite
rfall_sprite_h:
	.byte >lemming_rfall1_sprite,>lemming_rfall2_sprite
	.byte >lemming_rfall3_sprite,>lemming_rfall4_sprite


dig_sprite_l:
	.byte <lemming_dig1_sprite,<lemming_dig2_sprite
	.byte <lemming_dig3_sprite,<lemming_dig4_sprite
	.byte <lemming_dig5_sprite,<lemming_dig6_sprite
	.byte <lemming_dig7_sprite,<lemming_dig8_sprite
dig_sprite_h:
	.byte >lemming_dig1_sprite,>lemming_dig2_sprite
	.byte >lemming_dig3_sprite,>lemming_dig4_sprite
	.byte >lemming_dig5_sprite,>lemming_dig6_sprite
	.byte >lemming_dig7_sprite,>lemming_dig8_sprite

rwalk_sprite_l:
	.byte <lemming_rwalk1_sprite,<lemming_rwalk2_sprite
	.byte <lemming_rwalk3_sprite,<lemming_rwalk4_sprite
	.byte <lemming_rwalk5_sprite,<lemming_rwalk6_sprite
	.byte <lemming_rwalk7_sprite,<lemming_rwalk8_sprite
rwalk_sprite_h:
	.byte >lemming_rwalk1_sprite,>lemming_rwalk2_sprite
	.byte >lemming_rwalk3_sprite,>lemming_rwalk4_sprite
	.byte >lemming_rwalk5_sprite,>lemming_rwalk6_sprite
	.byte >lemming_rwalk7_sprite,>lemming_rwalk8_sprite

lwalk_sprite_l:
	.byte <lemming_lwalk1_sprite,<lemming_lwalk2_sprite
	.byte <lemming_lwalk3_sprite,<lemming_lwalk4_sprite
	.byte <lemming_lwalk5_sprite,<lemming_lwalk6_sprite
	.byte <lemming_lwalk7_sprite,<lemming_lwalk8_sprite
lwalk_sprite_h:
	.byte >lemming_lwalk1_sprite,>lemming_lwalk2_sprite
	.byte >lemming_lwalk3_sprite,>lemming_lwalk4_sprite
	.byte >lemming_lwalk5_sprite,>lemming_lwalk6_sprite
	.byte >lemming_lwalk7_sprite,>lemming_lwalk8_sprite

exploding_sprite_l:
	.byte <lemming_explode1_sprite,<lemming_explode1_sprite
	.byte <lemming_explode2_sprite,<lemming_explode3_sprite
	.byte <lemming_explode4_sprite,<lemming_explode5_sprite
	.byte <lemming_explode6_sprite,<lemming_explode7_sprite
	.byte <lemming_explode8_sprite,<lemming_explode7_sprite
	.byte <lemming_explode9_sprite,<lemming_explode8_sprite
	.byte <lemming_explode9_sprite,<lemming_explode8_sprite
	.byte <lemming_explode9_sprite,<lemming_explode8_sprite

exploding_sprite_h:
	.byte >lemming_explode1_sprite,>lemming_explode1_sprite
	.byte >lemming_explode2_sprite,>lemming_explode3_sprite
	.byte >lemming_explode4_sprite,>lemming_explode5_sprite
	.byte >lemming_explode6_sprite,>lemming_explode7_sprite
	.byte >lemming_explode8_sprite,>lemming_explode7_sprite
	.byte >lemming_explode9_sprite,>lemming_explode8_sprite
	.byte >lemming_explode9_sprite,>lemming_explode8_sprite
	.byte >lemming_explode9_sprite,>lemming_explode8_sprite


; 787989898
; clcrlrlrle

countdown_sprites_l:
.byte <countdown5_sprite,<countdown4_sprite,<countdown3_sprite
.byte <countdown2_sprite,<countdown1_sprite

countdown_sprites_h:
.byte >countdown5_sprite,>countdown4_sprite,>countdown3_sprite
.byte >countdown2_sprite,>countdown1_sprite


splatting_sprite_l:
	.byte <lemming_splat1_sprite,<lemming_splat2_sprite
	.byte <lemming_splat3_sprite,<lemming_splat4_sprite
	.byte <lemming_splat5_sprite,<lemming_splat6_sprite
	.byte <lemming_splat7_sprite,<lemming_splat8_sprite

splatting_sprite_h:
	.byte >lemming_splat1_sprite,>lemming_splat2_sprite
	.byte >lemming_splat3_sprite,>lemming_splat4_sprite
	.byte >lemming_splat5_sprite,>lemming_splat6_sprite
	.byte >lemming_splat7_sprite,>lemming_splat8_sprite

umbrella_sprite_l:
	.byte <lemming_umbrella1_sprite,<lemming_umbrella2_sprite
	.byte <lemming_umbrella3_sprite,<lemming_umbrella4_sprite
	.byte <lemming_umbrella5_sprite,<lemming_umbrella6_sprite
	.byte <lemming_umbrella7_sprite,<lemming_umbrella8_sprite

umbrella_sprite_h:
	.byte >lemming_umbrella1_sprite,>lemming_umbrella2_sprite
	.byte >lemming_umbrella3_sprite,>lemming_umbrella4_sprite
	.byte >lemming_umbrella5_sprite,>lemming_umbrella6_sprite
	.byte >lemming_umbrella7_sprite,>lemming_umbrella8_sprite

stopper_sprite_l:
	.byte <lemming_stopper1_sprite,<lemming_stopper2_sprite
	.byte <lemming_stopper3_sprite,<lemming_stopper4_sprite
	.byte <lemming_stopper5_sprite,<lemming_stopper6_sprite
	.byte <lemming_stopper7_sprite,<lemming_stopper7_sprite
	.byte <lemming_stopper9_sprite,<lemming_stopper10_sprite
	.byte <lemming_stopper11_sprite,<lemming_stopper12_sprite
	.byte <lemming_stopper13_sprite,<lemming_stopper14_sprite
	.byte <lemming_stopper7_sprite,<lemming_stopper7_sprite

stopper_sprite_h:
	.byte >lemming_stopper1_sprite,>lemming_stopper2_sprite
	.byte >lemming_stopper3_sprite,>lemming_stopper4_sprite
	.byte >lemming_stopper5_sprite,>lemming_stopper6_sprite
	.byte >lemming_stopper7_sprite,>lemming_stopper7_sprite
	.byte >lemming_stopper9_sprite,>lemming_stopper10_sprite
	.byte >lemming_stopper11_sprite,>lemming_stopper12_sprite
	.byte >lemming_stopper13_sprite,>lemming_stopper14_sprite
	.byte >lemming_stopper7_sprite,>lemming_stopper7_sprite


rclimb_sprite_l:
	.byte <lemming_rclimb1_sprite,<lemming_rclimb2_sprite
	.byte <lemming_rclimb3_sprite,<lemming_rclimb4_sprite
	.byte <lemming_rclimb5_sprite,<lemming_rclimb6_sprite
	.byte <lemming_rclimb7_sprite,<lemming_rclimb8_sprite
rclimb_sprite_h:
	.byte >lemming_rclimb1_sprite,>lemming_rclimb2_sprite
	.byte >lemming_rclimb3_sprite,>lemming_rclimb4_sprite
	.byte >lemming_rclimb5_sprite,>lemming_rclimb6_sprite
	.byte >lemming_rclimb7_sprite,>lemming_rclimb8_sprite

lclimb_sprite_l:
	.byte <lemming_lclimb1_sprite,<lemming_lclimb2_sprite
	.byte <lemming_lclimb3_sprite,<lemming_lclimb4_sprite
	.byte <lemming_lclimb5_sprite,<lemming_lclimb6_sprite
	.byte <lemming_lclimb7_sprite,<lemming_lclimb8_sprite
lclimb_sprite_h:
	.byte >lemming_lclimb1_sprite,>lemming_lclimb2_sprite
	.byte >lemming_lclimb3_sprite,>lemming_lclimb4_sprite
	.byte >lemming_lclimb5_sprite,>lemming_lclimb6_sprite
	.byte >lemming_lclimb7_sprite,>lemming_lclimb8_sprite


rbash_sprite_l:
	.byte <lemming_rbasher1_sprite,<lemming_rbasher2_sprite
	.byte <lemming_rbasher3_sprite,<lemming_rbasher4_sprite
	.byte <lemming_rbasher5_sprite,<lemming_rbasher6_sprite
	.byte <lemming_rbasher7_sprite,<lemming_rbasher8_sprite
rbash_sprite_h:
	.byte >lemming_rbasher1_sprite,>lemming_rbasher2_sprite
	.byte >lemming_rbasher3_sprite,>lemming_rbasher4_sprite
	.byte >lemming_rbasher5_sprite,>lemming_rbasher6_sprite
	.byte >lemming_rbasher7_sprite,>lemming_rbasher8_sprite

lbash_sprite_l:
	.byte <lemming_lbasher1_sprite,<lemming_lbasher2_sprite
	.byte <lemming_lbasher3_sprite,<lemming_lbasher4_sprite
	.byte <lemming_lbasher5_sprite,<lemming_lbasher6_sprite
	.byte <lemming_lbasher7_sprite,<lemming_lbasher8_sprite
lbash_sprite_h:
	.byte >lemming_lbasher1_sprite,>lemming_lbasher2_sprite
	.byte >lemming_lbasher3_sprite,>lemming_lbasher4_sprite
	.byte >lemming_lbasher5_sprite,>lemming_lbasher6_sprite
	.byte >lemming_lbasher7_sprite,>lemming_lbasher8_sprite


rmine_sprite_l:
	.byte <lemming_rmine1_sprite,<lemming_rmine2_sprite
	.byte <lemming_rmine3_sprite,<lemming_rmine4_sprite
	.byte <lemming_rmine5_sprite,<lemming_rmine6_sprite
	.byte <lemming_rmine7_sprite,<lemming_rmine8_sprite
rmine_sprite_h:
	.byte >lemming_rmine1_sprite,>lemming_rmine2_sprite
	.byte >lemming_rmine3_sprite,>lemming_rmine4_sprite
	.byte >lemming_rmine5_sprite,>lemming_rmine6_sprite
	.byte >lemming_rmine7_sprite,>lemming_rmine8_sprite

lmine_sprite_l:
	.byte <lemming_lmine1_sprite,<lemming_lmine2_sprite
	.byte <lemming_lmine3_sprite,<lemming_lmine4_sprite
	.byte <lemming_lmine5_sprite,<lemming_lmine6_sprite
	.byte <lemming_lmine7_sprite,<lemming_lmine8_sprite
lmine_sprite_h:
	.byte >lemming_lmine1_sprite,>lemming_lmine2_sprite
	.byte >lemming_lmine3_sprite,>lemming_lmine4_sprite
	.byte >lemming_lmine5_sprite,>lemming_lmine6_sprite
	.byte >lemming_lmine7_sprite,>lemming_lmine8_sprite


rbuild_sprite_l:
	.byte <lemming_rbuild1_sprite,<lemming_rbuild2_sprite
	.byte <lemming_rbuild3_sprite,<lemming_rbuild4_sprite
	.byte <lemming_rbuild5_sprite,<lemming_rbuild6_sprite
	.byte <lemming_rbuild7_sprite,<lemming_rbuild8_sprite
rbuild_sprite_h:
	.byte >lemming_rbuild1_sprite,>lemming_rbuild2_sprite
	.byte >lemming_rbuild3_sprite,>lemming_rbuild4_sprite
	.byte >lemming_rbuild5_sprite,>lemming_rbuild6_sprite
	.byte >lemming_rbuild7_sprite,>lemming_rbuild8_sprite

lbuild_sprite_l:
	.byte <lemming_lbuild1_sprite,<lemming_lbuild2_sprite
	.byte <lemming_lbuild3_sprite,<lemming_lbuild4_sprite
	.byte <lemming_lbuild5_sprite,<lemming_lbuild6_sprite
	.byte <lemming_lbuild7_sprite,<lemming_lbuild8_sprite
lbuild_sprite_h:
	.byte >lemming_lbuild1_sprite,>lemming_lbuild2_sprite
	.byte >lemming_lbuild3_sprite,>lemming_lbuild4_sprite
	.byte >lemming_lbuild5_sprite,>lemming_lbuild6_sprite
	.byte >lemming_lbuild7_sprite,>lemming_lbuild8_sprite


rpullup_sprite_l:
	.byte <lemming_rpullup1_sprite,<lemming_rpullup2_sprite
	.byte <lemming_rpullup3_sprite,<lemming_rpullup4_sprite
	.byte <lemming_rpullup5_sprite,<lemming_rpullup6_sprite
	.byte <lemming_rpullup7_sprite,<lemming_rpullup8_sprite
rpullup_sprite_h:
	.byte >lemming_rpullup1_sprite,>lemming_rpullup2_sprite
	.byte >lemming_rpullup3_sprite,>lemming_rpullup4_sprite
	.byte >lemming_rpullup5_sprite,>lemming_rpullup6_sprite
	.byte >lemming_rpullup7_sprite,>lemming_rpullup8_sprite

lpullup_sprite_l:
	.byte <lemming_lpullup1_sprite,<lemming_lpullup2_sprite
	.byte <lemming_lpullup3_sprite,<lemming_lpullup4_sprite
	.byte <lemming_lpullup5_sprite,<lemming_lpullup6_sprite
	.byte <lemming_lpullup7_sprite,<lemming_lpullup8_sprite
lpullup_sprite_h:
	.byte >lemming_lpullup1_sprite,>lemming_lpullup2_sprite
	.byte >lemming_lpullup3_sprite,>lemming_lpullup4_sprite
	.byte >lemming_lpullup5_sprite,>lemming_lpullup6_sprite
	.byte >lemming_lpullup7_sprite,>lemming_lpullup8_sprite


rshrug_sprite_l:
	.byte <lemming_rshrug1_sprite,<lemming_rshrug2_sprite
	.byte <lemming_shrug3_sprite,<lemming_shrug4_sprite
	.byte <lemming_shrug5_sprite,<lemming_shrug6_sprite
	.byte <lemming_shrug7_sprite,<lemming_shrug8_sprite
rshrug_sprite_h:
	.byte >lemming_rshrug1_sprite,>lemming_rshrug2_sprite
	.byte >lemming_shrug3_sprite,>lemming_shrug4_sprite
	.byte >lemming_shrug5_sprite,>lemming_shrug6_sprite
	.byte >lemming_shrug7_sprite,>lemming_shrug8_sprite

lshrug_sprite_l:
	.byte <lemming_lshrug1_sprite,<lemming_lshrug2_sprite
	.byte <lemming_shrug3_sprite,<lemming_shrug4_sprite
	.byte <lemming_shrug5_sprite,<lemming_shrug6_sprite
	.byte <lemming_shrug7_sprite,<lemming_shrug8_sprite
lshrug_sprite_h:
	.byte >lemming_lshrug1_sprite,>lemming_lshrug2_sprite
	.byte >lemming_shrug3_sprite,>lemming_shrug4_sprite
	.byte >lemming_shrug5_sprite,>lemming_shrug6_sprite
	.byte >lemming_shrug7_sprite,>lemming_shrug8_sprite


