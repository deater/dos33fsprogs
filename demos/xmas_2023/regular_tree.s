; Regular Tree

; =============================================================================
; ROUTINE MAIN
; =============================================================================

regular_tree:

	lda	#$00
	sta	DRAW_PAGE
	sta	clear_all_color+1

	lda	#$04
	sta	DRAW_PAGE
	jsr	clear_all


	bit	PAGE2		; set page 2
;	bit	SET_TEXT	; set text
	bit	LORES		; set lo-res

	lda	#0
	sta	FRAME

	; load image offscreen $6000

	lda	#<mask1_data
	sta	zx_src_l+1
	lda	#>mask1_data
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	; load image offscreen $6400

	lda	#<mask2_data
	sta	zx_src_l+1
	lda	#>mask2_data
	sta	zx_src_h+1
	lda	#$64
	jsr	zx02_full_decomp

	; load image offscreen $6800

	lda	#<mask3_data
	sta	zx_src_l+1
	lda	#>mask3_data
	sta	zx_src_h+1
	lda	#$68
	jsr	zx02_full_decomp

	; load image offscreen $6C00

	lda	#<mask4_data
	sta	zx_src_l+1
	lda	#>mask4_data
	sta	zx_src_h+1
	lda	#$6C
	jsr	zx02_full_decomp

	; load image offscreen $7000

	lda	#<mask5_data
	sta	zx_src_l+1
	lda	#>mask5_data
	sta	zx_src_h+1
	lda	#$70
	jsr	zx02_full_decomp

	; load image offscreen $7400

	lda	#<mask6_data
	sta	zx_src_l+1
	lda	#>mask6_data
	sta	zx_src_h+1
	lda	#$74
	jsr	zx02_full_decomp

	; load image offscreen $7800

	lda	#<mask7_data
	sta	zx_src_l+1
	lda	#>mask7_data
	sta	zx_src_h+1
	lda	#$78
	jsr	zx02_full_decomp

	; load image offscreen $7C00

	lda	#<mask8_data
	sta	zx_src_l+1
	lda	#>mask8_data
	sta	zx_src_h+1
	lda	#$7C
	jsr	zx02_full_decomp


	lda	#0
	sta	OFFSET


reset_tree_loop:
	lda	#$60
	sta	TREE_COUNT

regular_tree_loop:
	ldx	TREE_COUNT
	jsr	gr_fast_copy

;	jsr	wait_until_keypress

	jsr	scroll_loop

	jsr	page_flip

	lda	#128
	jsr	wait

	inc	TREE_COUNT
	inc	TREE_COUNT
	inc	TREE_COUNT
	inc	TREE_COUNT

	lda	TREE_COUNT
	cmp	#$80
	bne	done_regular_tree
	jmp	reset_tree_loop

done_regular_tree:
	jmp	regular_tree_loop



	;==========================
	; gr_fast_copy
	;==========================
	; page to start at in X

gr_fast_copy:

	stx	fcl_smc1+2
	stx	fcl_smc2+2
	inx
	stx	fcl_smc3+2
	stx	fcl_smc4+2
	inx
	stx	fcl_smc5+2
	stx	fcl_smc6+2
	inx
	stx	fcl_smc7+2
	stx	fcl_smc8+2

	lda	DRAW_PAGE
	clc
	adc	#4
	tax

	stx	fcl_smc11+2
	stx	fcl_smc12+2
	inx
	stx	fcl_smc13+2
	stx	fcl_smc14+2
	inx
	stx	fcl_smc15+2
	stx	fcl_smc16+2
	inx
	stx	fcl_smc17+2
	stx	fcl_smc18+2

	ldy	#120
gr_fast_copy_loop:

fcl_smc1:
	lda	$7000,Y
fcl_smc11:
	sta	$400,Y

fcl_smc2:
	lda	$7080,Y
fcl_smc12:
	sta	$480,Y

fcl_smc3:
	lda	$7100,Y
fcl_smc13:
	sta	$500,Y

fcl_smc4:
	lda	$7180,Y
fcl_smc14:
	sta	$580,Y

fcl_smc5:
	lda	$7200,Y
fcl_smc15:
	sta	$600,Y

fcl_smc6:
	lda	$7280,Y
fcl_smc16:
	sta	$680,Y

fcl_smc7:
	lda	$7300,Y
fcl_smc17:
	sta	$700,Y

fcl_smc8:
	lda	$7380,Y
fcl_smc18:
	sta	$780,Y

	dey
	bpl	gr_fast_copy_loop

	rts



page_flip:
	lda	DRAW_PAGE
	beq	flip_draw_page2

flip_draw_page_1:
	bit	PAGE2
	lda	#0
	beq	done_page_flip		; bra

flip_draw_page2:
	bit	PAGE1
	lda	#4
done_page_flip:
	sta	DRAW_PAGE
	rts

