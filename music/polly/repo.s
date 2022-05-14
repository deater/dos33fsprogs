; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SPEAKER	= $C030


repo:
	ldy	#0
repo_loop:
	bit	SPEAKER
addr_smc:
	lda	low_values,Y
	cmp	#$FF
	beq	done

	jsr	delay_a

	clc
	lda	addr_smc+1
	adc	#1
	sta	addr_smc+1
	lda	#0
	adc	addr_smc+2
	sta	addr_smc+2

	jmp	repo_loop

done:
	lda	KEYPRESS
	bpl	done
	bit	KEYRESET

	lda	#<low_values
	sta	addr_smc+1
	lda	#>low_values
	sta	addr_smc+2

	jmp	repo


.include "sample.inc"

.align	$100

.include "delay_a.s"
