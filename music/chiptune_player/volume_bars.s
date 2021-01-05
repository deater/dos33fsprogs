;==============================
;==============================
; Draw volume bars
;==============================
;==============================

volume_bars:
			; hline Y,V2 at A
	; top line

	lda	#COLOR_BOTH_GREY					; 2
	sta	COLOR			; remove for crazy effect	; 3
	ldy	#12							; 2
	lda	#26							; 2
	sta	V2							; 3
	lda	#6							; 2
	jsr	hlin_double						; 6
								; 63+14*16=287
							;=====================
							;		307
	; middle

	lda	#8							; 2
middle_loop:
	pha								; 3

	cmp	#8							; 2
	beq	middle_black						; 2nt/3
	cmp	#26							; 2
	beq	middle_black						; 2nt/3

	cmp	#10							; 2
	bne	not_top							; 2nt/3

	ldx	#$3B			; pink/purple			; 2
	stx	A_COLOR							; 3
	ldx	#$7E			; light-blue/aqua		; 2
	stx	B_COLOR							; 3
	ldx	#$CD			; light-green/yellow		; 2
	stx	C_COLOR							; 3
	jmp	calc_volume						; 3

not_top:
	ldx	#COLOR_BOTH_RED						; 2
	stx	A_COLOR							; 3
	ldx	#COLOR_BOTH_DARKBLUE					; 2
	stx	B_COLOR							; 3
	ldx	#COLOR_BOTH_DARKGREEN					; 2
	stx	C_COLOR							; 3

calc_volume:

	; 10 14/15	24-x = 14  PLUS=none, zero=bottom, neg=all
	; 12 12/13	12
	; 14 10/11	10
	; 16  8/9	8
	; 18  6/7	6
	; 20  4/5	4
	; 22  2/3	2
	; 24  0/1	0

	; FIXME: there must be a way to make this faster

mod_a:
	pha								; 3
	sec								; 2
	eor	#$ff		; negate				; 2
	adc	#24		; 24-A					; 2
	sec								; 2
	sbc	A_VOLUME						; 2
	bmi	mod_b							; 2nt/3
	beq	mod_a_bottom						; 2nt/3
mod_a_zero:
	lda	#0							; 2
	beq	done_a							; 2nt/3
mod_a_bottom:
	lda	A_COLOR							; 2
	and	#$f0							; 2
done_a:
	sta	A_COLOR							; 2

mod_b:
	pla								; 4
	pha								; 3
	sec								; 2
	eor	#$ff		; negate				; 2
	adc	#24		; 24-A					; 2
	sec								; 2
	sbc	B_VOLUME						; 2
	bmi	mod_c							; 2nt/3
	beq	mod_b_bottom						; 2nt/3
mod_b_zero:
	lda	#0							; 2
	beq	done_b							; 2nt/3
mod_b_bottom:
	lda	B_COLOR							; 3
	and	#$f0							; 2
done_b:
	sta	B_COLOR							; 3

mod_c:
	pla								; 4
	pha								; 3
	sec								; 2
	eor	#$ff		; negate				; 2
	adc	#24		; 24-A					; 2
	sec								; 2
	sbc	C_VOLUME						; 2
	bmi	mod_d							; 2nt/3
	beq	mod_c_bottom						; 2nt/3
mod_c_zero:
	lda	#0							; 2
	beq	done_c							; 2nt/3
mod_c_bottom:
	lda	C_COLOR							; 3
	and	#$f0							; 2
done_c:
	sta	C_COLOR							; 3

mod_d:
	pla								; 4

	jmp	middle_color_done					; 3

middle_black:
	ldx	#COLOR_BOTH_BLACK					; 2
	stx	A_COLOR							; 3
	stx	B_COLOR							; 3
	stx	C_COLOR							; 3

middle_color_done:

	; left border
	ldy	#COLOR_BOTH_GREY					; 2
	sty	COLOR							; 3

	ldy	#12							; 2
	sty	V2							; 3
	ldy	#12							; 2

	jsr	hlin_double						; 6
								; 63+1*16=79
	; border space
	lda	#COLOR_BOTH_BLACK					; 2
	sta	COLOR							; 3

	ldx	#1							; 2
	jsr	hlin_double_continue				; 10+1*16=27

	; A volume
	lda	A_COLOR							; 3
	sta	COLOR							; 3

	ldx	#3							; 2
	jsr	hlin_double_continue				; 10+3*16=58

	; A space
	lda	#COLOR_BOTH_BLACK					; 2
	sta	COLOR							; 3

	ldx	#1							; 2
	jsr	hlin_double_continue					; 6
								; 10+1*16=27
	; B volume
	lda	B_COLOR							; 3
	sta	COLOR							; 3

	ldx	#3							; 2
	jsr	hlin_double_continue					; 6
								; 10+3*16=58
	; B space
	lda	#COLOR_BOTH_BLACK					; 2
	sta	COLOR							; 3

	ldx	#1							; 2
	jsr	hlin_double_continue					; 6
								; 10+1*16=27

	; C volume
	lda	C_COLOR							; 3
	sta	COLOR							; 3

	ldx	#3							; 2
	jsr	hlin_double_continue					; 6
								; 10+3*16=58

	; C space
	lda	#COLOR_BOTH_BLACK					; 2
	sta	COLOR							; 3

	ldx	#1							; 2
	jsr	hlin_double_continue					; 6
								; 10+1*16=27
	; Right border

	lda	#COLOR_BOTH_GREY					; 2
	sta	COLOR							; 3

	ldx	#1							; 2
	jsr	hlin_double_continue					; 6
								; 10+1*16=27

	pla								; 4
	clc								; 2
	adc	#2							; 2
	cmp	#28							; 2
	beq	bottom_line						; 2nt/3
	jmp	middle_loop						; 3

bottom_line:
	; bottom line

	lda	#COLOR_BOTH_GREY					; 2
	sta	COLOR							; 3
	ldy	#12							; 2
	lda	#26							; 2
	sta	V2							; 3
	lda	#28							; 2
	jsr	hlin_double						; 6
								; 63+14*16=287

	rts								; 6



; 309+ 684*10 + 313 = roughly worst case 7462
