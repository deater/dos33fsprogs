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


draw_common:
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift

done_draw_lemming:

	inc	CURRENT_LEMMING
	lda	CURRENT_LEMMING
	cmp	#MAX_LEMMINGS
;	beq	really_done_draw_lemming
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
	.byte	0 ; <(draw_climbing_sprite-1)
	.byte	0 ; <(draw_bashing_sprite-1)
	.byte	<(draw_stopping_sprite-1)
	.byte	0 ; <(draw_mining_sprite-1)
	.byte	0 ; <(draw_building_sprite-1)
	.byte	0 ; <(draw_shrugging_sprite-1)
	.byte	0 ; <(draw_pullup_sprite-1)

draw_lemming_jump_h:
	.byte	>(draw_falling_sprite-1)
	.byte	>(draw_walking_sprite-1)
	.byte	>(draw_digging_sprite-1)
	.byte	>(draw_exploding_sprite-1)
	.byte	>(draw_particles-1)
	.byte	>(draw_splatting_sprite-1)
	.byte	>(draw_floating_sprite-1)
	.byte	0 ; >(draw_climbing_sprite-1)
	.byte	0 ; >(draw_bashing_sprite-1)
	.byte	>(draw_stopping_sprite-1)
	.byte	0 ; >(draw_mining_sprite-1)
	.byte	0 ; >(draw_building_sprite-1)
	.byte	0 ; >(draw_shrugging_sprite-1)
	.byte	0 ; >(draw_pullup_sprite-1)


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
	jmp	draw_common


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

	jmp	draw_common


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

	jmp	draw_common


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

	jsr	hgr_hlin_page_toggle		; toggle to page2

	ldx	#0
	sta	HGR_COLOR

	ldy	CURRENT_LEMMING

	; line from (x,a) to (x+y,a)
	lda	lemming_x,Y
	asl
	adc	lemming_x,Y
	asl
	adc	lemming_x,Y		; multiply by 7
	tax
	pha

	lda	lemming_y,Y
	clc
	adc	#9

	ldy	#7

	jsr	hgr_hlin

	; line from (x,a) to (x+y,a)
	pla
	tax

	ldy	CURRENT_LEMMING
	lda	lemming_y,Y
	ldy	#7
	clc
	adc	#10
	jsr	hgr_hlin


	jsr	hgr_hlin_page_toggle		; toggle back to page1

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
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift

	jmp	done_draw_lemming

	;====================
	; draw splatting
	;====================

draw_splatting_sprite:

	;==========================
	; Handle splatting
	;==========================

	; moved to make room
handle_splatting:

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
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift

	jmp	done_draw_lemming



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
	jmp	draw_common











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

