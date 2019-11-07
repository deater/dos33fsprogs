	; ZZ points to offset from pointer


;D000	;0 $9000,$9100,$9200 = A Low (reg0)
;D100	;1 $9300,$9400,$9500 = A high (reg1) [top], B high (reg3) [bottom]
;D200	;2 $9600,$9700,$9800 = B Low (reg2)
;D300	;3 $9900,$9A00,$9B00 = C Low (reg4)
;D400	;4 $9C00,$9D00,$9E00 = Envelope Shape (r13) [top], C high (reg5) [bot]
;D500	;5 $9F00,$A000,$A100 = Noise (r6), bit7 = don't change envelope
;D600	;6 $A200,$A300,$A400 = Enable (r7)
;D700	;7 $A500,$A600,$A700 = A amp (r8), bit 5 of r8,r9,r10
;D800	;8 $A800,$A900,$AA00 = C amp (r10) [top], B amp (r9) [bottom]
;D900	;9 $AB00,$AC00,$AD00 = ENV low  (r11)
;DA00	;a $AE00,$AF00,$B000 = ENV high (r12)

	; 3+ 72 + 72 + 83 + 74 + 72 + 77 + 19 + 70 + 74 + 72 +
	;	77 + 18 + 82 + 85 + 72 + 72 + 8 + 72 + 6 = 1180

play_frame_compressed:

	ldy	FRAME_OFFSET					; 3

	; Register 0: A fine
	ldx	#0						; 2
r0_smc:
	lda	$D000,Y						; 4+
	jsr	play_mb_write					; 6+60
								;======
								; 72

	; Register 2: B fine
	ldx	#2						; 2
r2_smc:
	lda	$D200,Y						; 4+
	jsr	play_mb_write					; 6+60
								;======
								; 72

	; Register 1: A coarse
	ldx	#1						; 2
r1_smc:
	lda	$D100,Y						; 4+
	pha							; 3
	lsr							; 2
	lsr							; 2
	lsr							; 2
	lsr							; 2
	jsr	play_mb_write					; 6+60
								;======
								; 83

	; Register 3: B low
	ldx	#3						; 2
	pla							; 4
	and	#$f						; 2
	jsr	play_mb_write					; 6+60
								;======
								; 74
	; Register 4: C fine
	ldx	#4						; 2
r4_smc:
	lda	$D300,Y						; 4+
	jsr	play_mb_write					; 6+60
								;=======
								; 72

	; Register 5: C coarse
	ldx	#5						; 2
r5_smc:
	lda	$D400,Y						; 4+
	pha							; 3
	and	#$f						; 2
	jsr	play_mb_write					; 6+60
								;========
								; 77

	; Register 13: E type
	pla							; 4
	lsr							; 2
	lsr							; 2
	lsr							; 2
	lsr							; 2

r13_smc:
	ldx	$D500,Y		; check for env update		; 4
	bmi	skip_envelope_write				; 3
							;============
							;	19

								; -1
	ldx	#13						; 2
	jsr	play_mb_write					; 6+60
	jmp	done_envelope_write				; 3
								;=====
								; 70
skip_envelope_write:
	; KILL CYCLES...  Need to kill 70

	; delay 25+a (so 70-2-25=43)
	lda	#43						; 2
	jsr	delay_a						; 25+43
								;======
								; 70

done_envelope_write:

	; Register 6: Noise
	ldx	#6						; 2
r6_smc:
	lda	$D500,Y						; 4+
	and	#$1f						; 2
	jsr	play_mb_write					; 6+60
								;=======
								; 74

	; Register 7: Enable
	ldx	#7						; 2
r7_smc:
	lda	$D600,Y						; 4+
	jsr	play_mb_write					; 6+60
								;========
								; 72

	; Register 8: a-amp
	ldx	#8						; 2
r8_smc:
	lda	$D700,Y						; 4+
	pha							; 3
	and	#$1f						; 2
	jsr	play_mb_write					; 6+60
								;=======
								; 77

	pla							; 4
	and	#$e0						; 2
	lsr							; 2
	sta	AY_WRITE_TEMP					; 3
	lsr							; 2
	and	#$10						; 2
	sta	AY_WRITE_TEMP2					; 3
								;====
								; 18

	; Register 9: b-amp (bottom)
	ldx	#9						; 2
r9_smc:
	lda	$D800,Y						; 4+
	pha							; 3
	and	#$f						; 2
	ora	AY_WRITE_TEMP					; 3
	and	#$1f						; 2
	jsr	play_mb_write					; 6+60
								;=======
								; 82

	; Register 10: c-amp (top)
	ldx	#10						; 2
	pla							; 4
	lsr							; 2
	lsr							; 2
	lsr							; 2
	lsr							; 2
	ora	AY_WRITE_TEMP2					; 3
	and	#$1f						; 2
	jsr	play_mb_write					; 6+60
								;======
								; 85

	; Register 11: E fine
	ldx	#11						; 2
r11_smc:
	lda	$D900,Y						; 4+
	jsr	play_mb_write					; 6+60
								;======
								; 72

	; Register 12: E coarse
	ldx	#12						; 2
r12_smc:
	lda	$DA00,Y						; 4+
	jsr	play_mb_write					; 6+60
								;======
								; 72

	; incrememnt offset
	; wrap to next

	iny						; 2
	sty	FRAME_OFFSET				; 3
	beq	frame_wrap				; 3
						;==========
						;	  8

no_frame_wrap:
							; -1
	; delay 72+1-3=70
	lda	#43		; 70-2-25=43
	jsr	delay_a

	jmp	done_frame_wrap				; 3
frame_wrap:
	inc	r0_smc+2	; 6
	inc	r1_smc+2	; 6
	inc	r2_smc+2	; 6
	inc	r4_smc+2	; 6
	inc	r5_smc+2	; 6
	inc	r13_smc+2	; 6
	inc	r6_smc+2	; 6
	inc	r7_smc+2	; 6
	inc	r8_smc+2	; 6
	inc	r9_smc+2	; 6
	inc	r11_smc+2	; 6
	inc	r12_smc+2	; 6
				;=====
				; 72
done_frame_wrap:


	rts							; 6


	;========================
	; 28+26+6= 60

	; trashes A,X

play_mb_write:

	; address
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	stx	MOCK_6522_ORA2		; put address on PA2		; 4
	ldx	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
	stx	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	stx	MOCK_6522_ORB2		; latch_address on PB2		; 4
	ldx	#MOCK_AY_INACTIVE	; go inactive			; 2
	stx	MOCK_6522_ORB1						; 4
	stx	MOCK_6522_ORB2						; 4
								;===========
								;	28

        ; value
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	sta	MOCK_6522_ORA2		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	sta	MOCK_6522_ORB2		; write on PB2			; 4
	stx	MOCK_6522_ORB1						; 4
	stx	MOCK_6522_ORB2						; 4
								;===========
								; 	26

	rts							;        6



