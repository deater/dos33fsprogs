;==============================
;==============================
; Draw volume bars
;==============================
;==============================

volume_bars:


			; hline Y,V2 at A

	; top line

	lda	#COLOR_BOTH_GREY
	sta	COLOR			; remove for crazy effect
	ldy	#12
	lda	#26
	sta	V2
	lda	#6
	jsr	hlin_double

	; middle

	lda	#8
middle_loop:
	pha

	cmp	#8
	beq	middle_black
	cmp	#26
	beq	middle_black

	cmp	#10
	bne	not_top

	ldx	#$3B			; pink/purple
	stx	A_COLOR
	ldx	#$7E			; light-blue/aqua
	stx	B_COLOR
	ldx	#$CD			; light-green/yellow
	stx	C_COLOR
	jmp	calc_volume

not_top:
	ldx	#COLOR_BOTH_RED
	stx	A_COLOR
	ldx	#COLOR_BOTH_DARKBLUE
	stx	B_COLOR
	ldx	#COLOR_BOTH_DARKGREEN
	stx	C_COLOR

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
	pha
	sec
	eor	#$ff		; negate
	adc	#24		; 24-A
	sec
	sbc	A_VOLUME
	bmi	mod_b
	beq	mod_a_bottom
mod_a_zero:
	lda	#0
	beq	done_a
mod_a_bottom:
	lda	A_COLOR
	and	#$f0
done_a:
	sta	A_COLOR

mod_b:
	pla
	pha
	sec
	eor	#$ff		; negate
	adc	#24		; 24-A
	sec
	sbc	B_VOLUME
	bmi	mod_c
	beq	mod_b_bottom
mod_b_zero:
	lda	#0
	beq	done_b
mod_b_bottom:
	lda	B_COLOR
	and	#$f0
done_b:
	sta	B_COLOR

mod_c:
	pla
	pha
	sec
	eor	#$ff		; negate
	adc	#24		; 24-A
	sec
	sbc	C_VOLUME
	bmi	mod_d
	beq	mod_c_bottom
mod_c_zero:
	lda	#0
	beq	done_c
mod_c_bottom:
	lda	C_COLOR
	and	#$f0
done_c:
	sta	C_COLOR

mod_d:
	pla

	jmp	middle_color_done

middle_black:
	ldx	#COLOR_BOTH_BLACK
	stx	A_COLOR
	stx	B_COLOR
	stx	C_COLOR

middle_color_done:

	; left border
	ldy	#COLOR_BOTH_GREY
	sty	COLOR

	ldy	#12
	sty	V2
	ldy	#12

	jsr	hlin_double

	; border space
	lda	#COLOR_BOTH_BLACK
	sta	COLOR

	ldx	#1
	jsr	hlin_double_continue

	; A volume
	lda	A_COLOR
	sta	COLOR

	ldx	#3
	jsr	hlin_double_continue

	; A space
	lda	#COLOR_BOTH_BLACK
	sta	COLOR

	ldx	#1
	jsr	hlin_double_continue

	; B volume
	lda	B_COLOR
	sta	COLOR

	ldx	#3
	jsr	hlin_double_continue

	; B space
	lda	#COLOR_BOTH_BLACK
	sta	COLOR

	ldx	#1
	jsr	hlin_double_continue

	; C volume
	lda	C_COLOR
	sta	COLOR

	ldx	#3
	jsr	hlin_double_continue

	; C space
	lda	#COLOR_BOTH_BLACK
	sta	COLOR

	ldx	#1
	jsr	hlin_double_continue

	; Right border

	lda	#COLOR_BOTH_GREY
	sta	COLOR

	ldx	#1
	jsr	hlin_double_continue

	pla
	clc
	adc	#2
	cmp	#28
	beq	bottom_line
	jmp	middle_loop

bottom_line:
	; bottom line

	lda	#COLOR_BOTH_GREY
	sta	COLOR
	ldy	#12
	lda	#26
	sta	V2
	lda	#28
	jsr	hlin_double

	rts


