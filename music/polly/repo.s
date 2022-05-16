; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SPEAKER	= $C030


repo:

repo_loop:
	bit	SPEAKER

	; delay extra

extra_smc:
	ldx	extra_high_values
	beq	delay_high

extra_loop:
	ldy	#255
extra_inner_loop:
	lda	#200
	jsr	delay_a
	dey
	bne	extra_inner_loop

	dex
	bne	extra_loop


	; delay high
delay_high:

high_smc:
	ldx	high_values
high_loop:
	lda	#200
	jsr	delay_a

	dex
	bne	high_loop

low_delay:

low_smc:
	lda	low_values			; 4
	cmp	#$FF				; 2
	beq	done				; 2 normally

	jsr	delay_a				; 25+A

	clc					; 2
	lda	low_smc+1
	adc	#1
	sta	low_smc+1
	lda	#0
	adc	low_smc+2
	sta	low_smc+2

	clc
	lda	high_smc+1
	adc	#1
	sta	high_smc+1
	lda	#0
	adc	high_smc+2
	sta	high_smc+2

	clc
	lda	extra_smc+1
	adc	#1
	sta	extra_smc+1
	lda	#0
	adc	extra_smc+2
	sta	extra_smc+2


	jmp	repo_loop

done:
	lda	KEYPRESS
	bpl	done
	bit	KEYRESET

	lda	#<low_values
	sta	low_smc+1
	lda	#>low_values
	sta	low_smc+2

	lda	#<high_values
	sta	high_smc+1
	lda	#>high_values
	sta	high_smc+2

	lda	#<extra_high_values
	sta	extra_smc+1
	lda	#>extra_high_values
	sta	extra_smc+2

	jmp	repo


.include "sample.inc"

.align	$100

.include "delay_a.s"
