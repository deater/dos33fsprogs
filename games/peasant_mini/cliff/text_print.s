
	;================================
	; move_and_print
	;================================
	; get X,Y from OUTL/OUTH
	; then print following string to that address
	; stop at NUL
	; convert to APPLE ASCII (or with 0x80)
	; leave OUTL/OUTH pointing to next string

move_and_print:
	ldy	#0
	lda	(OUTL),Y
	sta	CH
	iny
	lda	(OUTL),Y
	asl
	tay
	lda	gr_offsets,Y    ; lookup low-res memory address
	clc
	adc	CH		; add in xpos
	sta	BASL		; store out low byte of addy

	lda	gr_offsets+1,Y	; look up high byte
	adc	DRAW_PAGE	;
	sta	BASH		; and store it out
				; BASH:BASL now points at right place

	clc
	lda	OUTL
	adc	#2
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH

	;================================
	; print_string
	;================================

print_string:
	ldy	#0
print_string_loop:
	lda	(OUTL),Y
	beq	done_print_string

	; adjust for upper/lowercase

	; $20..$80
	; normal
	;	$20..$3F (symbols)   = $A0-$BF (ora $80)
	;	$40..$5F (uppercase) = $C0-$DF (ora $80)
	;	$60..$7F (lowercase) = $E0-$FF (ora $80)
	; inverse (need to set $C00F if lowercase, but
	;		that will make uppercase into mousechars :( )
	;	$20..$3F (symbols)   = $20-$3F (and $7f)
	;	$40..$5F (uppercase) = $00-$1F (and $3f)
	;	$60..$7F (lowercase) = $60-$7F (and $7f)


	cmp	#$60
	bcc	not_lowercase

	; here if lowercase
ps_smc2:
	and	#$ff		; $9f to force uppercase, $ff regular

not_lowercase:

	; adjust for inverse/flash/normal

ps_smc1:
	and	#$7f			; this will be ORA $80 if normal
					; this will be AND $3F if inverse
					; we want to skip if inverse
					;  and not capital letters blah

	cmp	#$40
	bcc	not_inverse_uppercase
	cmp	#$60
	bcs	not_inverse_uppercase
	and	#$3f

not_inverse_uppercase:
	sta	(BASL),Y
	iny
	bne	print_string_loop
done_print_string:
	iny
	clc
	tya
	adc	OUTL
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH

	rts

	; want $E1 -> $81
	;	1110	1000
	;	so and with $9f?
force_uppercase:
	lda	#$9f
	sta	ps_smc2+1

	rts


	; set normal text
set_normal:
	lda	#$80
	sta	ps_smc1+1

	lda	#09             ; ora
	sta	ps_smc1

	rts

	; restore inverse text

	; urgh, inverse is $00..$??
	; for lowercase though it's $60..$??
	; and you have to set $c00f first?

	; so $3f on Apple II
	; so mask with #$7f instead on IIe+

set_inverse:
	lda	#$3f		;
	sta	ps_smc1+1

	lda	#$29		; and
	sta	ps_smc1

	rts


	;================================
	; move and print a list of lines
	;================================
	; look for negative X meaning done
move_and_print_list:
	jsr     move_and_print
	ldy     #0
	lda     (OUTL),Y
	bpl     move_and_print_list

	rts


	;==============================
	; clear all of gr screen (page1)
	;==============================
clear_gr_all:
	ldx	#0
;	stx	clear_value_smc+1
	beq	clear_bottom_loop_outer		; bra

	;====================================
	; clear bottom of text screen (page1)
	;====================================
clear_bottom:
	lda	#' '+$80
	sta	clear_value_smc+1
	ldx	#20
clear_bottom_loop_outer:
	txa
	asl
	tay
	lda	gr_offsets,Y
	sta	OUTL
	iny
	lda	gr_offsets,Y
	clc
	adc	DRAW_PAGE
	sta	OUTH

clear_value_smc:
	lda	#' '+$80
	ldy	#39
clear_bottom_loop_inner:
	sta	(OUTL),Y
	dey
	bpl	clear_bottom_loop_inner

	inx
	cpx	#24

	bne	clear_bottom_loop_outer

	rts
