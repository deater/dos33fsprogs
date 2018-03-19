; This plays KRG files, stripped down ym5 files
;   this is a limited format: the envelope values are ignored
;   the fields with don't-care values are packed together
;   they are played at 25Hz

; FRAME0 = AFINE	(r0)
; FRAME1 = BFINE	(r2)
; FRAME2 = CFINE	(r4)
; FRAME3 = NOISE PERIOD	(r6)
; FRAME4 = ENABLE	(r7)
; FRAME5 = ACOARSE/BCOARSE	(r1/r3)
; FRAME6 = CCOARSE/AAMP		(r5/r8)
; FRAME7 = BAMP/CAMP		(r9/r10)

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

CHUNKSIZE	EQU     11	; hardcoded, based on krg file

interrupt_handler:
	pha			; save A				; 3
				; Should we save X and Y too?

;	inc	$0404		; debug (flashes char onscreen)

	bit	$C404		; clear 6522 interrupt by reading T1C-L	; 4


	lda	DONE_PLAYING						; 3
	beq	mb_play_music	; if song done, don't play music	; 3/2nt
	jmp	done_interrupt						; 3
								;============
								;	13

mb_play_music:


	;======================================
	; Write frames to Mockingboard
	;======================================
	; actually plays frame loaded at end of
	; last interrupt, so 20ms behind?

mb_write_frame:




	;==================================
	; loop through the 11 registers
	; reading the value, then write out
	;==================================
	ldx	#0		; set up reg count			; 2

mb_write_loop_left:
	lda	REGISTER_DUMP,X	; load register value			; 4
	cmp	REGISTER_OLD,X	; compare with old values		; 4
	beq	mb_no_write_left					; 3/2nt
								;=============
								; typ 11

	; address
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP,X		; load register value		; 4
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	36
mb_no_write_left:
	inx				; point to next register	; 2
	cpx	#11			; if 11 we're done		; 2
	bmi	mb_write_loop_left	; otherwise, loop		; 3/2nt
								;============
								; 	7

	ldx	#0		; set up reg count			; 2
mb_write_loop_right:
	lda	REGISTER_DUMP,X	; load register value			; 4
	cmp	REGISTER_OLD,X	; compare with old values		; 4
	beq	mb_no_write_right					; 3/2nt
								;=============
								; typ 11

	; address
	stx	MOCK_6522_ORA2		; put address on PA2		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB2						; 4

        ; value
	lda	REGISTER_DUMP,X		; load register value		; 4
	sta	MOCK_6522_ORA2		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB2		; write on PB2			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB2						; 4

								;===========
								; 	36
mb_no_write_right:
	inx				; point to next register	; 2
	cpx	#11			; if 11 we're done		; 2
	bmi	mb_write_loop_right	; otherwise, loop		; 3/2nt
								;============
								; 	7

	;=====================================
	; Copy registers to old
	;=====================================
	ldx	#10							; 2
mb_reg_copy:
	lda	REGISTER_DUMP,X	; load register value			; 4
	sta	REGISTER_OLD,X	; compare with old values		; 4
	dex								; 2
	bpl	mb_reg_copy						; 2nt/3
								;=============
								; 	171

	;===================================
	; Load all 11 registers in advance
	;===================================
	; note, assuming not cross page boundary, not any slower
	; then loading from zero page?

mb_load_values:

	ldy	MB_CHUNK_OFFSET	; get chunk offset			; 3

	; afine
	lda	(MB_ADDRL),y		; load register value		; 5
	sta	A_FINE_TONE						; 3
	clc				; point to next interleaved	; 2
	lda	MB_ADDRH		; page by adding CHUNKSIZE	; 3
	adc	#CHUNKSIZE						; 3
	sta	MB_ADDRH						; 3

	; bfine
	lda	(MB_ADDRL),y		; load register value		; 5
	sta	B_FINE_TONE						; 3
	clc				; point to next interleaved	; 2
	lda	MB_ADDRH		; page by adding CHUNKSIZE	; 3
	adc	#CHUNKSIZE						; 3
	sta	MB_ADDRH						; 3

	; cfine
	lda	(MB_ADDRL),y		; load register value		; 5
	sta	C_FINE_TONE						; 3
	clc				; point to next interleaved	; 2
	lda	MB_ADDRH		; page by adding CHUNKSIZE	; 3
	adc	#CHUNKSIZE						; 3
	sta	MB_ADDRH						; 3

	; noise
	lda	(MB_ADDRL),y		; load register value		; 5
	sta	NOISE							; 3
	clc				; point to next interleaved	; 2
	lda	MB_ADDRH		; page by adding CHUNKSIZE	; 3
	adc	#CHUNKSIZE						; 3
	sta	MB_ADDRH						; 3

	; enable
	lda	(MB_ADDRL),y		; load register value		; 5
	sta	ENABLE							; 3
	clc				; point to next interleaved	; 2
	lda	MB_ADDRH		; page by adding CHUNKSIZE	; 3
	adc	#CHUNKSIZE						; 3
	sta	MB_ADDRH						; 3

	; acoarse/bcoarse
	lda	(MB_ADDRL),y		; load register value		; 5
	and	#$f							; 2
	sta	B_COARSE_TONE						; 3
	lda	(MB_ADDRL),y		; load register value		; 5
	lsr								; 2
	lsr								; 2
	lsr								; 2
	lsr								; 2
	sta	A_COARSE_TONE						; 3
	clc				; point to next interleaved	; 2
	lda	MB_ADDRH		; page by adding CHUNKSIZE	; 3
	adc	#CHUNKSIZE						; 3
	sta	MB_ADDRH						; 3

	; CCOARSE/AAMP
	lda	(MB_ADDRL),y		; load register value		; 5
	and	#$f							; 2
	sta	A_VOLUME						; 3
	lda	(MB_ADDRL),y		; load register value		; 5
	lsr								; 2
	lsr								; 2
	lsr								; 2
	lsr								; 2
	sta	C_COARSE_TONE						; 3
	clc				; point to next interleaved	; 2
	lda	MB_ADDRH		; page by adding CHUNKSIZE	; 3
	adc	#CHUNKSIZE						; 3
	sta	MB_ADDRH						; 3
	inx				; point to next register	; 2

	; BAMP/CAMP
	lda	(MB_ADDRL),y		; load register value		; 5
	and	#$f							; 2
	sta	C_VOLUME						; 3
	lda	(MB_ADDRL),y		; load register value		; 5
	lsr								; 2
	lsr								; 2
	lsr								; 2
	lsr								; 2
	sta	B_VOLUME						; 3

	;=========================================
	; if NOISE is $ff then we are done

	lda	NOISE						; 3
	bpl	mb_not_done						; 3/2nt

	jmp	quiet_exit						; 3
								;===========
								; typ 6
mb_not_done:

	;==============================================
	; incremement offset.  If 0 move to next chunk
	;==============================================

increment_offset:

	inc	MB_CHUNK_OFFSET		; increment offset		; 5
	bne	increment_done	; if not zero,	done		; 3/2nt

	inc	WHICH_CHUNK
	lda	WHICH_CHUNK
	cmp	#CHUNKSIZE
	bne	increment_done

	lda	#0
	sta	WHICH_CHUNK

increment_done:

	lda	#>music_start
	clc
	adc	WHICH_CHUNK
	sta	MB_ADDRH

	;=================================
	; Finally done with this interrupt
	;=================================

done_interrupt:
;	jmp	exit_interrupt

quiet_exit:
;	sta	DONE_PLAYING
;	jsr	clear_ay_both

	;=====================================
	; clear register area
	;=====================================
;	ldx	#13							; 2
;	lda	#0							; 2
;mb_clear_reg:
;	sta	REGISTER_DUMP,X ; clear register value			; 4
;	sta	REGISTER_OLD,X	; clear old values			; 4
;	dex								; 2
;	bpl	mb_clear_reg						; 2nt/3

exit_interrupt:

	pla			; restore a				; 4

	rti			; return from interrupt			; 6

								;============
								; typical
								; ???? cycles


REGISTER_OLD:
	.byte	0,0,0,0,0,0,0,0,0,0,0,0,0,0
