effect_midline:

	lda	#7
	sta	XX

outer_outer_loop:
	ldy	#120


	; comes in with 4
outer_loop:

	ldx	#192		; 2
; 6
	lda	$00	; nop 3	; 3
; 9
	jmp	skip_nop
; 12

inner_loop:

	nop			; 2
	nop			; 2
	nop			; 2
	nop			; 2


; 8

	; set text
	sta	LORES		; 4
skip_nop:
	sta	SET_TEXT	; 4
	sta	SETAN3		; 4
	sta	CLR80COL	; 4
	bit	PAGE1		; 4

; 28

	jsr	delay_12	; 12

; 40

	; set double-hires
	sta	SET_GR		; 4
	sta	HIRES		; 4
	sta	CLRAN3		; 4
	sta	SET80COL	; 4
	bit	PAGE2		; 4

; 60

	dex			; 2
; 62
	bne	inner_loop	; 2/3
; 65

				; -1
	dey			; 2
	bne	outer_loop	; 3

	dec	XX
	bne	outer_outer_loop



.if 0
; black and white

	; set double-hires
	sta	SET_GR		; 4
	sta	HIRES		; 4
	sta	CLRAN3		; 4
	sta	SET80COL	; 4
	bit	PAGE2		; 4
; 20
	jsr	delay_12
; 32
	; set text
	sta	LORES		; 4
	sta	SET_TEXT	; 4
	sta	SETAN3		; 4
	sta	CLR80COL	; 4
	bit	PAGE1		; 4
; 52

	nop
	nop
	nop
	nop
	nop
; 62
	jmp	effect_midline	; 3
; 65
.endif


.if 0

	ldx	#192		; 2
qloop:
	bit	HIRES		; 4
	bit	PAGE1		; 4
	bit	PAGE1		; 4
; 12
	jsr	delay_12	; 12
	jsr	delay_12	; 12
; 36
	bit	LORES		; 4
	bit	PAGE2		; 4
	bit	PAGE2		; 4
; 48
	jsr	delay_12	; 12
; 60
	dex			; 2
; 62
	bne	qloop		; 2/3
.endif

