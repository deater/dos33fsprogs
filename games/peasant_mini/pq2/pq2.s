; Peasant's Quest II

; maybe, well, not really

;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

mod7_table      = $1c00
div7_table      = $1d00
hposn_low       = $1e00
hposn_high      = $1f00

PT3_LOC = song

pq2_start:
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

	jsr	hgr_make_tables

	lda	#0
	jsr	hgr_page1_clearscreen

	;===========================
	; set up music
	;===========================

	lda	#0
	sta	DONE_PLAYING
	lda	#1
	sta	LOOP		; change to 1 to loop forever


	jsr	mockingboard_detect
	jsr	mockingboard_patch

	jsr	mockingboard_init
	jsr	mockingboard_setup_interrupt

	jsr	reset_ay_both
	jsr	clear_ay_both

	jsr	pt3_init_song

	cli



	;======================================
	;======================================
	; Pan
	;======================================
	;======================================
	; do we have room to do page flipping?


	;===========================================
	; load left logo to $2000 and right to $4000

	; left logo

	lda	#<intro_left_data
	sta	zx_src_l+1

	lda	#>intro_left_data
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	; right logo

	lda	#<intro_right_data
	sta	zx_src_l+1
	lda	#>intro_right_data
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	;==============================
	; do the pan
	;==============================

	jsr	horiz_pan

	; wait a bit

	jsr	wait_until_keypress


	;============================
	; load dialog1 to PAGE1
	;============================

	lda	#<dialog1_data
	sta	zx_src_l+1
	lda	#>dialog1_data
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	jsr	wait_until_keypress

	;============================
	; load dialog2 to PAGE1
	;============================

	lda	#<dialog2_data
	sta	zx_src_l+1
	lda	#>dialog2_data
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	jsr	wait_until_keypress




done_intro:
	jmp	done_intro


;.align $100
	.include	"wait_keypress.s"
	.include	"zx02_optim.s"
	.include	"hgr_table.s"
	.include	"hgr_clear_screen.s"
	.include	"horiz_scroll.s"
	.include	"hgr_partial.s"
;	.include	"../hgr_page_flip.s"

;	.include	"../irq_wait.s"


intro_left_data:
	.incbin "graphics/pq2_bgl.hgr.zx02"
intro_right_data:
	.incbin "graphics/pq2_bgr.hgr.zx02"

dialog1_data:
	.incbin "graphics/pq2_dialog1.hgr.zx02"
dialog2_data:
	.incbin "graphics/pq2_dialog2.hgr.zx02"

.include        "pt3_lib_core.s"
.include        "pt3_lib_init.s"
.include        "pt3_lib_mockingboard_setup.s"
.include        "interrupt_handler.s"
; if you're self patching, detect has to be after interrupt_handler.s
.include        "pt3_lib_mockingboard_detect.s"



.if 0
board_desty:
	.byte	17,17,71,33,84
board_y_start:
	.byte	0,38,93,110,177
board_y_end:
	.byte	36,92,108,176,191
.endif

.align 256

song:
	.incbin "mA2E_tune1.pt3"
