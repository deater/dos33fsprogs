.include "zp.inc"
.include "../hardware.inc"
.include "qload.inc"
;.include "music.inc"
.include "common_defines.inc"


	;===========================================
	; draw question by TryPixelAgain @TryPixAgn
	;===========================================

gentfsh_question:

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

	lda	#$0
	sta	WHICH

	;====================================
	; patch page2

	lda	#$20
	sta	DRAW_PAGE

	ldy	#>patch_page1_2
	ldx	#<patch_page1_2

	jsr	patch_graphics

	lda	#$0
	sta	DRAW_PAGE

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
	cmp	#4
	bne	no_oflo
	lda	#0		; wrap at 4
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


.include "../patch_graphics_v1.s"
.include "../change_palette.s"

question01_question03_diff: .include "graphics/q0001_0003_diff.inc"
question03_question05_diff: .include "graphics/q0003_0005_diff.inc"
question05_question07_diff: .include "graphics/q0005_0007_diff.inc"
question07_question01_diff: .include "graphics/q0007_0001_diff.inc"

question02_question04_diff: .include "graphics/q0002_0004_diff.inc"
question04_question06_diff: .include "graphics/q0004_0006_diff.inc"
question06_question08_diff: .include "graphics/q0006_0008_diff.inc"
question08_question02_diff: .include "graphics/q0008_0002_diff.inc"


patches_page1_l:
	.byte	<question01_question03_diff
	.byte	<question03_question05_diff
	.byte	<question05_question07_diff
	.byte	<question07_question01_diff

patches_page1_h:
	.byte	>question01_question03_diff
	.byte	>question03_question05_diff
	.byte	>question05_question07_diff
	.byte	>question07_question01_diff

patches_page2_l:
	.byte	<question02_question04_diff
	.byte	<question04_question06_diff
	.byte	<question06_question08_diff
	.byte	<question08_question02_diff

patches_page2_h:
	.byte	>question02_question04_diff
	.byte	>question04_question06_diff
	.byte	>question06_question08_diff
	.byte	>question08_question02_diff

bg1_graphic:
	.incbin "graphics/q0001.hgr.zx02"

;bg2_graphic:
;	.incbin "graphics/q0002.hgr.zx02"


patch_page1_2:
	.include "graphics/q0001_0002_diff.inc"
