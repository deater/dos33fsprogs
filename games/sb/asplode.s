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

; things missing from real game
;    some of the animations (both of player and head being destroyed)
;    there are some pauses after things happen
;

; Notes
;   collision detection on shield should really be 16 bit, some things
;	get past the shield check but then collide on the next frame
;   sprite routines cheat in a lot of ways. assume blue/orange
;       assume X only in 3.5 pixel offsets
;       do minimal transparency using black0

; Challenges:
;   moving such huge sprites
;   fitting all in RAM
;   sound


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

	;===================
	; set up variables

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

	;==========================
	; main loop
	;===========================
main_loop:

	jsr	flip_page

	;========================
	; copy over background
	;========================
reset_loop:
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

	ldx	HEAD_DAMAGE
	lda	head_sprites_l,X
	sta	INL
	lda	head_sprites_h,X
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
	adc	BULLET_X_VEL_L
	sta	BULLET_X_L
	lda	BULLET_X
	adc	BULLET_X_VEL
	sta	BULLET_X

	;========================
	; bounce off "walls"
	; in reality just bounce if <9 or > 29?

	lda	BULLET_X
	cmp	#29
	bcs	walls_out	; bge
	cmp	#9
	bcs	walls_good	; bge

walls_out:

	; flip X direction

	sec
	lda	#0
	sbc	BULLET_X_VEL_L
	sta	BULLET_X_VEL_L
	lda	#0
	sbc	BULLET_X_VEL
	sta	BULLET_X_VEL


walls_good:

	; move bullet Y

	lda	BULLET_YDIR
	bne	bullet_down

bullet_up:
	dec	BULLET_Y
	jmp	bullet_y_done

bullet_down:
	inc	BULLET_Y
bullet_y_done:

	; see if off end

	lda	BULLET_Y
	cmp	#17
	bcc	bullet_still_good

	; reset to top

	lda	#0
	sta	BULLET_Y
bullet_still_good:

	;==========================
	; check bullet collisions
	;===========================

	;===========================
	; check player
	;   if (bullet_x > player_x+2) &&
	;	(bullet_x<player_x+6)
	; if 2 < bx - px < 6 ???

	; 012345678
	; b-p
	; --------
	; 8765432101234567890123456
	; p-b      ----------------
	; 8765432101234567890123456
	; NNNNNNNNNNYYYYNNNNNNNNNNN
	; XXXXXXXXPPOOOOPPXXXXXXXXX

	; only if BULLET_Y=16?

	lda	BULLET_Y
	cmp	#16
	bne	skip_check_player_collide
check_player_collide:
	sec
	lda	BULLET_X
	sbc	PLAYER_X
	cmp	#2
	bcc	skip_check_player_collide	; blt
	cmp	#8
	bcs	skip_check_player_collide

	jmp	asplode_asplode

skip_check_player_collide:

	;===========================
	; check shield collide

	; only if Y=15 and YDIR=1
check_shield_collide:
	lda	BULLET_Y
	cmp	#15
	beq	do_check_shields
	jmp	skip_check_shield_collide

do_check_shields:
	; sorta-random number in X
	ldx	FRAME
	lda	$6000,X		; from source code
	and	#$3
	tax

	lda	SHIELD_POSITION
	beq	skip_check_shield_collide	; 0 means DOWN

shields_up:
	; our rules
	;  SHIELD_X_VEL maxes at 1/-1
	;    hitting shield left subs random $10/$20/$20/$40
	;    hitting shield right adds random $10/$20/$20/$40
	;    hitting shield center adds/subs random $10/$20

	cmp	#SHIELD_UP_RIGHT
	beq	check_hit_shield_right
	cmp	#SHIELD_UP_CENTER
	beq	check_hit_shield_center

check_hit_shield_left:

	sec
	lda	BULLET_X
	sbc	PLAYER_X
	cmp	#1
	bcc	skip_check_shield_collide	; blt
	cmp	#7
	bcs	skip_check_shield_collide	; bge

hit_shield_left:
	sec
	lda	BULLET_X_VEL_L
	sbc	bullet_vals,X
	sta	BULLET_X_VEL_L
	lda	BULLET_X_VEL
	sbc	#0
	sta	BULLET_X_VEL
	jmp	done_hit_shield


check_hit_shield_right:

	sec
	lda	BULLET_X
	sbc	PLAYER_X
	cmp	#4
	bcc	skip_check_shield_collide	; blt
	cmp	#10
	bcs	skip_check_shield_collide


hit_shield_right:
	clc
	lda	BULLET_X_VEL_L
	adc	bullet_vals,X
	sta	BULLET_X_VEL_L
	lda	BULLET_X_VEL
	adc	#0
	sta	BULLET_X_VEL
	jmp	done_hit_shield

check_hit_shield_center:

	sec
	lda	BULLET_X
	sbc	PLAYER_X
	cmp	#2
	bcc	skip_check_shield_collide	; blt
	cmp	#8
	bcs	skip_check_shield_collide	; bge

hit_shield_center:

	cpx	#1
	bcs	center_left

	clc
	lda	BULLET_X_VEL_L
	adc	bullet_vals_center,X
	sta	BULLET_X_VEL_L
	lda	BULLET_X_VEL
	adc	#0
	sta	BULLET_X_VEL
	jmp	done_hit_shield

center_left:
	sec
	lda	BULLET_X_VEL_L
	sbc	bullet_vals_center,X
	sta	BULLET_X_VEL_L
	lda	BULLET_X_VEL
	sbc	#0
	sta	BULLET_X_VEL
;	jmp	done_hit_shield


done_hit_shield:
	; max at $1/$00 or $FF/$00


	; flip ydir

	lda	#0
	sta	BULLET_YDIR

	; play sound

	ldy	#5
	jsr	play_asplode



skip_check_shield_collide:

	;===========================
	; check head

	; only if Y=0 and YDIR=0

	lda	BULLET_Y
	bne	done_check_head

	lda	BULLET_YDIR
	bne	done_check_head

check_head_collide:

	sec
	lda	BULLET_X
	sbc	STRONGBAD_X
	cmp	#0
	bcc	skip_check_head_collide		; blt
	cmp	#6
	bcs	skip_check_head_collide

	inc	HEAD_DAMAGE			; increase head damage
	lda	HEAD_DAMAGE
	cmp	#5
	bcc	skip_check_head_collide

	lda	#0				; reset
	sta	HEAD_DAMAGE

skip_check_head_collide:
	lda	#1
	sta	BULLET_YDIR	; bounce


done_check_head:


	;=====================
	; play bullet sound


	; if Y=1 and YDIR=1

	lda	BULLET_Y
	cmp	#1
	bne	no_ysound

	lda	BULLET_YDIR
	beq	no_ysound

	ldy	#6
	jsr	play_asplode
no_ysound:

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

	and	#$df			; convert lowercase to upper

;	cmp	#'Q'
;	beq	done_game

	cmp	#27		; escape
	beq	done_game

	cmp	#'A'		; shield left
	beq	shield_left
	cmp	#'S'		; shield center
	beq	shield_center
	cmp	#'D'		; shield right
	beq	shield_right

;	cmp	#'X'
;	beq	asplode_asplode

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
	lda	SHIELD_POSITION
	bne	done_adjust_shield
	lda	#SHIELD_UP_LEFT
	bne	adjust_shield
shield_center:
	lda	SHIELD_POSITION
	bne	done_adjust_shield
	lda	#SHIELD_UP_CENTER
	bne	adjust_shield
shield_right:
	lda	SHIELD_POSITION
	bne	done_adjust_shield
	lda	#SHIELD_UP_RIGHT
adjust_shield:
	sta	SHIELD_POSITION
	lda	#4
	sta	SHIELD_COUNT
done_adjust_shield:
	jmp	main_loop

asplode_asplode:

	jsr	do_asplode

	jmp	reset_loop

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


.include "asplode_head.s"

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
	.incbin "asplode_sound/asplode_sound.btc.zx02"

shield_sprites_l:
	.byte <player_sprite,<shield_left_sprite
	.byte <shield_center_sprite,<shield_right_sprite

shield_sprites_h:
	.byte >player_sprite,>shield_left_sprite
	.byte >shield_center_sprite,>shield_right_sprite


head_sprites_l:
	.byte <big_head0_sprite,<big_head1_sprite,<big_head2_sprite
	.byte <big_head3_sprite,<big_head4_sprite

head_sprites_h:
	.byte >big_head0_sprite,>big_head1_sprite,>big_head2_sprite
	.byte >big_head3_sprite,>big_head4_sprite

y_positions:
; 90 to 160 roughly?  Let's say 64?
; have 16 positions?  4 each?

; can probably optimize this

bullet_sprite_l:
.byte  <bullet0_sprite, <bullet1_sprite, <bullet2_sprite, <bullet3_sprite
.byte  <bullet4_sprite, <bullet5_sprite, <bullet6_sprite, <bullet7_sprite
.byte  <bullet8_sprite, <bullet9_sprite,<bullet10_sprite,<bullet11_sprite
.byte <bullet12_sprite,<bullet13_sprite,<bullet14_sprite,<bullet15_sprite
.byte <bullet_done_sprite

bullet_sprite_h:
.byte  >bullet0_sprite, >bullet1_sprite, >bullet2_sprite, >bullet3_sprite
.byte  >bullet4_sprite, >bullet5_sprite, >bullet6_sprite, >bullet7_sprite
.byte  >bullet8_sprite, >bullet9_sprite,>bullet10_sprite,>bullet11_sprite
.byte >bullet12_sprite,>bullet13_sprite,>bullet14_sprite,>bullet15_sprite
.byte >bullet_done_sprite

bullet_sprite_y:
.byte 83,88,93,98
.byte 103,108,113,118
.byte 123,128,133,138
.byte 143,148,153,158
.byte 163

bullet_vals:
.byte $10,$20,$20,$40

bullet_vals_center:
.byte $20,$00,$00,$20

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
