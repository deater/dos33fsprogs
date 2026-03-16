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
	; note we do this in a separate file
load_bg:

	bit	KEYRESET	; just to be safe

        bit	PAGE1		; display page1

	;=================================
	; init vars
	;=================================


	;===================================
	; decompress first graphic to page1

;	lda	#$0
;	sta	DRAW_PAGE

;	lda	#<bg1_graphic
;	sta	zx_src_l+1
;	lda	#>bg1_graphic
;	sta	zx_src_h+1

;	lda	#$20

;	jsr	zx02_full_decomp


	;====================================
	; decompress second graphics to page2


	;====================================
	; copy graphic to page 2

;	lda	#<bg1_graphic
;	sta	zx_src_l+1
;	lda	#>bg1_graphic
;	sta	zx_src_h+1

;	lda	#$40

;	jsr	zx02_full_decomp



	lda	#0
	sta	WHICH


	;====================================
	; patch page2

;	lda	#$20
;	sta	DRAW_PAGE

;	ldy	#>patch_page1_8
;	ldx	#<patch_page1_8

;	jsr	patch_graphics

	jsr	wait_until_keypress

	; at this point, PAGE1= 001, PAGE2=008

	;=================================
	; init graphics
	;=================================

	bit	SET_GR
        bit	HIRES
        bit	FULLGR

	lda	#$20
	sta	DRAW_PAGE	; draw to page2
        bit	PAGE1		; display page1



animation_loop:


	;==============================
	; now drawing page2, viewing page1


	ldx	WHICH			; patching page2
	ldy	patches_page2_h,X
	lda	patches_page2_l,X
	tax

	jsr	patch_graphics

	jsr	hgr_page_flip		; display page2

;	jsr	wait_some

	jsr	wait_until_keypress


	;========================================
	; now drawing page1, viewing page2

	ldx	WHICH
	ldy	patches_page1_h,X	; patching page1
	lda	patches_page1_l,X
	tax

	jsr	patch_graphics


	jsr	hgr_page_flip		; display page1

;	jsr	wait_some

	jsr	wait_until_keypress




	inc	WHICH
	lda	WHICH
	cmp	#8
	bne	no_oflo
	lda	#0		; wrap at 8
	sta	WHICH
no_oflo:
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


.include "../patch_graphics_v2.s"


doodle001_doodle003_diff: .include "graphics/a2_doodle001_003_diff.inc"
doodle003_doodle005_diff: .include "graphics/a2_doodle003_005_diff.inc"
doodle005_doodle007_diff: .include "graphics/a2_doodle005_007_diff.inc"
doodle007_doodle001_diff: .include "graphics/a2_doodle007_001_diff.inc"

doodle002_doodle004_diff: .include "graphics/a2_doodle002_004_diff.inc"
doodle004_doodle006_diff: .include "graphics/a2_doodle004_006_diff.inc"
doodle006_doodle008_diff: ;.include "graphics/a2_doodle006_008_diff.inc"
doodle008_doodle002_diff: .include "graphics/a2_doodle008_002_diff.inc"

patches_page1_l:
	.byte	<doodle001_doodle003_diff
	.byte	<doodle003_doodle005_diff
	.byte	<doodle005_doodle007_diff
	.byte	<doodle007_doodle001_diff

patches_page1_h:
	.byte	>doodle001_doodle003_diff
	.byte	>doodle003_doodle005_diff
	.byte	>doodle005_doodle007_diff
	.byte	>doodle007_doodle001_diff

patches_page2_l:
	.byte	<doodle008_doodle002_diff
	.byte	<doodle002_doodle004_diff
	.byte	<doodle004_doodle006_diff
	.byte	<doodle006_doodle008_diff


patches_page2_h:
	.byte	>doodle008_doodle002_diff
	.byte	>doodle002_doodle004_diff
	.byte	>doodle004_doodle006_diff
	.byte	>doodle006_doodle008_diff



;bg1_graphic:
;	.incbin "graphics/a2_doodle001.hgr.zx02"

;bg2_graphic:
;	.incbin "graphics/a2_doodle002.hgr.zx02"


;patch_page1_8:
;	.include "graphics/a2_doodle001_008_diff.inc"
