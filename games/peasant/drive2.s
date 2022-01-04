; based on anti-m/anti-m.a

check_floppy_in_drive2:

	lda	$C0EB		;	drive 2 select

	jsr	driveon

;	lda	$C0E9		;	motor on	1110 1001

;	jsr	spinup		; spin up drive

	jsr	seek		; seek to where?


	;=====================================
	; try 768 times to find valid sector

	; does this by looking for $D5 $AA $96 sector address header

	ldx	#2
	ldy	#0

check_drive2_loop:
	iny
	bne	keep_trying

	;========================
	; didn't find it in time

	clc				; clear Carry for failure
	dex
	bmi	done_check		; actually done after 3*256

keep_trying:

get_valid_byte:
	lda	$C0EC			; read byte
	bpl	get_valid_byte		; keep trying if high bit not set

check_if_d5:
	cmp	#$D5			; see if D5 (start of ... )
	bne	check_drive2_loop	; if not, try again

check_if_aa:
	lda	$C0EC			; read byte
	bpl	check_if_aa		; keep trying until valid
	cmp	#$AA			; see if aa
	bne 	get_valid_byte		; if not try again

check_if_96:
	lda	$C0EC			; read byte
	bpl	check_if_96		; keep trying until valid
	cmp	#$96			; see if 96
	bne	check_if_d5		; if not try again

	; if we make it here, carry is set
	; because result was greater or equal to #$96

done_check:
	jmp	driveoff
