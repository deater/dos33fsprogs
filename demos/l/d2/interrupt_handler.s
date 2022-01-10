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

	cmp	#$C0
	bne	all_ok

	;====================================
	; if at end, loop back to beginning

	lda	#0			; reset song offset
	sta	SONG_OFFSET
	beq	set_notes_loop		; bra

all_ok:

	; see if note

	tay
	and	#$C0
	cmp	#$C0
	beq	handle_timing

note_only:
	tya
	; CCOONNNN -- c=channel, o=octave, n=note
	; TODO: OONNNNCC instead?

	lsr
	lsr
	lsr
	lsr
	sta	OCTAVE			; save octave for later
	lsr
	and	#$FE			; fine register value, want in X
	tax

	tya				; get note
	and	#$3F
	tay				; lookup in table
	lda	frequency_lookup_low,Y

	sta	AY_REGS,X		; set proper register value

	; set coarse note A
	;  hack: if octave=0 (C2) then coarse=1
	;        else coarse=0

	inx			; point to corase register

	lda	OCTAVE
	and	#$3		; if 0 then 1
				; if 1,2,3 then 0
	beq	invert

	lda	#1
invert:
	eor	#$1

	sta	AY_REGS,X

	jsr	ay3_write_regs	; trashes A/X/Y


	;============================
	; point to next

	inc	SONG_OFFSET

	; assume less than 256 bytes

	bne	set_notes_loop		; bra

handle_timing:
	; was timing

	tya

	and	#$3f
	sta	SONG_COUNTDOWN

	inc	SONG_OFFSET

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

