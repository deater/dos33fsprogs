	;=========================================================
	; gr_copy_to_current, 40x48 version
	;=========================================================
	; copy 0xc00 to DRAW_PAGE
	;
	; 45 + 2 + 120*(8*9 + 5) -1 + 6 = 9292
;.align	$100
gr_copy_to_current:

	lda	DRAW_PAGE					; 3
	clc							; 2
	adc	#$4						; 2
	sta	gr_copy_line+5					; 4
	sta	gr_copy_line+11					; 4
	adc	#$1						; 2
	sta	gr_copy_line+17					; 4
	sta	gr_copy_line+23					; 4
	adc	#$1						; 2
	sta	gr_copy_line+29					; 4
	sta	gr_copy_line+35					; 4
	adc	#$1						; 2
	sta	gr_copy_line+41					; 4
	sta	gr_copy_line+47					; 4
							;===========
							;	45

	ldy	#119		; for early ones, copy 120 bytes	; 2

gr_copy_line:
	lda	$C00,Y		; load a byte (self modified)		; 4
	sta	$400,Y		; store a byte (self modified)		; 5

	lda	$C80,Y		; load a byte (self modified)		; 4
	sta	$480,Y		; store a byte (self modified)		; 5

	lda	$D00,Y		; load a byte (self modified)		; 4
	sta	$500,Y		; store a byte (self modified)		; 5

	lda	$D80,Y		; load a byte (self modified)		; 4
	sta	$580,Y		; store a byte (self modified)		; 5

	lda	$E00,Y		; load a byte (self modified)		; 4
	sta	$600,Y		; store a byte (self modified)		; 5

	lda	$E80,Y		; load a byte (self modified)		; 4
	sta	$680,Y		; store a byte (self modified)		; 5

	lda	$F00,Y		; load a byte (self modified)		; 4
	sta	$700,Y		; store a byte (self modified)		; 5

	lda	$F80,Y		; load a byte (self modified)		; 4
	sta	$780,Y		; store a byte (self modified)		; 5

	dey			; decrement pointer			; 2
	bpl	gr_copy_line	;					; 2nt/3

	rts								; 6



	;=========================================================
	; gr_copy_to_current, 40x48 version
	;=========================================================
	; copy 0x1000 to DRAW_PAGE

gr_copy_to_current_1000:

	lda	DRAW_PAGE					; 3
	clc							; 2
	adc	#$4						; 2
	sta	gr_copy_line_40+5				; 4
	sta	gr_copy_line_40+11				; 4
	adc	#$1						; 2
	sta	gr_copy_line_40+17				; 4
	sta	gr_copy_line_40+23				; 4
	adc	#$1						; 2
	sta	gr_copy_line_40+29				; 4
	sta	gr_copy_line_40+35				; 4
	adc	#$1						; 2
	sta	gr_copy_line_40+41				; 4
	sta	gr_copy_line_40+47				; 4
							;===========
							;	45

	ldy	#119		; for early ones, copy 120 bytes	; 2

gr_copy_line_40:
	lda	$1000,Y		; load a byte (self modified)		; 4
	sta	$400,Y		; store a byte (self modified)		; 5

	lda	$1080,Y		; load a byte (self modified)		; 4
	sta	$480,Y		; store a byte (self modified)		; 5

	lda	$1100,Y		; load a byte (self modified)		; 4
	sta	$500,Y		; store a byte (self modified)		; 5

	lda	$1180,Y		; load a byte (self modified)		; 4
	sta	$580,Y		; store a byte (self modified)		; 5

	lda	$1200,Y		; load a byte (self modified)		; 4
	sta	$600,Y		; store a byte (self modified)		; 5

	lda	$1280,Y		; load a byte (self modified)		; 4
	sta	$680,Y		; store a byte (self modified)		; 5

	lda	$1300,Y		; load a byte (self modified)		; 4
	sta	$700,Y		; store a byte (self modified)		; 5

	lda	$1380,Y		; load a byte (self modified)		; 4
	sta	$780,Y		; store a byte (self modified)		; 5

	dey			; decrement pointer			; 2
	bpl	gr_copy_line_40	;					; 2nt/3

	rts								; 6



	;=========================================================
	; gr_copy_to_current_40x40
	;=========================================================
	; Take image in 0xc00
	; 	Copy to DRAW_PAGE
	;	Actually copy lines 0..39
	; Don't over-write bottom 4 lines of text
gr_copy_to_current_40x40:

	ldx	#0
gc_40x40_loop:
	lda	gr_offsets,x
	sta	OUTL
	sta	INL
	lda	gr_offsets+1,x
	clc
	adc	DRAW_PAGE
	sta	OUTH

	lda	gr_offsets+1,x
	clc
	adc	#$8
	sta	INH

	ldy	#39
gc_40x40_inner:
	lda	(INL),Y
	sta	(OUTL),Y

	dey
	bpl	gc_40x40_inner

	inx
	inx

	cpx	#40
	bne	gc_40x40_loop

	rts								; 6


	;=========================================================
	; gr_make_quake
	;=========================================================
	; Take image in 0xc00
	; 	Copy to 0x1000
	;	Actually copy lines 2..41 to 0..39
gr_make_quake:

	ldx	#0
make_quake_loop:
	lda	gr_offsets,x
	sta	OUTL
	lda	gr_offsets+1,x
	clc
	adc	#$C
	sta	OUTH

	inx
	inx

	lda	gr_offsets,x
	sta	INL
	lda	gr_offsets+1,x
	clc
	adc	#$8
	sta	INH

	ldy	#39
quake_inner:
	lda	(INL),Y
	sta	(OUTL),Y

	dey
	bpl	quake_inner

	cpx	#40
	bne	make_quake_loop

	; write zeros to the rest

quake_clear_bottom:
	lda	gr_offsets,x
	sta	OUTL
	lda	gr_offsets+1,x
	clc
	adc	#$C
	sta	OUTH

	inx
	inx

	ldy	#39
	lda	#0
quake_clear_inner:
	sta	(OUTL),Y
	dey
	bpl	quake_clear_inner

	cpx	#48
	bne	quake_clear_bottom

	; clear the extra two lines from the original
quake_clear_extra:

	ldx	#40
	lda	gr_offsets,x
	sta	OUTL
	lda	gr_offsets+1,x
	clc
	adc	#$8
	sta	OUTH

	ldy	#39
	lda	#0
quake_clear_extra_inner:
	sta	(OUTL),Y
	dey
	bpl	quake_clear_extra_inner

	rts								; 6


