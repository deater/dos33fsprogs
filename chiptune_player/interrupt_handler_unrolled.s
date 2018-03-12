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

TIME_OFFSET	EQU	13

interrupt_handler:
	pha			; save A				; 3
				; Should we save X and Y too?

;	inc	$0404		; debug (flashes char onscreen)

	bit	$C404		; clear 6522 interrupt by reading T1C-L	; 4


	lda	DONE_PLAYING						; 3
	beq	mb_play_music	; if song done, don't play music	; 3/2nt
	jmp	check_keyboard						; 3
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
	; loop through the 14 registers
	; reading the value, then write out
	;==================================
	; inlined "write_ay_both" to save up to 156 (12*13) cycles
	; unrolled

mb_write_r0_right:

	lda	REGISTER_DUMP+0	; load register value			; 3
	cmp	REGISTER_OLD+0	; compare with old values		; 4
	beq	mb_write_r1_right					; 3/2nt
								;=============
								; typ 10
	; address
	ldx	#0							; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+0		; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37

mb_write_r1_right:

	lda	REGISTER_DUMP+1	; load register value			; 3
	cmp	REGISTER_OLD+1	; compare with old values		; 4
	beq	mb_write_r2_right					; 3/2nt
								;=============
								; typ 10
	; address
	ldx	#1							; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+1		; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37
mb_write_r2_right:

	lda	REGISTER_DUMP+2	; load register value			; 3
	cmp	REGISTER_OLD+2	; compare with old values		; 4
	beq	mb_write_r3_right					; 3/2nt
								;=============
								; typ 10
	; address
	ldx	#2							; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+2		; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37
mb_write_r3_right:

	lda	REGISTER_DUMP+3	; load register value			; 3
	cmp	REGISTER_OLD+3	; compare with old values		; 4
	beq	mb_write_r4_right					; 3/2nt
								;=============
								; typ 10
	; address
	ldx	#3							; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+3		; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37
mb_write_r4_right:

	lda	REGISTER_DUMP+4	; load register value			; 3
	cmp	REGISTER_OLD+4	; compare with old values		; 4
	beq	mb_write_r5_right					; 3/2nt
								;=============
								; typ 10
	; address
	ldx	#4							; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+4		; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37
mb_write_r5_right:

	lda	REGISTER_DUMP+5	; load register value			; 3
	cmp	REGISTER_OLD+5	; compare with old values		; 4
	beq	mb_write_r6_right					; 3/2nt
								;=============
								; typ 10
	; address
	ldx	#5							; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+5		; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37
mb_write_r6_right:

	lda	REGISTER_DUMP+6	; load register value			; 3
	cmp	REGISTER_OLD+6	; compare with old values		; 4
	beq	mb_write_r7_right					; 3/2nt
								;=============
								; typ 10
	; address
	ldx	#6							; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+6		; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37
mb_write_r7_right:

	lda	REGISTER_DUMP+7	; load register value			; 3
	cmp	REGISTER_OLD+7	; compare with old values		; 4
	beq	mb_write_r8_right					; 3/2nt
								;=============
								; typ 10
	; address
	ldx	#7							; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+7		; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37

mb_write_r8_right:

	lda	REGISTER_DUMP+8	; load register value			; 3
	cmp	REGISTER_OLD+8	; compare with old values		; 4
	beq	mb_write_r9_right					; 3/2nt
								;=============
								; typ 10
	; address
	ldx	#8						; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+8		; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37
mb_write_r9_right:

	lda	REGISTER_DUMP+9	; load register value			; 3
	cmp	REGISTER_OLD+9	; compare with old values		; 4
	beq	mb_write_r10_right					; 3/2nt
								;=============
								; typ 10
	; address
	ldx	#9							; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+9		; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37
mb_write_r10_right:

	lda	REGISTER_DUMP+10; load register value			; 3
	cmp	REGISTER_OLD+10	; compare with old values		; 4
	beq	mb_write_r11_right					; 3/2nt
								;=============
								; typ 10
	; address
	ldx	#10							; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+10	; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37
mb_write_r11_right:

	lda	REGISTER_DUMP+11; load register value			; 3
	cmp	REGISTER_OLD+11	; compare with old values		; 4
	beq	mb_write_r12_right					; 3/2nt
								;=============
								; typ 10
	; address
	ldx	#11							; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+11	; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37
mb_write_r12_right:

	lda	REGISTER_DUMP+12; load register value			; 3
	cmp	REGISTER_OLD+12	; compare with old values		; 4
	beq	mb_write_r13_right					; 3/2nt
								;=============
								; typ 10
	; address
	ldx	#12							; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+12	; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37
mb_write_r13_right:

	lda	REGISTER_DUMP+13; load register value			; 3
	cmp	REGISTER_OLD+13	; compare with old values		; 4
	beq	mb_write_done_right					; 3/2nt
	cmp	#$ff			; if FF we skip	r13		; 2
	beq	mb_write_done_right					; 3/2nt


								;=============
								; typ 10
	; address
	ldx	#13							; 2
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	lda	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sta	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

        ; value
	lda	REGISTER_DUMP+13	; load register value		; 3
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	lda	#MOCK_AY_INACTIVE	; go inactive			; 2
	sta	MOCK_6522_ORB1						; 4

								;===========
								; 	37
mb_write_done_right:


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
	bne	back_to_first_reg	; if not zero,	done		; 3/2nt


	;=====================
	; move to next state
	;=====================

	clc
	rol	DECODER_STATE		; next state			; 5
					; 20 -> 40 -> 80 -> c+00
	bcs	wraparound_to_a						; 3/2nt

	bit	DECODER_STATE		;bit7->N bit6->V
	bvs	back_to_first_reg	; do nothing on B		; 3/2nt

start_c:
	lda	#1
	sta	CHUNKSIZE

	; setup next three chunks of song

	lda	#1				; start decompressing
	sta	DECOMPRESS_TIME			; outside of handler

	jmp	back_to_first_reg

wraparound_to_a:
	lda	#$3
	sta	CHUNKSIZE
	lda	#$20
	sta	DECODER_STATE
	sta	COPY_TIME			; start copying

	lda	DECOMPRESS_TIME
	beq	blah
	lda	#1
	sta	DECODE_ERROR
blah:
	;==============================
	; After 14th reg, reset back to
	; read R0 data
	;==============================

back_to_first_reg:
	lda	#0							; 2
	bit	DECODER_STATE						; 3
	bmi	back_to_first_reg_c					; 2nt/3
	bvc	back_to_first_reg_a					; 2nt/3

back_to_first_reg_b:
	lda	#$1			; offset by 1

back_to_first_reg_a:
	clc								; 2
	adc	#>UNPACK_BUFFER		; in proper chunk 1 or 2	; 2

	jmp	update_r0_pointer					; 3

back_to_first_reg_c:
	lda	#>(UNPACK_BUFFER+$2A00)	; in linear C area		; 2

update_r0_pointer:
	sta	INH		; update r0 pointer			; 3



	;=================================
	; Finally done with this interrupt
	;=================================

done_interrupt:


	;=====================
	; Update time counter
	;=====================
update_time:
	inc	FRAME_COUNT						; 5
	lda	FRAME_COUNT						; 3
	cmp	#50							; 3
	bne	done_time						; 3/2nt

	lda	#$0							; 2
	sta	FRAME_COUNT						; 3

update_second_ones:
	inc	$7d0+TIME_OFFSET+3					; 6
	inc	$bd0+TIME_OFFSET+3					; 6
	lda	$bd0+TIME_OFFSET+3					; 4
	cmp	#$ba			; one past '9'			; 2
	bne	done_time						; 3/2nt
	lda	#'0'+$80						; 2
	sta	$7d0+TIME_OFFSET+3					; 4
	sta	$bd0+TIME_OFFSET+3					; 4
update_second_tens:
	inc	$7d0+TIME_OFFSET+2					; 6
	inc	$bd0+TIME_OFFSET+2					; 6
	lda	$bd0+TIME_OFFSET+2					; 4
	cmp	#$b6		; 6 (for 60 seconds)			; 2
	bne	done_time						; 3/2nt
	lda	#'0'+$80						; 2
	sta	$7d0+TIME_OFFSET+2					; 4
	sta	$bd0+TIME_OFFSET+2					; 4
update_minutes:
	inc	$7d0+TIME_OFFSET					; 6
	inc	$bd0+TIME_OFFSET					; 6
				; we don't handle > 9:59 songs yet
done_time:
								;=============
								;     90 worst


	;=================================
	; Moved visualization here as a hack
	;=================================

	;============================
	; Visualization
	;============================

	jsr	clear_top
	lda	RASTERBARS_ON
	beq	skip_rasters
	jsr	draw_rasters
skip_rasters:
	jsr	volume_bars
	jsr	page_flip


check_keyboard:

	jsr	get_key
	lda	LASTKEY
	beq	exit_interrupt

	cmp	#(' '+$80)
	bne	key_R
key_space:
	lda	#$80
	eor	DONE_PLAYING
	jmp	quiet_exit

key_R:
	cmp	#'R'
	bne	key_left

	lda	#$ff
	eor	RASTERBARS_ON
	sta	RASTERBARS_ON
	jmp	done_key

key_left:
	cmp	#'A'
	bne	key_right

	lda	#$40
	bne	quiet_exit

key_right:
	cmp	#'D'
	bne	done_key

	lda	#$20
	bne	quiet_exit

done_key:
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
								; 1358 cycles


REGISTER_OLD:
	.byte	0,0,0,0,0,0,0,0,0,0,0,0,0,0
