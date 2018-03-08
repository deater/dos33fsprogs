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
	beq	mb_write_frame	; if song done, don't play music	; 3/2nt
	jmp	check_keyboard						; 3
								;============
								;	13

	;=============================
	; Write frames to Mockingboard
	;=============================

mb_write_frame:

	ldy	MB_CHUNK_OFFSET	; get chunk offset			; 3

	ldx	#0		; set up reg count			; 2

								;=============
								;	5

	;==================================
	; loop through the 14 registers
	; reading the value, then write out
	;==================================
mb_write_loop:
	lda	(INL),y		; load register value			; 5

				; if REG==1 and high bit set
				; then end of song

	bpl	mb_not_done						; 3/2nt
	cpx	#1							; 2
	bne	mb_not_done						; 3/2nt

	lda	#1		; set done playing			; 2

	jmp	quiet_exit						; 3

mb_not_done:

	; special case R13.  If it is 0xff, then don't update
	; otherwise might spuriously reset the envelope settings

	cpx	#13							; 2
	bne	mb_not_13						; 3/2nt
	cmp	#$ff							; 2
	beq	increment_offset					; 3/2nt

mb_not_13:
	sta	MB_VALUE						; 3

	; always write out all to zero page
	; we mostly care about vola/volb/volc so this wastes 11 bytes of RAM
	; code is simpler, and save on three cmp/branches per loop

	and	#$f							; 2
	sta	REGISTER_DUMP,X						; 4

					; INLINE this (could save 72 cycles)
	jsr	write_ay_both		; assume 3 channel (not six)	; 6
					; so write same to both
					; left/right
									; 53

	;====================
	; point to next page
	;====================

	clc				; point to next interleaved	; 2
	lda	INH			; page by adding CHUNKSIZE (3/1); 3
	adc	CHUNKSIZE						; 3
	sta	INH							; 3

	inx				; point to next register	; 2
	cpx	#14			; if 14 we're done		; 2
	bmi	mb_write_loop		; otherwise, loop		; 3/2nt
								;============
								; roughly 95?
								;  *13= 1235?


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

								;============
								;        18


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

exit_interrupt:

	pla			; restore a				; 4

	rti			; return from interrupt			; 6

								;============
								; typical
								; 1358 cycles

