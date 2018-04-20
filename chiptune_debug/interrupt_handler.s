	;================================
	;================================
	; mockingboard interrupt handler
	;================================
	;================================

interrupt_handler:
	pha			; save A				; 3
				; Should we save X and Y too?

.ifdef NOIRQ
.else
	bit	$C404		; clear 6522 interrupt by reading T1C-L	; 4
.endif

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
	; loop through the 14 registers
	; reading the value, then write out
	;==================================
	; inlined "write_ay_both" to save up to 156 (12*13) cycles
	; unrolled

mb_write_loop:
	lda	REGISTER_DUMP,X	; load register value			; 4
	cmp	REGISTER_OLD,X	; compare with old values		; 4
	beq	mb_no_write						; 3/2nt
								;=============
								; typ 11

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
	cpx	#14			; if 14 we're done		; 2
	bmi	mb_write_loop		; otherwise, loop		; 3/2nt
								;============
								; 	7
mb_skip_13:


	;=====================================
	; Copy registers to old
	;=====================================
	ldx	#13							; 2
mb_reg_copy:
	lda	REGISTER_DUMP,X	; load register value			; 4
	sta	REGISTER_OLD,X	; compare with old values		; 4
	dex								; 2
	bpl	mb_reg_copy						; 2nt/3
								;=============
								; 	171

	;===================================
	; Load all 14 registers in advance
	;===================================
	; note, assuming not cross page boundary, not any slower
	; then loading from zero page?

mb_load_values:

	ldx	#0		; set up reg count			; 2
	ldy	MB_CHUNK_OFFSET	; get chunk offset			; 3
								;=============
								;	5

mb_load_loop:
	lda	(INL),y		; load register value			; 5
	sta	REGISTER_DUMP,X						; 4
								;============
								;	9
	;====================
	; point to next page
	;====================

	clc				; point to next interleaved	; 2
	lda	INH			; page by adding CHUNKSIZE (3/1); 3
	adc	CHUNKSIZE						; 3
	sta	INH							; 3

	inx				; point to next register	; 2
	cpx	#14			; if 14 we're done		; 2
	bmi	mb_load_loop		; otherwise, loop		; 3/2nt
								;============
								; 	18



	;==============================================
	; incremement offset.  If 0 move to next chunk
	;==============================================

increment_offset:

	inc	MB_CHUNK_OFFSET		; increment offset		; 5

	lda	#0							; 2
	clc								; 2
	adc	#>UNPACK_BUFFER		; in proper chunk 1 or 2	; 2
	sta	INH		; update r0 pointer			; 3



	;=================================
	; Finally done with this interrupt
	;=================================

done_interrupt:
	pla			; restore a				; 4
.ifdef NOIRQ
	rts
.else
	rti			; return from interrupt			; 6
.endif

REGISTER_OLD:
	.byte	0,0,0,0,0,0,0,0,0,0,0,0,0,0
