; Credits

; o/~ It's the credits, yeah, that's the best part
;     When the movie ends and the reading starts o/~

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"

mod7_table	= $1c00
div7_table	= $1d00
hposn_low	= $1e00
hposn_high	= $1f00

intro_start:
	;=====================
	; initializations
	;=====================

	;===================
	; Load graphics
	;===================
load_loop:

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen

	jsr	hgr_make_tables

	;=====================
	;=====================
	; do credits
	;=====================
	;=====================


	; load the logo set 1

	lda	#<summary1_data
	sta	zx_src_l+1
	lda	#>summary1_data
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp


	lda	#0
	sta	COUNT

credits_logo_outer_outer:

	lda	#0				; clear screen
	jsr	hgr_page1_clearscreen


        lda     #12
        sta     CH
        lda     #192
        sta     CV

	pha
	txa
	pha
	tya
	pha

	ldx	COUNT

        lda     credits_list_low,X
        ldy     credits_list_high,X

	jsr	draw_font_1x10_multiple

	pla
	tay
	pla
	tax
	pla



	ldx	COUNT				; patch the source offsets
	lda	logo_x_offsets,X
	sta	clo_smc1+1
	lda	logo_y_offsets,X
	sta	clo_smc2+1

	ldx	#63
credits_logo_outer:

	; setup output pointer

	lda	hposn_low+16,X			; adjust X
	clc
	adc	#15				; center on screen
	sta	OUTL

	; setup high

	lda	hposn_high+16,X
	sta	OUTH


	; setup input pointers

	stx	XSAVE
	txa
	clc
clo_smc2:
	adc	#0
	tax

	lda	hposn_low,X
	clc
clo_smc1:
	adc	#0
	sta	INL

	lda	hposn_high,X
	eor	#$60
	sta	INH
	ldx	XSAVE

	ldy	#9
credits_logo_inner:
	lda	(INL),Y
	sta	(OUTL),Y
	dey
	bpl	credits_logo_inner

	dex
	bpl	credits_logo_outer


	jsr	wait_until_keypress

	inc	COUNT
	lda	COUNT

	cmp	#12
	bne	skip_summary2

	; reload logos when we hit 12

	lda	#<summary2_data
	sta	zx_src_l+1
	lda	#>summary2_data
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp
	lda	#0
skip_summary2:
	cmp	#21
	beq	done_credits_logo

	jmp	credits_logo_outer_outer

done_credits_logo:

	;=======================
	; scroll job
	;=======================

	ldx	#0
	stx	FRAME

do_scroll:

	lda	FRAME
	and	#$7
	bne	no_update_message

	; clear lines
	ldx	#200
cl_outer_loop:
	lda	hposn_low,X
	sta	OUTL
	lda	hposn_high,X
	sta	OUTH
	ldy	#39
	lda	#0
cl_inner_loop:
	sta	(OUTL),Y
	dey
	bpl	cl_inner_loop
	dex
	cpx	#191
	bne	cl_outer_loop


	; print message

        lda     #12
        sta     CH
        lda     #192
        sta     CV

        lda     #<apple_message
        ldy     #>apple_message

	jsr	draw_condensed_1x8

no_update_message:

	inc	FRAME

	jsr	hgr_vertical_scroll

	jmp	do_scroll



logo_y_offsets:
	.byte	0,0,0,0
	.byte	64,64,64,64
	.byte	128,128,128,128
	.byte	0,0,0,0
	.byte	64,64,64,64
	.byte	128

logo_x_offsets:
	.byte	0,10,20,30
	.byte	0,10,20,30
	.byte	0,10,20,30
	.byte	0,10,20,30
	.byte	0,10,20,30
	.byte	0


.align $100
	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
	.include	"../hgr_table.s"
	.include	"../hgr_clear_screen.s"
	.include	"vertical_scroll.s"

	.include	"font_4am_1x8.s"
	.include	"fonts/font_4am_1x8_data.s"

	.include	"font_4am_1x10.s"
	.include	"fonts/font_4am_1x10_data.s"


summary1_data:
	.incbin "graphics/summary1_invert.hgr.zx02"
summary2_data:
	.incbin "graphics/summary2_invert.hgr.zx02"


credits_list_low:
	.byte <credit_message1,<credit_message2,<credit_message3
	.byte <credit_message4,<credit_message5,<credit_message6
	.byte <credit_message7,<credit_message8,<credit_message9
	.byte <credit_message10,<credit_message11,<credit_message12
	.byte <credit_message13,<credit_message14,<credit_message15
	.byte <credit_message16,<credit_message17,<credit_message18
	.byte <credit_message19,<credit_message20,<credit_message21

credits_list_high:
	.byte >credit_message1,>credit_message2,>credit_message3
	.byte >credit_message4,>credit_message5,>credit_message6
	.byte >credit_message7,>credit_message8,>credit_message9
	.byte >credit_message10,>credit_message11,>credit_message12
	.byte >credit_message13,>credit_message14,>credit_message15
	.byte >credit_message16,>credit_message17,>credit_message18
	.byte >credit_message19,>credit_message20,>credit_message21




credit_message1:	; intro
credit_message2:	; intro ships
credit_message3:	; intro explosion
	.byte 11, 96,"GRAPHICS -- MARVEL",13
	.byte 14,108,"A2 -- DEATER",13
	.byte 13,128,"MUSIC - SKAVEN",13
	.byte 14,140,"AY - DEATER",13
	.byte 13,160,"CODE -- DEATER",0
;credit_message2:	; intro ships
;	.byte 11, 96,"GRAPHICS -- MARVEL",13
;	.byte 14,108,"A2 -- DEATER",13
;	.byte 13,128,"MUSIC - SKAVEN",13
;	.byte 14,140,"AY - DEATER",13
;	.byte 13,160,"CODE -- DEATER",0
;credit_message3:	; intro explosion
;	.byte 11, 96,"GRAPHICS -- MARVEL",13
;	.byte 14,108,"A2 -- DEATER",13
;	.byte 13,128,"MUSIC - SKAVEN",13
;	.byte 14,140,"AY - DEATER",13
;	.byte 13,160,"CODE -- DEATER",0
credit_message4:	; logo
	.byte 12, 96,"GRAPHICS - PIXEL",13
	.byte 14,108,"A2 -- DEATER",0
credit_message5:	; chessboard
credit_message9:	; ape
credit_message10:	; leaves
credit_message16:	; transmission
	.byte 12, 96,"GRAPHICS -- PIXEL",13
	.byte 14,108,"A2 -- DEATER",13
	.byte  9,128,"MUSIC -- PURPLE MOTION",13
	.byte 15,140,"AY -- Z00M",13
	.byte 13,160,"CODE -- DEATER",0
credit_message6:	; tunnel
credit_message7:	; circles
credit_message8:	; interference
credit_message13:	; plasma
credit_message14:	; cube
credit_message15:	; balls
credit_message17:	; voxel
	.byte  9, 96,"MUSIC -- PURPLE MOTION",13
	.byte 15,108,"AY -- Z00M",13
	.byte 13,128,"CODE -- DEATER",0
;credit_message7:	; circles
;	.byte  9, 96,"MUSIC -- PURPLE MOTION",13
;	.byte 15,108,"AY -- Z00M",13
;	.byte 13,128,"CODE -- DEATER",0
;credit_message8:	; interference
;	.byte  9,128,"MUSIC -- PURPLE MOTION",13
;	.byte 15,140,"AY -- Z00M",13
;	.byte 13,160,"CODE -- DEATER",0
;credit_message9:	; ape
;	.byte 12, 96,"GRAPHICS -- PIXEL",13
;	.byte 14,108,"A2 -- DEATER",13
;	.byte  9,128,"MUSIC -- PURPLE MOTION",13
;	.byte 15,140,"AY -- Z00M",13
;	.byte 13,160,"CODE -- DEATER",0
;credit_message10:	; leaves
;	.byte 12, 96,"GRAPHICS -- PIXEL",13
;	.byte 14,108,"A2 -- DEATER",13
;	.byte  9,128,"MUSIC -- PURPLE MOTION",13
;	.byte 15,140,"AY -- Z00M",13
;	.byte 13,160,"CODE -- DEATER",0
credit_message11:	; lens
credit_message12:	; roto
	.byte  7, 96,"GRAPHICS -- PIXEL / SKAVEN",13
	.byte 14,108,"A2 -- DEATER",13
	.byte  9,128,"MUSIC -- PURPLE MOTION",13
	.byte 15,140,"AY -- Z00M",13
	.byte 13,160,"CODE -- DEATER",0
;credit_message12:	; roto
;	.byte 12, 96,"GRAPHICS -- PIXEL",13	; / SKAVEN
;	.byte 14,108,"A2 -- DEATER",13
;	.byte  9,128,"MUSIC -- PURPLE MOTION",13
;	.byte 15,140,"AY -- Z00M",13
;	.byte 13,160,"CODE -- DEATER",0
;credit_message13:	; plasma
;	.byte  9,128,"MUSIC -- PURPLE MOTION",13
;	.byte 15,140,"AY -- Z00M",13
;	.byte 13,160,"CODE -- DEATER",0
;credit_message14:	; cube
;	.byte  9,128,"MUSIC -- PURPLE MOTION",13
;	.byte 15,140,"AY -- Z00M",13
;	.byte 13,160,"CODE -- DEATER",0
;credit_message15:	; balls
;	.byte  9,128,"MUSIC -- PURPLE MOTION",13
;	.byte 15,140,"AY -- Z00M",13
;	.byte 13,160,"CODE -- DEATER",0
;credit_message16:	; transmission
;	.byte 12, 96,"GRAPHICS -- PIXEL",13
;	.byte 14,108,"A2 -- DEATER",13
;	.byte  9,128,"MUSIC -- PURPLE MOTION",13
;	.byte 15,140,"AY -- Z00M",13
;	.byte 13,160,"CODE -- DEATER",0
;credit_message17:	; voxel
;	.byte  9,128,"MUSIC -- PURPLE MOTION",13
;	.byte 15,140,"AY -- Z00M",13
;	.byte 13,160,"CODE -- DEATER",0
credit_message18:	; polar
	.byte 11, 96,"GRAPHICS -- MARVEL",13
	.byte 14,108,"A2 -- DEATER",13
	.byte  9,128,"MUSIC -- PURPLE MOTION",13
	.byte 15,140,"AY -- Z00M",13
	.byte 13,160,"CODE -- DEATER",0
credit_message19:	; 3D
	.byte 14, 96,"WORLD - TRUG",13
	.byte 14,108,"A2 -- DEATER",13
	.byte 13,128,"MUSIC - SKAVEN",13
	.byte 14,140,"AY -- DEATER",13
	.byte 13,160,"CODE -- DEATER",0
credit_message20:	; NUTS
credit_message21:	; CREDITS
	.byte 12, 96,"GRAPHICS -- PIXEL",13
	.byte 14,108,"A2 -- DEATER",13
	.byte 13,128,"MUSIC - SKAVEN",13
	.byte 14,140,"AY -- DEATER",13
	.byte 13,160,"CODE -- DEATER",0
;credit_message21:	; CREDITS
;	.byte 12, 96,"GRAPHICS -- PIXEL",13
;	.byte 14,108,"A2 -- DEATER",13
;	.byte 13,128,"MUSIC - SKAVEN",13
;	.byte 14,140,"AY -- DEATER",13
;	.byte 13,160,"CODE -- DEATER",0



apple_message:
	.byte "Apple ][ Forever",0
