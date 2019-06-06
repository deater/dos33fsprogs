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



;	inc	$0404		; debug (flashes char onscreen)

	bit	$C404		; clear 6522 interrupt by reading T1C-L	; 4

	lda	DONE_PLAYING						; 3
	beq	pt3_play_music	; if song done, don't play music	; 3/2nt
	jmp	check_keyboard						; 3
								;============
								;	13

pt3_play_music:

	; decode a frame of music

	jsr	pt3_make_frame

	; handle song over condition
	lda	DONE_SONG
	beq	mb_write_frame		; if not done, continue

	lda	LOOP			; see if looping
	beq	move_to_next

pt3_loop_smc:
	lda	#$d1			; looping, move to loop location
					; non-zero to avoid the temptation
					; to merge with following lda #$0
	sta	current_pattern_smc+1
	lda	#$0
	sta	current_line_smc+1
	sta	current_subframe_smc+1
	sta	DONE_SONG		; undo the next song

	beq	done_interrupt		; branch always

move_to_next:
	; same as "press right"
	ldx	#$20
	jmp	quiet_exit

	;======================================
	; Write frames to Mockingboard
	;======================================
	; for speed could merge this into
	; the decode code

mb_write_frame:


	tax			; set up reg count			; 2
								;============
								;	  2

	;==================================
	; loop through the 14 registers
	; reading the value, then write out
	;==================================

mb_write_loop:
	lda	AY_REGISTERS,X	; load register value			; 4

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
	ldy	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	sty	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	sty	MOCK_6522_ORB2		; latch_address on PB2		; 4
	ldy	#MOCK_AY_INACTIVE	; go inactive			; 2
	sty	MOCK_6522_ORB1						; 4
	sty	MOCK_6522_ORB2						; 4

        ; value
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	sta	MOCK_6522_ORA2		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	sta	MOCK_6522_ORB2		; write on PB2			; 4
	sty	MOCK_6522_ORB1						; 4
	sty	MOCK_6522_ORB2						; 4
								;===========
								; 	56
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
	; self-modifying version via qkumba
update_time:
	inc	frame_count_smc+1					; 5
frame_count_smc:
	lda	#$0							; 2
	eor	#50							; 3
	bne	done_time						; 3/2nt

	sta	frame_count_smc+1					; 3

	ldx	$7d0+TIME_OFFSET+3					; 4
	cpx	#'9'+$80						; 2
	bne	update_second_ones					; 3/2nt

	ldx	$7d0+TIME_OFFSET+2					; 4
	cpx	#'5'+$80	; 6-1 (for 60 seconds)			; 2
	bne	update_second_tens					; 3/2nt

update_minutes:
	inc	$7d0+TIME_OFFSET					; 6
	inc	$bd0+TIME_OFFSET					; 6

	ldx	#'0'+$80-1						; 2

update_second_tens:
	inx								; 2
	stx	$7d0+TIME_OFFSET+2					; 4
	stx	$bd0+TIME_OFFSET+2					; 4

	ldx	#'0'+$80-1						; 2

update_second_ones:
	inx								; 2
	stx	$7d0+TIME_OFFSET+3					; 4
	stx	$bd0+TIME_OFFSET+3					; 4
				; we don't handle > 9:59 songs yet
done_time:
								;=============
								;     52 worst


	;=================================
	; Handle keyboard
	;=================================

check_keyboard:

	jsr	get_key
	tax
	beq	exit_interrupt

	;====================
	; space pauses

	cmp	#(' '+$80)		; set carry if true
	bne	key_M
key_space:
	lda	#$80
	eor	DONE_PLAYING

	; disable fire when paused

	sta	DONE_PLAYING
	beq	yes_bar
	lda	#0
	beq	lowbar			; branch always
yes_bar:
	lda	#7
lowbar:
	jsr	fire_setline

	ldx	DONE_PLAYING

	bcs	quiet_exit		; branch always

	;===========================
	; M key switches MHz mode

key_M:
	cmp	#'M'
	bne	key_L			; set carry if true

	ldx	#'0'+$80
	lda	convert_177_smc1
	eor	#$20
	sta	convert_177_smc1
	sta	convert_177_smc2
	sta	convert_177_smc3
	sta	convert_177_smc4
	sta	convert_177_smc5
	cmp	#$18
	beq	at_MHz

	; update text on screen

	ldx	#'7'+$80

at_MHz:
	stx	$7F4
	stx	$BF4

	bcs	done_key		; branch always


	;===========================
	; L enables loop mode

key_L:
	cmp	#'L'
	bne	key_left		; set carry if true

	ldx	#'/'+$80
	lda	LOOP
	eor	#$1
	sta	LOOP
	beq	music_looping

	; update text on screen

	ldx	#'L'+$80

music_looping:
	stx	$7D0+18
	stx	$BD0+18

	bcs	done_key		; branch always


	;======================
	; left key, to prev song

key_left:
	ldx	#$40
	cmp	#'A'
	beq	quiet_exit

	;========================
	; right key, to next song

key_right:
	ldx	#$20
	cmp	#'D'
	bne	done_key

	;========================
	; stop playing for now
	; quiet down the Mockingboard
	; (otherwise will be stuck on last note)

quiet_exit:
	stx	DONE_PLAYING
	jsr	clear_ay_both

	;ldx	#$ff		; also mute the channel
	stx	AY_REGISTERS+7 ; just in case

done_key:
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


