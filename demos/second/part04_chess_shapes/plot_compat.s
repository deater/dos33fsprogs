	;================================
	; plot_setup
	;================================

plot_setup:

	lsr			; shift bottom bit into carry		; 2
	tay

	bcc	do_plot_even						; 2nt/3
do_plot_odd:
	lda	#$f0							; 2
	bcs	do_plot_c_done						; 2nt/3
do_plot_even:
	lda	#$0f							; 2
do_plot_c_done:
	sta	mask_smc2+1						;
	eor	#$FF							; 2
	sta	mask_invert_smc1+1					;


	lda	gr_offsets_l,Y	; lookup low-res memory address		; 4
	sta	gbasl_smc1+1
	sta	gbasl_smc2+1


        lda	gr_offsets_h,Y						; 4
	clc
        adc	DRAW_PAGE	; add in draw page offset		; 3
	sta	gbasl_smc1+2
	sta	gbasl_smc2+2



	;================================
	; plot1
	;================================

plot1:
mask_invert_smc1:
	lda	#$ff		; load mask				; 2
gbasl_smc1:
	and	$400,Y		; mask to preserve on-screen color	; 4+
	sta	COLOR_MASK	; save temporarily			; 3
color_smc:
	lda	#$FF		; load color				; 2
mask_smc2:
	and	#$FF		; mask so only hi/lo we want		; 2
	ora	COLOR_MASK	; combine with on-screen color		; 3
gbasl_smc2:
	sta	$400,Y		; save back out				; 5

