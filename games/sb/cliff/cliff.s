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

	lda	#10
	sta	PEASANT_X
	lda	#100
	sta	PEASANT_Y

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

	jsr	hgr_copy



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


	.include	"../hgr_tables.s"

	.include	"../zx02_optim.s"

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


