; Based on redbook_sound.s

; it's originally by Paul Lutus, from the Apple II Red Book p45
;	which can only do roughly 194Hz to 2000Hz+

; this makes things twice as long, which allows lower notes, but
;	loses some precision on high notes

; also modified so "0" means no sound


;=====================================================
; speaker tone
;=====================================================
; A,X,Y trashed
; duration also trashed

	; more exactly, it is (4+10F)+(13+10F) = 20F+17

speaker_tone:
	ldy	#0							; 3
speaker_tone_loop:
	lda	$C030		; click speaker				; 4
speaker_loop:
	nop
	nop
	nop
	nop
	nop

	dey			;					; 2
	bne	freq_loop	;					; 2/3
	dec	speaker_duration	; (Duration)			; 6
	beq	done_tone						; 2/3
freq_loop:
	dex								; 2
	bne	speaker_loop						; 2/3
	ldx	speaker_frequency	; (Frequency)			; 4
	beq	speaker_loop		; play nothing if 0		; 2/3
	jmp	speaker_tone_loop					; 3
done_tone:
	rts

speaker_duration:
	.byte	$00
speaker_frequency:
	.byte	$00

