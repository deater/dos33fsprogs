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

;	inc	$0404		; debug (flashes char onscreen)


pt3_irq_smc1:
        bit     MOCK_6522_T1CL  ; clear 6522 interrupt by reading T1C-L ; 4

        lda     DONE_PLAYING                                            ; 3
        beq     ym_play_music  ; if song done, don't play music        ; 3/2nt
        jmp     done_pt3_irq_handler                                    ; 3
                                                                ;============
                                                                ;       13

ym_play_music:

	lda	BASE_FRAME_L
	sta	CURRENT_FRAME_L
	lda	BASE_FRAME_H
	sta	CURRENT_FRAME_H

	ldx	#0
frame_loop:
	ldy	#0
	lda	(CURRENT_FRAME_L),Y
	cmp	#$ff
	bne	all_good
	cpx	#1			; see if A coarse is $FF
	beq	go_next_chunk		; if so, end of song, loop

all_good:
	jsr	update_ay_register

	clc
	lda	CURRENT_FRAME_H
	adc	#$4
	sta	CURRENT_FRAME_H

	inx
	cpx	#12
	bne	frame_loop


	inc	BASE_FRAME_L
	bne	not_oflo

	inc	BASE_FRAME_H
	lda	BASE_FRAME_H
	cmp	#$D4
	bne	not_oflo

go_next_chunk:
	inc	CURRENT_CHUNK
	jsr	load_song_chunk


not_oflo:

	jmp	exit_interrupt

	;=================================
	; Finally done with this interrupt
	;=================================

quiet_exit:
	stx	DONE_PLAYING
	jsr	clear_ay_both

	; mute the sound

	ldx	#7
	lda	#$ff
	jsr	update_ay_register


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





	;=========================
	; update ay_register
	; reg in X
	; value in A

update_ay_register:

pt3_irq_smc2:
        stx     MOCK_6522_ORA1          ; put address on PA1            ; 4
        stx     MOCK_6522_ORA2          ; put address on PA2            ; 4
        ldy     #MOCK_AY_LATCH_ADDR     ; latch_address for PB1         ; 2
pt3_irq_smc3:
        sty     MOCK_6522_ORB1          ; latch_address on PB1          ; 4
        sty     MOCK_6522_ORB2          ; latch_address on PB2          ; 4
        ldy     #MOCK_AY_INACTIVE       ; go inactive                   ; 2
pt3_irq_smc4:
        sty     MOCK_6522_ORB1                                          ; 4
        sty     MOCK_6522_ORB2                                          ; 4

        ; value
pt3_irq_smc5:
        sta     MOCK_6522_ORA1          ; put value on PA1              ; 4
        sta     MOCK_6522_ORA2          ; put value on PA2              ; 4
        lda     #MOCK_AY_WRITE          ;                               ; 2
pt3_irq_smc6:
        sta     MOCK_6522_ORB1          ; write on PB1                  ; 4
        sty     MOCK_6522_ORB1                                          ; 4
pt3_irq_smc7:
        sta     MOCK_6522_ORB2          ; write on PB2                  ; 4
        sty     MOCK_6522_ORB2                                          ; 4

	rts


done_pt3_irq_handler:

