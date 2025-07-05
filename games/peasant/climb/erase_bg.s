
NUM_ERASES = 6
	;===================================
	; copy from $6000 to draw page
	;===================================
erase_bg:

	lda	#$0
	sta	erase_count

	lda	DRAW_PAGE
	beq	erase_bg_page1_loop

erase_bg_page2_loop:

	ldx	erase_count

	lda	erase_data_page2_x,X
	bmi	skip_this_erase_page2
	sta	erase_common_xloop_smc+1
	clc
	adc	erase_data_page2_xsize,X
	sta	erase_common_xsize_smc+1


	lda	erase_data_page2_y,X
	sta	erase_common_ystart_smc+1
	clc
	adc	erase_data_page2_ysize,X
	sta	erase_common_yend_smc+1

	; mark as done
	lda	#$ff
	sta	erase_data_page2_x,X

	jsr	erase_common

skip_this_erase_page2:
	inc	erase_count
	lda	erase_count
	cmp	#NUM_ERASES
	bne	erase_bg_page2_loop

	rts


erase_bg_page1_loop:

	ldx	erase_count

	lda	erase_data_page1_x,X
	bmi	skip_this_erase_page1
	sta	erase_common_xloop_smc+1
	clc
	adc	erase_data_page1_xsize,X
	sta	erase_common_xsize_smc+1


	lda	erase_data_page1_y,X
	sta	erase_common_ystart_smc+1
	clc
	adc	erase_data_page1_ysize,X
	sta	erase_common_yend_smc+1

	; mark as done
	lda	#$ff
	sta	erase_data_page1_x,X

	jsr	erase_common

skip_this_erase_page1:
	inc	erase_count
	lda	erase_count
	cmp	#NUM_ERASES
	bne	erase_bg_page1_loop

	rts



	;===================================
	; erase common

erase_common:

erase_common_ystart_smc:
	ldx	#100

erase_common_yloop:

	lda	hposn_low,X
	sta	OUTL
	sta	INL

	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	OUTH		; out to DRAW_PAGE
	lda	hposn_high,X
	clc
	adc	#$40
	sta	INH		; in from $6000

erase_common_xloop_smc:
	ldy	#10

erase_common_xloop:
	lda	(INL),Y
	sta	(OUTL),Y
	iny
erase_common_xsize_smc:
	cpy	#3
	bne	erase_common_xloop

	inx
erase_common_yend_smc:
	cpx	#30
	bne	erase_common_yloop

done_erase_common:
	rts

erase_count:
	.byte $00
