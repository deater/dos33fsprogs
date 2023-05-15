; goal
;
;	192 lines
;	window is 32 lines
;		so 0...current
;		current...current+32
;		current+32...192
; double hi-res / double lo-res

; test, 100 lines of double-hires
;	100*65 = 6500

	; 2+ X*(12+2+3) - 1

effect_top_smc:
	ldx	#100		; 2
aloop:
	jsr	delay_12	; 12
	jsr	delay_12	; 12
	jsr	delay_12	; 12
	jsr	delay_12	; 12
	jsr	delay_12	; 12
	dex			; 2
	bne	aloop		; 2/3

	sta	LORES
	sta	PAGE1
	sta	SET80COL
	sta	CLRAN3
	ldx	#32		; 2
bloop:
	jsr	delay_12	; 12
	jsr	delay_12	; 12
	jsr	delay_12	; 12
	jsr	delay_12	; 12
	jsr	delay_12	; 12
	dex			; 2
	bne	bloop		; 2/3


	bit	HIRES
effect_bottom_smc:
	ldx	#60		; 2
cloop:
	jsr	delay_12	; 12
	jsr	delay_12	; 12
	jsr	delay_12	; 12
	jsr	delay_12	; 12
	jsr	delay_12	; 12
	inx			; 2
	cpx	#192
	bcs	cloop		; 2/3









