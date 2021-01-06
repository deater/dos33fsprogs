
	; Autogenerates code that does interleaved Page0/Page1 lores mode
	; but leaving room for 14 pixels/line of per-scanline color

	; originally 183,589
	; takes roughly 17 + 192*((49*16)+2+46)	+ 15 = 159,776!!!!
	; want to play sound every 15787 cycles (10.1)

	; so every 19 times through loop

	; 11 times should update???

UPDATE_START = $9800

DEFAULT_COLOR	= $0

create_update_type1:
	ldx	#192						; 2
	lda	#<UPDATE_START					; 2
	sta	OUTL						; 3
	lda	#>UPDATE_START					; 2
	sta	OUTH						; 3
	lda	#19						; 2
	sta	FORCE_MUSIC					; 3
							;===========
							;        17
create_update_outer_loop:
	ldy	#48						; 2

create_update_inner_loop:
	lda	one_scanline,Y					; 4+
	sta	(OUTL),Y					; 6
	dey							; 2
	bpl	create_update_inner_loop			; 3
							;============
							;        16

								; -1
	; toggle PAGE0/PAGE1
	txa							; 2
	and	#$1	; ror?					; 2
	clc							; 2
	adc	#$54						; 2
	ldy	#1						; 2
	sta	(OUTL),Y					; 6

	clc							; 2
	lda	#49						; 2
	adc	OUTL						; 3
	sta	OUTL						; 3
	lda	OUTH						; 3
	adc	#0						; 2
	sta	OUTH						; 3

	dec	FORCE_MUSIC					; 5
	bne	no_force_music					; 3
	lda	#19
	sta	FORCE_MUSIC

	txa
	pha

	jsr     play_frame_compressed

	pla
	tax

no_force_music:

	dex							; 2
	bne	create_update_outer_loop			; 3
							;===========
							;	46

								; -1
	ldy	#0						; 2
	lda	#$60						; 2
	sta	(OUTL),Y					; 6

	rts							; 6
							;=============
							;         15





BARS_START = 46

	;============================
	; setup rasterbars
	;===========================
	; from 40 to 168?

	;
	; 22+ NUM*(7+14*(66)+32+11) +5
	;   NUM=128 -> 123,286 /15787 = 8 ... every 16 times
	;   NUM=32 -> 30,838 / 15787 = 2
	;

	; original:
	;	setup_rasterbars_page_smc=4
	;	setup_rasterbars_offset_smc=13
	;	setup_rasterbars_bars_start_smc=46
	;	setup_rasterbars_bars_end_smc=184
	;	setup_rasterbars_start_addr1_smc:=#<(UPDATE_START+(BARS_START*49))
	;	setup_rasterbars_start_addr2_smc:=#<(UPDATE_START+(BARS_START*49))

	; missing:
	;	setup_rasterbars_page_smc=4
	;	setup_rasterbars_offset_smc=2
	;	setup_rasterbars_bars_start_smc=16
	;	setup_rasterbars_bars_end_smc=48
	;	setup_rasterbars_start_addr1_smc:=#<(UPDATE_START+(16*49))
	;	setup_rasterbars_start_addr2_smc:=#<(UPDATE_START+(16*49))


setup_rasterbars:

setup_rasterbars_page_smc:
	lda	#4		; which  page			; 2
	sta	RASTER_PAGE					; 3

setup_rasterbars_bars_start_smc:
	ldx	#BARS_START					; 2
setup_rasterbars_start_addr1_smc:
	lda	#<(UPDATE_START+(BARS_START*49))		; 2
	sta	OUTL						; 3
setup_rasterbars_start_addr2_smc:
	lda	#>(UPDATE_START+(BARS_START*49))		; 2
	sta	OUTH						; 3
	lda	#0						; 2
	sta	FORCE_MUSIC					; 3
							;===========
							;        22
setup_rasterbars_outer_loop:
	ldy	#6						; 2
setup_rasterbars_offset_smc:
	lda	#13						; 2
	sta	RASTER_X					; 3
							;===========
							;	  7
setup_rasterbars_inner_loop:
	txa							; 2
	pha							; 3
	inx							; 2
	txa				; start one earlier	; 2
	lsr							; 2
	lsr							; 2
	and	#$fe						; 2
	tax							; 2
	clc							; 2
	lda	gr_offsets,X					; 4+
	adc	RASTER_X					; 3
	inc	RASTER_X					; 3
	sta	(OUTL),Y					; 6
	iny							; 2
	clc							; 2
	lda	gr_offsets+1,X					; 4
	adc	RASTER_PAGE					; 2
	sta	(OUTL),Y					; 6
	iny							; 2
	iny							; 2
	pla							; 4
	tax							; 2

	cpy	#48						; 2
	bne	setup_rasterbars_inner_loop			; 3
							;============
							;	66

								;-1

	inc	FORCE_MUSIC					; 6
	and	#$f						; 2
	bne	no_music_this_time				; 3
							;===========
							;       11

	txa
	pha
	jsr     play_frame_compressed
	pla
	tax

no_music_this_time:

	clc							; 2
	lda	#49						; 2
	adc	OUTL						; 3
	sta	OUTL						; 3
	lda	OUTH						; 3
	adc	#0						; 2
	sta	OUTH						; 3

	lda	RASTER_PAGE					; 3
	eor	#$04						; 2
	sta	RASTER_PAGE					; 3

	inx							; 2
setup_rasterbars_bars_end_smc:
	cpx	#184						; 2
	bne	setup_rasterbars_outer_loop			; 3
							;============
							;         32
	rts							; -1
								;  6

one_scanline:
.byte	$2C,$54,$C0	; bit	PAGE0	; 4
.byte	$A9,DEFAULT_COLOR		; lda	#$0b	; 2
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$8D,$00,$02	; sta	$200	; 4
.byte	$A5,$FA		; lda	TEMP    ; 3

