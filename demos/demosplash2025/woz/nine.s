; Woz-Nine, vaguely a parody of the c64 nine demo
;
; mostly testing out dhgr sprites
;
; by deater (Vince Weaver) <vince@deater.net>

;.include "zp.inc"
;.include "hardware.inc"

;repack_src = $A000

;hposn_high = $1000
;hposn_low  = $1100
;div7_table	= $1200
;mod7_table	= $1300


woz_nine:
	;==================
	; init vars
	;==================

	lda	#$0
	sta	DRAW_PAGE		; draw to PAGE1

	;==================
	; init ball modes

	ldx	#8
init_ball_loop:
	lda	#$ff
	sta	BALL_STATE,X
	lda	#$0
	sta	BALL_OFFSET,X
	dex
	bpl	init_ball_loop


	;===================
	; set graphics mode
	;===================
;	jsr	HOME

;	bit	SET_GR
;	bit	HIRES
;	bit	FULLGR
;	sta	AN3		; set double hires
;	sta	EIGHTYCOLON	; 80 column
;	sta	CLR80COL
;	sta	SET80COL	; 80 store

	bit	PAGE1	; start in page1

;	jsr	hgr_make_tables
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

	ldy	WHICH_BALL
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

	;======================
	; clear out remnants
	;======================

	lda	#0
	sta	DRAW_PAGE

	lda	#14
	sta	CURSOR_X

	lda	#10
	sta	CURSOR_Y

	lda	#<erase_main
	sta	INL
	lda	#>erase_main
	sta	INH

	jsr	dhgr_draw_sprite_main

	lda	#<erase_aux
	sta	INL
	lda	#>erase_aux
	sta	INH

	jsr	dhgr_draw_sprite_aux

	lda	#$20
	sta	DRAW_PAGE

	lda	#14
	sta	CURSOR_X

	lda	#10
	sta	CURSOR_Y

	lda	#<erase_main
	sta	INL
	lda	#>erase_main
	sta	INH

	jsr	dhgr_draw_sprite_main

	lda	#<erase_aux
	sta	INL
	lda	#>erase_aux
	sta	INH

	jsr	dhgr_draw_sprite_aux




	;=====================
	;=====================
	; circle loop
	;=====================
	;=====================

	lda	#0
	sta	ORBITS
	sta	NEXT_BALL

	; release ball #0 first

	lda	#1
	sta	BALL_STATE+0

circle_loop:

	jsr	hgr_page_flip

	;=======================
	; erase previous balls

	jsr	erase_balls

	;=======================
	; get position and draw

	lda	#0
	sta	WHICH_BALL

	; release next ball

	lda	BALL_OFFSET+0
	lsr
	lsr
	tax
	lda	#1
	sta	BALL_STATE,X

draw_circle_ball_loop:

	ldx	WHICH_BALL		; get ball
	lda	BALL_STATE,X		; check if out, if not skip
	bmi	skip_ball

	lda	BALL_OFFSET,X		; get offset in circle
	tax
	lda	circle_x,X		; get x-position
	lsr				; divide by 2?
	sta	BALL_X			; set position

	lda	circle_y,X		; get y position
	sta	CURSOR_Y

	ldy	WHICH_BALL		; get color of ball
	jsr	draw_ball		; draw it

	ldx	WHICH_BALL		; increment current ball offset
	inc	BALL_OFFSET,X
	lda	BALL_OFFSET,X
	cmp	#$20			; 32 positions
	bne	skip_ball		; if not 32, good

	lda	#0			; reset count to 0
	sta	BALL_OFFSET,X

	; only orbit if BALL#1
	lda	WHICH_BALL		; were we ball #0?
	bne	skip_ball		; if not do nothing

	inc	ORBITS			; increment orbits

skip_ball:
	inc	WHICH_BALL
	lda	WHICH_BALL
	cmp	#8
	bne	draw_circle_ball_loop

done_orbit:
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



	;==========================
	; Load Image
	;===========================
	; page to load to in DRAW_PAGE

load_image:

	lda	DRAW_PAGE
	pha

	;=============================
        ; load top part to MAIN $A000

        lda     #$80			; decompress to $a000
        sta     DRAW_PAGE

        lda     #<woz_top
        sta     zx_src_l+1
        lda     #>woz_top
        sta     zx_src_h+1

        jsr     zx02_full_decomp_main

	; restore page
	pla
	sta	DRAW_PAGE
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

        jsr     zx02_full_decomp_main

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

	ldy	#31
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
	; draw ball at BALL_X, CURSOR_Y
	;=================================
	;=================================
	; color in Y
	; BALL_X is 0...139 (not 0...279)

draw_ball:

	ldx	BALL_X
	lda	div7_table,X
	asl
	sta	CURSOR_X

;	lda	mod7_table,X	; 0..6 is which sprite
;	tax

	tya
	asl
	asl
	asl			; a is now color*8
	clc
	adc	mod7_table,X

	tax

	pha

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

	pla
	tax

	lda	red_ball_aux_l,X
	sta	INL
	lda	red_ball_aux_h,X
	sta	INH

	jsr	dhgr_draw_sprite_aux

	rts

red_ball_main_l:
	.byte <red0_main,<red1_main,<red2_main,<red3_main
	.byte <red4_main,<red5_main,<red6_main,0
orange_ball_main_l:
	.byte <orange0_main,<orange1_main,<orange2_main,<orange3_main
	.byte <orange4_main,<orange5_main,<orange6_main,0
yellow_ball_main_l:
	.byte <yellow0_main,<yellow1_main,<yellow2_main,<yellow3_main
	.byte <yellow4_main,<yellow5_main,<yellow6_main,0
green_ball_main_l:
	.byte <green0_main,<green1_main,<green2_main,<green3_main
	.byte <green4_main,<green5_main,<green6_main,0
blue_ball_main_l:
	.byte <blue0_main,<blue1_main,<blue2_main,<blue3_main
	.byte <blue4_main,<blue5_main,<blue6_main,0
purple_ball_main_l:
	.byte <purple0_main,<purple1_main,<purple2_main,<purple3_main
	.byte <purple4_main,<purple5_main,<purple6_main,0
grey_ball_main_l:
	.byte <grey0_main,<grey1_main,<grey2_main,<grey3_main
	.byte <grey4_main,<grey5_main,<grey6_main,0
brown_ball_main_l:
	.byte <brown0_main,<brown1_main,<brown2_main,<brown3_main
	.byte <brown4_main,<brown5_main,<brown6_main,0


red_ball_main_h:
	.byte >red0_main,>red1_main,>red2_main,>red3_main
	.byte >red4_main,>red5_main,>red6_main,0
orange_ball_main_h:
	.byte >orange0_main,>orange1_main,>orange2_main,>orange3_main
	.byte >orange4_main,>orange5_main,>orange6_main,0
yellow_ball_main_h:
	.byte >yellow0_main,>yellow1_main,>yellow2_main,>yellow3_main
	.byte >yellow4_main,>yellow5_main,>yellow6_main,0
green_ball_main_h:
	.byte >green0_main,>green1_main,>green2_main,>green3_main
	.byte >green4_main,>green5_main,>green6_main,0
blue_ball_main_h:
	.byte >blue0_main,>blue1_main,>blue2_main,>blue3_main
	.byte >blue4_main,>blue5_main,>blue6_main,0
purple_ball_main_h:
	.byte >purple0_main,>purple1_main,>purple2_main,>purple3_main
	.byte >purple4_main,>purple5_main,>purple6_main,0
grey_ball_main_h:
	.byte >grey0_main,>grey1_main,>grey2_main,>grey3_main
	.byte >grey4_main,>grey5_main,>grey6_main,0
brown_ball_main_h:
	.byte >brown0_main,>brown1_main,>brown2_main,>brown3_main
	.byte >brown4_main,>brown5_main,>brown6_main,0

red_ball_aux_l:
	.byte <red0_aux,<red1_aux,<red2_aux,<red3_aux
	.byte <red4_aux,<red5_aux,<red6_aux,0
orange_ball_aux_l:
	.byte <orange0_aux,<orange1_aux,<orange2_aux,<orange3_aux
	.byte <orange4_aux,<orange5_aux,<orange6_aux,0
yellow_ball_aux_l:
	.byte <yellow0_aux,<yellow1_aux,<yellow2_aux,<yellow3_aux
	.byte <yellow4_aux,<yellow5_aux,<yellow6_aux,0
green_ball_aux_l:
	.byte <green0_aux,<green1_aux,<green2_aux,<green3_aux
	.byte <green4_aux,<green5_aux,<green6_aux,0
blue_ball_aux_l:
	.byte <blue0_aux,<blue1_aux,<blue2_aux,<blue3_aux
	.byte <blue4_aux,<blue5_aux,<blue6_aux,0
purple_ball_aux_l:
	.byte <purple0_aux,<purple1_aux,<purple2_aux,<purple3_aux
	.byte <purple4_aux,<purple5_aux,<purple6_aux,0
grey_ball_aux_l:
	.byte <grey0_aux,<grey1_aux,<grey2_aux,<grey3_aux
	.byte <grey4_aux,<grey5_aux,<grey6_aux,0
brown_ball_aux_l:
	.byte <brown0_aux,<brown1_aux,<brown2_aux,<brown3_aux
	.byte <brown4_aux,<brown5_aux,<brown6_aux,0


red_ball_aux_h:
	.byte >red0_aux,>red1_aux,>red2_aux,>red3_aux
	.byte >red4_aux,>red5_aux,>red6_aux,0
orange_ball_aux_h:
	.byte >orange0_aux,>orange1_aux,>orange2_aux,>orange3_aux
	.byte >orange4_aux,>orange5_aux,>orange6_aux,0
yellow_ball_aux_h:
	.byte >yellow0_aux,>yellow1_aux,>yellow2_aux,>yellow3_aux
	.byte >yellow4_aux,>yellow5_aux,>yellow6_aux,0
green_ball_aux_h:
	.byte >green0_aux,>green1_aux,>green2_aux,>green3_aux
	.byte >green4_aux,>green5_aux,>green6_aux,0
blue_ball_aux_h:
	.byte >blue0_aux,>blue1_aux,>blue2_aux,>blue3_aux
	.byte >blue4_aux,>blue5_aux,>blue6_aux,0
purple_ball_aux_h:
	.byte >purple0_aux,>purple1_aux,>purple2_aux,>purple3_aux
	.byte >purple4_aux,>purple5_aux,>purple6_aux,0
grey_ball_aux_h:
	.byte >grey0_aux,>grey1_aux,>grey2_aux,>grey3_aux
	.byte >grey4_aux,>grey5_aux,>grey6_aux,0
brown_ball_aux_h:
	.byte >brown0_aux,>brown1_aux,>brown2_aux,>brown3_aux
	.byte >brown4_aux,>brown5_aux,>brown6_aux,0





hat_x:
	.byte 98, 98, 98, 98, 98, 98, 98, 98
	.byte 98, 98, 98, 98, 98, 98, 98, 98

hat_y:
	.byte 65, 61, 57, 53, 49, 45, 41, 37
	.byte 33, 29, 25, 21, 17, 13,  9,  5

circle_x:
	.byte 134, 148, 162, 174, 186, 196, 204, 208
	.byte 210, 208, 204, 196, 186, 174, 162, 148

	.byte 134, 120, 106,  92, 82,  70, 64,  58
	.byte  56,  58,  62,  70, 82,  92,106, 120

circle_y:
	.byte   1,   1
	.byte   4,  11
	.byte  18,  29
	.byte  41,  55
	.byte  69,  85
	.byte 101, 112
	.byte 123, 131
	.byte 135, 138

	.byte 139, 138
	.byte 135, 130
	.byte 120, 111
	.byte  99,  84
	.byte  69,  54
	.byte  40,  28
	.byte  19,   9
	.byte   4,   1


;	.include	"zx02_optim.s"

	.include	"../dhgr_sprite.s"
	.include	"../div7_table.s"

;	.include	"hgr_tables.s"

;	.include	"dhgr_repack.s"

;	.include	"hgr_page_flip.s"

	.include	"sprites/ball_sprites.inc"

woz_bottom:
	.incbin "graphics/new_woz.raw_bottom.zx02"
woz_top:
	.incbin "graphics/new_woz.raw_top.zx02"


