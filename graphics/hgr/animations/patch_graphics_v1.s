	;=================================
	; patch graphics
	;=================================
	; patch is in INH:INL

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



