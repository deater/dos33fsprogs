	;=================================
	; patch graphics
	;=================================
	; patch is in INH:INL

patch_graphics_main:

	stx	INL
	sty	INH

	; reset output

	clc
	lda	#$4
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
	sta	$400,X

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





	;=================================
	; patch graphics
	;=================================
	; patch is in INH:INL

patch_graphics_aux:

	stx	INL
	sty	INH

	; reset output

	clc
	lda	#$4
	adc	DRAW_PAGE
	sta	patch_graphics_aux_smc+2

	lda	#$0
	sta	patch_graphics_aux_smc+1

	ldy	#0
patch_graphics_aux_loop:
	jsr	get_next

	sta	patch_length_aux_smc+1

	cmp	#$ff
	beq	done_patch_graphics_aux_loop

	jsr	get_next

	adc	patch_graphics_aux_smc+1
	sta	patch_graphics_aux_smc+1

	jsr	get_next

	adc	patch_graphics_aux_smc+2
	sta	patch_graphics_aux_smc+2

	sei
	sta	WRAUX


	ldx	#0
patch_graphics_aux_inner:

	jsr	get_next

patch_graphics_aux_smc:
	sta	$400,X

	inx
patch_length_aux_smc:
	cpx	#5
	bne	patch_graphics_aux_inner

	sta	WRMAIN
	cli

	jmp	patch_graphics_aux_loop

done_patch_graphics_aux_loop:

	rts





