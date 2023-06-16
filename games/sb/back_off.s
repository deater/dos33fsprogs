; Strongbad Zone -- Back Off Ladies section
;
; by popular demand.  Too lazy to try to fit it in with the
;	main program so it gets loaded separately
;
; Yet Another HSR project
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

div7_table     = $400
mod7_table     = $500
hposn_high     = $600
hposn_low      = $700


back_off_start:

	;===================
	; set graphics mode
	;===================

	; assume already in graphics mode

	;====================
	; set up tables
	;====================

	; assume tables already there

	;==========================
	; Load Sound
	;===========================

	lda	SOUND_STATUS
	and	#SOUND_IN_LC
	beq	done_load_sound

	; read/write RAM, use $d000 bank1
	bit	$C083
	bit	$C083

	lda	#<sound_data
	sta	ZX0_src
	lda	#>sound_data
	sta	ZX0_src+1

	lda	#$D0

	jsr	full_decomp

	; read ROM/no-write
	bit	$C082


done_load_sound:

	;=================
	; Load Background
	;=================
	; this is tricky as there's not enough room
	; so we are over-writing stuff carefully

load_backgrounds:

	lda	#<bg1_data
	sta	ZX0_src
	lda	#>bg1_data
	sta	ZX0_src+1

	lda	#$A0

	jsr	full_decomp

	;===================
	; set up variables
.if 0
	lda	#16
	sta	STRONGBAD_X
	sta	PLAYER_X

	lda	#1
	sta	STRONGBAD_DIR
	sta	BULLET_YDIR

	lda	#SHIELD_DOWN
	sta	SHIELD_POSITION
	sta	SHIELD_COUNT

	lda	#0
	sta	BULLET_X_L
	sta	BULLET_X_VEL
	sta	HEAD_DAMAGE

	lda	#$80
	sta	BULLET_X_VEL_L

	lda	#20
	sta	BULLET_X
	lda	#0
	sta	BULLET_Y
.endif


	jsr	do_back_off

	;==========================
	; done game
	;==========================

done_game:
	bit	KEYRESET
	jsr	wait_until_keypress

	lda	#0
	sta	WHICH_LOAD
	rts


wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer
	rts


	;==============================
	; do the backoff routine
	;==============================
	; should move head to center
do_back_off:

	lda	#0
	sta	FRAME

	lda	#16
	sta	STRONGBAD_X

back_off_loop:
	;===================
	; copy background
	;===================

	lda	#$a0
	jsr	hgr_copy


	;==========================
	; draw new sprite
	;==========================

	ldx	FRAME
	lda	asplode_sprite_l,X
	sta	INL
	lda	asplode_sprite_h,X
	sta	INH

use_hardcoded_x:
	lda	asplode_sprite_x,X
	sta	SPRITE_X

	lda	asplode_sprite_y,X
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	ldx	FRAME
	cpx	#6
	bcc	done_extra_sprites

	;==========================
	; draw back
	;==========================

	lda	#<back_sprite
	sta	INL
	lda	#>back_sprite
	sta	INH
	lda	#11
	sta	SPRITE_X
	lda	#133
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	ldx	FRAME
	cpx	#12
	bcc	done_extra_sprites

	;==========================
	; draw off
	;==========================

	lda	#<off_sprite
	sta	INL
	lda	#>off_sprite
	sta	INH
	lda	#18
	sta	SPRITE_X
	lda	#133
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

done_extra_sprites:



	jsr	flip_page


	ldx	FRAME

sound_check_back:
	cpx	#5
	bne	sound_check_off
	; play sound
	ldy	#0
	beq	do_play_asplode		; bra

sound_check_off:
	cpx	#11
	bne	sound_check_baby
	ldy	#1
	bne	do_play_asplode

sound_check_baby:
	cpx	#17
	bne	sound_check_done
	ldy	#3

do_play_asplode:
	jsr	play_back_off

sound_check_done:

	inc	FRAME
	lda	FRAME
	cmp	#18
	bcs	done_back_off

	jmp	back_off_loop

done_back_off:

	lda	#20
	jsr	long_wait

	; reset things

	bit	KEYRESET	; clear any keypresses during asplode

	rts


asplode_sprite_l:
	; back
	.byte	<back_sm_sprite		; 11
	.byte	<back_sm_sprite		; 12
	.byte	<back_med_sprite	; 13
	.byte	<back_med_sprite	; 14
	.byte	<back_sprite		; 15
	.byte	<back_sprite		; 16
	; off
	.byte	<off_sm_sprite		; 17
	.byte	<off_sm_sprite		; 18
	.byte	<off_med_sprite		; 19
	.byte	<off_med_sprite		; 20
	.byte	<off_sprite		; 21
	.byte	<off_sprite		; 22
	; baby
	.byte	<baby_sm_sprite		; 29
	.byte	<baby_sm_sprite		; 30
	.byte	<baby_med_sprite	; 31
	.byte	<baby_med_sprite	; 32
	.byte	<baby_sprite		; 33
	.byte	<baby_sprite		; 34

asplode_sprite_h:
	; back
	.byte	>back_sm_sprite
	.byte	>back_sm_sprite
	.byte	>back_med_sprite
	.byte	>back_med_sprite
	.byte	>back_sprite
	.byte	>back_sprite
	; off
	.byte	>off_sm_sprite
	.byte	>off_sm_sprite
	.byte	>off_med_sprite
	.byte	>off_med_sprite
	.byte	>off_sprite
	.byte	>off_sprite
	; baby
	.byte	>baby_sm_sprite
	.byte	>baby_sm_sprite
	.byte	>baby_med_sprite
	.byte	>baby_med_sprite
	.byte	>baby_sprite
	.byte	>baby_sprite

asplode_sprite_x:
	; back
	.byte	18
	.byte	17
	.byte	15
	.byte	14
	.byte	12
	.byte	11
	; off
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	.byte	18
	; baby
	.byte	18
	.byte	19
	.byte	20
	.byte	21	;
	.byte	23
	.byte	24

asplode_sprite_y:
	; back
	.byte 80
	.byte 90
	.byte 100
	.byte 111
	.byte 122
	.byte 133
	; off
	.byte 80
	.byte 90
	.byte 100
	.byte 111
	.byte 122
	.byte 133
	; baby
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


	;==========
	; flip page
	;==========
flip_page:
	lda	DRAW_PAGE
	beq	draw_page2
draw_page1:
	bit	PAGE2
	lda	#0

	beq	done_flip

draw_page2:
	bit	PAGE1
	lda	#$20

done_flip:
	sta	DRAW_PAGE

	rts



	.include	"hgr_sprite_big.s"
	.include	"hgr_copy_fast.s"
	.include	"audio.s"
	.include	"play_back_off.s"

	.include	"asplode_graphics/bob_sprites.inc"

bg1_data:
	.incbin		"asplode_graphics/bob_bg.hgr.zx02"

sound_data:
	.incbin		"asplode_sound/back_off.btc.zx02"

	.include	"zx02_optim.s"


