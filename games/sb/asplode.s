; Strongbad Zone
;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>


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


	lda	#$80


	jsr	full_decomp

	lda	#16
	sta	STRONGBAD_X
	sta	PLAYER_X

	lda	#1
	sta	STRONGBAD_DIR

	lda	#SHIELD_DOWN
	sta	SHIELD_POSITION
	sta	SHIELD_COUNT

	lda	#20
	sta	BULLET_X
	lda	#90
	sta	BULLET_Y

	;==========================
	; main loop
	;===========================
main_loop:

	;==========
	; flip page
	;==========

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

	lda	#<head_sprite
	sta	INL
	lda	#>head_sprite
	sta	INH
	lda	STRONGBAD_X
	sta	SPRITE_X
	lda	#36
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

	;==========================
	; move bullet
	;===========================

	inc	BULLET_Y
	lda	BULLET_Y
	cmp	#150
	bcc	bullet_still_good

	; new bullet position
	; FIXME: better

	lda	#90
	sta	BULLET_Y
bullet_still_good:

	;==========================
	; draw bullet
	;===========================

	lda	#<bullet0_sprite
	sta	INL
	lda	#>bullet0_sprite
	sta	INH
	lda	BULLET_X
	sta	SPRITE_X
	lda	BULLET_Y
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

	.include	"hgr_tables.s"
	.include	"zx02_optim.s"
	.include	"hgr_sprite_big.s"
	.include	"cycle_colors.s"
	.include	"hgr_copy_fast.s"

	.include	"asplode_graphics/sb_sprites.inc"

title_data:
	.incbin "asplode_graphics/sb_title.hgr.zx02"

comp_data:
	.incbin "asplode_graphics/sb_zone.hgr.zx02"


shield_sprites_l:
	.byte <player_sprite,<shield_left_sprite
	.byte <shield_center_sprite,<shield_right_sprite

shield_sprites_h:
	.byte >player_sprite,>shield_left_sprite
	.byte >shield_center_sprite,>shield_right_sprite
