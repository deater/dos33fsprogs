	;====================================
	; generate 4 patterns worth of music
	; at address $7000-$FC00

pt3_write_lc_4:

	; page offset
	lda	#0
	sta	FRAME_PAGE

lc4_frame_decode_loop:

	jsr	pt3_set_pages

	jsr	pt3_write_lc

	lda	FRAME_PAGE
	cmp	#8
	bne	lc4_frame_decode_loop

	rts

pt3_write_lc_9:

	; page offset
	lda	#0
	sta	FRAME_PAGE

lc9_frame_decode_loop:

	jsr	pt3_set_pages

	jsr	pt3_write_lc

	lda	FRAME_PAGE
	cmp	#9
	bne	lc9_frame_decode_loop

	rts


	;==============================
	; write one page of frame data
pt3_write_lc_1:

	; page offset
	lda	#0
	sta	FRAME_PAGE

	jsr	pt3_set_pages

	jsr	pt3_write_lc

	rts



	;==============================
	; write one page of frame data

pt3_write_lc:

	; offset within page
	lda	#0
	sta	FRAME_OFFSET

lc_frame_decode_loop:
	jsr	pt3_make_frame

	jsr	pt3_write_frame

	inc	FRAME_OFFSET

	lda	SOUND_WHILE_DECODE
	beq	no_play_music

	lda	FRAME_OFFSET
	and	#$7
	bne	no_play_music

	jsr	play_frame_compressed

no_play_music:
	lda	FRAME_OFFSET
	cmp	#63*4			; FIXME: make this depend on song
					; hardcoding for 63 for our song
	bne	lc_frame_decode_loop

	inc	FRAME_PAGE

	rts

	;========================
	;
pt3_set_pages:
	lda	FRAME_PAGE
	asl
	asl
	asl
	asl
	tay

	lda	music_addr_table+0,Y
	sta	r0_wrsmc+2

	lda	music_addr_table+1,Y
	sta	r1_wrsmc+2

	lda	music_addr_table+2,Y
	sta	r2_wrsmc+2

	lda	music_addr_table+3,Y
	sta	r4_wrsmc+2

	lda	music_addr_table+4,Y		;5+13=D4
	sta	r13_wrsmc+2

	lda	music_addr_table+5,Y
	sta	r6_wrsmc+2

	lda	music_addr_table+6,Y
	sta	r7_wrsmc+2

	lda	music_addr_table+7,Y
	sta	r8_wrsmc+2

	lda	music_addr_table+8,Y
	sta	r9_wrsmc+2

	lda	music_addr_table+9,Y
	sta	r11_wrsmc+2

	lda	music_addr_table+10,Y
	sta	r12_wrsmc+2

	rts

.align $100
music_table_begin:

music_addr_table:

.byte $91,$92,$93,$94,$95,$96,$97,$98,$99,$9a,$9b,$BB,$CC,$DD,$EE,$FF	;0
.byte $86,$87,$88,$89,$8a,$8b,$8c,$8d,$8e,$8f,$90,$BB,$CC,$DD,$EE,$FF	;1
.byte $7b,$7c,$7d,$7e,$7f,$80,$81,$82,$83,$84,$85,$BB,$CC,$DD,$EE,$FF	;2
.byte $70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7a,$BB,$CC,$DD,$EE,$FF	;3
.byte $bd,$be,$bf,$10,$11,$12,$13,$14,$15,$16,$17,$BB,$CC,$DD,$EE,$FF	;4
.byte $b2,$b3,$b4,$b5,$b6,$b7,$b8,$b9,$ba,$bb,$bc,$BB,$CC,$DD,$EE,$FF	;5
.byte $a7,$a8,$a9,$aa,$ab,$ac,$ad,$ae,$af,$b0,$b1,$BB,$CC,$DD,$EE,$FF	;6
.byte $9c,$9d,$9e,$9f,$a0,$A1,$a2,$a3,$a4,$a5,$a6,$BB,$CC,$DD,$EE,$FF	;7
;.byte $40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$BB,$CC,$DD,$EE,$FF	;8
;.byte $35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$BB,$CC,$DD,$EE,$FF	;9
;.byte $d0,$d1,$d2,$d3,$d4,$d5,$d6,$d7,$d8,$d9,$da,$BB,$CC,$DD,$EE,$FF
music_table_end:

.assert >music_table_begin = >music_table_end, error, "music_table crosses page"


