; TODO
;   move some of these flags to be bits rather than bytes?
;   enabled could be bit 6 or 7 for fast checking
;
; Use memset to set things to 0?

NOTE_WHICH=0
NOTE_VOLUME=1
NOTE_TONE_SLIDING=2
NOTE_ENABLED=3
NOTE_ENVELOPE_ENABLED=4
NOTE_SAMPLE_POINTER=5
NOTE_SAMPLE_LOOP=7
NOTE_SAMPLE_LENGTH=8

note_a:
	.byte	'A'	; NOTE_WHICH
	.byte	$0	; NOTE_VOLUME
	.byte	$0	; NOTE_TONE_SLIDING
	.byte	$0	; NOTE_ENABLED
	.byte	$0	; NOTE_ENVELOPE_ENABLED
	.word	$0	; NOTE_SAMPLE_POINTER
	.byte	$0	; NOTE_SAMPLE_LOOP
	.byte	$0	; NOTE_SAMPLE_LENGTH
note_b:
	.byte	'B'	; NOTE_WHICH
	.byte	$0	; NOTE_VOLUME
	.byte	$0	; NOTE_TONE_SLIDING
	.byte	$0	; NOTE_ENABLED
	.byte	$0	; NOTE_ENVELOPE_ENABLED
	.word	$0	; NOTE_SAMPLE_POINTER
	.byte	$0	; NOTE_SAMPLE_LOOP
	.byte	$0	; NOTE_SAMPLE_LENGTH
note_c:
	.byte	'C'	; NOTE_WHICH
	.byte	$0	; NOTE_VOLUME
	.byte	$0	; NOTE_TONE_SLIDING
	.byte	$0	; NOTE_ENABLED
	.byte	$0	; NOTE_ENVELOPE_ENABLED
	.word	$0	; NOTE_SAMPLE_POINTER
	.byte	$0	; NOTE_SAMPLE_LOOP
	.byte	$0	; NOTE_SAMPLE_LENGTH

pt3_noise_period:	.byte	$0
pt3_noise_add:		.byte	$0
pt3_envelope_period:	.byte	$0
pt3_envelope_type:	.byte	$0
pt3_current_pattern:	.byte	$0
pt3_music_len:		.byte	$0

load_ornament:
	rts

load_sample:
	rts

pt3_init_song:
	lda	#$f
	sta	note_a+NOTE_VOLUME
	sta	note_b+NOTE_VOLUME
	sta	note_c+NOTE_VOLUME
	lda	#$0
	sta	note_a+NOTE_TONE_SLIDING
	sta	note_b+NOTE_TONE_SLIDING
	sta	note_c+NOTE_TONE_SLIDING
	sta	note_a+NOTE_ENABLED
	sta	note_b+NOTE_ENABLED
	sta	note_c+NOTE_ENABLED
	sta	note_a+NOTE_ENVELOPE_ENABLED
	sta	note_b+NOTE_ENVELOPE_ENABLED
	sta	note_c+NOTE_ENVELOPE_ENABLED
	lda	#'A'
	jsr	load_ornament
	lda	#'A'
	jsr	load_sample
	lda	#'B'
	jsr	load_ornament
	lda	#'B'
	jsr	load_sample
	lda	#'C'
	jsr	load_ornament
	lda	#'C'
	jsr	load_sample

	lda	#$0
	sta	pt3_noise_period
	sta	pt3_noise_add
	sta	pt3_envelope_period
	sta	pt3_envelope_type
	sta	pt3_current_pattern

	rts




; Table #1 of Pro Tracker 3.3x - 3.5x
PT3NoteTable_ST_high:
.byte $0E,$0E,$0D,$0C,$0B,$0B,$0A,$09
.byte $09,$08,$08,$07,$07,$07,$06,$06
.byte $05,$05,$05,$04,$04,$04,$04,$03
.byte $03,$03,$03,$03,$02,$02,$02,$02
.byte $02,$02,$02,$01,$01,$01,$01,$01
.byte $01,$01,$01,$01,$01,$01,$01,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00

PT3NoteTable_ST_low:
.byte $F8,$10,$60,$80,$D8,$28,$88,$F0
.byte $60,$E0,$58,$E0,$7C,$08,$B0,$40
.byte $EC,$94,$44,$F8,$B0,$70,$2C,$FD
.byte $BE,$84,$58,$20,$F6,$CA,$A2,$7C
.byte $58,$38,$16,$F8,$DF,$C2,$AC,$90
.byte $7B,$65,$51,$3E,$2C,$1C,$0A,$FC
.byte $EF,$E1,$D6,$C8,$BD,$B2,$A8,$9F
.byte $96,$8E,$85,$7E,$77,$70,$6B,$64
.byte $5E,$59,$54,$4F,$4B,$47,$42,$3F
.byte $3B,$38,$35,$32,$2F,$2C,$2A,$27
.byte $25,$23,$21,$1F,$1D,$1C,$1A,$19
.byte $17,$16,$15,$13,$12,$11,$10,$0F


; Table #2 of Pro Tracker 3.4x - 3.5x
PT3NoteTable_ASM_34_35_high:
.byte $0D,$0C,$0B,$0A,$0A,$09,$09,$08
.byte $08,$07,$07,$06,$06,$06,$05,$05
.byte $05,$04,$04,$04,$04,$03,$03,$03
.byte $03,$03,$02,$02,$02,$02,$02,$02
.byte $02,$01,$01,$01,$01,$01,$01,$01
.byte $01,$01,$01,$01,$01,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00

PT3NoteTable_ASM_34_35_lo:
.byte $10,$55,$A4,$FC,$5F,$CA,$3D,$B8
.byte $3B,$C5,$55,$EC,$88,$2A,$D2,$7E
.byte $2F,$E5,$9E,$5C,$1D,$E2,$AB,$76
.byte $44,$15,$E9,$BF,$98,$72,$4F,$2E
.byte $0F,$F1,$D5,$BB,$A2,$8B,$74,$60
.byte $4C,$39,$28,$17,$07,$F9,$EB,$DD
.byte $D1,$C5,$BA,$B0,$A6,$9D,$94,$8C
.byte $84,$7C,$75,$6F,$69,$63,$5D,$58
.byte $53,$4E,$4A,$46,$42,$3E,$3B,$37
.byte $34,$31,$2F,$2C,$29,$27,$25,$23
.byte $21,$1F,$1D,$1C,$1A,$19,$17,$16
.byte $15,$14,$12,$11,$10,$0F,$0E,$0D


PT3VolumeTable_33_34:
.byte $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
.byte $0,$0,$0,$0,$0,$0,$0,$0,$1,$1,$1,$1,$1,$1,$1,$1
.byte $0,$0,$0,$0,$0,$0,$1,$1,$1,$1,$1,$2,$2,$2,$2,$2
.byte $0,$0,$0,$0,$1,$1,$1,$1,$2,$2,$2,$2,$3,$3,$3,$3
.byte $0,$0,$0,$0,$1,$1,$1,$2,$2,$2,$3,$3,$3,$4,$4,$4
.byte $0,$0,$0,$1,$1,$1,$2,$2,$3,$3,$3,$4,$4,$4,$5,$5
.byte $0,$0,$0,$1,$1,$2,$2,$3,$3,$3,$4,$4,$5,$5,$6,$6
.byte $0,$0,$1,$1,$2,$2,$3,$3,$4,$4,$5,$5,$6,$6,$7,$7
.byte $0,$0,$1,$1,$2,$2,$3,$3,$4,$5,$5,$6,$6,$7,$7,$8
.byte $0,$0,$1,$1,$2,$3,$3,$4,$5,$5,$6,$6,$7,$8,$8,$9
.byte $0,$0,$1,$2,$2,$3,$4,$4,$5,$6,$6,$7,$8,$8,$9,$A
.byte $0,$0,$1,$2,$3,$3,$4,$5,$6,$6,$7,$8,$9,$9,$A,$B
.byte $0,$0,$1,$2,$3,$4,$4,$5,$6,$7,$8,$8,$9,$A,$B,$C
.byte $0,$0,$1,$2,$3,$4,$5,$6,$7,$7,$8,$9,$A,$B,$C,$D
.byte $0,$0,$1,$2,$3,$4,$5,$6,$7,$8,$9,$A,$B,$C,$D,$E
.byte $0,$1,$2,$3,$4,$5,$6,$7,$8,$9,$A,$B,$C,$D,$E,$F


PT3VolumeTable_35:
.byte $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
.byte $0,$0,$0,$0,$0,$0,$0,$0,$1,$1,$1,$1,$1,$1,$1,$1
.byte $0,$0,$0,$0,$1,$1,$1,$1,$1,$1,$1,$1,$2,$2,$2,$2
.byte $0,$0,$0,$1,$1,$1,$1,$1,$2,$2,$2,$2,$2,$3,$3,$3
.byte $0,$0,$1,$1,$1,$1,$2,$2,$2,$2,$3,$3,$3,$3,$4,$4
.byte $0,$0,$1,$1,$1,$2,$2,$2,$3,$3,$3,$4,$4,$4,$5,$5
.byte $0,$0,$1,$1,$2,$2,$2,$3,$3,$4,$4,$4,$5,$5,$6,$6
.byte $0,$0,$1,$1,$2,$2,$3,$3,$4,$4,$5,$5,$6,$6,$7,$7
.byte $0,$1,$1,$2,$2,$3,$3,$4,$4,$5,$5,$6,$6,$7,$7,$8
.byte $0,$1,$1,$2,$2,$3,$4,$4,$5,$5,$6,$7,$7,$8,$8,$9
.byte $0,$1,$1,$2,$3,$3,$4,$5,$5,$6,$7,$7,$8,$9,$9,$A
.byte $0,$1,$1,$2,$3,$4,$4,$5,$6,$7,$7,$8,$9,$A,$A,$B
.byte $0,$1,$2,$2,$3,$4,$5,$6,$6,$7,$8,$9,$A,$A,$B,$C
.byte $0,$1,$2,$3,$3,$4,$5,$6,$7,$8,$9,$A,$A,$B,$C,$D
.byte $0,$1,$2,$3,$4,$5,$6,$7,$7,$8,$9,$A,$B,$C,$D,$E
.byte $0,$1,$2,$3,$4,$5,$6,$7,$8,$9,$A,$B,$C,$D,$E,$F


