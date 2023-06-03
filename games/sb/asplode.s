; Strongbad Zone
;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>


.include "zp.inc"
.include "hardware.inc"


hires_start:

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


	lda	#$20


	jsr	full_decomp

	lda	#16
	sta	STRONGBAD_X
	sta	PLAYER_X

	lda	#1
	sta	STRONGBAD_DIR

	;==========================
	; main loop
	;===========================
main_loop:

	inc	FRAME


	;===========================
	; move head
	;===========================

	lda	FRAME
	and	#$3
	bne	no_move_head

	lda	STRONGBAD_X
	cmp	#22
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
	; draw player
	;===========================

	lda	#<player_sprite
	sta	INL
	lda	#>player_sprite
	sta	INH
	lda	PLAYER_X
	sta	SPRITE_X
	lda	#138
	sta	SPRITE_Y
	jsr	hgr_draw_sprite_big

check_keypress:
	lda     KEYPRESS
;	bpl	check_keypress
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
	cmp	#'S'		; shield center
	cmp	#'D'		; shield right

	cmp	#8		; left
	beq	move_left

        cmp	#$15
        beq	move_right	; right


done_keyboard_check:
	jmp	main_loop

move_left:
	dec	PLAYER_X
	jmp	main_loop

move_right:
	inc	PLAYER_X
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

	.include	"asplode_graphics/sb_sprites.inc"

title_data:
	.incbin "asplode_graphics/sb_title.hgr.zx02"

comp_data:
	.incbin "asplode_graphics/sb_zone.hgr.zx02"


