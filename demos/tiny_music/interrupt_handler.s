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


pt3_irq_handler:
	bit	MOCK_6522_T1CL	; clear 6522 interrupt by reading T1C-L	; 4

	; set note A

	ldx	#$00
	lda	#$F4
	jsr	pt3_write_reg

	; set coarse note A

	ldx	#$01
	lda	#$00
	jsr	pt3_write_reg

	; set mixer ABC enabled

	ldx	#$07
	lda	#$38
	jsr	pt3_write_reg

	; A volume 14

	ldx	#$08
	lda	#$E
	jsr	pt3_write_reg




	;=================================
	; Finally done with this interrupt
	;=================================

done_pt3_irq_handler:


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

; starts at C4
frequency_lookup:
.byte $F4,$E6,$D9,$CD,$C1,$B7,$AC,$A3,$99,$91,$89,$81,$00,$00,$00,$00
.byte $7A,$73,$6C,$66,$60,$5B,$56,$51,$4C,$48,$44,$40,$00,$00,$00,$00
.byte $3D,$39,$36,$33,$30,$2D,$2B,$28,$26,$24,$22,$20,$00,$00,$00,$00

; .byte $EE,$E1,$D4,$C8,$BD,$B2,$A8,$9F,$96,$8E,$86,$7E,$00,$00,$00,$00
; .byte $77,$70,$6A,$64,$5E,$59,$54,$4F,$4B,$47,$43,$3F,$00,$00,$00,$00
; .byte $3B,$38,$35,$32,$2F,$2C,$2A,$27,$25,$23,$21,$1F,$00,$00,$00,$00

	;=====================
	; address in X
	; value in A
pt3_write_reg:
        stx     MOCK_6522_ORA1          ; put address on PA1            ; 4
        stx     MOCK_6522_ORA2          ; put address on PA2            ; 4
        ldy     #MOCK_AY_LATCH_ADDR     ; latch_address for PB1         ; 2
        sty     MOCK_6522_ORB1          ; latch_address on PB1          ; 4
        sty     MOCK_6522_ORB2          ; latch_address on PB2          ; 4
        ldy     #MOCK_AY_INACTIVE       ; go inactive                   ; 2
        sty     MOCK_6522_ORB1                                          ; 4
        sty     MOCK_6522_ORB2                                          ; 4

        ; value
        sta     MOCK_6522_ORA1          ; put value on PA1              ; 4
        sta     MOCK_6522_ORA2          ; put value on PA2              ; 4
        lda     #MOCK_AY_WRITE          ;                               ; 2
        sta     MOCK_6522_ORB1          ; write on PB1                  ; 4
        sty     MOCK_6522_ORB1                                          ; 4
        sta     MOCK_6522_ORB2          ; write on PB2                  ; 4
        sty     MOCK_6522_ORB2                                          ; 4
	rts
