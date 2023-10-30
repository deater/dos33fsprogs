; Chess board, polyhedrons, circles, interference

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

mod7_table	= $1c00
div7_table	= $1d00
hposn_low	= $1e00
hposn_high	= $1f00

chess_start:
	;=====================
	; initializations
	;=====================

	;===================
	; Load graphics
	;===================

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen
	jsr	hgr_page2_clearscreen

	bit	PAGE2

	; load image offscreen $6000

	lda	#<chess_data
	sta	zx_src_l+1
	lda	#>chess_data
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp


	lda	#0
	sta	COUNT
	sta	DRAW_PAGE

	lda	#$60				; copy to screen
	jsr	hgr_copy

	bit	PAGE1

	jsr	wait_until_keypress



	; load image offscreen $6000

	lda	#<orange_data
	sta	zx_src_l+1
	lda	#>orange_data
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	ldx	#0
	stx	COUNT

orange_loop:

	lda	#$60				; copy to screen
	jsr	hgr_copy

	ldx     COUNT

	lda     object_coords_x,X
	cmp	#$FF
	beq	done_orange_loop

	sta     SPRITE_X
	lda     object_coords_y,X
	sta     SPRITE_Y

        lda     #<object_data
	sta     INL
	lda     #>object_data
	sta     INH

	jsr     hgr_draw_sprite_big

	jsr	hgr_page_flip

	inc	COUNT
	lda	COUNT
	cmp	#48
	bne	no_orange_oflo
	lda	#0
	sta	COUNT

no_orange_oflo:

	lda	KEYPRESS
	bpl	orange_loop

done_orange_loop:
	bit	KEYRESET

chess_done:



	;==================
	;==================
	;==================
	; DO TUNNEL HERE
	;==================
	;==================
	;==================

	; load image $2000

	lda	#<tunnel1_data
	sta	zx_src_l+1
	lda	#>tunnel1_data
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	; load image $4000

	lda	#<tunnel2_data
	sta	zx_src_l+1
	lda	#>tunnel2_data
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

tunnel_loop:
	bit	PAGE1
	lda	#8
	jsr	wait_irq

	bit	PAGE2
	lda	#8
	jsr	wait_irq

	lda	KEYPRESS
	bpl	tunnel_loop

main_tunnel_done:
	bit	KEYRESET

	;==================
	;==================
	;==================
	; DO INTERFERENCE HERE
	;==================
	;==================
	;==================

	jsr	interference


main_interference_done:


	rts


;.align $100
	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
;	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"
	.include	"../hgr_copy_fast.s"
	.include	"../hgr_sprite_big.s"

	.include	"interference.s"
	.include	"../hgr_page_flip.s"

	; wait A * 1/50s
wait_irq:
;	lda	#50
	sta	IRQ_COUNTDOWN
wait_irq_loop:
	lda	IRQ_COUNTDOWN
	bne	wait_irq_loop
	rts

chess_data:
	.incbin "graphics/chess_object2.hgr.zx02"
orange_data:
	.incbin "graphics/orange_bg.hgr.zx02"

object_data:
	.include "graphics/object.inc"

tunnel1_data:
	.incbin "graphics/tunnel1_cropped.hgr.zx02"
tunnel2_data:
	.incbin "graphics/tunnel2_cropped.hgr.zx02"


; object is roughly 15 wide?

; this is a triangle pattern
; we could reverse at some point

	; 12*4 = 48
object_coords_x:
	.byte	13,12,11,10, 9, 8, 7, 6, 5, 4, 3, 2
	.byte	 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12
	.byte	13,14,15,16,17,18,19,20,21,22,23,24
	.byte	25,24,23,22,21,20,19,18,17,16,15,14

object_coords_y:
	.byte	 5,10,16,23,30,36,43,49,55,62,68,75
	.byte	82,82,82,82,82,82,82,82,82,82,82,82
	.byte	82,82,82,82,82,82,82,82,82,82,82,82
	.byte	75,68,62,55,49,43,36,30,23,16,10, 5

