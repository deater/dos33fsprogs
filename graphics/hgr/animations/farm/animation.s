.include "zp.inc"
.include "../hardware.inc"
.include "qload.inc"
;.include "music.inc"
.include "common_defines.inc"


	;=======================================
	; draw farmtown by gentfish
	;=======================================

gentfsh_farm:

	bit	KEYRESET	; just to be safe

	;=================================
	; init vars
	;=================================

	lda	#3
	sta	FRAME_RATE



.if 0
	;=======================
	; start music

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	no_music

yes_music:
	cli
no_music:
.endif


	;=======================================
	; load backgrounds from animation
	;=======================================

load_bg:

	bit	KEYRESET	; just to be safe

	;=================================
	; init vars
	;=================================


	;===================================
	; decompress first graphic to page1

	lda	#$0
	sta	DRAW_PAGE

	lda	#<bg1_graphic
	sta	zx_src_l+1
	lda	#>bg1_graphic
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp


	;====================================
	; decompress second graphics to page2

	lda	#<bg1_graphic
	sta	zx_src_l+1
	lda	#>bg1_graphic
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp

	lda	#0
	sta	DRAW_PAGE
	sta	WHICH

	;====================================
	; patch page2

	ldy	#>patch_page1_2
	ldx	#<patch_page1_2

	jsr	patch_graphics


	;=================================
	; init graphics
	;=================================

	bit	SET_GR
        bit	HIRES
        bit	FULLGR

        bit	PAGE2		; display page2



animation_loop:

	; draw page1, view page2

	ldx	WHICH
	ldy	patches_page1_h,X
	lda	patches_page1_l,X
	tax

	jsr	patch_graphics

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

	jsr	hgr_page_flip

	inc	WHICH
	lda	WHICH
	cmp	#24
	bne	no_oflo
	lda	#0		; wrap at 48
	sta	WHICH
no_oflo:
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
	; wait some losers

wait_some:

;	lda	SOUND_STATUS
;	and	#SOUND_MOCKINGBOARD
;	bne	wait_mockingboard

wait_nomock:
	ldx	FRAME_RATE
	jmp	wait_50xms

;wait_mockingboard:
;	lda	FRAME_RATE
;	jmp	wait_ticks


.include "../patch_graphics.s"
.include "../change_palette.s"

farm01_farm03_diff: .include "graphics/a2_gentfish_farm01_03_diff.inc"
farm03_farm05_diff: .include "graphics/a2_gentfish_farm03_05_diff.inc"
farm05_farm07_diff: .include "graphics/a2_gentfish_farm05_07_diff.inc"
farm07_farm09_diff: .include "graphics/a2_gentfish_farm07_09_diff.inc"
farm09_farm11_diff: .include "graphics/a2_gentfish_farm09_11_diff.inc"
farm11_farm13_diff: .include "graphics/a2_gentfish_farm11_13_diff.inc"
farm13_farm15_diff: .include "graphics/a2_gentfish_farm13_15_diff.inc"
farm15_farm17_diff: .include "graphics/a2_gentfish_farm15_17_diff.inc"
farm17_farm19_diff: .include "graphics/a2_gentfish_farm17_19_diff.inc"
farm19_farm21_diff: .include "graphics/a2_gentfish_farm19_21_diff.inc"
farm21_farm23_diff: .include "graphics/a2_gentfish_farm21_23_diff.inc"
farm23_farm25_diff: .include "graphics/a2_gentfish_farm23_25_diff.inc"
farm25_farm27_diff: .include "graphics/a2_gentfish_farm25_27_diff.inc"
farm27_farm29_diff: .include "graphics/a2_gentfish_farm27_29_diff.inc"
farm29_farm31_diff: .include "graphics/a2_gentfish_farm29_31_diff.inc"
farm31_farm33_diff: .include "graphics/a2_gentfish_farm31_33_diff.inc"
farm33_farm35_diff: .include "graphics/a2_gentfish_farm33_35_diff.inc"
farm35_farm37_diff: .include "graphics/a2_gentfish_farm35_37_diff.inc"
farm37_farm39_diff: .include "graphics/a2_gentfish_farm37_39_diff.inc"
farm39_farm41_diff: .include "graphics/a2_gentfish_farm39_41_diff.inc"
farm41_farm43_diff: .include "graphics/a2_gentfish_farm41_43_diff.inc"
farm43_farm45_diff: .include "graphics/a2_gentfish_farm43_45_diff.inc"
farm45_farm47_diff: .include "graphics/a2_gentfish_farm45_47_diff.inc"
farm47_farm01_diff: .include "graphics/a2_gentfish_farm47_01_diff.inc"

farm02_farm04_diff: .include "graphics/a2_gentfish_farm02_04_diff.inc"
farm04_farm06_diff: .include "graphics/a2_gentfish_farm04_06_diff.inc"
farm06_farm08_diff: .include "graphics/a2_gentfish_farm06_08_diff.inc"
farm08_farm10_diff: .include "graphics/a2_gentfish_farm08_10_diff.inc"
farm10_farm12_diff: .include "graphics/a2_gentfish_farm10_12_diff.inc"
farm12_farm14_diff: .include "graphics/a2_gentfish_farm12_14_diff.inc"
farm14_farm16_diff: .include "graphics/a2_gentfish_farm14_16_diff.inc"
farm16_farm18_diff: .include "graphics/a2_gentfish_farm16_18_diff.inc"
farm18_farm20_diff: .include "graphics/a2_gentfish_farm18_20_diff.inc"
farm20_farm22_diff: .include "graphics/a2_gentfish_farm20_22_diff.inc"
farm22_farm24_diff: .include "graphics/a2_gentfish_farm22_24_diff.inc"
farm24_farm26_diff: .include "graphics/a2_gentfish_farm24_26_diff.inc"
farm26_farm28_diff: .include "graphics/a2_gentfish_farm26_28_diff.inc"
farm28_farm30_diff: .include "graphics/a2_gentfish_farm28_30_diff.inc"
farm30_farm32_diff: .include "graphics/a2_gentfish_farm30_32_diff.inc"
farm32_farm34_diff: .include "graphics/a2_gentfish_farm32_34_diff.inc"
farm34_farm36_diff: .include "graphics/a2_gentfish_farm34_36_diff.inc"
farm36_farm38_diff: .include "graphics/a2_gentfish_farm36_38_diff.inc"
farm38_farm40_diff: .include "graphics/a2_gentfish_farm38_40_diff.inc"
farm40_farm42_diff: .include "graphics/a2_gentfish_farm40_42_diff.inc"
farm42_farm44_diff: .include "graphics/a2_gentfish_farm42_44_diff.inc"
farm44_farm46_diff: .include "graphics/a2_gentfish_farm44_46_diff.inc"
farm46_farm48_diff: .include "graphics/a2_gentfish_farm46_48_diff.inc"
farm48_farm02_diff: .include "graphics/a2_gentfish_farm48_02_diff.inc"


patches_page1_l:
	.byte	<farm01_farm03_diff
	.byte	<farm03_farm05_diff
	.byte	<farm05_farm07_diff
	.byte	<farm07_farm09_diff
	.byte	<farm09_farm11_diff
	.byte	<farm11_farm13_diff
	.byte	<farm13_farm15_diff
	.byte	<farm15_farm17_diff
	.byte	<farm17_farm19_diff
	.byte	<farm19_farm21_diff
	.byte	<farm21_farm23_diff
	.byte	<farm23_farm25_diff
	.byte	<farm25_farm27_diff
	.byte	<farm27_farm29_diff
	.byte	<farm29_farm31_diff
	.byte	<farm31_farm33_diff
	.byte	<farm33_farm35_diff
	.byte	<farm35_farm37_diff
	.byte	<farm37_farm39_diff
	.byte	<farm39_farm41_diff
	.byte	<farm41_farm43_diff
	.byte	<farm43_farm45_diff
	.byte	<farm45_farm47_diff
	.byte	<farm47_farm01_diff



patches_page1_h:
	.byte	>farm01_farm03_diff
	.byte	>farm03_farm05_diff
	.byte	>farm05_farm07_diff
	.byte	>farm07_farm09_diff
	.byte	>farm09_farm11_diff
	.byte	>farm11_farm13_diff
	.byte	>farm13_farm15_diff
	.byte	>farm15_farm17_diff
	.byte	>farm17_farm19_diff
	.byte	>farm19_farm21_diff
	.byte	>farm21_farm23_diff
	.byte	>farm23_farm25_diff
	.byte	>farm25_farm27_diff
	.byte	>farm27_farm29_diff
	.byte	>farm29_farm31_diff
	.byte	>farm31_farm33_diff
	.byte	>farm33_farm35_diff
	.byte	>farm35_farm37_diff
	.byte	>farm37_farm39_diff
	.byte	>farm39_farm41_diff
	.byte	>farm41_farm43_diff
	.byte	>farm43_farm45_diff
	.byte	>farm45_farm47_diff
	.byte	>farm47_farm01_diff


patches_page2_l:
	.byte	<farm02_farm04_diff
	.byte	<farm04_farm06_diff
	.byte	<farm06_farm08_diff
	.byte	<farm08_farm10_diff
	.byte	<farm10_farm12_diff
	.byte	<farm12_farm14_diff
	.byte	<farm14_farm16_diff
	.byte	<farm16_farm18_diff
	.byte	<farm18_farm20_diff
	.byte	<farm20_farm22_diff
	.byte	<farm22_farm24_diff
	.byte	<farm24_farm26_diff
	.byte	<farm26_farm28_diff
	.byte	<farm28_farm30_diff
	.byte	<farm30_farm32_diff
	.byte	<farm32_farm34_diff
	.byte	<farm34_farm36_diff
	.byte	<farm36_farm38_diff
	.byte	<farm38_farm40_diff
	.byte	<farm40_farm42_diff
	.byte	<farm42_farm44_diff
	.byte	<farm44_farm46_diff
	.byte	<farm46_farm48_diff
	.byte	<farm48_farm02_diff



patches_page2_h:
	.byte	>farm02_farm04_diff
	.byte	>farm04_farm06_diff
	.byte	>farm06_farm08_diff
	.byte	>farm08_farm10_diff
	.byte	>farm10_farm12_diff
	.byte	>farm12_farm14_diff
	.byte	>farm14_farm16_diff
	.byte	>farm16_farm18_diff
	.byte	>farm18_farm20_diff
	.byte	>farm20_farm22_diff
	.byte	>farm22_farm24_diff
	.byte	>farm24_farm26_diff
	.byte	>farm26_farm28_diff
	.byte	>farm28_farm30_diff
	.byte	>farm30_farm32_diff
	.byte	>farm32_farm34_diff
	.byte	>farm34_farm36_diff
	.byte	>farm36_farm38_diff
	.byte	>farm38_farm40_diff
	.byte	>farm40_farm42_diff
	.byte	>farm42_farm44_diff
	.byte	>farm44_farm46_diff
	.byte	>farm46_farm48_diff
	.byte	>farm48_farm02_diff

bg1_graphic:
	.incbin "graphics/a2_gentfish_farm01.hgr.zx02"

;bg2_graphic:
;	.incbin "graphics/a2_gentfish_farm02.hgr.zx02"


patch_page1_2:
	.include "graphics/a2_gentfish_farm01_02_diff.inc"
