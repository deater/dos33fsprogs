.include "zp.inc"
.include "../hardware.inc"
.include "qload.inc"
.include "music.inc"
.include "common_defines.inc"

	;=======================================
	; draw mixtape animation by @MONO1bit
	;=======================================

mix_tape:

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

	lda	#<graphics_frame2
	sta	zx_src_l+1
	lda	#>graphics_frame2
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

	; draw page1, view page2

	ldx	WHICH
	ldy	patches_page1_h,X
	lda	patches_page1_l,X
	tax

	jsr	patch_graphics

;	jsr	draw_sound_bars

	jsr	wait_some

;	jsr	wait_until_keypress

	jsr	hgr_page_flip


	; draw page2, view page1

	jsr	wait_some

;	jsr	wait_until_keypress

	ldx	WHICH
	ldy	patches_page2_h,X
	lda	patches_page2_l,X
	tax

	jsr	patch_graphics

;	jsr	draw_sound_bars

	jsr	hgr_page_flip

	inc	WHICH
	lda	WHICH
	cmp	#12
	bne	no_wrap
	lda	#0
	sta	WHICH
no_wrap:
	;=====================
	; handle keyboard

	lda	KEYPRESS
	bpl	keep_going

	bit	KEYRESET

check_g:
	cmp	#'G'+$80
	bne	check_o

	jsr	make_green
	jmp	keep_going

check_o:
	cmp	#'O'+$80
	bne	check_plus

	jsr	make_orange
	jmp	keep_going

check_plus:
	cmp	#'+'+$80
	bne	check_minus

	inc	FRAME_RATE

	jmp	keep_going

check_minus:
	cmp	#'-'+$80
	bne	keep_going

	dec	FRAME_RATE		; minimum 0
	bpl	keep_going
	lda	#0
	sta	FRAME_RATE

	beq	keep_going		; bra


keep_going:
	jmp	animation_loop


	;===================================
	; wait some frames

wait_some:

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	bne	wait_mockingboard

wait_nomock:
	lda	FRAME_RATE
	jmp	wait_50ms

wait_mockingboard:
	lda	FRAME_RATE
	jmp	wait_ticks

.include "../patch_graphics_v1.s"
.include "../change_palette.s"
.include "../sound_bars.s"

graphics_frame1:
	.incbin "graphics/tape0001.hgr.zx02"

graphics_frame2:
	.incbin "graphics/tape0002.hgr.zx02"



frame01_frame03_diff:
	.include "graphics/tape01_tape03_diff.inc"
frame03_frame05_diff:
	.include "graphics/tape03_tape05_diff.inc"
frame05_frame07_diff:
	.include "graphics/tape05_tape07_diff.inc"
frame07_frame09_diff:
	.include "graphics/tape07_tape09_diff.inc"
frame09_frame11_diff:
	.include "graphics/tape09_tape11_diff.inc"
frame11_frame13_diff:
	.include "graphics/tape11_tape13_diff.inc"
frame13_frame15_diff:
	.include "graphics/tape13_tape15_diff.inc"
frame15_frame17_diff:
	.include "graphics/tape15_tape17_diff.inc"
frame17_frame19_diff:
	.include "graphics/tape17_tape19_diff.inc"
frame19_frame21_diff:
	.include "graphics/tape19_tape21_diff.inc"
frame21_frame23_diff:
	.include "graphics/tape21_tape23_diff.inc"
frame23_frame01_diff:
	.include "graphics/tape23_tape01_diff.inc"



frame02_frame04_diff:
	.include "graphics/tape02_tape04_diff.inc"
frame04_frame06_diff:
	.include "graphics/tape04_tape06_diff.inc"
frame06_frame08_diff:
	.include "graphics/tape06_tape08_diff.inc"
frame08_frame10_diff:
	.include "graphics/tape08_tape10_diff.inc"
frame10_frame12_diff:
	.include "graphics/tape10_tape12_diff.inc"
frame12_frame14_diff:
	.include "graphics/tape12_tape14_diff.inc"
frame14_frame16_diff:
	.include "graphics/tape14_tape16_diff.inc"
frame16_frame18_diff:
	.include "graphics/tape16_tape18_diff.inc"
frame18_frame20_diff:
	.include "graphics/tape18_tape20_diff.inc"
frame20_frame22_diff:
	.include "graphics/tape20_tape22_diff.inc"
frame22_frame24_diff:
	.include "graphics/tape22_tape24_diff.inc"
frame24_frame02_diff:
	.include "graphics/tape24_tape02_diff.inc"


patches_page1_l:
	.byte	<frame01_frame03_diff
	.byte	<frame03_frame05_diff
	.byte	<frame05_frame07_diff
	.byte	<frame07_frame09_diff
	.byte	<frame09_frame11_diff
	.byte	<frame11_frame13_diff
	.byte	<frame13_frame15_diff
	.byte	<frame15_frame17_diff
	.byte	<frame17_frame19_diff
	.byte	<frame19_frame21_diff
	.byte	<frame21_frame23_diff
	.byte	<frame23_frame01_diff

patches_page1_h:
	.byte	>frame01_frame03_diff
	.byte	>frame03_frame05_diff
	.byte	>frame05_frame07_diff
	.byte	>frame07_frame09_diff
	.byte	>frame09_frame11_diff
	.byte	>frame11_frame13_diff
	.byte	>frame13_frame15_diff
	.byte	>frame15_frame17_diff
	.byte	>frame17_frame19_diff
	.byte	>frame19_frame21_diff
	.byte	>frame21_frame23_diff
	.byte	>frame23_frame01_diff

patches_page2_l:
	.byte	<frame02_frame04_diff
	.byte	<frame04_frame06_diff
	.byte	<frame06_frame08_diff
	.byte	<frame08_frame10_diff
	.byte	<frame10_frame12_diff
	.byte	<frame12_frame14_diff
	.byte	<frame14_frame16_diff
	.byte	<frame16_frame18_diff
	.byte	<frame18_frame20_diff
	.byte	<frame20_frame22_diff
	.byte	<frame22_frame24_diff
	.byte	<frame24_frame02_diff

patches_page2_h:
	.byte	>frame02_frame04_diff
	.byte	>frame04_frame06_diff
	.byte	>frame06_frame08_diff
	.byte	>frame08_frame10_diff
	.byte	>frame10_frame12_diff
	.byte	>frame12_frame14_diff
	.byte	>frame14_frame16_diff
	.byte	>frame16_frame18_diff
	.byte	>frame18_frame20_diff
	.byte	>frame20_frame22_diff
	.byte	>frame22_frame24_diff
	.byte	>frame24_frame02_diff

