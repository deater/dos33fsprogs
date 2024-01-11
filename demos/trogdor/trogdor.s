; TROGDOR 2024

.include "hardware.inc"
.include "zp.inc"
.include "qload.inc"
.include "music.inc"


trogdor_main:

	;======================================
	; init
	;======================================

	lda	#$00
	sta	DRAW_PAGE
	sta	clear_all_color+1

	lda	#$04
	sta	DRAW_PAGE
	jsr	clear_all

	;======================================
	; draw opening scene
	;======================================

	lda	#<trog00_graphics
	sta	zx_src_l+1
	lda	#>trog00_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	bit     SET_GR
        bit     HIRES
        bit     FULLGR
        bit     PAGE1

	jsr	wait_until_keypress

	; second

	lda	#<trog03_graphics
	sta	zx_src_l+1
	lda	#>trog03_graphics
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp



finished:
	jmp	finished



	; start music

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	no_music
	cli	; enable sound
no_music:


               ;0123456789012345678901234567890123456789
merry_text:
	.byte   "      MERRY CHRISTMAS!!! MERRY CHRISTMAS!!! ME"







trog00_graphics:
.incbin "graphics/trog00_trogdor.hgr.zx02"

trog03_graphics:
.incbin "graphics/trog03_man.hgr.zx02"

.include "wait_keypress.s"
.include "irq_wait.s"


