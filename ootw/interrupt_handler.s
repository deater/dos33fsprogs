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
	pha			; save A				; 3
				; A is saved in $45 by firmware
	txa
	pha			; save X
	tya
	pha			; save Y



;	inc	$0404		; debug (flashes char onscreen)

	bit	$C404		; clear 6522 interrupt by reading T1C-L	; 4

	lda	DONE_PLAYING						; 3
	beq	pt3_play_music	; if song done, don't play music	; 3/2nt
	jmp	exit_interrupt						; 3
								;============
								;	13

pt3_play_music:

	; decode a frame of music

	jsr	pt3_make_frame

	; handle song over condition
	lda	DONE_SONG
	beq	mb_write_frame		; if not done, continue

	lda	LOOP			; see if looping
	beq	move_to_next

pt3_loop_smc:
	lda	#0			; looping, move to loop location
	sta	current_pattern
	lda	#$0
	sta	current_line
	sta	current_subframe
	sta	DONE_SONG		; undo the next song

	beq	done_interrupt		; branch always

move_to_next:
	; same as "press right"
	ldx	#$20
	jmp	quiet_exit

	;======================================
	; Write frames to Mockingboard
	;======================================
	; for speed could merge this into
	; the decode code

mb_write_frame:


	tax			; set up reg count			; 2
								;============
								;	  2

	;==================================
	; loop through the 14 registers
	; reading the value, then write out
	;==================================

mb_write_loop:
	lda	AY_REGISTERS,X	; load register value			; 4

	; special case R13.  If it is 0xff, then don't update
	; otherwise might spuriously reset the envelope settings

	cpx	#13							; 2
	bne	mb_not_13						; 3/2nt
	cmp	#$ff							; 2
	beq	mb_skip_13						; 3/2nt
								;============
								; typ 5
mb_not_13:


	; address
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	stx	MOCK_6522_ORA2		; put address on PA2		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
	ldy	#MOCK_AY_INACTIVE	; go inactive			; 2
	sty	MOCK_6522_ORB1						; 4
	sty	MOCK_6522_ORB2						; 4

        ; value
	lda	AY_REGISTERS,X		; load register value		; 4
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	sta	MOCK_6522_ORA2		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	sta	MOCK_6522_ORB2		; write on PB2			; 4
	sty	MOCK_6522_ORB1						; 4
	sty	MOCK_6522_ORB2						; 4
								;===========
								; 	60
mb_no_write:
	inx				; point to next register	; 2
	cpx	#14			; if 14 we're done		; 2
	bmi	mb_write_loop		; otherwise, loop		; 3/2nt
								;============
								; 	7
mb_skip_13:


	jmp	exit_interrupt

	;=================================
	; Finally done with this interrupt
	;=================================

done_interrupt:

quiet_exit:
	stx	DONE_PLAYING
	jsr	clear_ay_both

	;ldx	#$ff		; also mute the channel
	stx	AY_REGISTERS+7 ; just in case

done_key:
exit_interrupt:

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


