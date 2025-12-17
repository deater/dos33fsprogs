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

	lda	#10
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

animation_loop:

	; draw page1, view page2

	ldx	WHICH
	ldy	patches_page1_aux_h,X
	lda	patches_page1_aux_l,X
	tax

	jsr	patch_graphics_aux


	ldx	WHICH
	ldy	patches_page1_main_h,X
	lda	patches_page1_main_l,X
	tax

	jsr	patch_graphics_main

	jsr	wait_some

;	jsr	wait_until_keypress

	jsr	gr_page_flip


	; draw page2, view page1

	jsr	wait_some

;	jsr	wait_until_keypress

	ldx	WHICH
	ldy	patches_page2_aux_h,X
	lda	patches_page2_aux_l,X
	tax

	jsr	patch_graphics_aux

	ldx	WHICH
	ldy	patches_page2_main_h,X
	lda	patches_page2_main_l,X
	tax

	jsr	patch_graphics_main


	jsr	gr_page_flip

	inc	WHICH
	lda	WHICH

	cmp	#5
	bne	done_wrap

	lda	#0

	sta	WHICH
done_wrap:

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
	jmp	wait_50ms_sound

wait_mockingboard:
	lda	FRAME_RATE
	jmp	wait_ticks

.include "../patch_graphics.s"
.include "../sound_bars.s"
.include "../copy_400.s"
.include "wait_a_bit.s"

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

