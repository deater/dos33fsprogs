; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SPEAKER=  $C030

WAIT   = $FCA8                 ; delay 1/2(26+27A+5A^2) us

; zero page use
HALF_PERIOD = $FF

test_sound:
	jsr	tiny_sound_effect

wait_until_keypress:
	lda	KEYPRESS
	bpl	wait_until_keypress
	bit	KEYRESET

	jmp	test_sound




tiny_sound_effect:
	ldy	#0

freq_smc:
	lda	#$40
	sta	HALF_PERIOD

play_note:

loop_half_period:
	lda	$C030			; 4 cycles
	ldx	HALF_PERIOD		; 3 cycles
loop_nops:
	pha				; 4 cycles
	plp				; 4 cycles

	dex				; 2 cycles
	bne	loop_nops		; 3 cycles

	; Testing duration loop
	dey				; 2 cycles
	bne	loop_half_period	; 3 cycles


	lsr	freq_smc+1

	lsr	pattern
	beq	end
	bcc	skip_wait

wait_smc:
	lda	#80
	jsr	WAIT
skip_wait:

	beq	tiny_sound_effect		; bra

end:
	rts








pattern:
	.byte	$13
