; Strongbad Zone
;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>

; some notes on the engine from the original
;	bullet moving is not 3d in any way, it's just 2D
;	there are distinct Y locations with different sized sprites
;	X velocity starts at 3
;		hitting shield left, subs random 0..5
;		hitting shield right, adds random 0..5
;		hitting shield center, adds random -0.5 .. 0.5
;	bounces off side walls roughly at same X as back walls
;		doesn't even try to adjust for Y
;	if it hits back wall, it reflects back
;	if it misses you, makes small explosion, starts again at far wall
;		with same X as it went off screen with

.include "zp.inc"
.include "hardware.inc"

div7_table     = $400
mod7_table     = $500
hposn_high     = $600
hposn_low      = $700


strongbadzone_start:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	;====================
	; set up tables
	;====================

	lda	#$20
	sta	HGR_PAGE
	jsr	hgr_make_tables


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
	;==========================
	; Load Title
	;===========================

load_title:
	lda	#<title_data
	sta	ZX0_src
	lda	#>title_data
	sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp

	; load to page2 for color cycle

	lda	#<title_data
	sta	ZX0_src
	lda	#>title_data
	sta	ZX0_src+1

	lda	#$40

	jsr	full_decomp

title_cycle_loop:

	jsr	cycle_colors
	inc	FRAME


	lda	KEYPRESS
	bpl	title_cycle_loop

	bit	KEYRESET


	;===================
	; setup game
	;===================

	;==========================
	; Load Background
	;===========================

load_background:

	; size in ldsizeh:ldsizel (f1/f0)

	lda	#<comp_data
	sta	ZX0_src
	lda	#>comp_data
	sta	ZX0_src+1


	lda	#$A0


	jsr	full_decomp

	lda	#16
	sta	STRONGBAD_X
	sta	PLAYER_X

	lda	#1
	sta	STRONGBAD_DIR

	lda	#SHIELD_DOWN
	sta	SHIELD_POSITION
	sta	SHIELD_COUNT

	lda	#0
	sta	BULLET_X_L
	sta	BULLET_X_VEL

	lda	#20
	sta	BULLET_X
	lda	#0
	sta	BULLET_Y

	;==========================
	; main loop
	;===========================
main_loop:

	jsr	flip_page

	;========================
	; copy over background
	;========================

	jsr	hgr_copy


	inc	FRAME

	;==========================
	; adjust shield
	;==========================

	lda	SHIELD_COUNT
	beq	done_shield_count

	dec	SHIELD_COUNT
	bne	done_shield_count

	lda	#SHIELD_DOWN		; put shield down if timeout
	sta	SHIELD_POSITION

done_shield_count:

	;===========================
	; move head
	;===========================

	lda	FRAME
	and	#$3
	bne	no_move_head

	lda	STRONGBAD_X
	cmp	#21
	bcs	reverse_head_dir
	cmp	#12
	bcs	no_reverse_head_dir
reverse_head_dir:
	lda	STRONGBAD_DIR
	eor	#$FF
	sta	STRONGBAD_DIR
	inc	STRONGBAD_DIR

no_reverse_head_dir:

	clc
	lda	STRONGBAD_X
	adc	STRONGBAD_DIR
	sta	STRONGBAD_X

no_move_head:



	;==========================
	; draw head
	;===========================

	lda	#<big_head_sprite
	sta	INL
	lda	#>big_head_sprite
	sta	INH
	lda	STRONGBAD_X
	sta	SPRITE_X
	lda	#36
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	;==========================
	; move bullet
	;===========================

	; 16 bit add

	clc
	lda	BULLET_X_L
	adc	BULLET_X_VEL
	sta	BULLET_X_L
	lda	BULLET_X
	adc	#0
	sta	BULLET_X

	; TODO: bounce off walls

	inc	BULLET_Y
	lda	BULLET_Y
	cmp	#15
	bcc	bullet_still_good

	; new bullet position
	; FIXME: better

	lda	#0
	sta	BULLET_Y
bullet_still_good:

	;==========================
	; draw bullet
	;===========================

	ldy	BULLET_Y
	lda	bullet_sprite_l,Y
	sta	INL
	lda	bullet_sprite_h,Y
	sta	INH

	lda	BULLET_X
	sta	SPRITE_X

	lda	bullet_sprite_y,Y
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	;==========================
	; draw player
	;===========================

	ldx	SHIELD_POSITION
	lda	shield_sprites_l,X
	sta	INL
	lda	shield_sprites_h,X
	sta	INH
	lda	PLAYER_X
	sta	SPRITE_X
	lda	#138
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

check_keypress:
	lda     KEYPRESS
	bpl	done_keyboard_check

	bit     KEYRESET		; clear the keyboard strobe

	; clear high bit
	and	#$7f

	; FIXME: adjust for lowercase too
	cmp	#'Q'
	beq	done_game

	cmp	#27		; escape
	beq	done_game

	cmp	#'A'		; shield left
	beq	shield_left
	cmp	#'S'		; shield center
	beq	shield_center
	cmp	#'D'		; shield right
	beq	shield_right

	cmp	#'X'
	beq	asplode_asplode

	cmp	#8		; left
	beq	move_left

        cmp	#$15
        beq	move_right	; right


done_keyboard_check:
	jmp	main_loop

move_left:
	lda	PLAYER_X
	beq	no_more_left
	dec	PLAYER_X
no_more_left:
	jmp	main_loop

move_right:
	lda	PLAYER_X
	cmp	#28			; bge
	bcs	no_more_right
	inc	PLAYER_X
no_more_right:
	jmp	main_loop

shield_left:
	lda	#SHIELD_UP_LEFT
	bne	adjust_shield
shield_center:
	lda	#SHIELD_UP_CENTER
	bne	adjust_shield
shield_right:
	lda	#SHIELD_UP_RIGHT
adjust_shield:
	sta	SHIELD_POSITION
	lda	#5
	sta	SHIELD_COUNT
	jmp	main_loop

asplode_asplode:

	jsr	do_asplode

	jmp	main_loop

	;==========================
	; done game
	;==========================

done_game:
	lda	#0
	sta	WHICH_LOAD
	rts




wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer
	rts


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

	;===================
	; copy background
	;===================

	jsr	hgr_copy

	;==========================
	; draw head
	;==========================

	lda	#<big_head_sprite
	sta	INL
	lda	#>big_head_sprite
	sta	INH
	lda	#16				; center
	sta	SPRITE_X
	lda	#36
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big


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

	;==========================
	; draw head
	;==========================

	lda	#<head_sprite
	sta	INL
	lda	#>head_sprite
	sta	INH
	lda	#15
	sta	SPRITE_X
	lda	#133
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	;==========================
	; draw A
	;==========================

	lda	#<a_sprite
	sta	INL
	lda	#>a_sprite
	sta	INH
	lda	#21
	sta	SPRITE_X
	lda	#133
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	;==========================
	; draw SPLODE
	;==========================

	lda	#<splode_sprite
	sta	INL
	lda	#>splode_sprite
	sta	INH
	lda	#23
	sta	SPRITE_X
	lda	#133
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	; play sound
;	jsr	play_asplode

	jsr	flip_page

	jsr	wait_until_keypress

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



	.include	"hgr_tables.s"
	.include	"zx02_optim.s"
	.include	"hgr_sprite_big.s"
	.include	"cycle_colors.s"
	.include	"hgr_copy_fast.s"
	.include	"audio.s"
	.include	"play_asplode.s"

	.include	"asplode_graphics/sb_sprites.inc"

title_data:
	.incbin "asplode_graphics/sb_title.hgr.zx02"

comp_data:
	.incbin "asplode_graphics/sb_zone.hgr.zx02"

sound_data:
	.incbin "asplode_sound/asplode.btc.zx02"

shield_sprites_l:
	.byte <player_sprite,<shield_left_sprite
	.byte <shield_center_sprite,<shield_right_sprite

shield_sprites_h:
	.byte >player_sprite,>shield_left_sprite
	.byte >shield_center_sprite,>shield_right_sprite


y_positions:
; 90 to 160 roughly?  Let's say 64?
; have 16 positions?  4 each?

; can probably optimize this

bullet_sprite_l:
.byte  <bullet0_sprite, <bullet1_sprite, <bullet2_sprite, <bullet3_sprite
.byte  <bullet4_sprite, <bullet5_sprite, <bullet6_sprite, <bullet7_sprite
.byte  <bullet8_sprite, <bullet9_sprite,<bullet10_sprite,<bullet11_sprite
.byte <bullet12_sprite,<bullet13_sprite,<bullet14_sprite,<bullet15_sprite

bullet_sprite_h:
.byte  >bullet0_sprite, >bullet1_sprite, >bullet2_sprite, >bullet3_sprite
.byte  >bullet4_sprite, >bullet5_sprite, >bullet6_sprite, >bullet7_sprite
.byte  >bullet8_sprite, >bullet9_sprite,>bullet10_sprite,>bullet11_sprite
.byte >bullet12_sprite,>bullet13_sprite,>bullet14_sprite,>bullet15_sprite

bullet_sprite_y:
.byte 90,94,98,102
.byte 106,110,114,118
.byte 122,126,130,134
.byte 138,142,146,150

; original
; 1 =  6
; 2 = 12
; 3 = 18
; 4 = 25
; 5 = 32
; 6 = 38
; 7 = 44
; 8 = 50
; 9 = 57
; 10= 63
; 11= 70
; 12= 77
; 13= 82
; 14= 89
; 15= 95
; 27= 167 (peak)
; 30= 148
; 31= 139

; 9,5 -> 22,14 = 12x9 roughly.  3 times smaller, 4x3?  2x6?
