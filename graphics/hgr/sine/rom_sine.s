; try to get sine table from ROM

sinetable=$6000
costable_base = $F5BA

rom_sine:

	;==========================================
	; create sinetable using ROM cosine table

	ldx	#0
	ldy	#$f
sinetable_loop:

	lda	costable_base+1,X
force_zero:
	lsr			; rom value is *256
	lsr			; we want *32
	lsr

	sta	sinetable+$10,X
	sta	sinetable+$00,Y
	eor	#$FF
	sta	sinetable+$30,X
	sta	sinetable+$20,Y

	lda	#0

	inx
	dey

	beq	force_zero
	bpl	sinetable_loop
end:
	jmp	end
