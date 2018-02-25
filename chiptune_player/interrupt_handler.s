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

interrupt_handler:
	pha			; save A				; 3
				; Should we save X and Y too?

;	inc	$0404		; debug (flashes char onscreen)

	bit	$C404		; clear 6522 interrupt by reading T1C-L	; 4


								;============

								;	  7
	;=====================
	; Update time counter
	;=====================

	inc	FRAME_COUNT						; 5
	lda	FRAME_COUNT						; 3
	cmp	#50							; 3
	bne	mb_write_frame						; 3/2nt

	lda	#$0							; 2
	sta	FRAME_COUNT						; 3

update_second_ones:
	inc	$7d0+17							; 6
	inc	$bd0+17							; 6
	lda	$bd0+17							; 4
	cmp	#$ba			; one past '9'			; 2
	bne	mb_write_frame						; 3/2nt
	lda	#'0'+$80						; 2
	sta	$7d0+17							; 4
	sta	$bd0+17							; 4
update_second_tens:
	inc	$7d0+16							; 6
	inc	$bd0+16							; 6
	lda	$bd0+16							; 4
	cmp	#$b6		; 6 (for 60 seconds)			; 2
	bne	mb_write_frame						; 3/2nt
	lda	#'0'+$80						; 2
	sta	$7d0+16							; 4
	sta	$bd0+16							; 4
update_minutes:
	inc	$7d0+14							; 6
	inc	$bd0+14							; 6
				; we don't handle > 9:59 songs yet

								;=============
								;     90 worst


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
	sta	DONE_PLAYING						; 3
	jmp	done_interrupt						; 3

mb_not_done:

	; special case R13.  If it is 0xff, then don't update
	; otherwise might spuriously reset the envelope settings

	cpx	#13							; 2
	bne	mb_not_13						; 3/2nt
	cmp	#$ff							; 2
	beq	phase_specific					; 3/2nt

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

	clc				; point to next interleaved	; 2
	lda	INH			; page by adding $300		; 3
	adc	#CHUNKSIZE						; 2
	sta	INH							; 3

	inx				; point to next register	; 2
	cpx	#14			; if 14 we're done		; 2
	bmi	mb_write_loop		; otherwise, loop		; 3/2nt
								;============
								; roughly 95?
								;  *13= 1235?


	;==============================================
	; phase_specific action
	;==============================================

	; if phase is A and OFFSET&0x0f==0 then do a copy
	; if phase is B, do nothing
	; if phase is C, do a decompress step

phase_specific:

	lda	#0							; 2
	bit	DECODER_STATE	; Z=A, V=B, N=C				; 3
	bvs	increment_offset
	beq	handle_copy

decompress_step:
	jmp	increment_offset

handle_copy:
	lda	MB_CHUNK_OFFSET
	and	#$0f
	bne	increment_offset

	lda	COPY_OFFSET
	cmp	#$14
	beq	increment_offset

	jsr	page_copy

	inc	COPY_OFFSET	; (opt: make subtract?)


	;==============================================
	; incremement offset.  If 0 move to next chunk
	;==============================================

increment_offset:

	inc	MB_CHUNK_OFFSET		; increment offset		; 5
	bne	reset_chunk		; if not zero,	done		; 3/2nt



wraparound:

	inc	MB_CHUNK		; go to next chunk		; 5
	lda	MB_CHUNK						; 3
	cmp	#CHUNKSIZE		; have we reached end?		; 2
	bne	reset_chunk						; 3/2nt
	lda	#0			; if so reset			; 2
	sta	MB_CHUNK						; 3

	; can't tail call as need to restore stack and rti
	jsr	next_subsong		; and decompress next		; 6


reset_chunk:
	lda	MB_CHUNK		; reset input pointer		; 3
	clc				; to the beginning		; 2

	adc	#>UNPACK_BUFFER		; in proper chunk (1 of 3)	; 2
	sta	INH							; 3


								;============
								;        18
done_interrupt:
	pla			; restore a				; 4

	rti			; return from interrupt			; 6

								;============
								; typical
								; 1358 cycles

