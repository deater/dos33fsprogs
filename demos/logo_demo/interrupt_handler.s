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
	cld			; must be first in ProDOS handler

	; no need to save, ProDOS does it for us?


;	php			; save status flags
;	pha			; save A				; 3
				; A is saved in $45 by firmware
;	txa
;	pha			; save X
;	tya
;	pha			; save Y



;	inc	$0404		; debug (flashes char onscreen)


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

	; update time
;	inc	ticks
;	lda	ticks
;	cmp	#50
;	bne	no_tick_oflo

;	lda	#0
;	sta	ticks
;	inc	seconds

no_tick_oflo:

	; if done, no timeout
;	lda	command
;	cmp	#DONE
;	beq	handle_credits

	; trigger at timeout value

;	lda	seconds
;	cmp	timeout
;	bne	handle_credits

;	inc	trigger

;	lda	which
;	asl
;	tax
;	lda	todo_list,x
;	sta	command

;	cmp	#DO_CREDITS
;	bne	itsnot

;	jsr	switch_to_credits
;	lda	command

itsnot:
;	cmp	#DONE
;	beq	handle_credits

;	lda	todo_list+1,x
;	sta	timeout

	; point to next
;	inc	which

	; reset seconds
;	lda	#0
;	sta	seconds

	; HUGE HACK
	; return to our code instead of BASIC

;	ldx	original_stack
;	txs
;	lda	#>command_loop
;	pha
;	lda	#<command_loop
;	pha

;	lda	#0		; program status word
;	pha

;	rti

;handle_credits:
;	lda	command
;	cmp	#DONE
;	bne	done_match

;	jsr	display_credits


done_match:

	clc			; tell ProDOS we handled things

	rts			; ProDOS handles rti?


;	pla
;	tay			; restore Y
;	pla
;	tax			; restore X
;	pla			; restore a				; 4

	; on II+/IIe (but not IIc) we need to do this?
interrupt_smc:
;	lda	$45		; restore A
;	plp

;	rti			; return from interrupt			; 6

								;============
								; typical
								; ???? cycles



seconds:	.byte	$00
ticks:		.byte	$00
