	;====================================
	; generate 4 patterns worth of music
	; at address $D000-$FC00

pt3_write_lc_4:

	; page offset
	lda	#0
	sta	FRAME_PAGE

lc4_frame_decode_loop:

	jsr	pt3_set_pages

	jsr	pt3_write_lc

	lda	FRAME_PAGE
	cmp	#4
	bne	lc4_frame_decode_loop

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

	lda	FRAME_OFFSET
	cmp	#59*3			; FIXME: make this depend on song
					; hardcoding for 59 for our song
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
.byte $f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8,$f9,$fa,$fb,$BB,$CC,$DD,$EE,$FF
.byte $e6,$e7,$e8,$e9,$ea,$eb,$ec,$ed,$ee,$ef,$f0,$BB,$CC,$DD,$EE,$FF
.byte $db,$dc,$dd,$de,$df,$e0,$e1,$e2,$e3,$e4,$e5,$BB,$CC,$DD,$EE,$FF
.byte $d0,$d1,$d2,$d3,$d4,$d5,$d6,$d7,$d8,$d9,$da,$BB,$CC,$DD,$EE,$FF
.byte $d0,$d1,$d2,$d3,$d4,$d5,$d6,$d7,$d8,$d9,$da,$BB,$CC,$DD,$EE,$FF
music_table_end:

.assert >music_table_begin = >music_table_end, error, "music_table crosses page"


