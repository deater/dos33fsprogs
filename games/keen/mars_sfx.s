SFX_KEENSLEFT = 0
SFX_WLDENTRSND = 1
SFX_GAMEOVERSND = 2
SFX_TELEPORTSND = 3

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
	.byte <keensleft,  <WLDENTERSND, <GAMEOVERSND, <TELEPORTSND

sounds_high:
	.byte >keensleft,  >WLDENTERSND, >GAMEOVERSND, >TELEPORTSND


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
GAMEOVERSND:
.byte 1,1	; 19886.3
.byte 3,1	; 6628.8
.byte 6,1	; 3977.3
.byte 8,1	; 2840.9
.byte 12,1	; 1988.6
.byte 17,1	; 1420.5
.byte 22,1	; 1104.8
.byte 25,1	; 947.0
.byte 28,1	; 864.6
.byte 31,1	; 764.9
.byte 34,1	; 710.2
.byte 38,1	; 641.5
.byte 43,1	; 568.2
.byte 46,1	; 523.3
.byte 49,1	; 497.2
.byte 55,1	; 441.9
.byte 61,1	; 397.7
.byte 64,1	; 382.4
.byte 67,1	; 361.6
.byte 71,1	; 342.9
.byte 75,1	; 326.0
.byte 78,1	; 310.7
.byte 86,1	; 284.1
.byte 89,1	; 272.4
.byte 92,2	; 265.2
.byte 97,1	; 251.7
.byte 101,1	; 242.5
.byte 99,1	; 245.5
.byte 103,1	; 236.7
.byte 107,1	; 228.6
.byte 111,1	; 221.0
.byte 118,1	; 207.1
.byte 115,1	; 211.6
.byte 120,1	; 202.9
.byte 124,2	; 196.9
.byte 128,1	; 191.2
.byte 130,1	; 187.6
.byte 134,1	; 182.4
.byte 137,1	; 179.2
.byte 139,1	; 176.0
.byte 142,1	; 172.9
.byte 146,1	; 167.1
.byte 145,1	; 168.5
.byte 149,1	; 164.3
.byte 153,1	; 160.4
.byte 158,1	; 155.4
.byte 159,1	; 154.2
.byte 164,1	; 149.5
.byte 159,1	; 154.2
.byte 166,1	; 147.3
.byte 169,1	; 145.2
.byte 171,1	; 143.1
.byte 173,1	; 142.0
.byte 176,1	; 139.1
.byte 179,1	; 137.1
.byte 181,1	; 135.3
.byte 188,1	; 130.8
.byte 186,1	; 131.7
.byte 192,1	; 127.5
.byte 194,1	; 126.7
.byte 196,1	; 125.1
.byte 199,1	; 123.5
.byte 200,1	; 122.8
.byte 202,3	; 121.3
.byte 201,1	; 122.0
.byte 202,5	; 121.3
.byte 201,1	; 122.0
.byte 200,1	; 122.8
.byte 199,1	; 123.5
.byte 197,1	; 124.3
.byte 195,1	; 125.9
.byte 194,2	; 126.7
.byte 191,1	; 128.3
.byte 186,1	; 131.7
.byte 184,1	; 133.5
.byte 179,1	; 137.1
.byte 174,1	; 141.0
.byte 173,1	; 142.0
.byte 168,1	; 146.2
.byte 163,1	; 150.7
.byte 161,1	; 151.8
.byte 159,1	; 154.2
.byte 158,6	; 155.4
.byte 161,1	; 151.8
.byte 164,1	; 149.5
.byte 165,1	; 148.4
.byte 168,1	; 146.2
.byte 170,1	; 144.1
.byte 171,1	; 143.1
.byte 175,1	; 140.0
.byte 176,1	; 139.1
.byte 179,1	; 137.1
.byte 181,1	; 135.3
.byte 184,1	; 133.5
.byte 189,1	; 130.0
.byte 192,1	; 127.5
.byte 190,1	; 129.1
.byte 195,2	; 125.9
.byte 0,29	; 0.0
.byte 34,5	; 710.2
.byte 0,9	; 0.0
.byte 33,5	; 736.5
.byte 0,9	; 0.0
.byte 31,5	; 764.9
.byte 0,20	; 0.0
.byte 62,5	; 389.9
.byte 0,6	; 0.0
.byte 65,6	; 375.2
.byte 0,7	; 0.0
.byte 60,4	; 405.8
.byte 0,12	; 0.0
.byte 137,1	; 179.2
.byte 135,5	; 180.8
.byte 0,10	; 0.0
.byte 159,8	; 154.2
.byte 0,11	; 0.0
.byte 133,10	; 184.1
.byte 255,255
TELEPORTSND:
.byte 165,1     ; 148.4
.byte 82,1      ; 296.8
.byte 159,1     ; 154.2
.byte 28,1      ; 864.6
.byte 163,1     ; 150.7
.byte 166,1     ; 147.3
.byte 40,2      ; 602.6
.byte 186,1     ; 131.7
.byte 185,1     ; 132.6
.byte 0,1       ; 0.0
.byte 30,1      ; 795.5
.byte 86,1      ; 284.1
.byte 191,1     ; 128.3
.byte 66,1      ; 368.3
.byte 67,1      ; 361.6
.byte 88,1      ; 276.2
.byte 0,1       ; 0.0
.byte 88,1      ; 276.2
.byte 0,1       ; 0.0
.byte 189,1     ; 130.0
.byte 89,2      ; 272.4
.byte 0,1       ; 0.0
.byte 89,1      ; 272.4
.byte 22,1      ; 1104.8
.byte 89,1      ; 272.4
.byte 189,1     ; 130.0
.byte 27,1      ; 903.9
.byte 0,1       ; 0.0
.byte 83,1      ; 292.4
.byte 89,1      ; 272.4
.byte 91,1      ; 268.7
.byte 71,1      ; 342.9
.byte 188,1     ; 130.8
.byte 91,1      ; 268.7
.byte 0,1       ; 0.0
.byte 92,1      ; 265.2
.byte 83,1      ; 292.4
.byte 194,1     ; 126.7
.byte 22,1      ; 1104.8
.byte 0,1       ; 0.0
.byte 83,1      ; 292.4
.byte 59,1      ; 414.3
.byte 92,1      ; 265.2
.byte 60,1      ; 405.8
.byte 0,1       ; 0.0
.byte 51,1      ; 473.5
.byte 89,2      ; 272.4
.byte 0,1       ; 0.0
.byte 89,1      ; 272.4
.byte 38,1      ; 641.5
.byte 0,3       ; 0.0
.byte 89,1      ; 272.4
.byte 188,1     ; 130.8
.byte 89,1      ; 272.4
.byte 186,1     ; 131.7
.byte 190,1     ; 129.1
.byte 186,1     ; 131.7
.byte 0,1       ; 0.0
.byte 185,1     ; 132.6
.byte 83,1      ; 292.4
.byte 89,1      ; 272.4
.byte 0,1       ; 0.0
.byte 83,1      ; 292.4
.byte 89,2      ; 272.4
.byte 188,1     ; 130.8
.byte 0,1       ; 0.0
.byte 71,1      ; 342.9
.byte 188,1     ; 130.8
.byte 81,1      ; 301.3
.byte 189,2     ; 130.0
.byte 92,1      ; 265.2
.byte 89,1      ; 272.4
.byte 86,1      ; 284.1
.byte 91,1      ; 268.7
.byte 89,2      ; 272.4
.byte 86,1      ; 284.1
.byte 0,2       ; 0.0
.byte 72,1      ; 337.1
.byte 91,1      ; 268.7
.byte 92,1      ; 265.2
.byte 0,1       ; 0.0
.byte 94,1      ; 258.3
.byte 188,1     ; 130.8
.byte 194,1     ; 126.7
.byte 87,2      ; 280.1
.byte 0,1       ; 0.0
.byte 87,1      ; 280.1
.byte 188,1     ; 130.8
.byte 88,1      ; 276.2
.byte 0,1       ; 0.0
.byte 88,1      ; 276.2
.byte 188,1     ; 130.8
.byte 36,1      ; 662.9
.byte 197,2     ; 124.3
.byte 127,1     ; 193.1
.byte 0,1       ; 0.0
.byte 88,1      ; 276.2
.byte 0,2       ; 0.0
.byte 66,1      ; 368.3
.byte 0,2       ; 0.0
.byte 57,1      ; 423.1
.byte 78,1      ; 310.7
.byte 88,2      ; 276.2
.byte 189,1     ; 130.0
.byte 43,1      ; 568.2
.byte 166,1     ; 147.3
.byte 0,1       ; 0.0
.byte 188,1     ; 130.8
.byte 88,2      ; 276.2
.byte 194,1     ; 126.7
.byte 186,1     ; 131.7
.byte 0,1       ; 0.0
.byte 52,1      ; 462.5
.byte 89,1      ; 272.4
.byte 186,1     ; 131.7
.byte 91,2      ; 268.7
.byte 73,1      ; 331.4
.byte 91,3      ; 268.7
.byte 0,1       ; 0.0
.byte 91,1      ; 268.7
.byte 0,3       ; 0.0
.byte 33,1      ; 736.5
.byte 0,2       ; 0.0
.byte 59,1      ; 414.3
.byte 78,1      ; 310.7
.byte 0,1       ; 0.0
.byte 49,1      ; 497.2
.byte 48,1      ; 509.9
.byte 46,1      ; 523.3
.byte 12,3      ; 1988.6
.byte 0,3       ; 0.0
.byte 38,1      ; 641.5
.byte 36,1      ; 662.9
.byte 191,2     ; 128.3
.byte 113,1     ; 216.2
.byte 17,1      ; 1420.5
.byte 191,1     ; 128.3
.byte 0,1       ; 0.0
.byte 96,1      ; 255.0
.byte 27,1      ; 903.9
.byte 25,2      ; 947.0
.byte 13,1      ; 1807.8
.byte 0,1       ; 0.0
.byte 12,1      ; 1988.6
.byte 9,1       ; 2485.8
.byte 0,1       ; 0.0
.byte 20,1      ; 1169.8
.byte 123,1     ; 198.9
.byte 19,1      ; 1242.9
.byte 192,1     ; 127.5
.byte 0,1       ; 0.0
.byte 18,1      ; 1325.8
.byte 138,1     ; 177.6
.byte 17,1      ; 1420.5
.byte 11,1      ; 2209.6
.byte 0,2       ; 0.0
.byte 67,1      ; 361.6
.byte 153,1     ; 160.4
.byte 0,1       ; 0.0
.byte 11,1      ; 2209.6
.byte 0,2       ; 0.0
.byte 9,2       ; 2485.8
.byte 8,1       ; 2840.9
.byte 0,2       ; 0.0
.byte 7,1       ; 3314.4
.byte 0,2       ; 0.0
.byte 195,2     ; 125.9
.byte 0,3       ; 0.0
.byte 2,1       ; 9943.2
.byte 0,1       ; 0.0
.byte 169,1     ; 145.2
.byte 0,4       ; 0.0
.byte 4,1       ; 4971.6
.byte 186,1     ; 131.7
.byte 190,2     ; 129.1
.byte 0,1       ; 0.0
.byte 50,1      ; 485.0
.byte 190,1     ; 129.1
.byte 0,2       ; 0.0
.byte 101,1     ; 242.5
.byte 109,1     ; 223.4
.byte 255,255
