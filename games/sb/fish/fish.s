; Fishing Challenge '91
;
; "Are you asking for some sort of early-90s fishing challenge????"
;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


; NOTES
;	page1= $2000-$5fff
;	code = $6000-$bfff


div7_table     = $400
mod7_table     = $500
hposn_high     = $600
hposn_low      = $700


fish_start:

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

	; fish = 4225 bytes  load at $D000 - $E0FF
	; boat = 4966 bytes  load at $E100 - $F4FF

	lda	#<sound_data_fish
	sta	ZX0_src
	lda	#>sound_data_fish
	sta	ZX0_src+1

	lda	#$D0

	jsr	full_decomp

	lda	#<sound_data_boat
	sta	ZX0_src
	lda	#>sound_data_boat
	sta	ZX0_src+1

	lda	#$E1

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


wait_at_tile:
	lda	KEYPRESS
	bpl	wait_at_tile

	bit	KEYRESET

	;===================
	; print directions
	;===================


	;===================
	; setup game
	;===================

	;==========================
	; Load Background
	;===========================

load_background:

	lda	#<bg_data
	sta	ZX0_src
	lda	#>bg_data
	sta	ZX0_src+1

	lda	#$20

	jsr	full_decomp

	lda	#<bg_data
	sta	ZX0_src
	lda	#>bg_data
	sta	ZX0_src+1

	lda	#$40

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

	jmp	main_loop


title_data:
	.incbin "graphics/fish_title.hgr.zx02"

sound_data_fish:
	.incbin "sounds/fish.btc.zx02"
sound_data_boat:
	.incbin "sounds/get_in_boat.btc.zx02"


	; start at least 8k in?

	;==========================
	; main loop
	;===========================
main_loop:

.if 0

	jsr	flip_page



	;========================
	; copy over background
	;========================
reset_loop:

	lda	FRAME
	and	#$2
	beq	odd_bg
even_bg:
	lda	#$A0
	bne	do_bg
odd_bg:
	lda	#$80
do_bg:
	jsr	hgr_copy
.endif

	inc	FRAME

	;==========================
	; copy over proper boat
	;==========================

	;===========================
	; draw strong bad
	;===========================
.if 0
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
.endif

	;==========================
	; update score?
	;===========================


	;============================
	; draw fish
	;============================

	;============================
	; play sound
	;============================

;	ldy	#5
;	jsr	play_asplode


	;===========================
	; check keypress
	;===========================

check_keypress:
	lda     KEYPRESS
	bpl	done_keyboard_check

	bit     KEYRESET		; clear the keyboard strobe

	; clear high bit
	and	#$7f

	and	#$df			; convert lowercase to upper

	cmp	#27		; escape
	beq	done_game

	cmp	#'J'		; jig
	beq	do_jig
	cmp	#'L'		; lure
	beq	do_lure

done_keyboard_check:
	jmp	main_loop


do_jig:
	jsr	play_boat		; `come on and get in the boat'
;	lda	PLAYER_X
;	beq	no_more_left
;	dec	PLAYER_X
no_more_gire:
	jmp	main_loop

do_lure:
	jsr	play_fish		; 'fish'
;	lda	PLAYER_X
;	cmp	#28			; bge
;	bcs	no_more_right
;	inc	PLAYER_X
no_more_lure:
	jmp	main_loop

	;==========================
	; done game
	;==========================

done_game:
	lda	#0
really_done_game:
	sta	WHICH_LOAD
	rts


.if 0

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
.endif


bg_data:
	.incbin "graphics/fish_bg.hgr.zx02"

	.include	"hgr_tables.s"
	.include	"zx02_optim.s"

	.include	"hgr_sprite_big.s"
	.include	"hgr_copy_fast.s"
	.include	"audio.s"
	.include	"play_sounds.s"

;	.include	"asplode_graphics/sb_sprites.inc"

.if 0
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


.endif
