; This code detects a SSI263 chip on a Mockingboard
;	it does this by trying to enable the chip and waiting for
;	the SSI-263 to signal an interrupt when done.
;	If the interrupt never comes then assume no SSI-263 is present
; The code assumes the SSI-263 is hooked to VIA6522 #2 (?)

	;=============================
	;=============================
	; detect SSI263
	;=============================
	;=============================
	; A = slot of mockingboard

detect_ssi263:
	sta	MOCKINGBOARD_SLOT	; store for later

	and	#$7
	ora	#$c0		; turn slot number into address
	sta	ssid_wc_smc1+2	; update the read/write routines

	sei			; disable IRQ

	lda	$3fe		; backup the IRQ handler
	sta	irq1backup
	lda	$3ff
	sta	irq2backup

	lda	#<mb_irq	; point IRQ handler to our code
	sta	$3fe
	lda	#>mb_irq
	sta	$3ff

	; Set 6522#2 peripheral control register to recognize the signal
	; from the speech chip.
	lda	#(VIA6522_PCR2_CA2_LOW|VIA6522_PCR2_CA1_NEG)
	ldx	#VIA6522_PCR2
	jsr	ssi263_d_write_chip

	; Raise control bit in register 3 of SSI-263
	lda	#SSI263_CAA_CTL
	ldx	#SSI263_CAA
	jsr	ssi263_d_write_chip

	; Transitioned inflection (when CTL is toggled)
	lda	#SSI263_DRP_TRANSITIONED_INFLECTION
	ldx	#SSI263_DRP
	jsr	ssi263_d_write_chip

	; Lower control bit in SSI-263
	lda	#$70		; CTL=0, T=6, AMP=0
	ldx	#SSI263_CAA
	jsr	ssi263_d_write_chip

	; Enable 6522 interrupt on input CA2
	lda	#(VIA6522_IER2_SET|VIA6522_IER2_CA1)
	ldx	#VIA6522_IER2
	jsr	ssi263_d_write_chip

	ldx	#0		; clear counts
	ldy	#0

	cli			; enable interrupts

wait_irq:
	lda	irq_count	; see if irq happened

	bne	got_irq

	iny			; otherwise increase counts
	bne	wait_irq
	inx			;
	bne	wait_irq

got_irq:
	sei			; disable interrupts

	rts


	;========================
	; detection IRQ handler
	;========================
mb_irq:
	txa				; save X
	pha

	; Clear the 6522 interrupt flag
	lda	#VIA6522_IFR2_CA1
	ldx	#VIA6522_IFR2
	jsr	ssi263_d_write_chip

	; disable speech

	; Raise control bit in register 3 of SSI-263
	lda	#SSI263_CAA_CTL
	ldx	#SSI263_CAA
	jsr	ssi263_d_write_chip

	; Disable talking on SSI-263 (when CTL is toggled)
	lda	#SSI263_DRP_DISABLE_AR
	ldx	#SSI263_DRP
	jsr	ssi263_d_write_chip

	; Lower control bit in SSI-263
	lda	#$70		; also T=7?
	ldx	#SSI263_CAA
	jsr	ssi263_d_write_chip

	; increment our irq count

	inc	irq_count

	; Disable 6522 interrupts
	lda	#VIA6522_IER2_CA1
	ldx	#VIA6522_IER2
	jsr	ssi263_d_write_chip

	pla			; restore X
	tax

	lda	$45		; restore accumulator

	rti			; return from interrupt


        ;========================
        ; write_chip
        ;========================
ssi263_d_write_chip:
ssid_wc_smc1:
        sta     $C000,X
        rts

irq_count:	.byte $00
irq1backup:	.byte $00
irq2backup:	.byte $00

