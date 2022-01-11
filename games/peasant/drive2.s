; roughly based on anti-m/anti-m.a

; Notes from qkumba/4am

; Drive with no disk and no motor, will return same value in range $00..$7f
; Drive with no disk but motor running will return random $00..$FF
; Some cards will return random even with no drive connected
; so the best way to detect if disk is there is to try seeking/reading
;	and seeing if you get valid data

; Note: should attempt to not have drive1/drive on at same time
;	even when you turn off drive a 555 timer keeps it running
;	for 1s or so


; assume slot 6
; C0E8 = motor off
; C0E9 = motor on
; C0EA = select drive1
; C0EB = select drive2


	;=================================
	; check floppy in drive2
	;=================================
	; switches to drive2
	; turns drive on
	; seeks to track0
	; attempts to read a sector
	; if fails, returns C=0
	; if succeeds, returns C=1
	; turns drive off
	; switches back to drive1

check_floppy_in_drive2:

	; anti-m does E9,EB, spinup (motor on, then select d2?)
	; then delays, then seeks
	; at end, driveoff E8

	jsr	switch_drive2

	jsr	driveon		; turn drive on
				; seems counter-intuitive but you're
				; supposed to do this before
				; switching to drive2?





	; seek to track 0

	lda	#(40*2)		; worst case scenario(?)
	sta	curtrk_smc+1
	lda	#0		; seek to track0
	sta	phase_smc+1

	jsr	seek


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
	bmi	done_check_failed	; actually done after 3*256

keep_trying:

get_valid_byte:
	jsr	readnib			; read byte
	bpl	get_valid_byte		; keep trying if high bit not set

check_if_d5:
	cmp	#$D5			; see if D5 (start of ... )
	bne	check_drive2_loop	; if not, try again

check_if_aa:
	jsr	readnib			; read byte
	bpl	check_if_aa		; keep trying until valid
	cmp	#$AA			; see if aa
	bne 	get_valid_byte		; if not try again

check_if_96:
	jsr	readnib			; read byte
	bpl	check_if_96		; keep trying until valid
	cmp	#$96			; see if 96
	bne	check_if_d5		; if not try again

	; if we make it here, carry is set
	; because result was greater or equal to #$96

done_check:
	jsr	driveoff

	jsr	wait_1s

	jsr	switch_drive1

	sec

	rts

done_check_failed:
	jsr	driveoff

	jsr	wait_1s

	jsr	switch_drive1

	clc

	rts


