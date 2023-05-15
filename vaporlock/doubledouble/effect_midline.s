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










