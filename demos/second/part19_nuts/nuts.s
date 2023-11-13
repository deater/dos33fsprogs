; Nuts

; also end sprites to 3d

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload2.inc"

mod7_table	= $1c00
div7_table	= $1d00
hposn_low	= $1e00
hposn_high	= $1f00

nuts_start:
	;=====================
	; initializations
	;=====================

	;===================
	; Load graphics
	;===================
load_loop:

;	bit	SET_GR
;	bit	HIRES
;	bit	FULLGR
;	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen
	jsr	hgr_page2_clearscreen

;	bit	PAGE2

	; fc logo

	lda	#<fc_iipix_data
	sta	zx_src_l+1
	lda	#>fc_iipix_data
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp


	lda	#0
	sta	COUNT
	sta	DRAW_PAGE

ship_sprite_loop:

	lda	#$60
	jsr	hgr_copy

	bit	HIRES

	ldx	COUNT

	lda	ship_coords_x,X
	cmp	#$FF
	beq	done_ship_sprite_loop

	sta	SPRITE_X
	lda	ship_coords_y,X
	sta     SPRITE_Y

	lda	ship_size,X
	tax

	lda	ship_lookup_low,X
	sta     INL
	lda	ship_lookup_high,X
	sta	INH

	jsr	hgr_draw_sprite_big

	lda	DRAW_PAGE
	beq	ship_sprite_flip

	lda	#0
	sta	DRAW_PAGE
	bit	PAGE2
	jmp	done_ship_sprite_flip

ship_sprite_flip:
	lda	#$20
	sta	DRAW_PAGE
	bit	PAGE1

done_ship_sprite_flip:

;	jsr	wait_until_keypress

	inc	COUNT
	bne	ship_sprite_loop		; bra

done_ship_sprite_loop:

	bit	PAGE1

	lda	#50
	jsr	wait_irq

	; clear to white

	lda	#$ff
	jsr	hgr_page1_clearscreen

	lda	#50
	jsr	wait_irq

	; nuts4 logo

	lda	#<nuts4_data
	sta	zx_src_l+1
	lda	#>nuts4_data
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	lda	#150		; 3s
	jsr	wait_irq
	lda	#150		; 3s
	jsr	wait_irq

nuts_done:
	rts


.align $100
	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
;	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"
	.include	"../hgr_sprite_big.s"
	.include	"../hgr_copy_fast.s"


	; wait A * 1/50s
wait_irq:
;	lda	#50
	sta	IRQ_COUNTDOWN
wait_irq_loop:
	lda	IRQ_COUNTDOWN
	bne	wait_irq_loop
	rts

fc_iipix_data:
	.incbin "graphics/fc_iipix.hgr.zx02"

nuts4_data:
	.incbin "graphics/nuts4.hgr.zx02"

	.include "graphics/ship_sprites.inc"

ship_coords_x:
	.byte	28, 28, 28, 27, 26, 25, 24
	.byte   23, 22, 21, 20, 19, 18
	.byte	16, 14, 12, 10,  7,  3, 0,$FF

ship_coords_y:
	.byte	91, 97 ,103,109,111,112,112
	.byte   109,109,109,108,107,106
;	.byte   112,113,110,108,107,106
	.byte	 96, 96, 92, 85, 77, 68,59
;	.byte	102,101, 95, 85, 77, 68,59

ship_size:
	.byte	0,0,0,0,0,0,0
	.byte	1,1,1,1,1,1
	.byte	2,2,2,2,2,2,2

ship_lookup_low:
	.byte <small_ship_sprite,<medium_ship_sprite,<large_ship_sprite

ship_lookup_high:
	.byte >small_ship_sprite,>medium_ship_sprite,>large_ship_sprite

