; just a static effect for near-beginning

; note comes in with 6 (jsr) + 6 (rts) + vblank jitter

	; wait 24 scanlines lines
	; (24*65) = 1560 cycles
	; ??-8 = 1560-8 = 1552

effect_static:

; 3 LINES 80-COL TEXT AN3=0 PAGE=2

	; intentionally a few cycles short as vblank returns+ a few cycles
;	bit	SET_TEXT	; 4
;	bit	PAGE2		; 4

	jsr	delay_1544

; 3 LINES 40-COL TEXT AN3=0 PAGE=2

	sta	CLR80COL	; 4
	bit	SET_TEXT	; 4

	jsr	delay_1552	; 1560 total

; 3 LINES 40-col LORES AN3=0 PAGE=1

	bit	PAGE1		; 4
	bit	SET_GR		; 4

	jsr	delay_1552	; 1560 total

; 3 LINES 80-col DLORES AN3=0 PAGE=1

	sta	LORES		; 4
	sta	SET80COL	; 4
	sta	CLRAN3		; 4

	jsr	delay_1548	; 1560 total


; 3 LINES 80-col DLORES AN3=0 PAGE=1

	jsr	delay_1560

; 3 lines HIRES 40-COL AN3=1 PAGE=2

	sta	CLR80COL	; 4
	sta	HIRES		; 4
	sta	PAGE2		; 4
	sta	SETAN3		; 4

	jsr	delay_1544

; 3 lines Double-hires AN3=0 PAGE=1
	sta	PAGE1		; 4
	bit	HIRES		; 4
	sta	SET80COL	; 4	; set 80 column mode
	sta	CLRAN3		; 4	; doublehireson

	jsr	delay_1544

; 3 line Double-HIRES

	jsr	delay_1560

; set 80-column text for next iteration

	sta	SET_TEXT	; 4
	bit	PAGE2		; 4

	rts
