; Credits

; o/~ It's the credits, yeah, that's the best part
;     When the movie ends and the reading starts o/~

;
; by deater (Vince Weaver) <vince@deater.net>

;.include "zp.inc"
;.include "hardware.inc"
;.include "../qload.inc"
;.include "../music.inc"

;mod7_table	= $1c00
;div7_table	= $1d00
;hposn_low	= $1e00
;hposn_high	= $1f00

intro_start:
	;=====================
	; initializations
	;=====================

	bit	KEYRESET		; clear just in case

	;===================
	; Load graphics
	;===================
load_loop:

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	jsr	hgr_page1_clearscreen	; unrolled
	jsr	hgr_page2_clearscreen	; unrolled

;	jsr	hgr_make_tables


	;=======================
	;=======================
	; scroll job
	;=======================
	;=======================
	; so the way this works is that it only displays PAGE1
	;	and it prints new credits just off the bottom of it which
	;	is essentially the top of PAGE2
	; then it scrolls things up

	ldx	#0
	stx	FRAME

	; print message


	lda	#<final_credits		; store location of string
	sta	BACKUP_OUTL
	lda	#>final_credits
	sta	BACKUP_OUTH

scroll_loop:

	jsr	hgr_vertical_scroll


	;============================================
	; clear lines to get rid of stray old chars
	;============================================
	; just erase line 158 and 159

	;	$39D0, $3DD0

	clc
	lda	#$39
	adc	DRAW_PAGE
	sta	cl_smc+2

	clc
	lda	#$3d
	adc	DRAW_PAGE
	sta	cl_smc+5

	ldy	#39
	lda	#$00
cl_inner_loop:

cl_smc:
	sta	$39D0,Y
	sta	$3DD0,Y
	dey
	bpl	cl_inner_loop

	;=============================
	;=============================
	; draw text
	;=============================
	;=============================

	;=======================
	; draw one line at 158
	;=======================

	lda	#158		;
	sta	CV
	lda	BACKUP_OUTL	; get saved text location
	ldy	BACKUP_OUTH	; and load direct in A/Y
	ldx	FRAME		; load which line of text to draw
	jsr	draw_condensed_1x8

	; X points to last char printed?

	;=========================================
	; check if increment to next line of text
	;=========================================
	; flip over if frame==9

	lda	FRAME
	cmp	#9
	bcc	skip_next_text

			; point to location after
	sec		; always add 1
	txa		; afterward X points to end of string
	adc	OUTL		; (OUTL is already+1)
	sta	BACKUP_OUTL
	lda	#$0
	adc	OUTH
	sta	BACKUP_OUTH
	lda	#$ff
	sta	FRAME
skip_next_text:

	;===========================
	; draw second line at 159
	;===========================

	lda	#159		;
	sta	CV
	lda	BACKUP_OUTL	; get saved text location
	ldy	BACKUP_OUTH	; and load direct in A/Y
	ldx	FRAME
	inx
	jsr	draw_condensed_1x8

	;=================================
	; increment the frame
	;=================================

	inc	FRAME			; next frame

;	lda	FRAME			; wrap frame after 10 lines
;	cmp	#10
;	bne	no_update_message

;	lda	#0
;	sta	FRAME

	;=============================
	; draw sprites
	;=============================

	lda	#18
	sta	CURSOR_X

	lda	#160
	sta	CURSOR_Y

	inc	GUITAR_FRAME

	lda	GUITAR_FRAME
	and	#7
	tax
	lda	guitar_pattern,X
	tax

	lda	guitar_l,X
	sta	INL
	lda	guitar_h,X
	sta	INH

	jsr	hgr_draw_sprite


	;===========================
	; keeper1

	lda	GUITAR_FRAME
	and	#$1f
	tax
	lda	keeper1_pattern,X
	tax


	lda	#14
	sta	CURSOR_X

	lda	#160
	sta	CURSOR_Y

	lda	keeper_l,X
	sta	INL
	lda	keeper_h,X
	sta	INH

	jsr	hgr_draw_sprite

	;====================
	; keeper2

	lda	GUITAR_FRAME
	and	#$1f
	tax
	lda	keeper2_pattern,X
	tax


	lda	#22
	sta	CURSOR_X

	lda	#160
	sta	CURSOR_Y

	lda	keeper_l,X
	sta	INL
	lda	keeper_h,X
	sta	INH

	jsr	hgr_draw_sprite






	;=============================
	; do the scroll
	;=============================

	jsr	wait_vblank

	jsr	hgr_page_flip

	jmp	scroll_loop

.align $100
;	.include	"wait_keypress.s"
;	.include	"zx02_optim.s"
	.include	"hgr_clear_screen.s"
	.include	"vertical_scroll.s"

	.include	"font_4am_1x8_oneline.s"
	.include	"fonts/font_4am_1x8_data.s"

;	.include	"font_4am_1x10.s"
;	.include	"fonts/font_4am_1x10_data.s"

;	.include	"irq_wait.s"
	.include	"hgr_page_flip.s"

	.include	"vblank.s"

	.include	"hgr_sprite.s"

	.include	"graphics/guitar_sprites.inc"

guitar_pattern:
.byte 0,0,1,1,2,2,1,1

guitar_l:
	.byte <guitar0,<guitar1,<guitar2
guitar_h:
	.byte >guitar0,>guitar1,>guitar2

	.include	"graphics/keeper1_sprites.inc"
	.include	"graphics/keeper2_sprites.inc"

keeper_l:
	.byte <keeper_r0,<keeper_r1,<keeper_r2
	.byte <keeper_r3,<keeper_r4,<keeper_r5
	.byte <keeper_r6,<keeper_r7
	.byte <keeper_l0,<keeper_l1,<keeper_l2
	.byte <keeper_l3,<keeper_l4,<keeper_l5
	.byte <keeper_l6,<keeper_l7

keeper_h:
	.byte >keeper_r0,>keeper_r1,>keeper_r2
	.byte >keeper_r3,>keeper_r4,>keeper_r5
	.byte >keeper_r6,>keeper_r7
	.byte >keeper_l0,>keeper_l1,>keeper_l2
	.byte >keeper_l3,>keeper_l4,>keeper_l5
	.byte >keeper_l6,>keeper_l7





keeper1_pattern:
.byte 1,1,2,2,1,1,2,2
.byte 1,2,3,4,5,4,3,4
.byte 5,4,3,4,5,6,7,5
.byte 7,6,5,4,3,2,1,2



keeper2_pattern:
.byte 1+8,1+8,2+8,2+8,1+8,1+8,2+8,2+8
.byte 1+8,2+8,3+8,4+8,5+8,4+8,3+8,4+8
.byte 5+8,4+8,3+8,4+8,5+8,6+8,7+8,5+8
.byte 7+8,6+8,5+8,4+8,3+8,2+8,1+8,2+8


final_credits:
	.include "lyrics.s"

