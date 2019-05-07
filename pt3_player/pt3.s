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

