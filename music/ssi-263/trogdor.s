;
;  trogdor.s
;
; Getting text-to-speech on a ssi-263 equipped mockigboard
;	for Peasant's Quest

.include "hardware.inc"

.include "ssi263.inc"


speech_test:

	jsr	HOME

	lda	#4			; assume slot #4 for now
	jsr	detect_ssi263

	lda	irq_count
	clc
	adc	#'A'			; hack to show if detected or not
	sta	$400			; (B is detected, A is not)

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

	jmp	speech_loop

wait_until_keypress:

	lda	KEYPRESS
	bpl	wait_until_keypress

	bit	KEYRESET

	rts


.include "ssi263_detect.s"

.include "ssi263_simple_speech.s"


.byte 34,"I can honestly say it'll",13
        .byte "be a pleasure and an honor",13
        .byte "to burninate you, Rather",13
        .byte "Dashing.",0



	; unrefined hello from Programming Guide
hello:
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_HF	; HF
	.byte PHONEME_EH	; EH
	.byte PHONEME_L		; L
	.byte PHONEME_O		; O
	.byte PHONEME_PAUSE	; PA
	.byte PHONEME_PAUSE	; PA
	.byte $FF

