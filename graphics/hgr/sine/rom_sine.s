; try to get sine table from ROM

; zero page
GBASL	= $26
GBASH	= $27
YY	= $69
ROW_SUM = $70

HGR_X           = $E0
HGR_XH          = $E1
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_PAGE        = $E6

FRAME	= $FC
SUM	= $FD
SAVEX	= $FE
SAVEY	= $FF

	;================================
	; Clear screen and setup graphics
	;================================
rom_sine:

	;==========================================
	; create sinetable using ROM cosine table

	ldy	#0
sinetable_loop:
	tya							; 2
	and	#$3f	; wrap sine at 63 entries		; 2

	cmp	#$20
	php		; save pos/negative for later

	and	#$1f

	beq	sin_noadjust

	cmp	#$10
	bcc	sin_left		; blt
	bne	sin_right

	lda	#$20			; force sin(16) to $20 instead of $1F
	bne	sin_noadjust

sin_right:
	; sec	carry should be set here
	sbc	#$10		; X-16  (x=16..31)
	bne	sin_both	; bra
sin_left:
	; clc	; carry should be clear
	eor	#$FF		; 16-X (but plus one twos complement)
	adc	#$11
sin_both:
	tax
	lda	sinetable_base,X				; 4+

	lsr			; rom value is *256
	lsr			; we want *32
	lsr
sin_noadjust:

	plp
	bcc	sin_done

sin_negate:
	; carry set here
	eor	#$ff
;	adc	#0			; off by one, does it matter?

sin_done:
	sta	sinetable,Y

	iny
	bne	sinetable_loop

end:
	jmp	end

sinetable_base = $F5BA

sinetable=$6000


