.include "zp.inc"
.include "hardware.inc"
.include "qload.inc"
.include "music.inc"
.include "common_defines.inc"

	;=======================================
	; draw space lady animation by @redlo_to
	;=======================================

space_lady:

	bit	KEYRESET	; just to be safe

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

	jsr	wait_until_keypress

	jsr	hgr_page_flip


	; draw page2, view page1

	jsr	wait_until_keypress

	ldx	WHICH
	ldy	patches_page2_h,X
	lda	patches_page2_l,X
	tax

	jsr	patch_graphics

	jsr	hgr_page_flip

	inc	WHICH
	lda	WHICH
	and	#$3		; wrap at 4
	sta	WHICH

	jmp	animation_loop




	;=================================
	; patch graphics
	;=================================

patch_graphics:

	stx	INL
	sty	INH

	; reset output

	clc
	lda	#$20
	adc	DRAW_PAGE
	sta	patch_graphics_smc+2

	lda	#$0
	sta	patch_graphics_smc+1

	ldy	#0
patch_graphics_loop:
	jsr	get_next

	sta	patch_length_smc+1

	cmp	#$ff
	beq	done_patch_graphics_loop

;	iny
;	clc
;	lda	(INL),Y

	jsr	get_next

	adc	patch_graphics_smc+1
	sta	patch_graphics_smc+1
;	iny
;	lda	(INL),Y

	jsr	get_next

	adc	patch_graphics_smc+2
	sta	patch_graphics_smc+2

	ldx	#0
patch_graphics_inner:
;	iny

	jsr	get_next
;	lda	(INL),Y
patch_graphics_smc:
	sta	$2000,X

	inx
patch_length_smc:
	cpx	#5
	bne	patch_graphics_inner


	jmp	patch_graphics_loop

done_patch_graphics_loop:

	rts


get_next:
	lda	(INL),Y
	inc	INL
	bne	noflo
	inc	INH
noflo:

	rts

graphics_frame1:
	.incbin "graphics/a2_frame0001.hgr.zx02"

graphics_frame2:
	.incbin "graphics/a2_frame0002.hgr.zx02"



frame1_frame3_diff:
	.include "graphics/frame1_frame3_diff.inc"

frame3_frame5_diff:
	.include "graphics/frame3_frame5_diff.inc"

frame5_frame7_diff:
	.include "graphics/frame5_frame7_diff.inc"

frame7_frame1_diff:
	.include "graphics/frame7_frame1_diff.inc"


frame2_frame4_diff:
	.include "graphics/frame2_frame4_diff.inc"

frame4_frame6_diff:
	.include "graphics/frame4_frame6_diff.inc"

frame6_frame8_diff:
	.include "graphics/frame6_frame8_diff.inc"

frame8_frame2_diff:
	.include "graphics/frame8_frame2_diff.inc"


patches_page1_l:
	.byte	<frame1_frame3_diff
	.byte	<frame3_frame5_diff
	.byte	<frame5_frame7_diff
	.byte	<frame7_frame1_diff

patches_page1_h:
	.byte	>frame1_frame3_diff
	.byte	>frame3_frame5_diff
	.byte	>frame5_frame7_diff
	.byte	>frame7_frame1_diff


patches_page2_l:
	.byte	<frame2_frame4_diff
	.byte	<frame4_frame6_diff
	.byte	<frame6_frame8_diff
	.byte	<frame8_frame2_diff

patches_page2_h:
	.byte	>frame2_frame4_diff
	.byte	>frame4_frame6_diff
	.byte	>frame6_frame8_diff
	.byte	>frame8_frame2_diff


