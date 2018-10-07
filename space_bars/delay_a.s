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
