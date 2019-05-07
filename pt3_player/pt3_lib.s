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
NOTE_TONE_L=9
NOTE_TONE_H=10
NOTE_AMPLITUDE=11

note_a:
	.byte	'A'	; NOTE_WHICH
	.byte	$0	; NOTE_VOLUME
	.byte	$0	; NOTE_TONE_SLIDING
	.byte	$0	; NOTE_ENABLED
	.byte	$0	; NOTE_ENVELOPE_ENABLED
	.word	$0	; NOTE_SAMPLE_POINTER
	.byte	$0	; NOTE_SAMPLE_LOOP
	.byte	$0	; NOTE_SAMPLE_LENGTH
	.byte	$0	; NOTE_TONE_L
	.byte	$0	; NOTE_TONE_H
	.byte	$0	; NOTE_AMPLITUDE
note_b:
	.byte	'B'	; NOTE_WHICH
	.byte	$0	; NOTE_VOLUME
	.byte	$0	; NOTE_TONE_SLIDING
	.byte	$0	; NOTE_ENABLED
	.byte	$0	; NOTE_ENVELOPE_ENABLED
	.word	$0	; NOTE_SAMPLE_POINTER
	.byte	$0	; NOTE_SAMPLE_LOOP
	.byte	$0	; NOTE_SAMPLE_LENGTH
	.byte	$0	; NOTE_TONE_L
	.byte	$0	; NOTE_TONE_H
	.byte	$0	; NOTE_AMPLITUDE
note_c:
	.byte	'C'	; NOTE_WHICH
	.byte	$0	; NOTE_VOLUME
	.byte	$0	; NOTE_TONE_SLIDING
	.byte	$0	; NOTE_ENABLED
	.byte	$0	; NOTE_ENVELOPE_ENABLED
	.word	$0	; NOTE_SAMPLE_POINTER
	.byte	$0	; NOTE_SAMPLE_LOOP
	.byte	$0	; NOTE_SAMPLE_LENGTH
	.byte	$0	; NOTE_TONE_L
	.byte	$0	; NOTE_TONE_H
	.byte	$0	; NOTE_AMPLITUDE

pt3_noise_period:	.byte	$0
pt3_noise_add:		.byte	$0

pt3_envelope_period:	.byte	$0
pt3_envelope_add:	.byte	$0
pt3_envelope_type:	.byte	$0

pt3_current_pattern:	.byte	$0
pt3_music_len:		.byte	$0
pt3_mixer_value:	.byte	$0

; Header offsets

PT3_HEADER_FREQUENCY = $63

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

	;=====================================
	; Calculate Note
	;=====================================
calculate_note:

;if (a->enabled) {
;  b0 = pt3->data[a->sample_pointer + a->sample_position * 4];
;  b1 = pt3->data[a->sample_pointer + a->sample_position * 4 + 1];
;  a->tone = pt3->data[a->sample_pointer + a->sample_position * 4 + 2];
;  a->tone += (pt3->data[a->sample_pointer + a->sample_position * 4 + 3])<<8;
;  a->tone += a->tone_accumulator;
;  if ((b1 & 0x40) != 0) {
;     a->tone_accumulator=a->tone;
;  }
;  j = a->note + ((pt3->data[a->ornament_pointer + a->ornament_position]<<24)>>24);
;  if (j < 0) j = 0;
;  else if (j > 95) j = 95;
;  w = GetNoteFreq(j,pt3->frequency_table);
;  a->tone = (a->tone + a->tone_sliding + w) & 0xfff;
;  if (a->tone_slide_count > 0) {
;     a->tone_slide_count--;
;     if (a->tone_slide_count==0) {
;        a->tone_sliding+=a->tone_slide_step;
;        a->tone_slide_count = a->tone_slide_delay;
;        if (!a->simplegliss) {
;           if ( ((a->tone_slide_step < 0) &&
;                (a->tone_sliding <= a->tone_delta)) ||
;                ((a->tone_slide_step >= 0) &&
;                (a->tone_sliding >= a->tone_delta)) ) {
;              a->note = a->slide_to_note;
;              a->tone_slide_count = 0;
;              a->tone_sliding = 0;
;           }
;         }
;     }
;  }

;  a->amplitude= (b1 & 0xf);
;  if ((b0 & 0x80)!=0) {
;     if ((b0&0x40)!=0) {
;        if (a->amplitude_sliding < 15) {
;           a->amplitude_sliding++;
;        }
;     }
;     else {
;        if (a->amplitude_sliding > -15) {
;           a->amplitude_sliding--;
;        }
;     }
;  }

;  a->amplitude+=a->amplitude_sliding;

;  if (a->amplitude < 0) a->amplitude = 0;
;  else if (a->amplitude > 15) a->amplitude = 15;

;  //if (PlParams.PT3.PT3_Version <= 4)
;  //   a->amplitude = PT3VolumeTable_33_34[a->volume][a->amplitude];
;  //}
;  //else
;     a->amplitude = PT3VolumeTable_35[a->volume][a->amplitude];

;  if (((b0 & 0x1) == 0) && ( a->envelope_enabled)) {
;     a->amplitude |= 16;
;  }

;  /* Frequency slide */
;  /* If b1 top bits are 10 or 11 */
;  if ((b1 & 0x80) != 0) {
;     if ((b0 & 0x20) != 0) {
;        j = ((b0>>1)|0xF0) + a->envelope_sliding;
;     }
;     else {
;        j = ((b0>>1)&0xF) + a->envelope_sliding;
;     }
;     if (( b1 & 0x20) != 0) {
;        a->envelope_sliding = j;
;     }
;     pt3->envelope_add+=j;
;  }
;  /* Noise slide */
;  else {
;     pt3->noise_add = (b0>>1) + a->noise_sliding;
;     if ((b1 & 0x20) != 0) {
;        a->noise_sliding = pt3->noise_add;
;     }
;  }

;  pt3->mixer_value = ((b1 >>1) & 0x48) | pt3->mixer_value;

;  a->sample_position++;
;  if (a->sample_position >= a->sample_length) {
;     a->sample_position = a->sample_loop;
;  }

;  a->ornament_position++;
;  if (a->ornament_position >= a->ornament_length) {
;     a->ornament_position = a->ornament_loop;
;  }
;} else {
;   a->amplitude=0;
;}

;pt3->mixer_value=pt3->mixer_value>>1;

;if (a->onoff>0) {
;   a->onoff--;
;   if (a->onoff==0) {
;      a->enabled=!a->enabled;
;      if (a->enabled) a->onoff=a->onoff_delay;
;      else a->onoff=a->offon_delay;
;   }
;}


	rts

	;=====================================
	; Decode Note
	;=====================================

decode_note:

	rts

	;=====================================
	; pt3 make frame
	;=====================================
pt3_make_frame:
;       for(i=0;i < pt3.music_len;i++) {
;          pt3_set_pattern(i,&pt3);
;          for(j=0;j<64;j++) {
;             if (pt3_decode_line(&pt3)) break;
;             for(f=0;f<pt3.speed;f++) {

	; AY-3-8910 register summary
	;
	; R0/R1 = A period low/high
	; R2/R3 = B period low/high
	; R4/R5 = C period low/high
	; R6 = Noise period */
	; R7 = Enable XX Noise=!CBA Tone=!CBA */
	; R8/R9/R10 = Channel A/B/C amplitude M3210, M=envelope enable
	; R11/R12 = Envelope Period low/high
	; R13 = Envelope Shape, 0xff means don't write
	; R14/R15 = I/O (ignored)

	lda	#0
	sta	pt3_mixer_value
	sta	pt3_envelope_add

	lda	#0			; Note A
	jsr	calculate_note
	lda	#1			; Note B
	jsr	calculate_note
	lda	#2			; Note C
	jsr	calculate_note

	; Load up the Frequency Registers

	lda	note_a+NOTE_TONE_L	; Note A Period L
	sta	REGISTER_DUMP+0		; into R0
	lda	note_a+NOTE_TONE_H	; Note A Period H
	sta	REGISTER_DUMP+1		; into R1

	lda	note_b+NOTE_TONE_L	; Note B Period L
	sta	REGISTER_DUMP+2		; into R2
	lda	note_b+NOTE_TONE_H	; Note B Period H
	sta	REGISTER_DUMP+3		; into R3

	lda	note_c+NOTE_TONE_L	; Note C Period L
	sta	REGISTER_DUMP+4		; into R4
	lda	note_c+NOTE_TONE_H	; Note C Period H
	sta	REGISTER_DUMP+5		; into R5

	; Noise
	; frame[6]= (pt3->noise_period+pt3->noise_add)&0x1f;
	clc
	lda	pt3_noise_period
	adc	pt3_noise_add
	and	#$1f
	sta	REGISTER_DUMP+6


	; Mixer
	lda	pt3_mixer_value
	sta	REGISTER_DUMP+7

	; Amplitudes
	lda	note_a+NOTE_AMPLITUDE
	sta	REGISTER_DUMP+8
	lda	note_b+NOTE_AMPLITUDE
	sta	REGISTER_DUMP+9
	lda	note_c+NOTE_AMPLITUDE
	sta	REGISTER_DUMP+10

	; Envelope period
;	temp_envelope=pt3->envelope_period+
;			pt3->envelope_add+
;			pt3->envelope_slide;
;	frame[11]=(temp_envelope&0xff);
;	frame[12]=(temp_envelope>>8);

;	Envelope shape
;	if (pt3->envelope_type==pt3->envelope_type_old) {
;		frame[13]=0xff;
;	}
;	else {
;		frame[13]=pt3->envelope_type;
;	}
;	pt3->envelope_type_old=pt3->envelope_type;
;
;	if (pt3->envelope_delay > 0) {
;		pt3->envelope_delay--;
;		if (pt3->envelope_delay==0) {
;			pt3->envelope_delay=pt3->envelope_delay_orig;
;			pt3->envelope_slide+=pt3->envelope_slide_add;
;		}
;	}


	rts

	;======================================
	; GetNoteFreq
	;======================================

	; Return frequency from lookup table
	; Which note is in Y
	; return in X,A (high,low)
GetNoteFreq:
	lda	PT3_LOC+PT3_HEADER_FREQUENCY
	cmp	#1
	bne	freq_table_2

	lda	PT3NoteTable_ST_high,Y
	tax
	lda	PT3NoteTable_ST_low,Y
	rts

freq_table_2:
	lda	PT3NoteTable_ASM_34_35_high,Y
	tax
	lda	PT3NoteTable_ASM_34_35_low,Y
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

PT3NoteTable_ASM_34_35_low:
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


