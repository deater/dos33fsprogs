; TODO
;   move some of these flags to be bits rather than bytes?
;   enabled could be bit 6 or 7 for fast checking
;
; Use memset to set things to 0?

NOTE_WHICH=0
NOTE_VOLUME=1
NOTE_TONE_SLIDING_L=2
NOTE_TONE_SLIDING_H=3
NOTE_ENABLED=4
NOTE_ENVELOPE_ENABLED=5
NOTE_SAMPLE_POINTER_L=6
NOTE_SAMPLE_POINTER_H=7
NOTE_SAMPLE_LOOP=8
NOTE_SAMPLE_LENGTH=9
NOTE_TONE_L=10
NOTE_TONE_H=11
NOTE_AMPLITUDE=12
NOTE_NOTE=13
NOTE_LEN=14
NOTE_LEN_COUNT=15
NOTE_SPEC_COMMAND=16		; is this one needed?
NOTE_NEW_NOTE=17
NOTE_ALL_DONE=18
NOTE_ADDR_L=19
NOTE_ADDR_H=20
NOTE_ORNAMENT_POINTER_L=21
NOTE_ORNAMENT_POINTER_H=22
NOTE_ORNAMENT_LOOP=23
NOTE_ORNAMENT_LENGTH=24

note_a:
	.byte	'A'	; NOTE_WHICH
	.byte	$0	; NOTE_VOLUME
	.byte	$0	; NOTE_TONE_SLIDING_L
	.byte	$0	; NOTE_TONE_SLIDING_H
	.byte	$0	; NOTE_ENABLED
	.byte	$0	; NOTE_ENVELOPE_ENABLED
	.byte	$0	; NOTE_SAMPLE_POINTER_L
	.byte	$0	; NOTE_SAMPLE_POINTER_H
	.byte	$0	; NOTE_SAMPLE_LOOP
	.byte	$0	; NOTE_SAMPLE_LENGTH
	.byte	$0	; NOTE_TONE_L
	.byte	$0	; NOTE_TONE_H
	.byte	$0	; NOTE_AMPLITUDE
	.byte	$0	; NOTE_NOTE
	.byte	$0	; NOTE_LEN
	.byte	$0	; NOTE_LEN_COUNT
	.byte	$0	; NOTE_SPEC_COMMAND
	.byte	$0	; NOTE_NEW_NOTE
	.byte	$0	; NOTE_ALL_DONE
	.byte	$0	; NOTE_ADDR_L
	.byte	$0	; NOTE_ADDR_H
	.byte	$0	; NOTE_ORNAMENT_POINTER_L
	.byte	$0	; NOTE_ORNAMENT_POINTER_H
	.byte	$0	; NOTE_ORNAMENT_LOOP
	.byte	$0	; NOTE_ORNAMENT_LENGTH

note_b:
	.byte	'B'	; NOTE_WHICH
	.byte	$0	; NOTE_VOLUME
	.byte	$0	; NOTE_TONE_SLIDING_L
	.byte	$0	; NOTE_TONE_SLIDING_H
	.byte	$0	; NOTE_ENABLED
	.byte	$0	; NOTE_ENVELOPE_ENABLED
	.byte	$0	; NOTE_SAMPLE_POINTER_L
	.byte	$0	; NOTE_SAMPLE_POINTER_H
	.byte	$0	; NOTE_SAMPLE_LOOP
	.byte	$0	; NOTE_SAMPLE_LENGTH
	.byte	$0	; NOTE_TONE_L
	.byte	$0	; NOTE_TONE_H
	.byte	$0	; NOTE_AMPLITUDE
	.byte	$0	; NOTE_NOTE
	.byte	$0	; NOTE_LEN
	.byte	$0	; NOTE_LEN_COUNT
	.byte	$0	; NOTE_SPEC_COMMAND
	.byte	$0	; NOTE_NEW_NOTE
	.byte	$0	; NOTE_ALL_DONE
	.byte	$0	; NOTE_ADDR_L
	.byte	$0	; NOTE_ADDR_H
	.byte	$0	; NOTE_ORNAMENT_POINTER_L
	.byte	$0	; NOTE_ORNAMENT_POINTER_H
	.byte	$0	; NOTE_ORNAMENT_LOOP
	.byte	$0	; NOTE_ORNAMENT_LENGTH

note_c:
	.byte	'C'	; NOTE_WHICH
	.byte	$0	; NOTE_VOLUME
	.byte	$0	; NOTE_TONE_SLIDING_L
	.byte	$0	; NOTE_TONE_SLIDING_H
	.byte	$0	; NOTE_ENABLED
	.byte	$0	; NOTE_ENVELOPE_ENABLED
	.byte	$0	; NOTE_SAMPLE_POINTER_L
	.byte	$0	; NOTE_SAMPLE_POINTER_H
	.byte	$0	; NOTE_SAMPLE_LOOP
	.byte	$0	; NOTE_SAMPLE_LENGTH
	.byte	$0	; NOTE_TONE_L
	.byte	$0	; NOTE_TONE_H
	.byte	$0	; NOTE_AMPLITUDE
	.byte	$0	; NOTE_NOTE
	.byte	$0	; NOTE_LEN
	.byte	$0	; NOTE_LEN_COUNT
	.byte	$0	; NOTE_SPEC_COMMAND
	.byte	$0	; NOTE_NEW_NOTE
	.byte	$0	; NOTE_ALL_DONE
	.byte	$0	; NOTE_ADDR_L
	.byte	$0	; NOTE_ADDR_H
	.byte	$0	; NOTE_ORNAMENT_POINTER_L
	.byte	$0	; NOTE_ORNAMENT_POINTER_H
	.byte	$0	; NOTE_ORNAMENT_LOOP
	.byte	$0	; NOTE_ORNAMENT_LENGTH

pt3_version:		.byte	$0
pt3_frequency_table:	.byte	$0
pt3_speed:		.byte	$0
pt3_num_patterns:	.byte	$0
pt3_loop:		.byte	$0

pt3_noise_period:	.byte	$0
pt3_noise_add:		.byte	$0

pt3_envelope_period_l:	.byte	$0
pt3_envelope_period_h:	.byte	$0
pt3_envelope_slide_l:	.byte	$0
pt3_envelope_slide_h:	.byte	$0
pt3_envelope_slide_add_l:.byte	$0
pt3_envelope_slide_add_h:.byte	$0
pt3_envelope_add:	.byte	$0
pt3_envelope_type:	.byte	$0
pt3_envelope_type_old:	.byte	$0
pt3_envelope_delay:	.byte	$0
pt3_envelope_delay_orig:.byte	$0

;pt3_current_pattern:	.byte	$0
pt3_music_len:		.byte	$0
pt3_mixer_value:	.byte	$0

temp_word_l:		.byte	$0
temp_word_h:		.byte	$0


; Header offsets

PT3_HEADER_FREQUENCY	= $63
PT3_PATTERN_LOC_L	= $67
PT3_PATTERN_LOC_H	= $68
PT3_SAMPLE_LOC_L	= $69
PT3_SAMPLE_LOC_H	= $6A
PT3_ORNAMENT_LOC_L	= $A9
PT3_OTNAMENT_LOC_H	= $AA
PT3_PATTERN_TABLE	= $C9

	;===========================
	; Load Ornament
	;===========================

load_ornament:

	ldy	#0

;	a->ornament_pointer=pt3->ornament_patterns[a->ornament];
;	a->ornament_loop=pt3->data[a->ornament_pointer];
;	a->ornament_pointer++;
;	a->ornament_length=pt3->data[a->ornament_pointer];
;	a->ornament_pointer++;

	clc
	lda	note_a+NOTE_ORNAMENT_POINTER_L
	adc	#2
	sta	note_a+NOTE_ORNAMENT_POINTER_L
	lda	note_a+NOTE_ORNAMENT_POINTER_H
	adc	#0
	sta	note_a+NOTE_ORNAMENT_POINTER_H


	rts

	;===========================
	; Load Sample
	;===========================
	;
load_sample:
;	a->sample_pointer=pt3->sample_patterns[a->sample];
;	a->sample_loop=pt3->data[a->sample_pointer];
;	a->sample_pointer++;
;	a->sample_length=pt3->data[a->sample_pointer];
;	a->sample_pointer++;

	rts

pt3_init_song:
	lda	#$f
	sta	note_a+NOTE_VOLUME
	sta	note_b+NOTE_VOLUME
	sta	note_c+NOTE_VOLUME
	lda	#$0
	sta	note_a+NOTE_TONE_SLIDING_L
	sta	note_b+NOTE_TONE_SLIDING_L
	sta	note_c+NOTE_TONE_SLIDING_L
	sta	note_a+NOTE_TONE_SLIDING_H
	sta	note_b+NOTE_TONE_SLIDING_H
	sta	note_c+NOTE_TONE_SLIDING_H
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
	sta	pt3_envelope_period_l
	sta	pt3_envelope_period_h
	sta	pt3_envelope_type
;	sta	pt3_current_pattern

	rts

	;=====================================
	; Calculate Note
	;=====================================
calculate_note:
	ldy	#0

	lda	note_a+NOTE_ENABLED,Y
	bne	note_enabled

	lda	#0
	sta	note_a+NOTE_AMPLITUDE,Y
	jmp	done_note

note_enabled:

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

	; clamp amplitude to 0 - 15

	lda	note_a+NOTE_AMPLITUDE,Y
check_amp_lo:
	bpl	check_amp_hi
	lda	#0
	jmp	write_clamp_amplitude

check_amp_hi:
	cmp	#16
	bcc	done_clamp_amplitude	; blt
	lda	#15
write_clamp_amplitude:
	sta	note_a+NOTE_AMPLITUDE,Y
done_clamp_amplitude:

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

done_note:
	; set mixer value
	; this is a bit complex (from original code)
	; after 3 calls it is set up properly
	lda	pt3_mixer_value
	lsr
	sta	pt3_mixer_value

;if (a->onoff>0) {
;   a->onoff--;
;   if (a->onoff==0) {
;      a->enabled=!a->enabled;
;      if (a->enabled) a->onoff=a->onoff_delay;
;      else a->onoff=a->offon_delay;
;   }
;}


	rts

prev_note:	.byte $0
prev_sliding_l:	.byte $0
prev_sliding_h:	.byte $0
a_done:		.byte $0
current_val:	.byte $0

	;=====================================
	; Decode Note
	;=====================================

decode_note:

	; Init vars

	lda	#0
	sta	note_a+NOTE_NEW_NOTE		; for printing notes?
	sta	note_a+NOTE_SPEC_COMMAND	; These are only if printing?
	sta	a_done

	; Skip decode if note still running
	lda	note_a+NOTE_LEN_COUNT
	beq	keep_decoding			; assume not negative

	; we are still running, decrement and early return
	dec	note_a+NOTE_LEN_COUNT
	rts

keep_decoding:

	lda	note_a+NOTE_NOTE		; store prev note
	sta	prev_note

	lda	note_a+NOTE_TONE_SLIDING_H	; store prev sliding
	sta	prev_sliding_h
	lda	note_a+NOTE_TONE_SLIDING_L
	sta	prev_sliding_l


note_decode_loop:
	lda	note_a+NOTE_LEN			; re-up length count
	sta	note_a+NOTE_LEN_COUNT


;	current_val=pt3->data[*addr];
;	switch((current_val>>4)&0xf) {
;	case 0:
;		if (current_val==0x0) {
;			a->len_count=0;
;			a->all_done=1;
;			a_done=1;
;		}
;		else { /* FIXME: what if multiple spec commands? */
;			/* Doesn't seem to happen in practice */
;			/* But AY_emul has code to handle it */
;			a->spec_command=current_val&0xf;
;		}
;		break;
;	case 1:
;		if ((current_val&0xf)==0x0) {
;			a->envelope_enabled=0;
;		}
;		else {
;			pt3->envelope_type_old=0x78;
;			pt3->envelope_type=(current_val&0xf);

;			(*addr)++;
;			current_val=pt3->data[*addr];
;			pt3->envelope_period=(current_val<<8);

;			(*addr)++;

;			current_val=pt3->data[(*addr)];
;			pt3->envelope_period|=(current_val&0xff$

;			a->envelope_enabled=1;
;			pt3->envelope_slide=0;
;			pt3->envelope_delay=0;
;		}
;		(*addr)++;
;		current_val=pt3->data[(*addr)];
;		a->sample=(current_val/2);
;		pt3_load_sample(pt3,a->which);

;		a->ornament_position=0;

;		break;
;	case 2:
;		pt3->noise_period=(current_val&0xf);
;		break;
;	case 3:
;		pt3->noise_period=(current_val&0xf)+0x10;
;		break;
;	case 4:
;		a->ornament=(current_val&0xf);
;		pt3_load_ornament(pt3,a->which);
;		a->ornament_position=0;
;		break;
;	case 5:
;	case 6:
;	case 7:
;	case 8:
;	case 9:
;	case 0xa:
;		a->new_note=1;
;		a->note=(current_val-0x50);
;		a->sample_position=0;
;		a->amplitude_sliding=0;
;		a->noise_sliding=0;
;		a->envelope_sliding=0;
;		a->ornament_position=0;
;		a->tone_slide_count=0;
;		a->tone_sliding=0;
;		a->tone_accumulator=0;
;		a->onoff=0;
;		a->enabled=1;
;		a_done=1;
;		break;
;	case 0xb:
;		/* Disable envelope */
;		if (current_val==0xb0) {
;			a->envelope_enabled=0;
;			a->ornament_position=0;
;		}
;		/* set len */
;		else if (current_val==0xb1) {
;			(*addr)++;
;			current_val=pt3->data[(*addr)];
;			a->len=current_val;
;			a->len_count=a->len;
;		}
;		else {
;			a->envelope_enabled=1;
;			pt3->envelope_type_old=0x78;
;			pt3->envelope_type=(current_val&0xf)-1;
;			(*addr)++;
;			current_val=pt3->data[(*addr)];
;			pt3->envelope_period=(current_val<<8);
;			(*addr)++;
;			current_val=pt3->data[(*addr)];
;			pt3->envelope_period|=(current_val&0xff$
;			a->ornament_position=0;
;			pt3->envelope_slide=0;
;			pt3->envelope_delay=0;
;		}
;		break;
;	case 0xc:       /* volume */
;		if ((current_val&0xf)==0) {
;			a->sample_position=0;
;			a->amplitude_sliding=0;
;			a->noise_sliding=0;
;			a->envelope_sliding=0;
;			a->ornament_position=0;
;			a->tone_slide_count=0;
;			a->tone_sliding=0;
;			a->tone_accumulator=0;
;			a->onoff=0;
;			a->enabled=0;
;			a_done=1;
;		}
;		else {
;			a->volume=current_val&0xf;
;		}
;		break;
;	case 0xd:
;		if (current_val==0xd0) {
;			a_done=1;
;		}
;		else {
;			a->sample=(current_val&0xf);
;			pt3_load_sample(pt3,a->which);
;		}
;		break;
;	case 0xe:
;		a->sample=(current_val-0xd0);
;		pt3_load_sample(pt3,a->which);
;		break;
;	case 0xf:
;		a->envelope_enabled=0;
;		a->ornament=(current_val&0xf);
;		pt3_load_ornament(pt3,a->which);
;		(*addr)++;
;		current_val=pt3->data[*addr];

;		a->sample=current_val/2;
;		a->sample_pointer=pt3->sample_patterns[a->sampl$
;		pt3_load_sample(pt3,a->which);
;		break;
;	}

;	(*addr)++;
;	/* Note, the AYemul code has code to make sure these are applied */
;	/* In the same order they appear.  We don't bother? */
;	if (a_done) {
;		if (a->spec_command==0x0) {
;		}
;		/* Tone Down */
;		else if (a->spec_command==0x1) {
;			current_val=pt3->data[(*addr)];
;			a->spec_delay=current_val;
;			a->tone_slide_delay=current_val;
;			a->tone_slide_count=a->tone_slide_delay;
;			(*addr)++;
;			current_val=pt3->data[(*addr)];
;			a->spec_lo=(current_val);
;			(*addr)++;
;			current_val=pt3->data[(*addr)];
;			a->spec_hi=(current_val);
;			a->tone_slide_step=(a->spec_lo)|(a->spec_hi<<8);
;			/* Sign Extend */
;			a->tone_slide_step=(a->tone_slide_step<<16)>>16;
;			a->simplegliss=1;
;			a->onoff=0;
;			(*addr)++;
;		}
;		/* port */
;		else if (a->spec_command==0x2) {
;			a->simplegliss=0;
;			a->onoff=0;

;			current_val=pt3->data[(*addr)];
;			a->spec_delay=current_val;

;			a->tone_slide_delay=current_val;
;			a->tone_slide_count=a->tone_slide_delay;

;			(*addr)++;
;			(*addr)++;
;			(*addr)++;
;			current_val=pt3->data[(*addr)];
;			a->spec_lo=current_val;

;			(*addr)++;
;			current_val=pt3->data[(*addr)];
;			a->spec_hi=current_val;
;			(*addr)++;

;			a->tone_slide_step=(a->spec_hi<<8)|(a->spec_lo);
;			/* sign extend */
;			a->tone_slide_step=(a->tone_slide_step<<16)>>16;
;			/* abs() */
;			if (a->tone_slide_step<0) a->tone_slide_step=-a$
;			a->tone_delta=GetNoteFreq(a->note,pt3)-
;				GetNoteFreq(prev_note,pt3);
;			a->slide_to_note=a->note;
;			a->note=prev_note;
;			if (pt3->version >= 6) {
;				a->tone_sliding = prev_sliding;
;			}
;			if ((a->tone_delta - a->tone_sliding) < 0) {
;				a->tone_slide_step = -a->tone_slide_ste$
;			}
;		}
;		/* Position in Sample */
;		else if (a->spec_command==0x3) {
;			current_val=pt3->data[(*addr)];
;			a->sample_position=current_val;
;			(*addr)++;
;		}
;		/* Position in Ornament */
;		else if (a->spec_command==0x4) {
;			current_val=pt3->data[(*addr)];
;			a->ornament_position=current_val;
;			(*addr)++;
;		}
;		/* Vibrato */
;		else if (a->spec_command==0x5) {
;			current_val=pt3->data[(*addr)];
;			a->onoff_delay=current_val;
;			(*addr)++;
;			current_val=pt3->data[(*addr)];
;			a->offon_delay=current_val;
;			(*addr)++;

;			a->onoff=a->onoff_delay;
;			a->tone_slide_count=0;
;			a->tone_sliding=0;

;		}
;		/* Envelope Down */
;		else if (a->spec_command==0x8) {

;			/* delay? */
;			current_val=pt3->data[(*addr)];
;			pt3->envelope_delay=current_val;
;			pt3->envelope_delay_orig=current_val;
;			a->spec_delay=current_val;
;			(*addr)++;

;			/* Low? */
;			current_val=pt3->data[(*addr)];
;			a->spec_lo=current_val&0xff;
;			(*addr)++;

;			/* High? */
;			current_val=pt3->data[(*addr)];
;			a->spec_hi=current_val&0xff;
;			(*addr)++;
;			pt3->envelope_slide_add=(a->spec_hi<<8)|(a->spe$
;		/* Set Speed */
;		else  if (a->spec_command==0x9) {
;			current_val=pt3->data[(*addr)];
;			a->spec_lo=current_val;
;			pt3->speed=current_val;
;			(*addr)++;
;		}
;		break;
;	}

	rts

	;=====================================
	; Decode Line
	;=====================================

pt3_decode_line:
	; decode_note(&pt3->a,&(pt3->a_addr),pt3);
	jsr	decode_note

	; decode_note(&pt3->b,&(pt3->b_addr),pt3);
	jsr	decode_note

	; decode_note(&pt3->c,&(pt3->c_addr),pt3);
	jsr	decode_note

;	if (pt3->a.all_done && pt3->b.all_done && pt3->c.all_done) {
;		return 1;
;	}

	rts


current_subframe:	.byte	$0
current_line:		.byte	$0
current_pattern:	.byte	$0

	;=====================================
	; Set Pattern
	;=====================================

pt3_set_pattern:

	ldy	current_pattern
	lda	PT3_LOC+PT3_PATTERN_TABLE,Y	; get pattern table value

	asl		; mul by two, as word sized
	tay

	clc

	lda	PT3_LOC+PT3_PATTERN_LOC_L
	sta	PATTERN_L
	lda	PT3_LOC+PT3_PATTERN_LOC_H
	sta	PATTERN_H

	lda	(PATTERN_L),Y
	sta	note_a+NOTE_ADDR_L
	iny

	lda	(PATTERN_L),Y
	adc	>PT3_LOC		; assume page boundary
	sta	note_a+NOTE_ADDR_H
	iny

	lda	(PATTERN_L),Y
	sta	note_b+NOTE_ADDR_L
	iny

	lda	(PATTERN_L),Y
	adc	>PT3_LOC		; assume page boundary
	sta	note_b+NOTE_ADDR_H
	iny

	lda	(PATTERN_L),Y
	sta	note_c+NOTE_ADDR_L
	iny

	lda	(PATTERN_L),Y
	adc	>PT3_LOC		; assume page boundary
	sta	note_c+NOTE_ADDR_H

	lda	#0
	sta	note_a+NOTE_ALL_DONE
	sta	note_b+NOTE_ALL_DONE
	sta	note_c+NOTE_ALL_DONE

	sta	pt3_noise_period

	rts



	;=====================================
	; pt3 make frame
	;=====================================
pt3_make_frame:
;       for(i=0;i < pt3.music_len;i++) {
;          pt3_set_pattern(i,&pt3);
;          for(j=0;j<64;j++) {
;             if (pt3_decode_line(&pt3)) break;

next_subframe:
	inc	current_subframe	; for(f=0;f<pt3.speed;f++) {
	lda	current_subframe
	cmp	pt3_speed
	bne	do_frame

next_line:
	lda	#0
	sta	current_subframe

	jsr	pt3_decode_line

	inc	current_line
	cmp	#64
	bne	do_frame

next_pattern:
	lda	#0
	sta	current_line

	inc	current_pattern
	lda	current_pattern
	cmp	pt3_music_len
	beq	done_song

	jsr	pt3_set_pattern
	jmp	do_frame

done_song:
	lda	#$ff
	sta	DONE_PLAYING

	rts

do_frame:
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
	; result=period+add+slide (16-bits)
	clc
	lda	pt3_envelope_period_l
	adc	pt3_envelope_add
	sta	temp_word_l
	lda	pt3_envelope_period_h
	adc	#0
	sta	temp_word_h

	clc
	lda	pt3_envelope_slide_l
	adc	temp_word_l
;	sta	temp_word_l
	sta	REGISTER_DUMP+11
	lda	temp_word_h
	adc	pt3_envelope_slide_h
;	sta	temp_word_h
	sta	REGISTER_DUMP+12

	; Envelope shape
	lda	pt3_envelope_type
	cmp	pt3_envelope_type_old
	bne	envelope_diff
envelope_same:
	lda	#$ff			; if same, store $ff
envelope_diff:
	sta	REGISTER_DUMP+13

	lda	pt3_envelope_type
	sta	pt3_envelope_type_old	; copy old to new


	lda	pt3_envelope_delay
	beq	done_do_frame		; assume can't be negative?
					; do this if envelope_delay>0
	dec	pt3_envelope_delay
	bne	done_do_frame
					; only do if we hit 0
	lda	pt3_envelope_delay_orig	; reset envelope delay
	sta	pt3_envelope_delay

	clc				; 16-bit add
	lda	pt3_envelope_slide_l
	adc	pt3_envelope_slide_add_l
	sta	pt3_envelope_slide_l
	lda	pt3_envelope_slide_h
	adc	pt3_envelope_slide_add_h
	sta	pt3_envelope_slide_h

done_do_frame:

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


