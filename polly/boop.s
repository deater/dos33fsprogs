
; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SPEAKER=  $C030

COUNTDOWN = $FF

boop_music:

	jsr	boop

	jsr	beep

	jsr	boop

end:
	jmp	end


	;===========================
	; BEEP
	;===========================
beep:
	; BEEP
	; repeat 34 times
	lda	#34
	sta	COUNTDOWN
tone1_loop:
	jsr	play_304
	jsr	play_369
	jsr	play_32c
	dec	COUNTDOWN
	bne	tone1_loop

	rts


	;===========================
	; BOOP
	;===========================
boop:
	; BOOP
	; repeat 34 times
	lda	#34
	sta	COUNTDOWN
tone2_loop:
	jsr	play_4be
	jsr	play_4e6
	dec	COUNTDOWN
	bne	tone2_loop

	rts






play_4be:	; 4be = 1214
	; 1214
	;   -6 jsr
	;   -6 rts
	;============
	; 1202

	; Try X=239 Y=1 cycles=1202

	ldy	#1							; 2
loop1:	ldx	#239							; 2
loop2:	dex								; 2
	bne	loop2							; 2nt/3
	dey								; 2
	bne	loop1							; 2nt/3

	lda	SPEAKER		; click speaker

	rts

play_4e6:	; 1254

	; 1254
	;   -6 jsr
	;   -6 rts
	;============
	; 1232

	; Try X=245 Y=1 cycles=1232

	ldy	#1							; 2
loopA:	ldx	#245							; 2
loopB:	dex								; 2
	bne	loopB							; 2nt/3
	dey								; 2
	bne	loopA							; 2nt/3

	lda	SPEAKER		; click speaker

	rts


play_304:	; 772

	;  772
	;   -6 jsr
	;   -6 rts
	;============
	;  760

	; Try X=1 Y=69 cycles=760

	ldy	#69							; 2
loopC:	ldx	#1							; 2
loopD:	dex								; 2
	bne	loopD							; 2nt/3
	dey								; 2
	bne	loopC							; 2nt/3

	lda	SPEAKER		; click speaker

	rts

play_369:	; 873

	;  873
	;   -6 jsr
	;   -6 rts
	;============
	;  861

	; Try X=16 Y=10 cycles=861

	ldy	#10							; 2
loopE:	ldx	#16							; 2
loopF:	dex								; 2
	bne	loopF							; 2nt/3
	dey								; 2
	bne	loopE							; 2nt/3

	lda	SPEAKER		; click speaker

	rts

play_32c:	; 812

	;  812
	;   -6 jsr
	;   -6 rts
	;============
	;  800

	; Try X=158 Y=1 cycles=797 R3

	lda	COUNTDOWN	; nop3

	ldy	#11							; 2
loopG:	ldx	#158							; 2
loopH:	dex								; 2
	bne	loopH							; 2nt/3
	dey								; 2
	bne	loopG							; 2nt/3

	lda	SPEAKER		; click speaker

	rts







; From http://6502org.wikidot.com/software-delay

; 25+A cycles (including JSR), 19 bytes (excluding JSR)
;
; The branches must not cross page boundaries!
;

			;       Cycles              Accumulator         Carry flag
			; 0  1  2  3  4  5  6          (hex)           0 1 2 3 4 5 6

;	jsr	delay_a	; 6  6  6  6  6  6  6   00 01 02 03 04 05 06

dly0:	sbc	#7
delay_a:cmp	#7	; 2  2  2  2  2  2  2   00 01 02 03 04 05 06   0 0 0 0 0 0 0
	bcs	dly0	; 2  2  2  2  2  2  2   00 01 02 03 04 05 06   0 0 0 0 0 0 0
	lsr		; 2  2  2  2  2  2  2   00 00 01 01 02 02 03   0 1 0 1 0 1 0
	bcs	dly1	; 2  3  2  3  2  3  2   00 00 01 01 02 02 03   0 1 0 1 0 1 0
dly1:	beq	dly2	; 3  3  2  2  2  2  2   00 00 01 01 02 02 03   0 1 0 1 0 1 0
	lsr		;       2  2  2  2  2         00 00 01 01 01       1 1 0 0 1
	beq	dly3	;       3  3  2  2  2         00 00 01 01 01       1 1 0 0 1
	bcc	dly3	;             3  3  2               01 01 01           0 0 1
dly2:	bne	dly3	; 2  2              3   00 00             01   0 1         0
dly3:	rts		; 6  6  6  6  6  6  6   00 00 00 00 01 01 01   0 1 1 1 0 0 1
	;
	; Total cycles:	 25 26 27 28 29 30 31



