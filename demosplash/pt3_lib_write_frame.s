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


pt3_write_frame:

	ldy	FRAME_OFFSET					; 3

	;=====================
	; Register 0: A fine
	lda	A_FINE_TONE
r0_wrsmc:
	sta	$D000,Y

	;==========================
	; Register 1/3: A/B coarse
	lda	A_COARSE_TONE
	asl
	asl
	asl
	asl
	ora	B_COARSE_TONE
r1_wrsmc:
	sta	$D100,Y

	;====================
	; Register 2: B fine
	lda	B_FINE_TONE
r2_wrsmc:
	sta	$D200,Y

	;====================
	; Register 3: B coarse already done


	;=============================
	; Register 4: C fine
	lda	C_FINE_TONE
r4_wrsmc:
	sta	$D300,Y

	;=======================================
	; Register 5: Envelope Shape [top] / C coarse [bottom]
	lda	C_COARSE_TONE
	and	#$f
	sta	C_COARSE_TONE

	lda	ENVELOPE_SHAPE
	cmp	#$ff
	beq	no_envelope
yes_envelope:

	lda	ENVELOPE_SHAPE
	asl
	asl
	asl
	asl
	ora	C_COARSE_TONE
	sta	C_COARSE_TONE

	lda	#0
	sta	ENVELOPE_SHAPE
	jmp	done_envelope
no_envelope:
	lda	#$80
	sta	ENVELOPE_SHAPE

done_envelope:

	lda	C_COARSE_TONE
r13_wrsmc:
	sta	$D400,Y


	;=====================
	; Register 6: Noise
	lda	NOISE
	and	#$1f
	ora	ENVELOPE_SHAPE
r6_wrsmc:
	sta	$D500,Y

	;=====================
	; Register 7: Enable
	lda	ENABLE
r7_wrsmc:
	sta	$D600,Y

	;=====================
	; Register 8: a-amp

	lda	A_VOLUME
	and	#$1f
	sta	A_VOLUME

	lda	B_VOLUME
	and	#$10
	asl
	ora	A_VOLUME
	sta	A_VOLUME

	lda	C_VOLUME
	and	#$10
	asl
	asl
	ora	A_VOLUME
r8_wrsmc:
	sta	$D700,Y

	;============================
	; Register 9/10: b-amp (bottom) , c-amp (top)

	lda	B_VOLUME
	and	#$f
	sta	B_VOLUME

	lda	C_VOLUME
	asl
	asl
	asl
	asl
	ora	B_VOLUME
r9_wrsmc:
	sta	$D800,Y

	;=====================
	; Register 10: c-amp already handled


	;=====================
	; Register 11: E fine
	lda	ENVELOPE_FINE
r11_wrsmc:
	sta	$D900,Y

	;=======================
	; Register 12: E coarse
	lda	ENVELOPE_COARSE
r12_wrsmc:
	sta	$DA00,Y

	;=============================
	; Register 13: already handled


.if 0

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

.endif
	rts							; 6

