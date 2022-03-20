

load_music:

	lda	LOAD_NEXT_CHUNK		; see if we need to load next chunk
	beq	no_load_chunk		; outside IRQ to avoid glitch in music

	jsr	load_song_chunk

	lda	#0			; reset
	sta	LOAD_NEXT_CHUNK

no_load_chunk:
	rts



	;========================
	; load song chunk
	;	CURRENT_CHUNK is which one, 0..N
	;	CHUNK_DEST is $D0 or $E8

load_song_chunk:
	ldx	CURRENT_CHUNK

chunk_l_smc:
	lda     $DDDD,X
	sta     getsrc_smc+1	; LZSA_SRC_LO
chunk_h_smc:
	lda     $DDDD,X
	sta     getsrc_smc+2	; LZSA_SRC_HI
	bne	load_song_chunk_good

	; $00 in chunk table means we are off the end, so wrap
;	lda	#$00
	sta	CURRENT_CHUNK		; reset chunk to 0
	beq	load_song_chunk		; try again

load_song_chunk_good:
	lda	CHUNK_NEXT_LOAD		; decompress to $D0 or $E8

	jsr	decompress_lzsa2_fast


	lda	CHUNK_NEXT_LOAD		; point to next location
	eor	#$38
	sta	CHUNK_NEXT_LOAD

	rts

