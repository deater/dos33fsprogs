	;========================
	; print score
	;========================
print_score:
	lda	#<score_text
	sta	OUTL
	lda	#>score_text
	sta	OUTH

	jmp	hgr_put_string

	; tail call does rts for us


	;==========================
	; update score
	;==========================

	; we have to handle 1, 2 or 3 digits
update_score:
	ldx	#9		; offset of first digit in string
	sed			; set decimal mode

	lda	#0
	sta	update_leading_zero_smc+1

update_hundreds:
	lda	SCORE_HUNDREDS
	beq	update_tens

	inc	update_leading_zero_smc+1
	clc
	adc	#'0'
	sta	score_text,X
	inx

update_tens:
	lda	SCORE_TENSONES
	lsr
	lsr
	lsr
	lsr
	bne	update_go_tens

update_leading_zero_smc:
	cmp	#0
	beq	update_ones

update_go_tens:
	clc
	adc	#'0'
	sta	score_text,X
	inx

update_ones:
	lda	SCORE_TENSONES
	and	#$f
	clc
	adc	#'0'
	sta	score_text,X
	inx

	ldy	#0
copy_tail_loop:
	lda	score_tail,Y
	sta	score_text,X
	beq	done_copy_tail_loop
	inx
	iny
	jmp	copy_tail_loop

done_copy_tail_loop:
	cld			; clear decimal mode
	rts

	;========================
	; score points
	;========================
	; value to add in A
	; plays tone
	; clears old
	; updates new
score_points:
	; update score

	sed			; set BCD mode
	clc
	adc	SCORE_TENSONES
	sta	SCORE_TENSONES
	lda	#0
	adc	SCORE_HUNDREDS
	sta	SCORE_HUNDREDS
	cld			; clear BCD mode

	; update score string

	jsr	update_score

	; clear top
clear_top:
	; draw rectangle

	lda     #$3		; color is white1
	sta     VGI_RCOLOR

	lda     #0
	sta     VGI_RX1
	lda     #0
	sta     VGI_RY1
	lda	#140
	sta	VGI_RXRUN
	lda	#12
        sta     VGI_RYRUN

        jsr     vgi_simple_rectangle

	; print score

	jsr	print_score

	; play tone

	;===========================
	; weep-boom sound

	lda	#32
	sta	speaker_duration
	lda	#NOTE_E4
	sta	speaker_frequency
	jsr	speaker_beep
	lda	#64
	sta	speaker_duration
	lda	#NOTE_F4
	sta	speaker_frequency
	jsr	speaker_beep
	lda	#128
	sta	speaker_duration
	lda	#NOTE_F3
	sta	speaker_frequency
	jsr	speaker_beep

	rts



score_text:
	.byte 0,2,"Score: 0 of 150",0,0,0


score_tail:
	.byte " of 150",0

