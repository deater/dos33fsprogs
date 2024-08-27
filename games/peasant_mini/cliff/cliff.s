; Cliff climb minigame from Peasant's Quest
;
; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>


.include "zp.inc"
.include "hardware.inc"

;div7_table     = $400
;mod7_table     = $500
;hposn_high     = $600
;hposn_low      = $700

div7_table      = $b800
mod7_table      = $b900
hposn_high      = $ba00
hposn_low       = $bb00

cliff_base:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	lda	#0
	sta	LEVEL_OVER
	sta	FRAME
	sta	PEASANT_XADD
	sta	PEASANT_YADD
	sta	PEASANT_DIR	; 0 = up

	lda	#10
	sta	PEASANT_X
	lda	#100
	sta	PEASANT_Y

	; default for peasant quest is the tables are for page2
	lda	#$40
	sta	HGR_PAGE
	jsr	hgr_make_tables

	;===================
	; Load graphics
	;===================

	lda     #<priority_data
	sta     ZX0_src
	lda     #>priority_data
	sta     ZX0_src+1

        lda     #$20                    ; temporarily load to $2000

	jsr	full_decomp

	; copy to $400

	jsr	gr_copy_to_page1



	;=============================


	;==========================
	; Load Image
	;===========================

load_image:

	; size in ldsizeh:ldsizel (f1/f0)

	lda	#<bg_data
	sta	ZX0_src
	lda	#>bg_data
	sta	ZX0_src+1


	lda	#$20

	jsr	full_decomp

	jsr	hgr_copy			; copy to page2

	bit	PAGE2



	;==========================
	;==========================
	; main loop
	;==========================
	;==========================
game_loop:

	;=====================
	; move peasant

	jsr	move_peasant

	;=====================
	; draw peasant

	jsr	draw_peasant


	;=====================
	; draw enemies

	lda	#$20		 ; backup location
	sta	OUTH
	lda	#$00
	sta	OUTL

	lda	#8
	sta	SPRITE_X

	lda	#100
	sta	SPRITE_Y

	lda	#<bird0_sprite
	sta	INL
	lda	#>bird0_sprite
	sta	INH

	lda	#<bird0_mask
	sta	MASKL
	lda	#>bird0_mask
	sta	MASKH

	jsr	hgr_draw_sprite

	lda	#$21		 ; backup location
	sta	OUTH
	lda	#$00
	sta	OUTL

	lda	#21
	sta	SPRITE_X

	lda	#89
	sta	SPRITE_Y

	lda	#<bird1_sprite
	sta	INL
	lda	#>bird1_sprite
	sta	INH

	lda	#<bird1_mask
	sta	MASKL
	lda	#>bird1_mask
	sta	MASKH

	jsr	hgr_draw_sprite





	;=====================
	; increment frame

	inc	FRAME

	;=====================
	; check keyboard

	jsr	check_keyboard

	lda	LEVEL_OVER
	bne	done_cliff

	; delay

	lda	#200
	jsr	wait

	jmp	game_loop


done_cliff:
	lda	#0
	sta	WHICH_LOAD
	rts


	.include	"hgr_tables.s"

	.include	"hgr_sprite.s"

	.include	"zx02_optim.s"

	.include	"wait.s"

	.include	"keyboard.s"

	.include	"draw_peasant.s"

	.include	"move_peasant.s"

	.include	"hgr_partial_save.s"

	.include	"hgr_1x28_sprite_mask.s"

	.include	"gr_copy.s"
	.include	"hgr_copy.s"

	.include "cliff_graphics/peasant_robe_sprites.inc"

bg_data:
	.incbin "cliff_graphics/cliff_base.hgr.zx02"

priority_data:
	.incbin "cliff_graphics/cliff_base_priority.zx02"

sprites:
	.include "sprites/enemy_sprites.inc"
