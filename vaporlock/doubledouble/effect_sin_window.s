; double hi-res with configuratble sliding window

; show dhgr image on page1
;	show sliding 32-line window of dgr page 1


; note come in at 6 (jsr) + 6 (rts from vblank) + vblank jitter

effect_dhgr_dgr:

	;==========================
	; top
	;==========================
effect_top_smc:			; 12
	ldx	#100		; 2
	lda	$00 ; nop3	; 3
	nop			; 2
	nop			; 2
	jmp	aloop_24	; 3

aloop:
	jsr	delay_12	; 12
	jsr	delay_12	; 12
aloop_24:
	jsr	delay_12	; 12
	jsr	delay_12	; 12
	jsr	delay_12	; 12
; 60
	dex			; 2
; 62
	bne	aloop		; 2/3
; 65

	;==========================
	; middle (Switch mode)
	;==========================
				; -1
	ldx	#32		; 2
middle_smc1:
	sta	LORES		; 4
middle_smc2:
	sta	SET80COL	; 4
middle_smc3:
	sta	CLRAN3		; 4
middle_smc4:
	sta	PAGE1		; 4


; 17
	nop			; 2
	nop			; 2
	jmp	bloop_24	; 3
; 24

bloop:

	; update the movement mid-way

	ldy	FRAME				; 3
	lda	sin_table,Y			; 4 (aligned)
	sta	effect_top_smc+1		; 4
; 11
	clc					; 2
	adc	#32	; should this be 31?	; 2
	sta	effect_bottom_smc+1		; 4

; 19
	nop					; 2
	lda	$00	; nop3			; 3

bloop_24:

; 24
	jsr	delay_12	; 12
; 36
	jsr	delay_12	; 12
; 48
	jsr	delay_12	; 12
; 60

	dex			; 2
	bne	bloop		; 2/3

	;============================================
	; bottom (Switch back to double-hires page 1)
	;============================================

effect_bottom_smc:		; -1
	ldx	#60		; 2

	bit	SET_GR		; 4
	bit	HIRES		; 4
	sta	CLRAN3		; 4
	sta	SET80COL	; 4
	bit	PAGE1		; 4
; 21
	jmp	cloop_plus_24	; 3

cloop:
	jsr	delay_12	; 12
	jsr	delay_12	; 12
cloop_plus_24:
	jsr	delay_12	; 12
	jsr	delay_12	; 12
; 48
	nop			; 2
	nop			; 2
	nop			; 2
	nop			; 2
	nop			; 2
; 58
	inx			; 2
	cpx	#192		; 2
; 62
	bcs	cloop		; 2/3

	rts
