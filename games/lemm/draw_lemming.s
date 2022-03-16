	;==================
	;==================
	; erase lemming
	;==================
	;==================
erase_lemming:
	ldy	#0

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
	rts

	;=========================
	;=========================
	; draw lemming
	;=========================
	;=========================
draw_lemming:
	ldy	#0

	lda	lemming_out,Y
	bne	do_draw_countdown

	jmp	done_draw_lemming

do_draw_countdown:
	lda	lemming_exploding,Y
	beq	do_draw_lemming

	ldx	lemming_exploding
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
	ldy	#0
	lda	lemming_status,Y
	cmp	#LEMMING_DIGGING
	beq	draw_digging_sprite
	cmp	#LEMMING_FALLING
	beq	draw_falling_sprite
	cmp	#LEMMING_EXPLODING
	beq	draw_exploding_sprite
	cmp	#LEMMING_PARTICLES
	beq	draw_particles

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

	;====================
	; draw falling
	;====================

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


	;====================
	; draw exploding
	;====================

draw_exploding_sprite:


	jsr	handle_explosion

	jmp	done_draw_lemming

	;====================
	; draw particles
	;====================

draw_particles:

	jsr	handle_particles

	jmp	done_draw_lemming



	;======================
	; digging

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



draw_common:
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift

done_draw_lemming:
	rts


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


handle_particles:
	jsr	hgr_draw_particles

	lda	lemming_frame
	cmp	#16
	bne	still_going

	; partway through make lemming not out
	lda	#0
	sta	lemming_out
	jsr	update_lemmings_out
	lda	#LEVEL_FAIL
	sta	LEVEL_OVER

still_going:




not_done_particle:
	rts


	; moved to make room
handle_explosion:

	lda	lemming_frame,Y
	cmp	#$10
	bcc	exploding_animation
	beq	draw_explosion

start_particles:

	lda	#0
	sta	lemming_frame

	jsr	init_particles

	; erase explosion

	ldy	#0

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


	lda	#LEMMING_PARTICLES
	sta	lemming_status

	rts


draw_explosion:

	; first erase pit in background art

	jsr	hgr_hlin_page_toggle		; toggle to page2

	; line from (x,a) to (x+y,a)
	ldx	lemming_x
	dex
	ldy	#3
	lda	lemming_y
	clc
	adc	#10
	jsr	hgr_hlin

	; line from (x,a) to (x+y,a)
	ldx	lemming_x
	ldy	#1
	lda	lemming_y
	clc
	adc	#11
	jsr	hgr_hlin


	jsr	hgr_hlin_page_toggle		; toggle to page1

	ldy	#0
	lda	#<explosion_sprite
	sta	INL
	lda	#>explosion_sprite
	sta	INH

	ldx	lemming_x,Y
	dex
        stx     XPOS
	lda	lemming_y,Y
	sec
	sbc	#5

;	jmp	draw_common
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
;	jmp	draw_common

done_handle_exploding:
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift

	rts
