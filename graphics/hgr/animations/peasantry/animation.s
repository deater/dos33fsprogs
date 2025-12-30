.include "zp.inc"
.include "../hardware.inc"
.include "qload.inc"
.include "music.inc"
.include "common_defines.inc"

	;=======================================
	; draw the rain down in peasantry
	;=======================================

peasantry:

	bit	KEYRESET	; just to be safe

	;=================================
	; init vars
	;=================================

	lda	#3
	sta	FRAME_RATE

	;=================================
	; init graphics
	;=================================

	bit	SET_GR
        bit	HIRES
        bit	FULLGR

        bit	PAGE2		; display page1


	;===========================
	; decompress frame1 to $A000

	lda	#$0
	sta	DRAW_PAGE

	lda	#<graphics_frame1
	sta	zx_src_l+1
	lda	#>graphics_frame1
	sta	zx_src_h+1

	lda	#$A0

	jsr	zx02_full_decomp

;	jsr	grey_sky

	;===========================
	; decompress frame2 to page2

;	lda	#<graphics_frame1
;	sta	zx_src_l+1
;	lda	#>graphics_frame1
;	sta	zx_src_h+1

;	lda	#$40

;	jsr	zx02_full_decomp


	;=======================
	; start music

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	no_music

yes_music:
	cli
no_music:

	lda	#0
	sta	DRAW_PAGE
	sta	WHICH
	sta	WHICH_RAIN

animation_loop:

	jsr	hgr_copy

	jsr	draw_rain

	jsr	hgr_page_flip

	;=====================
	; handle keyboard
;wait_loop:
;	lda	KEYPRESS
;	bpl	wait_loop

;	bit	KEYRESET


keep_going:

	inc	WHICH_RAIN
	lda	WHICH_RAIN
	and	#$1
	sta	WHICH_RAIN

	jmp	animation_loop


.include "rain.s"

;.include "../patch_graphics.s"
;.include "../change_palette.s"
;.include "../sound_bars.s"

.include "hgr_copy.s"
.include "grey_sky.s"

graphics_frame1:
	.incbin "graphics/kerrek1.hgr.zx02"

