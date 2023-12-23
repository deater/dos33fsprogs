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


	;===================================
	; load images offscreen $4000-$6000

	; load image offscreen $4000

	lda	#<mask01_data
	sta	zx_src_l+1
	lda	#>mask01_data
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

	; load image offscreen $4400

	lda	#<mask02_data
	sta	zx_src_l+1
	lda	#>mask02_data
	sta	zx_src_h+1
	lda	#$44
	jsr	zx02_full_decomp

	; load image offscreen $4800

	lda	#<mask03_data
	sta	zx_src_l+1
	lda	#>mask03_data
	sta	zx_src_h+1
	lda	#$48
	jsr	zx02_full_decomp

	; load image offscreen $5000

	lda	#<mask04_data
	sta	zx_src_l+1
	lda	#>mask04_data
	sta	zx_src_h+1
	lda	#$4C
	jsr	zx02_full_decomp

	; load image offscreen $5000

	lda	#<mask05_data
	sta	zx_src_l+1
	lda	#>mask05_data
	sta	zx_src_h+1
	lda	#$50
	jsr	zx02_full_decomp

	; load image offscreen $5400

	lda	#<mask06_data
	sta	zx_src_l+1
	lda	#>mask06_data
	sta	zx_src_h+1
	lda	#$54
	jsr	zx02_full_decomp

	; load image offscreen $5800

	lda	#<mask07_data
	sta	zx_src_l+1
	lda	#>mask07_data
	sta	zx_src_h+1
	lda	#$58
	jsr	zx02_full_decomp

	; load image offscreen $5C00

	lda	#<mask08_data
	sta	zx_src_l+1
	lda	#>mask08_data
	sta	zx_src_h+1
	lda	#$5C
	jsr	zx02_full_decomp


	; load image offscreen $6000

	lda	#<mask09_data
	sta	zx_src_l+1
	lda	#>mask09_data
	sta	zx_src_h+1
	lda	#$60
	jsr	zx02_full_decomp

	; load image offscreen $6400

	lda	#<mask10_data
	sta	zx_src_l+1
	lda	#>mask10_data
	sta	zx_src_h+1
	lda	#$64
	jsr	zx02_full_decomp

	; load image offscreen $6800

	lda	#<mask11_data
	sta	zx_src_l+1
	lda	#>mask11_data
	sta	zx_src_h+1
	lda	#$68
	jsr	zx02_full_decomp

	; load image offscreen $6C00

	lda	#<mask12_data
	sta	zx_src_l+1
	lda	#>mask12_data
	sta	zx_src_h+1
	lda	#$6C
	jsr	zx02_full_decomp

	; load image offscreen $7000

	lda	#<mask13_data
	sta	zx_src_l+1
	lda	#>mask13_data
	sta	zx_src_h+1
	lda	#$70
	jsr	zx02_full_decomp

	; load image offscreen $7400

	lda	#<mask14_data
	sta	zx_src_l+1
	lda	#>mask14_data
	sta	zx_src_h+1
	lda	#$74
	jsr	zx02_full_decomp

	; load image offscreen $7800

	lda	#<mask15_data
	sta	zx_src_l+1
	lda	#>mask15_data
	sta	zx_src_h+1
	lda	#$78
	jsr	zx02_full_decomp

	; load image offscreen $7C00

	lda	#<mask16_data
	sta	zx_src_l+1
	lda	#>mask16_data
	sta	zx_src_h+1
	lda	#$7C
	jsr	zx02_full_decomp


	lda	#0
	sta	OFFSET
	sta	FRAMEL
	sta	FRAMEH


reset_tree_loop:
	lda	#$40
	sta	TREE_COUNT

regular_tree_loop:
	ldx	TREE_COUNT
	jsr	gr_fast_copy

	jsr	scroll_loop

	jsr	page_flip

	; update frame count

	inc	FRAMEL                                                  ; 5
	lda	FRAMEL                                                  ; 3
	and	#$3f                                                    ; 2
	sta	FRAMEL                                                  ; 3
	bne	frame_noflo4                                            ; 2/3
	inc	FRAMEH                                                  ; 5
frame_noflo4:

	lda	KEYPRESS
	bmi	done_regular_tree

	; wait for_pattern / end

	lda     SOUND_STATUS
	and     #SOUND_MOCKINGBOARD
	beq     no_music4

;	lda     #1
;	cmp     current_pattern_smc+1
;	bcc     totally_done_fireplace
;	beq     totally_done_fireplace
;	jmp     done_music4

no_music4:
	lda     FRAMEH
	cmp     #7
	beq     done_regular_tree

done_music4:




	lda	#128
	jsr	wait

	inc	TREE_COUNT
	inc	TREE_COUNT
	inc	TREE_COUNT
	inc	TREE_COUNT

	lda	TREE_COUNT
	cmp	#$80
	bne	done_tree_count
	jmp	reset_tree_loop
done_tree_count:
	jmp	regular_tree_loop


done_regular_tree:
	bit	KEYRESET

	rts


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

