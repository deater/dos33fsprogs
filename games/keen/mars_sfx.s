SFX_KEENSLEFT = 0
SFX_WLDENTRSND = 1

	;==========================
	; plays soundfx
	;==========================
	; which one in Y
play_sfx:

	lda	sounds_low,Y
	sta	INL
	lda	sounds_high,Y
	sta	INH

	ldy	#0
	sty	SOUND_OFFSET
play_sfx_loop:
	ldy	SOUND_OFFSET
	lda	(INL),Y
	sta	speaker_frequency

	iny
	lda	(INL),Y
	cmp	#$FF
	beq	play_done

	asl
;	clc
;	adc	(INL),Y

	sta	speaker_duration
	iny
	bne	no_wrap
	inc	INH
no_wrap:

	sty	SOUND_OFFSET

	jsr	speaker_tone

	jmp	play_sfx_loop


play_done:
	rts


sounds_low:
	.byte <keensleft,  <WLDENTERSND

sounds_high:
	.byte >keensleft,  >WLDENTERSND


WLDENTERSND:
.byte 28,1	; 864.6
.byte 29,1	; 828.6
.byte 30,2	; 795.5
.byte 31,2	; 764.9
.byte 33,1	; 736.5
.byte 35,1	; 685.7
.byte 36,1	; 662.9
.byte 39,1	; 621.4
.byte 41,1	; 584.9
.byte 48,1	; 509.9
.byte 44,1	; 552.4
.byte 45,1	; 537.5
.byte 48,1	; 509.9
.byte 0,15	; 0.0
.byte 65,1	; 375.2
.byte 66,1	; 368.3
.byte 68,2	; 355.1
.byte 70,1	; 348.9
.byte 72,2	; 337.1
.byte 73,1	; 331.4
.byte 76,2	; 320.7
.byte 78,1	; 310.7
.byte 80,1	; 305.9
.byte 81,1	; 301.3
.byte 83,2	; 292.4
.byte 86,1	; 284.1
.byte 89,1	; 272.4
.byte 92,1	; 265.2
.byte 96,2	; 255.0
.byte 0,14	; 0.0
.byte 108,1	; 226.0
.byte 109,1	; 223.4
.byte 112,1	; 218.5
.byte 113,1	; 216.2
.byte 118,1	; 207.1
.byte 122,1	; 200.9
.byte 124,1	; 196.9
.byte 125,1	; 195.0
.byte 127,1	; 193.1
.byte 128,1	; 191.2
.byte 129,1	; 189.4
.byte 130,1	; 187.6
.byte 132,1	; 185.9
.byte 133,2	; 184.1
.byte 134,1	; 182.4
.byte 137,1	; 179.2
.byte 138,1	; 177.6
.byte 0,13	; 0.0
.byte 145,1	; 168.5
.byte 149,1	; 164.3
.byte 150,1	; 163.0
.byte 155,1	; 157.8
.byte 149,1	; 164.3
.byte 156,1	; 156.6
.byte 158,1	; 155.4
.byte 160,2	; 153.0
.byte 156,1	; 156.6
.byte 161,1	; 151.8
.byte 159,1	; 154.2
.byte 163,1	; 150.7
.byte 161,1	; 151.8
.byte 164,1	; 149.5
.byte 255,255
keensleft:
.byte 151,4	; 161.7
.byte 0,7	; 0.0
.byte 139,3	; 176.0
.byte 138,1	; 177.6
.byte 0,8	; 0.0
.byte 120,8	; 202.9
.byte 0,15	; 0.0
.byte 77,5	; 315.7
.byte 76,2	; 320.7
.byte 0,18	; 0.0
.byte 44,8	; 552.4
.byte 0,15	; 0.0
.byte 23,7	; 1046.7
.byte 0,19	; 0.0
.byte 17,9	; 1420.5
.byte 255,255
