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
	php			; save status flags

	; we don't use decimal mode so no need to clear it?

	; A is saved in $45 by firmware
	; we are assuming a II/II+/IIe here

	txa
	pha			; save X
	tya
	pha			; save Y

;	inc	$0404		; debug (flashes char onscreen)


ay3_irq_handler:

	;==========================================
	; clear 6522 interrupt by reading T1C-L	; 4

	bit	MOCK_6522_T1CL


.include "play_frame.s"


	;=================================
	; Finally done with this interrupt
	;=================================

done_ay3_irq_handler:

	pla
	tay			; restore Y
	pla
	tax			; restore X

	; on II+/IIe the firmware saves A in $45
	; this won't work on a IIc/IIgs

	lda	$45		; restore A
	plp			; restore flags

	rti			; return from interrupt			; 6

								;============
								; typical
								; ???? cycles






