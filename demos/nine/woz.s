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

	jsr	load_image

	jsr	hgr_page_flip

	jsr	wait_until_keypress

	lda	#14
	sta	BALL_X

	lda	#10
	sta	CURSOR_Y

	lda	#$20
	sta	DRAW_PAGE

sprite_loop:

	; inc	CURSOR_Y

	inc	BALL_X

	jsr	draw_ball

	jmp	sprite_loop

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

        lda     #$80
        sta     DRAW_PAGE

        lda     #<woz_top
        sta     zx_src_l+1
        lda     #>woz_top
        sta     zx_src_h+1

	lda	#$A0
        jsr     zx02_full_decomp

        lda     #$20                    ; draw to page 2
        sta     DRAW_PAGE

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

        lda     #$20                    ; draw to page 2
        sta     DRAW_PAGE

        lda     #$a0
        jsr     dhgr_repack_bottom



	rts







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


