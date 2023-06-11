	;==============================
	; do the asplode routine
	;==============================
	; should move head to center
	; player explosion happens
	; do the "YOUR HEAD A SPLODE" animation
	; try to interleave the sound
	; in theory the background should pulse too but
	;	that might be too much
do_asplode:

	lda	#0
	sta	FRAME

	lda	#16
	sta	STRONGBAD_X

asplode_loop:
	;===================
	; copy background
	;===================

	jsr	hgr_copy

	;==========================
	; draw big head
	;==========================

	ldx	HEAD_DAMAGE
	lda	head_sprites_l,X
	sta	INL
	lda	head_sprites_h,X
	sta	INH
	lda	#16				; center
	sta	SPRITE_X
	lda	#36
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	;==========================
	; draw new sprite
	;==========================

	ldx	FRAME
	lda	asplode_sprite_l,X
	sta	INL
	lda	asplode_sprite_h,X
	sta	INH


	cpx	#11
	bcs	use_hardcoded_x

	ldy	BULLET_X
	dey
	tya

	jmp	asplode_it_x

use_hardcoded_x:
	lda	asplode_sprite_x,X
asplode_it_x:
	sta	SPRITE_X

	lda	asplode_sprite_y,X
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	ldx	FRAME
	cpx	#17
	bcc	done_extra_sprites

	;==========================
	; draw your
	;==========================

	lda	#<your_sprite
	sta	INL
	lda	#>your_sprite
	sta	INH
	lda	#8
	sta	SPRITE_X
	lda	#133
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	ldx	FRAME
	cpx	#23
	bcc	done_extra_sprites

	;==========================
	; draw head
	;==========================

	lda	#<head_sprite
	sta	INL
	lda	#>head_sprite
	sta	INH
	lda	#16
	sta	SPRITE_X
	lda	#133
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	ldx	FRAME
	cpx	#29
	bcc	done_extra_sprites

	;==========================
	; draw A
	;==========================

	lda	#<a_sprite
	sta	INL
	lda	#>a_sprite
	sta	INH
	lda	#22
	sta	SPRITE_X
	lda	#133
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

done_extra_sprites:



	jsr	flip_page


	ldx	FRAME


sound_check_explode:
	cpx	#2
	bne	sound_check_your
	; play sound
	ldy	#7
	bne	do_play_asplode		; bra

sound_check_your:
	cpx	#16
	bne	sound_check_head
	; play sound
	ldy	#0
	beq	do_play_asplode		; bra

sound_check_head:
	cpx	#22
	bne	sound_check_a
	ldy	#1
	bne	do_play_asplode
sound_check_a:
	cpx	#28
	bne	sound_check_splode
	ldy	#2
	bne	do_play_asplode

sound_check_splode:
	cpx	#34
	bne	sound_check_done
	ldy	#3

do_play_asplode:
	jsr	play_asplode

sound_check_done:

	inc	FRAME
	lda	FRAME
	cmp	#35
	bcs	done_asplode_head

	jmp	asplode_loop

done_asplode_head:

	lda	#20
	jsr	long_wait	; tail call

	; reset things

	lda	#0
	sta	SHIELD_POSITION
	sta	BULLET_Y
	sta	SHIELD_COUNT

	lda	#1
	sta	BULLET_YDIR

	bit	KEYRESET	; clear any keypresses during asplode

	rts


asplode_sprite_l:
	; begining explosion
	.byte	<asploding1_sprite	; 0
	.byte	<asploding1_sprite	; 1
	.byte	<asploding2_sprite	; 2
	.byte	<asploding3_sprite	; 3
	.byte	<asploding4_sprite	; 4
	.byte	<asploding2_sprite	; 5
	.byte	<asploding3_sprite	; 6
	.byte	<asploding4_sprite	; 7
	.byte	<asploding2_sprite	; 8
	.byte	<asploding3_sprite	; 9
	.byte	<asploding4_sprite	; 10
	; your
	.byte	<your_sm_sprite		; 11
	.byte	<your_sm_sprite		; 12
	.byte	<your_med_sprite	; 13
	.byte	<your_med_sprite	; 14
	.byte	<your_sprite		; 15
	.byte	<your_sprite		; 16
	; head
	.byte	<head_sm_sprite		; 17
	.byte	<head_sm_sprite		; 18
	.byte	<head_med_sprite	; 19
	.byte	<head_med_sprite	; 20
	.byte	<head_sprite		; 21
	.byte	<head_sprite		; 22
	; a
	.byte	<a_sm_sprite		; 23
	.byte	<a_sm_sprite		; 24
	.byte	<a_med_sprite		; 25
	.byte	<a_med_sprite		; 26
	.byte	<a_sprite		; 27
	.byte	<a_sprite		; 28
	; splode
	.byte	<splode_sm_sprite	; 29
	.byte	<splode_sm_sprite	; 30
	.byte	<splode_med_sprite	; 31
	.byte	<splode_med_sprite	; 32
	.byte	<splode_sprite		; 33
	.byte	<splode_sprite		; 34

asplode_sprite_h:
	.byte	>asploding1_sprite
	.byte	>asploding1_sprite
	.byte	>asploding2_sprite
	.byte	>asploding3_sprite
	.byte	>asploding4_sprite
	.byte	>asploding2_sprite
	.byte	>asploding3_sprite
	.byte	>asploding4_sprite
	.byte	>asploding2_sprite
	.byte	>asploding3_sprite
	.byte	>asploding4_sprite
	; your
	.byte	>your_sm_sprite
	.byte	>your_sm_sprite
	.byte	>your_med_sprite
	.byte	>your_med_sprite
	.byte	>your_sprite
	.byte	>your_sprite
	; head
	.byte	>head_sm_sprite
	.byte	>head_sm_sprite
	.byte	>head_med_sprite
	.byte	>head_med_sprite
	.byte	>head_sprite
	.byte	>head_sprite
	; a
	.byte	>a_sm_sprite
	.byte	>a_sm_sprite
	.byte	>a_med_sprite
	.byte	>a_med_sprite
	.byte	>a_sprite
	.byte	>a_sprite
	; splode
	.byte	>splode_sm_sprite
	.byte	>splode_sm_sprite
	.byte	>splode_med_sprite
	.byte	>splode_med_sprite
	.byte	>splode_sprite
	.byte	>splode_sprite

asplode_sprite_x:
	.byte	19		; FIXME: adjust for current pos
	.byte	19
	.byte	19
	.byte	19
	.byte	19
	.byte	19
	.byte	19
	.byte	19
	.byte	19
	.byte	19
	.byte	19
	; your
	.byte	18
	.byte	17
	.byte	14
	.byte	12
	.byte	9
	.byte	8
	; head
	.byte	18
	.byte	18
	.byte	17
	.byte	17
	.byte	16
	.byte	16
	; a
	.byte	19
	.byte	20
	.byte	20
	.byte	21
	.byte	22
	.byte	22
	; splode
	.byte	18
	.byte	20
	.byte	20
	.byte	21
	.byte	22
	.byte	24

asplode_sprite_y:
	.byte	150
	.byte	150
	.byte	150
	.byte	150
	.byte	150
	.byte	150
	.byte	150
	.byte	150
	.byte	150
	.byte	150
	.byte	150
	; your
	.byte 80
	.byte 90
	.byte 100
	.byte 111
	.byte 122
	.byte 133
	; head
	.byte 80
	.byte 90
	.byte 100
	.byte 111
	.byte 122
	.byte 133
	; a
	.byte 80
	.byte 90
	.byte 100
	.byte 111
	.byte 122
	.byte 133
	; splode
	.byte 80
	.byte 90
	.byte 100
	.byte 111
	.byte 122
	.byte 133


long_wait:
	ldx	#10
long_wait_loop:
	lda	#255
	jsr	WAIT
	dex
	bne	long_wait_loop
	rts

