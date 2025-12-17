.include "zp.inc"
.include "../hardware.inc"
.include "qload.inc"
.include "music.inc"
.include "common_defines.inc"

	;=======================================
	; draw TMBG animation
	;=======================================

tmbg:

	bit	KEYRESET	; just to be safe

	;=================================
	; init vars
	;=================================

	lda	#3
	sta	FRAME_RATE

	;=================================
	; init double-lores graphics
	;=================================

	bit	SET_GR
	bit	LORES
	sta	EIGHTYCOLON	; 80 column mode
	bit	FULLGR
	sta	CLRAN3		; set double lores
	sta	EIGHTYSTOREOFF	; normal PAGE1/PAGE2 behavior

        bit	PAGE2		; display page2

	;========================================
	; decompress frame1 to PAGE1

	lda	#$0
	sta	DRAW_PAGE

	lda	#<graphics_frame1_aux
	sta	zx_src_l+1
	lda	#>graphics_frame1_aux
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	; Copy $2000 to AUX $400, skipping holes

	ldx	#$20
	jsr	copy_to_400_aux


	lda	#<graphics_frame1_main
	sta	zx_src_l+1
	lda	#>graphics_frame1_main
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	ldx	#$20
	jsr	copy_to_400_main

	;========================================
	; decompress frame2 to PAGE2

	lda	#$4
	sta	DRAW_PAGE

	lda	#<graphics_frame2_aux
	sta	zx_src_l+1
	lda	#>graphics_frame2_aux
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	;

	ldx	#$20
	jsr	copy_to_400_aux

	;

	lda	#<graphics_frame2_main
	sta	zx_src_l+1
	lda	#>graphics_frame2_main
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	ldx	#$20
	jsr	copy_to_400_main

oop:
	jsr	wait_until_keypress
	bit	PAGE1
	jsr	wait_until_keypress
	bit	PAGE2
	jmp	oop


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
.if 0
	ldx	WHICH
	ldy	patches_page1_h,X
	lda	patches_page1_l,X
	tax
.endif
	jsr	patch_graphics

	jsr	draw_sound_bars

	jsr	wait_some

;	jsr	wait_until_keypress

	jsr	hgr_page_flip


	; draw page2, view page1
.if 0
	jsr	wait_some

;	jsr	wait_until_keypress

	ldx	WHICH
	ldy	patches_page2_h,X
	lda	patches_page2_l,X
	tax
.endif
	jsr	patch_graphics

	jsr	draw_sound_bars

	jsr	hgr_page_flip

	inc	WHICH
	lda	WHICH
	and	#$3		; wrap at 4
	sta	WHICH

	;=====================
	; handle keyboard

	lda	KEYPRESS
	bpl	keep_going

	bit	KEYRESET

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

.include "../patch_graphics.s"
.include "../sound_bars.s"
.include "../copy_400.s"


graphics_frame1_aux:
	.incbin "graphics/tmbg01.aux.zx02"

graphics_frame2_aux:
	.incbin "graphics/tmbg02.aux.zx02"

graphics_frame1_main:
	.incbin "graphics/tmbg01.main.zx02"

graphics_frame2_main:
	.incbin "graphics/tmbg02.main.zx02"



	.include "graphics/frame1_frame3_diff.inc"
	.include "graphics/frame3_frame5_diff.inc"
	.include "graphics/frame5_frame2_diff.inc"
	.include "graphics/frame2_frame4_diff.inc"
	.include "graphics/frame4_frame1_diff.inc"

patches_page1_aux_l:
	.byte	<f13_aux_diff
	.byte	<f35_aux_diff
	.byte	<f52_aux_diff
	.byte	<f24_aux_diff
	.byte	<f41_aux_diff

patches_page1_aux_h:
	.byte	>f13_aux_diff
	.byte	>f35_aux_diff
	.byte	>f52_aux_diff
	.byte	>f24_aux_diff
	.byte	>f41_aux_diff

patches_page1_main_l:
	.byte	<f13_main_diff
	.byte	<f35_main_diff
	.byte	<f52_main_diff
	.byte	<f24_main_diff
	.byte	<f41_main_diff

patches_page1_main_h:
	.byte	>f13_main_diff
	.byte	>f35_main_diff
	.byte	>f52_main_diff
	.byte	>f24_main_diff
	.byte	>f41_main_diff

patches_page2_aux_l:
	.byte	<f24_aux_diff
	.byte	<f41_aux_diff
	.byte	<f13_aux_diff
	.byte	<f35_aux_diff
	.byte	<f52_aux_diff

patches_page2_aux_h:
	.byte	>f24_aux_diff
	.byte	>f41_aux_diff
	.byte	>f13_aux_diff
	.byte	>f35_aux_diff
	.byte	>f52_aux_diff

patches_page2_main_l:
	.byte	<f24_main_diff
	.byte	<f41_main_diff
	.byte	<f13_main_diff
	.byte	<f35_main_diff
	.byte	<f52_main_diff

patches_page2_main_h:
	.byte	>f24_main_diff
	.byte	>f41_main_diff
	.byte	>f13_main_diff
	.byte	>f35_main_diff
	.byte	>f52_main_diff






