; numbers

; by Vince `deater` Weaver

.include "hardware.inc"
.include "zp.inc"

numbers:
	bit	SET_GR
	bit	LORES
	bit	PAGE1

	lda	#0
	sta	DRAW_PAGE

	jsr	CLRTOP

	lda	#$00
	sta	NUMBER_HIGH
	lda	#$00
	sta	NUMBER_LOW

number_loop:

	jsr	CLRTOP

	lda	#4
	sta	XPOS
	lda	#5
	sta	YPOS

	jsr	draw_full_dni_number


wait_for_it:
	lda	KEYPRESS
	bpl	wait_for_it

	bit	KEYRESET

	; four-digit base 5 increment
base5_inc:

	inc	NUMBER_LOW
	lda	NUMBER_LOW
	and	#$f
	cmp	#5
	bne	base5_inc_done

	clc
	lda	NUMBER_LOW
	adc	#$b
	sta	NUMBER_LOW

	lda	NUMBER_LOW
	cmp	#$50
	bne	base5_inc_done

	; if here, overflow to top byte
	lda	#0
	sta	NUMBER_LOW

	inc	NUMBER_HIGH
	lda	NUMBER_HIGH
	and	#$f
	cmp	#5
	bne	base5_inc_done

	clc
	lda	NUMBER_HIGH
	adc	#$b
	sta	NUMBER_HIGH

	lda	NUMBER_HIGH
	cmp	#$50
	bne	base5_inc_done

	lda	#$0
	sta	NUMBER_HIGH

base5_inc_done:

	jmp	number_loop


.include "print_dni_numbers.s"

.include "number_sprites.inc"

.include "gr_offsets.s"

