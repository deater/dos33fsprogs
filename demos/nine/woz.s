; VMW Productions DHIRES/ZX02 image viewer
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

repack_src = $A000

hposn_high = $1000
hposn_low  = $1100
div7_table	= $1200
mod7_table	= $1300


nine_start:
	;==================
	; init vars
	;==================

	lda	#$0
	sta	DRAW_PAGE

	;==================
	; init ball modes

	ldx	#8
init_ball_loop:
	lda	#$ff
	sta	BALL_MODE,X
	lda	#$0
	sta	BALL_OFFSET,X
	dex
	bpl	init_ball_loop


	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	sta	AN3		; set double hires
	sta	EIGHTYCOLON	; 80 column
	sta	CLR80COL
;	sta	SET80COL	; 80 store

	bit	PAGE1	; start in page1

	jsr	hgr_make_tables
	jsr	hgr_make_div7_tables

	;===================
	; Load graphics
	;===================
reload_loop:
	; load image to page1
	lda	#$00
	sta	DRAW_PAGE

	jsr	load_image

	; load image to page2
	lda	#$20
	sta	DRAW_PAGE

	jsr	load_image

	jsr	wait_until_keypress

	lda	#14
	sta	BALL_X

	lda	#10
	sta	CURSOR_Y

	lda	#$20
	sta	DRAW_PAGE

	lda	#0
	sta	BALL_OFFSET

	;=====================
	;=====================
	; hat loop
	;=====================
	;=====================

	lda	#0
	sta	WHICH_BALL
hat_loop:

	jsr	hgr_page_flip

	;=======================
	; erase previous balls

	jsr	erase_hat_above

	;=======================
	; get position and draw

	ldx	BALL_OFFSET
	lda	hat_x,X
	lsr
	sta	BALL_X

	lda	hat_y,X
	sta	CURSOR_Y

	jsr	draw_ball

	jsr	erase_hat_actual

	inc	BALL_OFFSET
	lda	BALL_OFFSET
	cmp	#16
	bne	hat_loop

done_ball:
	lda	#0
	sta	BALL_OFFSET

	inc	WHICH_BALL
	lda	WHICH_BALL
	cmp	#8
	bne	hat_loop
done_hat_loop:

	;=====================
	;=====================
	; circle loop
	;=====================
	;=====================

	lda	#0
	sta	ORBITS
circle_loop:

	jsr	hgr_page_flip

	;=======================
	; erase previous balls

	jsr	erase_balls

	;=======================
	; get position and draw

	ldx	BALL_OFFSET
	lda	circle_x,X
	lsr
	sta	BALL_X

	lda	circle_y,X
	sta	CURSOR_Y

	jsr	draw_ball

	inc	BALL_OFFSET
	lda	BALL_OFFSET
	cmp	#$10
	bne	circle_loop

done_orbit:

	lda	#0
	sta	BALL_OFFSET
	inc	ORBITS

	lda	ORBITS
	cmp	#5
	bne	circle_loop
done_circle:


	;==============================
	; draw text
	;==============================

	bit	PAGE1
	lda	#$0
	sta	DRAW_PAGE

	; text0

	lda	#0
	sta	CURSOR_X

	lda	#153
	sta	CURSOR_Y

	lda	#<text0_main
	sta	INL
	lda	#>text0_main
	sta	INH

	jsr	dhgr_draw_sprite_main

	lda	#<text0_aux
	sta	INL
	lda	#>text0_aux
	sta	INH

	jsr	dhgr_draw_sprite_aux

	; text1

	lda	#0
	sta	CURSOR_X

	lda	#167
	sta	CURSOR_Y

	lda	#<text1_main
	sta	INL
	lda	#>text1_main
	sta	INH
	jsr	dhgr_draw_sprite_main

	lda	#<text1_aux
	sta	INL
	lda	#>text1_aux
	sta	INH

	jsr	dhgr_draw_sprite_aux

	; text2

	lda	#0				; 84 / 7
	sta	CURSOR_X

	lda	#181
	sta	CURSOR_Y

	lda	#<text2_main
	sta	INL
	lda	#>text2_main
	sta	INH

	jsr	dhgr_draw_sprite_main

	lda	#<text2_aux
	sta	INL
	lda	#>text2_aux
	sta	INH

	jsr	dhgr_draw_sprite_aux

blah:
	jmp	blah



	;==================================
	; wait until keypress

wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer

	rts

	;==========================
	; Load Image
	;===========================

load_image:

	;=============================
        ; load top part to MAIN $A000

	lda	DRAW_PAGE
	pha

        lda     #$80
        sta     DRAW_PAGE

        lda     #<woz_top
        sta     zx_src_l+1
        lda     #>woz_top
        sta     zx_src_h+1

	lda	#$A0
        jsr     zx02_full_decomp

	pla
        sta     DRAW_PAGE
	pha

        lda     #$a0
        jsr     dhgr_repack_top

	;=============================
        ; load bottom part to MAIN $A000

        lda     #$80
        sta     DRAW_PAGE

        lda     #<woz_bottom
        sta     zx_src_l+1
        lda     #>woz_bottom
        sta     zx_src_h+1

	lda	#$A0
        jsr     zx02_full_decomp

	pla
        sta     DRAW_PAGE

        lda     #$a0
        jsr     dhgr_repack_bottom



	rts




	;=================================
	;=================================
	; erase balls (circle, all of them)
	;=================================
	;=================================

erase_balls:

	ldy	#15
	sty	ERASE_COUNT
erase_balls_loop:

	ldy	ERASE_COUNT
	lda	circle_x,Y
	lsr
	tax
	lda	div7_table,X
	asl
	sta	CURSOR_X

	lda	circle_y,Y
	sta	CURSOR_Y

	lda	#<erase_main
	sta	INL
	lda	#>erase_main
	sta	INH

	jsr	dhgr_draw_sprite_main

.if 0
	ldy	ERASE_COUNT
	ldx	circle_x,Y
	lda	div7_table,X
	asl
	sta	CURSOR_X
	lda	mod7_table,X
	tax
.endif
	lda	#<erase_aux
	sta	INL
	lda	#>erase_aux
	sta	INH

	jsr	dhgr_draw_sprite_aux

	dec	ERASE_COUNT
	bpl	erase_balls_loop

	rts



	;=================================
	;=================================
	; erase hat
	;=================================
	;=================================

erase_hat_above:

	;==============
	; erase above

	lda	#14
	sta	CURSOR_X

	lda	#20
	sta	CURSOR_Y

	lda	#<erase_hat_main
	sta	INL
	lda	#>erase_hat_main
	sta	INH

	jsr	dhgr_draw_sprite_main

	lda	#<erase_hat_aux
	sta	INL
	lda	#>erase_hat_aux
	sta	INH

	jmp	dhgr_draw_sprite_aux
	; tail call

	;==============
	; erase hat

erase_hat_actual:

	lda	#12				; 84 / 7
	sta	CURSOR_X

	lda	#69
	sta	CURSOR_Y

	lda	#<erase_hat2_main
	sta	INL
	lda	#>erase_hat2_main
	sta	INH

	jsr	dhgr_draw_sprite_main

	lda	#<erase_hat2_aux
	sta	INL
	lda	#>erase_hat2_aux
	sta	INH

	jmp	dhgr_draw_sprite_aux
	; tail call




	;=================================
	;=================================
	; draw ball at CURSOR_X, CURSOR_Y
	;=================================
	;=================================

draw_ball:

	ldx	BALL_X
	lda	div7_table,X
	asl
	sta	CURSOR_X
	lda	mod7_table,X
	tax

	lda	red_ball_main_l,X
	sta	INL
	lda	red_ball_main_h,X
	sta	INH

	jsr	dhgr_draw_sprite_main


	ldx	BALL_X
	lda	div7_table,X
	asl
	sta	CURSOR_X
	lda	mod7_table,X
	tax

	lda	red_ball_aux_l,X
	sta	INL
	lda	red_ball_aux_h,X
	sta	INH

	jsr	dhgr_draw_sprite_aux

	rts

red_ball_main_l:
	.byte <red0_main,<red1_main,<red2_main,<red3_main
	.byte <red4_main,<red5_main,<red6_main

red_ball_main_h:
	.byte >red0_main,>red1_main,>red2_main,>red3_main
	.byte >red4_main,>red5_main,>red6_main

red_ball_aux_l:
	.byte <red0_aux,<red1_aux,<red2_aux,<red3_aux
	.byte <red4_aux,<red5_aux,<red6_aux

red_ball_aux_h:
	.byte >red0_aux,>red1_aux,>red2_aux,>red3_aux
	.byte >red4_aux,>red5_aux,>red6_aux

hat_x:
	.byte 98, 98, 98, 98, 98, 98, 98, 98
	.byte 98, 98, 98, 98, 98, 98, 98, 98

hat_y:
	.byte 65, 61, 57, 53, 49, 45, 41, 37
	.byte 33, 29, 25, 21, 17, 13,  9,  5

circle_x:
	.byte 134, 162, 186, 204, 210, 204, 186, 162
	.byte 134, 106,  82,  64,  56,  62,  82, 106

circle_y:
	.byte   1,   4,  18,  41,  69, 101, 123, 135
	.byte 139, 135, 120,  99,  69,  40,  19,   4


	.include	"zx02_optim.s"

	.include	"dhgr_sprite.s"
	.include	"hgr_tables.s"

	.include	"dhgr_repack.s"

	.include	"hgr_page_flip.s"

	.include	"sprites/ball_sprites.inc"

woz_bottom:
	.incbin "graphics/new_woz.raw_bottom.zx02"
woz_top:
	.incbin "graphics/new_woz.raw_top.zx02"


