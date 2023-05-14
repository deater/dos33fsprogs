

; 3 LINES 80-COL TEXT AN3=0 PAGE=2

	; intentionally a few cycles short as vblank returns+ a few cycles
	bit	PAGE2
	bit	SET_TEXT	; 4

	; wait 24 scanlines lines
	; (24*65)-8 = 1560-8 = 1552

	jsr	delay_1552

; 3 LINES 40-COL TEXT AN3=0 PAGE=2

	nop
	nop

	nop
	nop
	sta	CLR80COL	; 4
	bit	SET_TEXT	; 4

	jsr	delay_1552

; 3 LINES 40-col LORES AN3=0 PAGE=1

	nop
	nop

	nop
	nop
	bit	PAGE1		; 4
	bit	SET_GR		; 4

	jsr	delay_1552

; 3 LINES 80-col DLORES AN3=0 PAGE=1

	nop
	nop

	sta	LORES
	sta	SET80COL	; 4
	sta	CLRAN3		; 4

	jsr	delay_1552


; 3 LINES 80-col DLORES AN3=0 PAGE=1

	nop
	nop

	nop
	nop

	nop
	nop

	nop
	nop

	jsr	delay_1552

; 3 lines HIRES 40-COL AN3=1 PAGE=2

	sta	CLR80COL
	sta	HIRES		; 4
	sta	PAGE2		; 4
	sta	SETAN3

	jsr	delay_1552

; 3 lines Double-hires AN3=0 PAGE=1
	sta	PAGE1
	bit	HIRES
	sta	SET80COL	; 4	; set 80 column mode
	sta	CLRAN3		; 4	; doublehireson

	jsr	delay_1552

; 3 line Double-HIRES

	nop
	nop

	nop
	nop

	nop
	nop

	nop
	nop

	jsr	delay_1552








