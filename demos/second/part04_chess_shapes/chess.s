; Chess board, polyhedrons, circles, interference

; o/~ One night in Bangkok makes a hard man humble... o/~

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"

mod7_table	= $1c00
div7_table	= $1d00
hposn_low	= $1e00
hposn_high	= $1f00

chess_start:
	;=====================
	; initializations
	;=====================

	; some of this not necessary as we come in in HGR

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1
	bit	KEYRESET

	lda	#$00
	jsr	hgr_page2_clearscreen

	;===================
	; Load graphics
	;===================



	;=============================
	; load chessboard image offscreen $6000
	;=============================

	lda	#<chess_data
	sta	zx_src_l+1
	lda	#>chess_data
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp




	; wait until pattern1
pattern2_loop:
	lda	#2
	jsr	wait_for_pattern
	bcc	pattern2_loop

	; technically the above, but we're not fast enough

;	lda	#175
;	jsr	wait_ticks

;	lda	#$FF
;	jsr	hgr_page1_clearscreen


	;==========================
	; Falling board animation
	;==========================

	; TODO

	; 148-192 = full = 44

	; 0 frames in = 0 high,			bottom=125+13	Y=125
	; 4 frames in, 130-138 = 8 high		bottom=138+17	Y=130
	; 8 frames in, from 135-155 = 20	bottom=155+25	Y=135
	;12 frames in, from 145-180 = 35	bottom=180	Y=145


	; first collapse down, top to 125 bottom up to 133
	;	so 125 whie other 60

	ldx	#0
	lda	#191
	sta	COUNT
compact_loop:

	txa
	lsr
	bcc	compact_not_even

	stx	SAVEX

	ldx	COUNT

	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	sta	GBASH

	lda	#0
	ldy	#39
compact_inner_loop2:
	sta	(GBASL),Y
	dey
	bpl	compact_inner_loop2

	dec	COUNT

	ldx	SAVEX

compact_not_even:

	lda	hposn_low,X
	sta	GBASL
	lda	hposn_high,X
	sta	GBASH

	lda	#0
	ldy	#39
compact_inner_loop:
	sta	(GBASL),Y
	dey
	bpl	compact_inner_loop

	lda	#30
	jsr	wait

	inx
	cpx	#122
	bne	compact_loop


	;=============================
	; dropping board
	;=============================

	ldx	#0
	stx	BOARD_COUNT

drop_board_loop:
	jsr	hgr_clear_screen

	ldx	BOARD_COUNT
	lda	board_y,X
	sta	HGR_DEST

	lda	board_starty,X
	sta	HGR_Y1

	lda	#0
	sta	HGR_X1
	lda	#40
	sta	HGR_X2
	lda	#192
	sta	HGR_Y2

	jsr	hgr_partial

	jsr	hgr_page_flip

;	jsr	wait_until_keypress

	lda	#10
	jsr	wait_ticks

	inc	BOARD_COUNT
	lda	BOARD_COUNT
	cmp	#7
	bne	drop_board_loop


	;=============================
	; Bouncing on board animation
	;=============================

	lda	#10
	jsr	setup_timeout

	bit	PAGE2

	lda	#0
	sta	COUNT
	sta	DRAW_PAGE
chess_bounce_loop:

	lda	#$60				; copy to screen
	jsr	hgr_copy

	ldx     COUNT

	lda     bounce_coords_x,X
	sta     SPRITE_X
	lda     bounce_coords_y,X
	sta     SPRITE_Y
	cmp	#100
	bcs	do_squashed

        lda     #<object_data
	sta     INL
	lda     #>object_data
	jmp	done_pick_object
do_squashed:
        lda     #<squished
	sta     INL
	lda     #>squished
done_pick_object:
	sta     INH


	jsr     hgr_draw_sprite_big

	jsr	hgr_page_flip

	inc	COUNT
	lda	COUNT
	cmp	#36
	bne	no_chess_bounce_oflo
	lda	#0
	sta	COUNT

no_chess_bounce_oflo:

	jsr	check_timeout
	bcc	chess_bounce_loop	; clear if not timed out

done_chess_bounce_loop:


	;=============================
	; Orange Blob Animation
	;=============================


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
;	cmp	#$FF			; needed?
;	beq	done_orange_loop

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

	; finish at music pattern #10 or keypress
	lda	#10
	jsr	wait_for_pattern
	bcc	orange_loop

;	lda	KEYPRESS
;	bpl	orange_loop

;done_orange_loop:
;	bit	KEYRESET

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

	; finish at music pattern #13 or keypress
	lda	#13
	jsr	wait_for_pattern
	bcc	tunnel_loop

main_tunnel_done:

	;==================
	;==================
	;==================
	; DO circles HERE
	;==================
	;==================
	;==================

	jsr	zooming_circles


	lda	#$ff
	sta	clear_all_color+1
	jsr	clear_all

	; todo, fade to white

	;==================
	;==================
	;==================
	; DO INTERFERENCE #1 HERE
	;==================
	;==================
	;==================

	; first until pattern 18

	lda	#18
	sta	interference_end_smc+1
	jsr	interference

	;======================
	; TODO: falling bars
	;======================
	lda	#0
	sta	DRAW_PAGE
	bit	PAGE1
	jsr	clear_all

	; left

	lda	#$FF
	sta	BAR_X1
	lda	#13
	sta	BAR_X2
	jsr	falling_bars

	lda	#15
	jsr	wait_ticks

	; middle

	lda	#13
	sta	BAR_X1
	lda	#26
	sta	BAR_X2
	jsr	falling_bars

	lda	#15
	jsr	wait_ticks

	; right

	lda	#26
	sta	BAR_X1
	lda	#39
	sta	BAR_X2
	jsr	falling_bars

	lda	#15
	jsr	wait_ticks


	;==================
	;==================
	;==================
	; DO INTERFERENCE #2 HERE
	;==================
	;==================
	;==================

	; again until pattern 25

;	lda	#25
;	sta	interference_end_smc+1
;	jsr	interference

	jsr	sier_zoom

main_interference_done:

	rts


;.align $100
	.include	"../wait_keypress.s"
;	.include	"../zx02_optim.s"
;	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"
	.include	"../hgr_copy_fast.s"
	.include	"../hgr_sprite_big.s"
	.include	"../irq_wait.s"

	.include	"interference.s"
	.include	"circles.s"
	.include	"sierzoom.s"
	.include	"../hgr_page_flip.s"
	.include	"falling_bars.s"
	.include	"hgr_partial.s"

	; wait A * 1/50s
wait_irq:
;	lda	#50
	sta	IRQ_COUNTDOWN
wait_irq_loop:
	lda	IRQ_COUNTDOWN
	bne	wait_irq_loop
	rts

chess_data:
	.incbin "graphics/chessboard.hgr.zx02"
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




	; 9*4=36
bounce_coords_x:
	.byte 12, 12, 12, 12, 12, 12, 12, 10, 10
	.byte 10, 10, 12, 12, 12, 12, 12, 12, 12
	.byte 12, 12, 12, 12, 12, 12, 12, 10, 10
	.byte 10, 10, 12, 12, 12, 12, 12, 12, 12

bounce_coords_y:
	.byte	4, 20, 35, 45, 60, 70, 82, 102, 115
	.byte 115,102, 82, 70, 60, 45, 35,  20,   4
	.byte	4, 20, 35, 45, 60, 70, 82, 102, 115
	.byte 115,102, 82, 70, 60, 45, 35,  20,   4

	; 148-192 = full = 44

	; 0 frames in = 0 high,			bottom=125+13	Y=125
	; 4 frames in, 130-138 = 8 high		bottom=138+17	Y=130
	; 8 frames in, from 135-155 = 20	bottom=155+25	Y=135
	;12 frames in, from 145-180 = 35	bottom=180	Y=145

board_y:
	.byte 125,130,135,145,139,145,139

board_starty:
	.byte 184,184,172,157,139,157,139
