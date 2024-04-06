SFX_KEENDIESND = 0
SFX_LVLDONESND = 1
SFX_GAMEOVERSND= 2
SFX_GOTITEMSND = 3
SFX_GUNCLICK   = 4
SFX_KEENLANDSND= 5
SFX_KEENJUMPSND= 6
SFX_BUMPHEADSND= 7
SFX_YORPBOPSND = 8
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
	.byte <KEENDIESND,<LVLDONESND, <GAMEOVERSND,<GOTITEMSND,<GUNCLICK
	.byte <KEENLANDSND,<KEENJUMPSND,<BUMPHEADSND,<YORPBOPSND

sounds_high:
	.byte >KEENDIESND,>LVLDONESND, >GAMEOVERSND,>GOTITEMSND,>GUNCLICK
	.byte >KEENLANDSND,>KEENJUMPSND,>BUMPHEADSND,>YORPBOPSND

KEENDIESND:
.byte 20,1	; 1169.8
.byte 22,3	; 1104.8
.byte 0,14	; 0.0
.byte 59,4	; 414.3
.byte 0,14	; 0.0
.byte 20,5	; 1169.8
.byte 0,15	; 0.0
.byte 59,4	; 414.3
.byte 60,1	; 405.8
.byte 0,12	; 0.0
.byte 19,4	; 1242.9
.byte 0,12	; 0.0
.byte 59,4	; 414.3
.byte 0,13	; 0.0
.byte 35,3	; 685.7
.byte 0,19	; 0.0
.byte 89,1	; 272.4
.byte 92,1	; 265.2
.byte 96,1	; 255.0
.byte 99,1	; 245.5
.byte 102,1	; 239.6
.byte 106,1	; 231.2
.byte 109,1	; 223.4
.byte 112,1	; 218.5
.byte 115,1	; 211.6
.byte 118,1	; 207.1
.byte 120,1	; 202.9
.byte 123,1	; 198.9
.byte 124,1	; 196.9
.byte 125,1	; 195.0
.byte 128,2	; 191.2
.byte 129,1	; 189.4
.byte 130,1	; 187.6
.byte 132,1	; 185.9
.byte 133,1	; 184.1
.byte 134,2	; 182.4
.byte 135,1	; 180.8
.byte 137,9	; 179.2
.byte 135,2	; 180.8
.byte 134,1	; 182.4
.byte 133,1	; 184.1
.byte 132,1	; 185.9
.byte 130,2	; 187.6
.byte 128,1	; 191.2
.byte 125,1	; 195.0
.byte 123,1	; 198.9
.byte 118,1	; 207.1
.byte 111,1	; 221.0
.byte 102,1	; 239.6
.byte 96,1	; 255.0
.byte 91,1	; 268.7
.byte 89,1	; 272.4
.byte 88,2	; 276.2
.byte 89,2	; 272.4
.byte 91,3	; 268.7
.byte 92,1	; 265.2
.byte 94,1	; 258.3
.byte 97,1	; 251.7
.byte 98,1	; 248.6
.byte 101,1	; 242.5
.byte 102,1	; 239.6
.byte 103,1	; 236.7
.byte 108,1	; 226.0
.byte 111,1	; 221.0
.byte 113,1	; 216.2
.byte 115,2	; 211.6
.byte 117,1	; 209.3
.byte 118,1	; 207.1
.byte 119,3	; 205.0
.byte 117,1	; 209.3
.byte 115,2	; 211.6
.byte 112,1	; 218.5
.byte 111,1	; 221.0
.byte 108,1	; 226.0
.byte 106,1	; 231.2
.byte 101,1	; 242.5
.byte 96,1	; 255.0
.byte 82,1	; 296.8
.byte 75,1	; 326.0
.byte 66,1	; 368.3
.byte 45,1	; 537.5
.byte 43,1	; 568.2
.byte 39,1	; 621.4
.byte 38,1	; 641.5
.byte 33,1	; 736.5
.byte 31,1	; 764.9
.byte 29,1	; 828.6
.byte 27,1	; 903.9
.byte 19,1	; 1242.9
.byte 13,1	; 1807.8
.byte 255,255
GOTITEMSND:
.byte 91,1	; 268.7
.byte 87,1	; 280.1
.byte 86,3	; 284.1
.byte 0,5	; 0.0
.byte 51,1	; 473.5
.byte 50,1	; 485.0
.byte 49,1	; 497.2
.byte 46,2	; 523.3
.byte 0,5	; 0.0
.byte	255,255
.if 0
.byte 24,1	; 994.3
.byte 23,1	; 1046.7
.byte 22,1	; 1104.8
.byte 20,1	; 1169.8
.byte 19,2	; 1242.9
.byte 0,4	; 0.0
.byte 17,1	; 1420.5
.byte 15,1	; 1529.7
.byte 14,3	; 1657.2
.byte 0,4	; 0.0
.byte 11,4	; 2209.6
.byte 0,3	; 0.0
.byte 9,4	; 2485.8
.byte 0,3	; 0.0
.byte 60,1	; 405.8
.byte 64,1	; 382.4
.byte 67,1	; 361.6
.byte 72,1	; 337.1
.byte 73,1	; 331.4
.byte 75,1	; 326.0
.byte 78,1	; 310.7
.byte 83,1	; 292.4
.byte 106,1	; 231.2
.byte 111,1	; 221.0
.byte 115,1	; 211.6
.byte 117,1	; 209.3
.byte 115,1	; 211.6
.byte 114,1	; 213.8
.byte 108,1	; 226.0
.byte 78,1	; 310.7
.byte 75,1	; 326.0
.byte 68,1	; 355.1
.byte 62,1	; 389.9
.byte 55,1	; 441.9
.byte 49,1	; 497.2
.byte 45,1	; 537.5
.byte 44,1	; 552.4
.byte 41,1	; 584.9
.byte 38,1	; 641.5
.byte 36,1	; 662.9
.byte 34,1	; 710.2
.byte 33,1	; 736.5
.byte 255,255
.endif
LVLDONESND:
.byte 36,4	; 662.9
.byte 0,9	; 0.0
.byte 36,6	; 662.9
.byte 0,8	; 0.0
.byte 36,6	; 662.9
.byte 0,15	; 0.0
.byte 93,2	; 261.7
.byte 94,5	; 258.3
.byte 0,10	; 0.0
.byte 82,12	; 296.8
.byte 83,1	; 292.4
.byte 0,7	; 0.0
.byte 149,1	; 164.3
.byte 139,10	; 176.0
.byte 140,1	; 174.4
.byte 139,1	; 176.0
.byte 0,6	; 0.0
.byte 183,1	; 134.4
.byte 181,1	; 135.3
.byte 0,4	; 0.0
.byte 184,6	; 133.5
.byte 0,7	; 0.0
.byte 170,1	; 144.1
.byte 169,1	; 145.2
.byte 0,2	; 0.0
.byte 171,3	; 143.1
.byte 170,3	; 144.1
.byte 169,1	; 145.2
.byte 0,9	; 0.0
.byte 156,1	; 156.6
.byte 158,1	; 155.4
.byte 0,3	; 0.0
.byte 159,3	; 154.2
.byte 158,4	; 155.4
.byte 0,11	; 0.0
.byte 135,1	; 180.8
.byte 137,1	; 179.2
.byte 0,3	; 0.0
.byte 134,28	; 182.4
.byte 0,12	; 0.0
.byte 206,4	; 119.1
.byte 205,5	; 119.8
.byte 206,1	; 119.1
.byte 205,4	; 119.8
.byte 0,11	; 0.0
.byte 12,5	; 1988.6
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
HISCORESND:
.byte 11,3	; 2209.6
.byte 0,7	; 0.0
.byte 11,4	; 2209.6
.byte 0,6	; 0.0
.byte 9,5	; 2485.8
.byte 0,9	; 0.0
.byte 28,6	; 864.6
.byte 0,10	; 0.0
.byte 11,8	; 2209.6
.byte 0,8	; 0.0
.byte 8,7	; 2840.9
.byte 0,5	; 0.0
.byte 7,6	; 3314.4
.byte 255,255
GUNCLICK:
.byte 207,4	; 118.4
.byte 0,1	; 0.0
.byte 44,1	; 552.4
.byte 39,1	; 621.4
.byte 0,1	; 0.0
.byte 205,1	; 119.8
.byte 148,1	; 165.7
.byte 196,1	; 125.1
.byte 255,255
.if 0
SHOTHIT:
.byte 192,2	; 127.5
.byte 158,1	; 155.4
.byte 195,1	; 125.9
.byte 124,1	; 196.9
.byte 191,1	; 128.3
.byte 192,1	; 127.5
.byte 120,1	; 202.9
.byte 59,1	; 414.3
.byte 199,1	; 123.5
.byte 119,1	; 205.0
.byte 199,1	; 123.5
.byte 124,1	; 196.9
.byte 91,1	; 268.7
.byte 149,1	; 164.3
.byte 50,1	; 485.0
.byte 120,1	; 202.9
.byte 149,1	; 164.3
.byte 200,1	; 122.8
.byte 24,1	; 994.3
.byte 200,1	; 122.8
.byte 207,1	; 118.4
.byte 17,1	; 1420.5
.byte 15,1	; 1529.7
.byte 255,255
.endif
KEENLANDSND:
.byte 175,1     ; 140.0
.byte 195,1     ; 125.9
.byte 181,1     ; 135.3
.byte 188,1     ; 130.8
.byte 206,1     ; 119.1
.byte 175,1     ; 140.0
.byte 199,1     ; 123.5
.byte 186,2     ; 131.7
.byte 0,1       ; 0.0
.byte 255,255
KEENJUMPSND:
.if 0
.byte 56,1      ; 432.3
.byte 54,1      ; 452.0
.byte 49,1      ; 497.2
.byte 48,1      ; 509.9
.byte 43,1      ; 568.2
.byte 39,1      ; 621.4
.byte 35,1      ; 685.7
.byte 31,1      ; 764.9
.byte 30,2      ; 795.5
.byte 33,1      ; 736.5
.byte 34,1      ; 710.2
.endif
.byte 40,1      ; 602.6
.byte 39,1      ; 621.4
.byte 36,1      ; 662.9
.byte 34,1      ; 710.2
.byte 33,1      ; 736.5
.byte 28,1      ; 864.6
.byte 25,1      ; 947.0
.byte 24,1      ; 994.3
.byte 22,1      ; 1104.8
.byte 255,255
BUMPHEADSND:
.byte 180,1     ; 136.2
.byte 197,1     ; 124.3
.byte 0,1       ; 0.0
.byte 184,1     ; 133.5
.byte 204,1     ; 120.5
.byte 181,1     ; 135.3
.byte 204,1     ; 120.5
.byte 207,1     ; 118.4
.byte 184,1     ; 133.5
.byte 197,1     ; 124.3
.byte 0,1       ; 0.0
.byte 204,1     ; 120.5
.byte 184,1     ; 133.5
.byte 186,1     ; 131.7
.byte 255,255
YORPBOPSND:
.byte 102,1     ; 239.6
.byte 104,1     ; 234.0
.byte 106,3     ; 231.2
.byte 107,2     ; 228.6
.byte 104,1     ; 234.0
.byte 103,1     ; 236.7
.byte 101,1     ; 242.5
.byte 99,1      ; 245.5
.byte 97,1      ; 251.7
.byte 94,1      ; 258.3
.byte 92,3      ; 265.2
.byte 0,14      ; 0.0
.byte 8,3       ; 2840.9
.byte 0,4       ; 0.0
.byte 25,3      ; 947.0
.byte 0,4       ; 0.0
.byte 9,3       ; 2485.8
.byte 0,5       ; 0.0
.byte 24,3      ; 994.3
.byte 0,4       ; 0.0
.byte 9,3       ; 2485.8
.byte 0,3       ; 0.0
.byte 24,3      ; 994.3
.byte 0,5       ; 0.0
.byte 4,3       ; 4971.6
.byte 255,255
