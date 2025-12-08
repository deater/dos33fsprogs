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
	; decompress frame1 to page1

	lda	#$0
	sta	DRAW_PAGE

	lda	#<graphics_frame1
	sta	zx_src_l+1
	lda	#>graphics_frame1
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	;===========================
	; decompress frame2 to page2

	lda	#<graphics_frame1
	sta	zx_src_l+1
	lda	#>graphics_frame1
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp


	;=======================
	; start music

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	no_music

yes_music:
	cli
no_music:

	; so frame1 is on page1
	;    frame2 is on page2

	;	show page2 (frame2)			FRAME2
	;	page1	1->3, fiip to page1		FRAME3
	; 	page2	2->4, flip to page2		FRAME4
	;	page1	3->5, flip to page1		FRAME5

	lda	#0
	sta	DRAW_PAGE
	sta	WHICH

animation_loop:

	jsr	hgr_page_flip

	;=====================
	; handle keyboard
wait_loop:
	lda	KEYPRESS
	bmi	wait_loop

	bit	KEYRESET


keep_going:
	jmp	animation_loop



;.include "../patch_graphics.s"
;.include "../change_palette.s"
;.include "../sound_bars.s"

graphics_frame1:
	.incbin "graphics/kerrek1.hgr.zx02"

