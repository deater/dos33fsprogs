enter_name:

	jsr	TEXT
	jsr	HOME

	lda     #>(enter_name_string)
        sta     OUTH
	lda     #<(enter_name_string)
        sta     OUTL

	jsr	print_string

	; zero out name

	lda	#<(name)
	sta	MEMPTRL
	sta	NAMEL
	lda	#>(name)
	sta	MEMPTRH
	sta	NAMEH
	lda	#0
	ldx	#8
	jsr	memset

name_loop:

	jsr	NORMAL

	lda	#11
	sta	CH		; HTAB 12

	lda	#2
	jsr	TABV		; VTAB 3

	ldy	#0
	sty	NAMEX

name_line:
	cpy	NAMEX
	bne	name_notx
	lda	#'+'
	jmp	name_next

name_notx:
	lda	NAMEL,Y
	beq	name_zero
	ora	#$80
	bne	name_next

name_zero:
	lda	#('_'+$80)
name_next:
	jsr	COUT
	lda	#(' '+$80)
	jsr	COUT
	iny
	cpy	#8
	bne	name_line

	lda	#7
	sta	CV

	lda	#('@'+$80)
	sta	CHAR

print_letters_loop:
	lda	#11
	sta	CH		; HTAB 12
	jsr	VTAB

	ldy	#0

print_letters_inner_loop:
	lda	CHAR
	jsr	COUT
	inc	CHAR
	lda	#(' '+$80)
	jsr	COUT
	iny

	cpy	#$8
	bne	print_letters_inner_loop

	jsr	wait_until_keypressed

	rts

