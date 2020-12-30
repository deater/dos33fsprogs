	;==========================
	; draw world map
	;==========================
	; including position

show_map:

	lda     #<(map_lzsa)
	sta     getsrc_smc+1
	lda     #>(map_lzsa)
	sta     getsrc_smc+2

	lda	DRAW_PAGE
	clc
	adc	#$4		; page to load at?
				; FIXME: really need to load at 0xc and
				; copy


	jsr	decompress_lzsa2_fast


	; basic_plot(8+((map_x&0x3)*6)+(tfv_x/6),
	;	8+(((map_x&0xc)>>2)*6)+(tfv_y/6))

	; horizontal

	lda	MAP_X
	and	#3
	asl
	sta	TEMP
	asl
	clc
	adc	TEMP		; ( MAP_X & 3 ) * 6
	sta	TEMP

	lda	TFV_X
	lsr
	lsr
	lsr			; TFV/8

	adc	TEMP
	adc	#8
	sta	CH

	; vertical

	lda	MAP_X
	and	#$c
	lsr
	sta	TEMP
	asl
	clc
	adc	TEMP		; ( MAP_X & C ) * 6
	sta	TEMP

	lda	TFV_Y
	lsr
	lsr
	lsr			; TFV/8

	adc	TEMP
	adc	#8
	lsr			; divide by 2 as htab_vtab multiplies
	sta	CV

;	jsr	htab_vtab

	lda	CV
	asl
	tay
	lda	gr_offsets,Y
	clc
	adc	CH
	sta	BASL

	lda	gr_offsets+1,Y
	sta	BASH

	lda	#$19		; red/orange
	ldy	#0
	sta	(BASL),Y


	jsr	page_flip

	jsr	wait_until_keypressed

	rts
