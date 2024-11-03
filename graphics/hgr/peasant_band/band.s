; Rather Dashing Band

;
; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"

DEBUG=0

driven_start:
	;=====================
	; initializations
	;=====================

	jsr	hardware_detect

	jsr	hgr_make_tables


	;===================
	; restart?
	;===================
restart:
	lda	#0
	sta	DRAW_PAGE


	;==================================
	; setup music
	;==================================

	; read/write RAM, use $d000 bank1
	bit	$C083
	bit	$C083

	lda     #<music_compressed
        sta     zx_src_l+1
        lda     #>music_compressed
        sta     zx_src_h+1
        lda     #$d0
        jsr     zx02_full_decomp


	lda	#0
	sta	DONE_PLAYING

	lda	#1
	sta	LOOP

	; patch mockingboard

	lda	SOUND_STATUS
	beq	skip_mbp1

        jsr     mockingboard_patch      ; patch to work in slots other than 4?

skip_mbp1:

	;=======================
	; Set up 50Hz interrupt
	;========================

	jsr	mockingboard_init
	jsr	mockingboard_setup_interrupt

	;============================
	; Init the Mockingboard
	;============================

	jsr	reset_ay_both
	jsr	clear_ay_both

	;==================
	; init song
	;==================

	jsr	pt3_init_song

dont_enable_mc:

skip_all_checks:


	cli		; start interrupts (music)

	jsr	intro_start


forever:
	jmp	forever

	.include	"wait_keypress.s"
	.include	"zx02_optim.s"


.include "pt3_lib_mockingboard_patch.s"

.include "hardware_detect.s"


PT3_ENABLE_APPLE_IIC = 1

	.include	"wait.s"

	.include	"lc_detect.s"

	.include	"wait_a_bit.s"
	.include	"gr_fast_clear.s"
	.include	"text_print.s"
	.include	"gr_offsets.s"
	.include	"gs_interrupt.s"

	.include	"pt3_lib_detect_model.s"
        .include	"pt3_lib_core.s"
        .include	"pt3_lib_init.s"
        .include	"pt3_lib_mockingboard_setup.s"
        .include	"interrupt_handler.s"
        .include	"pt3_lib_mockingboard_detect.s"

mod7_table      = $1c00
div7_table      = $1d00
hposn_low       = $1e00
hposn_high      = $1f00

        .include        "hgr_table.s"

	.include	"band_core.s"


;.align $100
PT3_LOC = $D000

music_compressed:
.incbin "music/bugsy_still_alive.pt3.zx02"

