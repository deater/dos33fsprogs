
	; Tried only drawing if changed
	; but page flipping means this can go wrong unless we draw to both

put_letters:

	;================
	; First -- Note A
	;================
first_note_a:
	lda	#$bb
	sta	sprite_color_smc+1

	ldx	note_a+NOTE_NOTE
;	cpx	olda
;	beq	first_note_b
;	stx	olda

	clc

	lda	note_lookup_letter,X
	and	#$7f
	adc	#<letter_a
	sta	INL

	lda	#>letter_a
	adc	#0
	sta	INH

	lda	#0
	sta	XPOS
	lda	#2
	sta	YPOS

	jsr	put_sprite

	; second
	clc
	ldx	note_a+NOTE_NOTE
	and	#$80

	bne	sharp_a

	lda	#<letter_none
	sta	INL
	lda	#>letter_none
	sta	INH
	jmp	do_sharp_a

sharp_a:
	lda	#<letter_sharp
	sta	INL
	lda	#>letter_sharp
	sta	INH

do_sharp_a:
	lda	#4
	sta	XPOS
	lda	#2
	sta	YPOS

	jsr	put_sprite

	; third

	clc
	ldx	note_a+NOTE_NOTE
	lda	note_lookup_number,X
	adc	#<number_0
	sta	INL

	lda	#>number_0
	adc	#0
	sta	INH

	lda	#8
	sta	XPOS
	lda	#2
	sta	YPOS

	jsr	put_sprite


	;================
	; First -- Note B
	;================
first_note_b:

	lda	#$22
	sta	sprite_color_smc+1

	ldx	note_b+NOTE_NOTE
;	cpx	oldb
;	beq	first_note_c
;	stx	oldb
	clc

	lda	note_lookup_letter,X
	and	#$7f
	adc	#<letter_a
	sta	INL

	lda	#>letter_a
	adc	#0
	sta	INH

	lda	#14
	sta	XPOS
	lda	#2
	sta	YPOS

	jsr	put_sprite

	; second

	clc
	ldx	note_b+NOTE_NOTE
	and	#$80

	bne	sharp_b

	lda	#<letter_none
	sta	INL
	lda	#>letter_none
	sta	INH
	jmp	do_sharp_b

sharp_b:
	lda	#<letter_sharp
	sta	INL
	lda	#>letter_sharp
	sta	INH

do_sharp_b:
	lda	#18
	sta	XPOS
	lda	#2
	sta	YPOS

	jsr	put_sprite

	; third

	clc
	ldx	note_b+NOTE_NOTE
	lda	note_lookup_number,X
	adc	#<number_0
	sta	INL

	lda	#>number_0
	adc	#0
	sta	INH

	lda	#22
	sta	XPOS
	lda	#2
	sta	YPOS

	jsr	put_sprite



	;================
	; First -- Note C
	;================
first_note_c:

	lda	#$33
	sta	sprite_color_smc+1

	ldx	note_c+NOTE_NOTE
;	cpx	oldc
;	beq	done_print_note
;	stx	oldc

	clc
	lda	note_lookup_letter,X
	and	#$7f
	adc	#<letter_a
	sta	INL

	lda	#>letter_a
	adc	#0
	sta	INH

	lda	#28
	sta	XPOS
	lda	#2
	sta	YPOS

	jsr	put_sprite

	; second

	clc
	ldx	note_c+NOTE_NOTE
	and	#$80

	bne	sharp_c

	lda	#<letter_none
	sta	INL
	lda	#>letter_none
	sta	INH
	jmp	do_sharp_c

sharp_c:
	lda	#<letter_sharp
	sta	INL
	lda	#>letter_sharp
	sta	INH

do_sharp_c:
	lda	#32
	sta	XPOS
	lda	#2
	sta	YPOS

	jsr	put_sprite

	; third

	clc
	ldx	note_c+NOTE_NOTE
	lda	note_lookup_number,X
	adc	#<number_0
	sta	INL

	lda	#>number_0
	adc	#0
	sta	INH

	lda	#36
	sta	XPOS
	lda	#2
	sta	YPOS

	jsr	put_sprite

done_print_note:

	rts

olda:	.byte $00
oldb:	.byte $00
oldc:	.byte $00

LETTER_A_OFFSET=0
LETTER_B_OFFSET=11
LETTER_C_OFFSET=22
LETTER_D_OFFSET=33
LETTER_E_OFFSET=44
LETTER_F_OFFSET=55
LETTER_G_OFFSET=66
SHARP=$80

NUMBER_0_OFFSET=0
NUMBER_1_OFFSET=11
NUMBER_2_OFFSET=22
NUMBER_3_OFFSET=33
NUMBER_4_OFFSET=44
NUMBER_5_OFFSET=55
NUMBER_6_OFFSET=66
NUMBER_7_OFFSET=77
NUMBER_8_OFFSET=88
NUMBER_9_OFFSET=99


letter_a:
	.byte 3,3
	.byte $f0,$0f,$f0
	.byte $ff,$0f,$ff
	.byte $ff,$00,$ff

letter_b:
	.byte 3,3
	.byte $ff,$0f,$f0
	.byte $ff,$0f,$f0
	.byte $ff,$f0,$0f

letter_c:
	.byte 3,3
	.byte $f0,$0f,$0f
	.byte $ff,$00,$00
	.byte $0f,$f0,$f0

letter_d:
	.byte 3,3
	.byte $ff,$0f,$f0
	.byte $ff,$00,$ff
	.byte $ff,$f0,$0f

letter_e:
	.byte 3,3
	.byte $ff,$0f,$0f
	.byte $ff,$0f,$00
	.byte $ff,$f0,$f0

letter_f:
	.byte 3,3
	.byte $ff,$0f,$0f
	.byte $ff,$0f,$00
	.byte $ff,$00,$00

letter_g:
	.byte 3,3
	.byte $f0,$0f,$0f
	.byte $ff,$00,$f0
	.byte $0f,$f0,$ff

letter_sharp:
	.byte 3,3
	.byte $ff,$f0,$ff
	.byte $ff,$f0,$ff
	.byte $0f,$00,$0f

letter_none:
	.byte 3,3
	.byte $00,$00,$00
	.byte $00,$00,$00
	.byte $00,$00,$00

number_0:
	.byte 3,3
	.byte $ff,$0f,$ff
	.byte $ff,$00,$ff
	.byte $ff,$f0,$ff

number_1:
	.byte 3,3
	.byte $00,$ff,$00
	.byte $00,$ff,$00
	.byte $00,$ff,$00

number_2:
	.byte 3,3
	.byte $0f,$0f,$ff
	.byte $ff,$0f,$0f
	.byte $ff,$f0,$f0

number_3:
	.byte 3,3
	.byte $0f,$0f,$ff
	.byte $0f,$0f,$ff
	.byte $f0,$f0,$ff

number_4:
	.byte 3,3
	.byte $ff,$00,$ff
	.byte $0f,$0f,$ff
	.byte $00,$00,$ff

number_5:
	.byte 3,3
	.byte $ff,$0f,$0f
	.byte $0f,$0f,$ff
	.byte $f0,$f0,$ff


number_6:
	.byte 3,3
	.byte $ff,$0f,$0f
	.byte $ff,$0f,$f0
	.byte $ff,$f0,$ff

number_7:
	.byte 3,3
	.byte $0f,$0f,$ff
	.byte $00,$00,$ff
	.byte $00,$00,$ff

number_8:
	.byte 3,3
	.byte $ff,$0f,$ff
	.byte $ff,$0f,$ff
	.byte $ff,$f0,$ff

number_9:
	.byte 3,3
	.byte $ff,$0f,$ff
	.byte $0f,$0f,$ff
	.byte $00,$00,$ff



note_lookup_letter:

;        "C-1","C#1","D-1","D#1","E-1","F-1","F#1","G-1", // 50
;        "G#1","A-1","A#1","B-1",
; 1
.byte	LETTER_C_OFFSET,LETTER_C_OFFSET|SHARP
.byte	LETTER_D_OFFSET,LETTER_D_OFFSET|SHARP
.byte	LETTER_E_OFFSET
.byte	LETTER_F_OFFSET,LETTER_F_OFFSET|SHARP
.byte	LETTER_G_OFFSET,LETTER_G_OFFSET|SHARP
.byte	LETTER_A_OFFSET,LETTER_A_OFFSET|SHARP
.byte	LETTER_B_OFFSET
; 2
.byte	LETTER_C_OFFSET,LETTER_C_OFFSET|SHARP
.byte	LETTER_D_OFFSET,LETTER_D_OFFSET|SHARP
.byte	LETTER_E_OFFSET
.byte	LETTER_F_OFFSET,LETTER_F_OFFSET|SHARP
.byte	LETTER_G_OFFSET,LETTER_G_OFFSET|SHARP
.byte	LETTER_A_OFFSET,LETTER_A_OFFSET|SHARP
.byte	LETTER_B_OFFSET
; 3
.byte	LETTER_C_OFFSET,LETTER_C_OFFSET|SHARP
.byte	LETTER_D_OFFSET,LETTER_D_OFFSET|SHARP
.byte	LETTER_E_OFFSET
.byte	LETTER_F_OFFSET,LETTER_F_OFFSET|SHARP
.byte	LETTER_G_OFFSET,LETTER_G_OFFSET|SHARP
.byte	LETTER_A_OFFSET,LETTER_A_OFFSET|SHARP
.byte	LETTER_B_OFFSET
; 4
.byte	LETTER_C_OFFSET,LETTER_C_OFFSET|SHARP
.byte	LETTER_D_OFFSET,LETTER_D_OFFSET|SHARP
.byte	LETTER_E_OFFSET
.byte	LETTER_F_OFFSET,LETTER_F_OFFSET|SHARP
.byte	LETTER_G_OFFSET,LETTER_G_OFFSET|SHARP
.byte	LETTER_A_OFFSET,LETTER_A_OFFSET|SHARP
.byte	LETTER_B_OFFSET
; 5
.byte	LETTER_C_OFFSET,LETTER_C_OFFSET|SHARP
.byte	LETTER_D_OFFSET,LETTER_D_OFFSET|SHARP
.byte	LETTER_E_OFFSET
.byte	LETTER_F_OFFSET,LETTER_F_OFFSET|SHARP
.byte	LETTER_G_OFFSET,LETTER_G_OFFSET|SHARP
.byte	LETTER_A_OFFSET,LETTER_A_OFFSET|SHARP
.byte	LETTER_B_OFFSET
; 6
.byte	LETTER_C_OFFSET,LETTER_C_OFFSET|SHARP
.byte	LETTER_D_OFFSET,LETTER_D_OFFSET|SHARP
.byte	LETTER_E_OFFSET
.byte	LETTER_F_OFFSET,LETTER_F_OFFSET|SHARP
.byte	LETTER_G_OFFSET,LETTER_G_OFFSET|SHARP
.byte	LETTER_A_OFFSET,LETTER_A_OFFSET|SHARP
.byte	LETTER_B_OFFSET
; 7
.byte	LETTER_C_OFFSET,LETTER_C_OFFSET|SHARP
.byte	LETTER_D_OFFSET,LETTER_D_OFFSET|SHARP
.byte	LETTER_E_OFFSET
.byte	LETTER_F_OFFSET,LETTER_F_OFFSET|SHARP
.byte	LETTER_G_OFFSET,LETTER_G_OFFSET|SHARP
.byte	LETTER_A_OFFSET,LETTER_A_OFFSET|SHARP
.byte	LETTER_B_OFFSET
; 8
.byte	LETTER_C_OFFSET,LETTER_C_OFFSET|SHARP
.byte	LETTER_D_OFFSET,LETTER_D_OFFSET|SHARP
.byte	LETTER_E_OFFSET
.byte	LETTER_F_OFFSET,LETTER_F_OFFSET|SHARP
.byte	LETTER_G_OFFSET,LETTER_G_OFFSET|SHARP
.byte	LETTER_A_OFFSET,LETTER_A_OFFSET|SHARP
.byte	LETTER_B_OFFSET

note_lookup_number:
; 1
.byte	NUMBER_1_OFFSET,NUMBER_1_OFFSET,NUMBER_1_OFFSET
.byte	NUMBER_1_OFFSET,NUMBER_1_OFFSET,NUMBER_1_OFFSET
.byte	NUMBER_1_OFFSET,NUMBER_1_OFFSET,NUMBER_1_OFFSET
.byte	NUMBER_1_OFFSET,NUMBER_1_OFFSET,NUMBER_1_OFFSET
; 2
.byte	NUMBER_2_OFFSET,NUMBER_2_OFFSET,NUMBER_2_OFFSET
.byte	NUMBER_2_OFFSET,NUMBER_2_OFFSET,NUMBER_2_OFFSET
.byte	NUMBER_2_OFFSET,NUMBER_2_OFFSET,NUMBER_2_OFFSET
.byte	NUMBER_2_OFFSET,NUMBER_2_OFFSET,NUMBER_2_OFFSET
; 3
.byte	NUMBER_3_OFFSET,NUMBER_3_OFFSET,NUMBER_3_OFFSET
.byte	NUMBER_3_OFFSET,NUMBER_3_OFFSET,NUMBER_3_OFFSET
.byte	NUMBER_3_OFFSET,NUMBER_3_OFFSET,NUMBER_3_OFFSET
.byte	NUMBER_3_OFFSET,NUMBER_3_OFFSET,NUMBER_3_OFFSET
; 4
.byte	NUMBER_4_OFFSET,NUMBER_4_OFFSET,NUMBER_4_OFFSET
.byte	NUMBER_4_OFFSET,NUMBER_4_OFFSET,NUMBER_4_OFFSET
.byte	NUMBER_4_OFFSET,NUMBER_4_OFFSET,NUMBER_4_OFFSET
.byte	NUMBER_4_OFFSET,NUMBER_4_OFFSET,NUMBER_4_OFFSET
; 5
.byte	NUMBER_5_OFFSET,NUMBER_5_OFFSET,NUMBER_5_OFFSET
.byte	NUMBER_5_OFFSET,NUMBER_5_OFFSET,NUMBER_5_OFFSET
.byte	NUMBER_5_OFFSET,NUMBER_5_OFFSET,NUMBER_5_OFFSET
.byte	NUMBER_5_OFFSET,NUMBER_5_OFFSET,NUMBER_5_OFFSET
; 6
.byte	NUMBER_6_OFFSET,NUMBER_6_OFFSET,NUMBER_6_OFFSET
.byte	NUMBER_6_OFFSET,NUMBER_6_OFFSET,NUMBER_6_OFFSET
.byte	NUMBER_6_OFFSET,NUMBER_6_OFFSET,NUMBER_6_OFFSET
.byte	NUMBER_6_OFFSET,NUMBER_6_OFFSET,NUMBER_6_OFFSET
; 7
.byte	NUMBER_7_OFFSET,NUMBER_7_OFFSET,NUMBER_7_OFFSET
.byte	NUMBER_7_OFFSET,NUMBER_7_OFFSET,NUMBER_7_OFFSET
.byte	NUMBER_7_OFFSET,NUMBER_7_OFFSET,NUMBER_7_OFFSET
.byte	NUMBER_7_OFFSET,NUMBER_7_OFFSET,NUMBER_7_OFFSET
; 8
.byte	NUMBER_8_OFFSET,NUMBER_8_OFFSET,NUMBER_8_OFFSET
.byte	NUMBER_8_OFFSET,NUMBER_8_OFFSET,NUMBER_8_OFFSET
.byte	NUMBER_8_OFFSET,NUMBER_8_OFFSET,NUMBER_8_OFFSET
.byte	NUMBER_8_OFFSET,NUMBER_8_OFFSET,NUMBER_8_OFFSET







