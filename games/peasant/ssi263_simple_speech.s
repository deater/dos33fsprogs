
.include "ssi263.inc"

; Simple speech routine for ssi-263

; to save space we only change the Phoneme/Delay each time, we don't
; mess with the other registers

	;========================
	; ssi263_write_chip
	;========================
ssi263_write_chip:
wc_smc1:
	sta	$C000,X
	rts

	;========================
	; read_chip
	;========================
ssi263_read_chip:
rc_smc1:
	lda	$C000,X
	rts


	;========================
	; ssi263_speech_init
	;========================
	; A = slot number of mockingboard
ssi263_speech_init:
	sei			; disable interrupts

	lda	MOCKINGBOARD_SLOT
	and	#$7
	ora	#$c0		; turn slot number into address
	sta	wc_smc1+2	; update the read/write routines
	sta	rc_smc1+2

	; Set 6522#2 peripheral control register to recognize the signal
	; from the speech chip.
	lda	#(VIA6522_PCR2_CA2_LOW|VIA6522_PCR2_CA1_NEG)
	ldx	#VIA6522_PCR2
	jsr	ssi263_write_chip


	lda	#<ssi263_speech_irq	; point IRQ handler to our code
	sta	$fffe
	lda	#>ssi263_speech_irq
	sta	$ffff


	; set defaults

	; filter frequency
	lda	#$E9
	ldx	#SSI263_F
	jsr	ssi263_write_chip

	; control / articulation/ amplitude
	lda	#$5C
	ldx	#SSI263_CAA
	jsr	ssi263_write_chip

	; rate/inflection
	lda	#$A8
	ldx	#SSI263_RI
	jsr	ssi263_write_chip

	; inflection
	lda	#$50
	ldx	#SSI263_I
	jsr	ssi263_write_chip


	cli				; enable interrupts

	rts


	;============================
	; ssi263_speech_shutdown
	;============================

ssi263_speech_shutdown:
	sei

	jsr	ssi263_disable

	rts



	;=========================
	; ssi263_speak
	;=========================
	; pointer to data in SPEECH_PTRL/H

ssi263_speak:

	sei		; disable interrupts

	; Set the busy flag
	lda	#$FF
	sta	speech_busy

	; Set peripheral control register to recognize the signal from the
	; speech chip.
	lda	#(VIA6522_PCR2_CA2_LOW|VIA6522_PCR2_CA1_NEG)
	ldx	#VIA6522_PCR2
	jsr	ssi263_write_chip

	; Set transitioned inflection by setting value while toggling CTL

	lda	#SSI263_CAA_CTL
	ldx	#SSI263_CAA
	jsr	ssi263_write_chip

	; Set transitioned inflection mode in register 0
	lda	#SSI263_DRP_TRANSITIONED_INFLECTION
	ldx	#SSI263_DRP
	jsr	ssi263_write_chip

	; Lower control bit
	lda	#$70		; also T=7
	ldx	#SSI263_CAA
	jsr	ssi263_write_chip

	; Enable 6522 interrupts
	lda	#(VIA6522_IER2_SET|VIA6522_IER2_CA1)
	ldx	#VIA6522_IER2
	jsr	ssi263_write_chip

	cli			; re-enable interrupts

	rts


	;====================
	; speech interrupt
	;====================
ssi263_speech_irq:

	php			; save flags
	cld

	pha			; save A
	txa
	pha			; save X
	tya
	pha			; save Y

;	inc	$0404		; irq indicator on screen

	; be sure it was a 6522#2 interrupt
	ldx	#VIA6522_IFR2
	jsr	ssi263_read_chip
	bmi	have_interrupt

	; wasn't us, return to caller
	; this assumes we can handle multiple interrupt sources

	jmp	end_interrupt

have_interrupt:
	; Clear the 6522#2 CA interrupt flag
	lda	#VIA6522_IFR2_CA1
	ldx	#VIA6522_IFR2
	jsr	ssi263_write_chip

	; Check if done with speech
	ldy	#0
	lda	(SPEECH_PTRL),Y
	cmp	#$ff
	beq	speech_end

not_end:

	; Set the speech playing flag
	lda	#$ff
	sta	speech_playing


	ldy	#$00
	; Get the next data
	lda	(SPEECH_PTRL),Y
	ldx	#SSI263_DRP		; duration/phoneme
	jsr	ssi263_write_chip

	; Next data (inc 16 bit)
	inc	SPEECH_PTRL
	bne	no_oflo
	inc	SPEECH_PTRH
no_oflo:

	; Finish the interrupt handler
	jmp	end_interrupt

speech_end:

	jsr	ssi263_disable

end_interrupt:

	pla
	tay				; restore Y
	pla
	tax				; restore X

	pla				; restore A

interrupt_smc:
;	lda	$45			; restore A (II+/IIe)

	plp				; restore flags

	rti				; return from interrupt


ssi263_disable:
	; If at the end, turn everything off

	; Toggle CTL while DR set to disable A/!R

	lda	#SSI263_CAA_CTL
	ldx	#SSI263_CAA
	jsr	ssi263_write_chip

	lda	#SSI263_DRP_DISABLE_AR
	ldx	#SSI263_DRP
	jsr	ssi263_write_chip

	; Zero amplitude
	lda	#$70
	ldx	#SSI263_CAA
	jsr	ssi263_write_chip

	; Clear busy and playing flags
	lda	#$00
	sta	speech_busy
	sta	speech_playing

	; Disable interrupt in 6522
	lda	#VIA6522_IER2_CA1
	ldx	#VIA6522_IER2
	jsr	ssi263_write_chip

	rts

speech_busy:	.byte   $00
speech_playing:	.byte   $00

