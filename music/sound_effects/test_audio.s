; Soft Switches
KEYPRESS= $C000
KEYRESET= $C010
SPEAKER=  $C030

WAIT   = $FCA8                 ; delay 1/2(26+27A+5A^2) us

; zero page use
BTC_L = $FE
BTC_H = $FF
SAVEL = $FC
SAVEH = $FD


test_audio:
;	lda	#$D0
;	sta	SAVEH
;	lda	#$00
;	sta	SAVEL

test_loop:
;	lda	SAVEH
;	sta	BTC_H
;	lda	SAVEL
;	sta	BTC_L

	lda	#<duck_sound
	sta	BTC_L
	lda	#>duck_sound
	sta	BTC_H

	ldx	#3
	jsr	play_audio

	jsr	wait_until_keypress

	inc	SAVEH
	jmp	test_loop

bob:
	jmp	bob

wait_until_keypress:
        lda     KEYPRESS
        bpl     wait_until_keypress
        bit     KEYRESET

	rts

.include "audio.s"

duck_sound:
.incbin "duck.btc"
