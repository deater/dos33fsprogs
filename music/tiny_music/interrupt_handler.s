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
	cld			; clear decimal mode
	pha			; save A				; 3
				; A is saved in $45 by firmware
	txa
	pha			; save X
	tya
	pha			; save Y

	inc	$0404		; debug (flashes char onscreen)


ay3_irq_handler:
	bit	MOCK_6522_T1CL	; clear 6522 interrupt by reading T1C-L	; 4

	; see if still counting down
	lda	SONG_COUNTDOWN
	bpl	done_update_song

try_again:
	ldy	SONG_OFFSET
set_notes_loop:


	; see if hit end
	lda	(SONG_L),Y
	cmp	#$FF
	bne	all_ok

	; if at end, reset
	lda	#0
	sta	SONG_OFFSET
	beq	try_again
all_ok:


	; see if note

	tax
	and	#$C0
	cmp	#$C0
	bne	note_only

	; was timing

	txa
	and	#$3f
	sta	SONG_COUNTDOWN
	iny
	sty	SONG_OFFSET
	jmp	done_update_song

note_only:
	txa
	; CCOONNNN -- c=channel, o=octave, n=note
	; FIXME: OONNNNCC instead?

	pha
	lsr
	lsr
	lsr
	lsr
	lsr
	and	#$FE
	sta	out_smc+1
	pla
	and	#$3F
	tax
	lda	frequency_lookup,X
	sty	y_smc+1
out_smc:
	ldx	#$00
	jsr	ay3_write_reg	; trashes A/X/Y

	; set coarse note A	(assume 0)
	;			could get extra octave by putting 1 here

y_smc:
	ldy	#0
	iny
	jmp	set_notes_loop

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
	pla			; restore a				; 4

	; on II+/IIe (but not IIc) we need to do this?
interrupt_smc:
	lda	$45		; restore A
	plp			; restore flags

	rti			; return from interrupt			; 6

								;============
								; typical
								; ???? cycles







