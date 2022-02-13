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

	; drop note down after first (rudimentary envelope)

	lda	#$C
	sta	AY_REGS+8		; Channel A
	sta	AY_REGS+9		; Channel B

	;============================
	; see if still counting down

	lda	SONG_COUNTDOWN
	bpl	done_update_song

set_notes_loop:

	;==================
	; load next byte

	ldy	SONG_OFFSET
	lda	tracker_song,Y

	;==================
	; see if hit end

	cmp	#$FF
	bne	all_ok

	;====================================
	; if at end, loop back to beginning

	lda	clear_screen_smc+1
	eor	#$7f
	sta	clear_screen_smc+1

	lda	#0			; reset song offset
	sta	SONG_OFFSET
	beq	set_notes_loop		; bra

all_ok:


handle_note:

	; NNNNNLLC -- c=channel, n=note

	tay				; save in Y

	and	#1
	asl
	tax				; channel A/B*2 in X

	tya
	lsr
	and	#$3
	sta	SONG_COUNTDOWN

	tya
	lsr
	lsr
	lsr

	tay				; lookup in table
	lda	frequencies_low,Y

	sta	AY_REGS,X		; set proper register value

	lda	frequencies_high,Y
	sta	AY_REGS+1,X

	lda	#$F
	sta	AY_REGS+8		; volume A

	;============================
	; point to next

	; assume less than 256 bytes
	inc	SONG_OFFSET


	lda	SONG_COUNTDOWN
	beq	set_notes_loop		; bra



.include "ay3_write_regs.s"

;	jsr	ay3_write_regs





handle_timing:
	; was timing

;	tya

;	and	#$3f
;	sta	SONG_COUNTDOWN

;	inc	SONG_OFFSET

done_update_song:
	dec	SONG_COUNTDOWN


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






