	;=================================
	; patch graphics v2
	;=================================
	; patch is in INH:INL

	; OUTH:OUTL = output

	; initial
	;	addr_offset = 0, end
	;	run_length top bits 00:
	;		addr offset, run_length, immediate ...

patch_graphics:

	stx	INL
	sty	INH

	; reset output

	clc
	lda	#$20
	adc	DRAW_PAGE
	sta	OUTH

	lda	#$0
	sta	OUTL

	ldy	#0
patch_graphics_loop:
	jsr	get_next

	cmp	#$FF				; $FF means done
	beq	done_patch_graphics_loop

	; add in addr_offset

	clc
	adc	OUTL
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH

	; get run_length

	jsr	get_next
	tax

immediate_loop:
	jsr	get_next

	sta	(OUTL),Y
	inc	OUTL
	bne	outl_noflo
	inc	OUTH
outl_noflo:

	dex
	bne	immediate_loop

.if 0
	cmp	#$FF
	bpl	regular_rle

	;=====================================
	; copy from memory
copy_from_memory:

	and	#$7f
	sta	cpatch_length_smc+1		; store run_length

	jsr	get_next			; get next (dest offset)

	clc
	adc	OUTL				; add in dest offset
	sta	OUTL

	lda	#0

	adc	OUTH
	sta	OUTH

	jsr	get_next			; get value to patch
	sta	cpatch_out_smc+1
	jsr	get_next			; get value to patch
	clc
	adc	#$20
	adc	DRAW_PAGE
	eor	#$60				; not-draw page
						; 20->40 0010 0100
						; 40->20 0100 0010

	sta	cpatch_out_smc+2


	ldx	#0
	ldy	#0
cpatch_graphics_inner:

cpatch_out_smc:
	lda	$2000,X
	sta	(OUTL),Y			; store it out

	inx
	iny
cpatch_length_smc:
	cpy	#5
	bne	cpatch_graphics_inner


	jmp	patch_graphics_loop

	;===================================
	; regular rle
regular_rle:

	sta	patch_length_smc+1		; store run_length

	jsr	get_next			; get next (dest offset)

	clc
	adc	OUTL				; add in dest offset
	sta	OUTL

	lda	#0

	adc	OUTH
	sta	OUTH

	ldy	#0
patch_graphics_inner:

	jsr	get_next			; get value to patch

patch_graphics_smc:
	sta	(OUTL),Y			; store it out

	iny
patch_length_smc:
	cpy	#5
	bne	patch_graphics_inner


	jmp	patch_graphics_loop


.endif
	jmp	patch_graphics_loop
done_patch_graphics_loop:
	rts


	;========================
	; get next
get_next:
	sty	TEMPY
	ldy	#0
	lda	(INL),Y
	inc	INL
	bne	noflo
	inc	INH
noflo:
	ldy	TEMPY
	rts



