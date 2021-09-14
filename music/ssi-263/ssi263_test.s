;
;  ssi263_test.s
;
; Used to play speech through the SC-02 / SSI-263 chip
;  optionally found on Mockingboard Cards
;
;  Jeremy Rand's Apple II bejeweled was a helpful reference

; Some notes:
;	+ Sound 1 card - one AY-3-8910
;	+ Speech 1 card - one SC-01 chip
;	+ Sound II card -- two AY-3-8910
;	+ Sound/Speech 1 - one SC-01/one AY-3-8910
;	+ Mockingboard A - two AY-3-8913 two SSI-263 sockets
;	+ Mockingboard B - Mockingboard A upgrade with SSI-263
;	+ Mockingboard C - Mockingboard A with one SSI-263

.include "hardware.inc"

.include "ssi263.inc"


speech_test:

	jsr	HOME

	lda	#4			; assume slot #4 for now
	jsr	detect_ssi263

	lda	irq_count
	clc
	adc	#'A'
	sta	$400

	lda	#4			; assume slot #4 for now
	jsr	ssi263_speech_init


speech_loop:

	; hello

	lda	#<hello
	sta	SPEECH_PTRL
	lda	#>hello
	sta	SPEECH_PTRH

	jsr	ssi263_speak

	jsr	wait_until_keypress

	; hello2

	lda	#<hello2
	sta	SPEECH_PTRL
	lda	#>hello2
	sta	SPEECH_PTRH

	jsr	ssi263_speak

	jsr	wait_until_keypress

	jmp	speech_loop

wait_until_keypress:

	lda	KEYPRESS
	bpl	wait_until_keypress

	bit	KEYRESET

	rts


.include "ssi263_detect.s"

.include "ssi263_speech.s"

	; unrefined hello from Programming Guide
hello:
	.byte $E9, $5C, $A8, $50, PHONEME_PAUSE	; PA
	.byte $E9, $5C, $A8, $50, PHONEME_PAUSE	; PA
	.byte $E9, $5C, $A8, $50, PHONEME_HF	; HF
	.byte $E9, $5C, $A8, $50, PHONEME_EH	; EH
	.byte $E9, $5C, $A8, $50, PHONEME_L	; L
	.byte $E9, $5C, $A8, $50, PHONEME_O	; O
	.byte $E9, $5C, $A8, $50, PHONEME_PAUSE	; PA
	.byte $E9, $5C, $A8, $50, PHONEME_PAUSE	; PA
	.byte $FF

	; refined hello from Programming Guide
hello2:
	.byte $E9, $5C, $A8, $68, PHONEME_PAUSE	; PA
	.byte $E9, $5C, $A8, $68, PHONEME_PAUSE	; PA
	.byte $E9, $50, $D8, $68, PHONEME_EH	; EH
	.byte $E9, $52, $88, $38, $6C	; HF
	.byte $E9, $5C, $D8, $4A, $4B	; EH1
	.byte $E9, $5A, $C8, $4C, $9B	; UH3
	.byte $E9, $5A, $C8, $48, $22	; LF
	.byte $E9, $5C, $98, $3F, $9B	; UH3
	.byte $E9, $5C, $98, $34, $91	; O
	.byte $E9, $5C, $A8, $2A, $52	; OU
	.byte $E9, $53, $58, $33, $96	; U
	.byte $E9, $50, $C8, $3C, $D6	; U
	.byte $E9, $5C, $C8, $2C, PHONEME_PAUSE	; PA
	.byte $E9, $5C, $C8, $0C, PHONEME_PAUSE	; PA
	.byte $FF
