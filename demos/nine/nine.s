; VMW Productions DHIRES/ZX02 image viewer
;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

hposn_high = $1000
hposn_low  = $1100

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
	sta	SET80COL	; 80 store

	bit	PAGE1	; start in page1

	jsr	hgr_make_tables

	;===================
	; Load graphics
	;===================
load_loop:

	jsr	load_image

	jsr	wait_until_keypress

	lda	#10
	sta	CURSOR_Y

sprite_loop:

	;==================
	; try drawing sprite
	;
	bit	PAGE1

	lda	#2
	sta	CURSOR_X


	lda	#<one_main
	sta	INL
	lda	#>one_main
	sta	INH

	jsr	hgr_draw_sprite

	bit	PAGE2

	lda	#2
	sta	CURSOR_X


	lda	#<one_aux
	sta	INL
	lda	#>one_aux
	sta	INH

	jsr	hgr_draw_sprite

	inc	CURSOR_Y

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
	bit	PAGE1

	lda	#<woz_bin
	sta	zx_src_l+1

	lda	#>woz_bin
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	; auxiliary part

	bit	PAGE2

	lda	#<woz_aux
	sta	zx_src_l+1

	lda	#>woz_aux
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	rts

	.include	"zx02_optim.s"

	.include	"hgr_sprite.s"
	.include	"hgr_tables.s"

	.include	"sprites/numbers.inc"

woz_aux:
	.incbin "graphics/a2_nine_woz.aux.zx02"
woz_bin:
	.incbin "graphics/a2_nine_woz.bin.zx02"
