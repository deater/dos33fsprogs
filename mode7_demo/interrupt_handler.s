; This plays KRG files, stripped down ym5 files
;   this is a limited format: the envelope values are ignored
;   the fields with don't-care values are packed together
;   they are played at 25Hz

; FRAME0 = AFINE
; FRAME1 = BFINE
; FRAME2 = CFINE
; FRAME3 = NOISE PERIOD
; FRAME4 = ENABLE
; FRAME5 = ACOARSE/BCOARSE
; FRAME6 = CCOARSE/AAMP
; FRAME7 = BAMP/CAMP

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

CHUNKSIZE	EQU     8	; hardcoded, based on krg file

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


	ldx	#0		; set up reg count			; 2
								;============
								;	  2

	;==================================
	; loop through the 11 registers
	; reading the value, then write out
	;==================================

mb_write_loop:
	lda	REGISTER_DUMP,X	; load register value			; 4
	cmp	REGISTER_OLD,X	; compare with old values		; 4
	beq	mb_no_write						; 3/2nt
								;=============
								; typ 11

	; address
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	stx	MOCK_6522_ORA2		; put address on PA2		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	sta	MOCK_6522_ORB2		; latch_address on PB2		; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4
	sta	MOCK_6522_ORB2						; 4

        ; value
	lda	REGISTER_DUMP,X		; load register value		; 4
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	sta	MOCK_6522_ORA2		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	sta	MOCK_6522_ORB2		; write on PB2			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4
	sta	MOCK_6522_ORB2						; 4

								;===========
								; 	62
mb_no_write:
	inx				; point to next register	; 2
	cpx	#11			; if 11 we're done		; 2
	bmi	mb_write_loop		; otherwise, loop		; 3/2nt
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

	ldx	#0		; set up reg count			; 2
	ldy	MB_CHUNK_OFFSET	; get chunk offset			; 3
								;=============
								;	5

mb_load_loop:
	lda	(MB_ADDRL),y		; load register value		; 5
	sta	REGISTER_DUMP,X						; 4
								;============
								;	9
	;====================
	; point to next page
	;====================

	clc				; point to next interleaved	; 2
	lda	MB_ADDRH		; page by adding CHUNKSIZE	; 3
	adc	#CHUNKSIZE						; 3
	sta	MB_ADDRH						; 3

	inx				; point to next register	; 2
	cpx	#11			; if 14 we're done		; 2
	bmi	mb_load_loop		; otherwise, loop		; 3/2nt
								;============
								; 	18

	;=========================================
	; if A_COARSE_TONE is $ff then we are done

	lda	A_COARSE_TONE						; 3
	bpl	mb_not_done						; 3/2nt

	lda	#1		; set done playing			; 2

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
	jmp	exit_interrupt

quiet_exit:
	sta	DONE_PLAYING
	jsr	clear_ay_both

	;=====================================
	; clear register area
	;=====================================
	ldx	#13							; 2
	lda	#0							; 2
mb_clear_reg:
	sta	REGISTER_DUMP,X ; clear register value			; 4
	sta	REGISTER_OLD,X	; clear old values			; 4
	dex								; 2
	bpl	mb_clear_reg						; 2nt/3

exit_interrupt:

	pla			; restore a				; 4

	rti			; return from interrupt			; 6

								;============
								; typical
								; ???? cycles


REGISTER_OLD:
	.byte	0,0,0,0,0,0,0,0,0,0,0,0,0,0
