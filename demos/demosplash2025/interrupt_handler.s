	;================================
	;================================
	; mockingboard interrupt handler
	;================================
	;================================
	; On Apple II/6502 the interrupt handler jumps to address in 0xfffe
	; This is in the ROM, which saves the registers
	;   on older IIe it saved A to $45 (which could mess with DISK II)
	;   newer IIe doesn't do that.
	; It then calculates if it is a BRK or not (which trashes A)
	; Then it sets up the stack like an interrupt and calls 0x3fe

	; Note: the IIc is much more complicated
	;	its firmware tries to decode the proper source
	;	based on various things, including screen hole values
	;	we bypass that by switching out ROM and replacing the
	;	$fffe vector with this, but that does mean we have
	;	to be sure status flag and accumulator set properly

interrupt_handler:

	; on Apple IIe with bank switching must save/restore bank switch stuff
	; possibly need to do this before we even use the stack....

	; for now assume ALTZP isn't set


	php			; save flags

	pha			; save A				; 3
				; A is saved in $45 by firmware
	txa
	pha			; save X
	tya
	pha			; save Y


;	lda	RDALTZP		; bit 7 is if ALT (1) or MAIN (0)

	lda	RDBNK2		; bit 7 is if $D000 bank 2 (1) or bank 1 (0)
	pha

	lda	RAMWRT		; bit 7 is write AUX=1 MAIN=0
	pha

	lda	RAMRD		; bit 7 is read AUX=1 MAIN=0
	pha


	; set the banking the way we want

	sta	READMAINMEM
	sta	WRITEMAINMEM

	lda	LCBANK1		; switch to language card bank1
	lda	LCBANK1




;	inc	$0404		; debug (flashes char onscreen)

	lda	IRQ_COUNTDOWN
	beq	skip_irq_dec
	dec	IRQ_COUNTDOWN
skip_irq_dec:


.include "pt3_lib_irq_handler.s"

	jmp	exit_interrupt

	;=================================
	; Finally done with this interrupt
	;=================================

quiet_exit:
	stx	DONE_PLAYING
	jsr	clear_ay_both

	ldx	#$ff		; also mute the channel
	stx	AY_REGISTERS+7	; just in case


exit_interrupt:

	pla			; bit 7 is read AUX=1 MAIN=0
	rol
	rol
	and	#$1
	tax
	sta	READMAINMEM,X	; $C002/$C003

	pla
	rol
	rol
	and	#$1
	tax
	sta	WRITEMAINMEM,X	; $C004/$C005

	pla		; bit 7 is if $D000 bank 2 (1) or bank 1 (0)
			;	C083/C08B	bank2/bank1 0011 1011

	bpl	fix_bank1
fix_bank2:
	lda	LCBANK2
	lda	LCBANK2
	jmp	fix_bank_done
fix_bank1:
	lda	LCBANK1
	lda	LCBANK1
fix_bank_done:

;	lsr
;	lsr
;	lsr
;	lsr
;	and	#$08
;	tax
;	lda	LCBANK2,X
;	lda	LCBANK2,X

	pla
	tay			; restore Y
	pla
	tax			; restore X
	pla			; restore a				; 4

	; on II+/IIe (but not IIc) we need to do this?
interrupt_smc:
	lda	$45		; restore A
	plp

	rti			; return from interrupt			; 6

								;============
								; typical
								; ???? cycles



