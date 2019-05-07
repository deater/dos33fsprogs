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
;	pha			; save A				; 3
				; A is saved in $45 by firmware
	txa
	pha			; save X
	tya
	pha			; save Y



	inc	$0404		; debug (flashes char onscreen)

	bit	$C404		; clear 6522 interrupt by reading T1C-L	; 4


;	jmp	exit_interrupt

	lda	DONE_PLAYING						; 3
	beq	pt3_play_music	; if song done, don't play music	; 3/2nt
	jmp	check_keyboard						; 3
								;============
								;	13

pt3_play_music:


;       for(i=0;i < pt3.music_len;i++) {
;          pt3_set_pattern(i,&pt3);
;          for(j=0;j<64;j++) {
;             if (pt3_decode_line(&pt3)) break;
;             for(f=0;f<pt3.speed;f++) {


	jsr	pt3_make_frame

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

mb_write_loop:
	lda	REGISTER_DUMP,X	; load register value			; 4

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

;	jsr	clear_top
;	lda	RASTERBARS_ON
;	beq	skip_rasters
;	jsr	draw_rasters
;skip_rasters:
;	jsr	volume_bars
;	jsr	page_flip


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
	dex								; 2
	bpl	mb_clear_reg						; 2nt/3

exit_interrupt:

;	pla			; restore a				; 4

	pla
	tay			; restore Y
	pla
	tax			; restore X
	lda	$45		; restore A


	rti			; return from interrupt			; 6

								;============
								; typical
								; ???? cycles



