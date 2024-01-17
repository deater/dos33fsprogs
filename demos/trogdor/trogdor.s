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

	lda	#$0
	sta	DRAW_PAGE

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

	; draw left flame

	lda	#<left_flame_small
	sta	INL
	lda	#>left_flame_small
	sta	INH
	lda	#<left_flame_small_mask
	sta	MASKL
	lda	#>left_flame_small_mask
	sta	MASKH

	lda	#8
	sta	SPRITE_X

	lda	#152
	sta	SPRITE_Y

	jsr	hgr_draw_sprite_big_mask

	; draw right flame

	lda	#<right_flame_big
	sta	INL
	lda	#>right_flame_big
	sta	INH
	lda	#<right_flame_big_mask
	sta	MASKL
	lda	#>right_flame_big_mask
	sta	MASKH

	lda	#24
	sta	SPRITE_X

	lda	#54
	sta	SPRITE_Y

	jsr	hgr_draw_sprite_big_mask



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


hposn_low       = $1e00
hposn_high      = $1f00

.include "hgr_sprite_big_mask.s"

.include "graphics/flame_sprites.inc"
