;===============================
;===============================
; Thunderstorm Outside
;===============================
;===============================
; thunderbolt and lightning
; very vey frightning

intro_08_lightning:

thunderstorm:

	lda	#<(intro_building_car_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(intro_building_car_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current
	jsr	page_flip
	bit	FULLGR

	lda	#<lightning_sequence
	sta	INTRO_LOOPL
	lda	#>lightning_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	lda	#<bolt_sequence
	sta	INTRO_LOOPL
	lda	#>bolt_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

;outside_loop:
;	lda	KEYPRESS
;	bpl	outside_loop
;	bit	KEYRESET


	rts


;=================================
;=================================
; Intro Segment 08 Data (Lightning)
;=================================
;=================================

.include "graphics/08_lightning/lightning.inc"
;.include "graphics/01_building/intro_building_car.inc"

	; Lightning sequence
lightning_sequence:
	; 125 start
	; 126, small central lightning 1,2,3,4
	;
	.byte 100
	.word storm01_lzsa
	.byte 7
	.word storm02_lzsa
	.byte 7
	.word storm03_lzsa
	.byte 7
	.word storm04_lzsa
	.byte 7
	; 128.2 center glow in cloud 5,6,5
	;
	.word nothing_lzsa
	.byte 100
	.word storm05_lzsa
	.byte 7
	.word storm06_lzsa
	.byte 7
	.word storm05_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 40
	; 128.7 inverse flash
	;
	.word flash_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 40
	; 129.6 center left glow in cloud 8
	;
	.word storm08_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 40
	; 130.1 glow in cloud, right 9
	;
	.word storm09_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 40
	; 130.4 glow in cloud, right 10
	;
	.word storm10_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 80
	; 131.7 small glow, center right 11,12
	;
	.word storm11_lzsa
	.byte 7
	.word storm12_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 80
	; 133.5 lightning bolt right 13,14,15,16
	;
	.word storm13_lzsa
	.byte 7
	.word storm14_lzsa
	.byte 7
	.word storm15_lzsa
	.byte 7
	.word storm16_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 80
	; 134.7 glow center left 8
	;
	.word storm08_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 40
	; 135.2 small glow center 5,6,5
	;
	.word storm05_lzsa
	.byte 7
	.word storm06_lzsa
	.byte 7
	.word storm05_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 40
	; 135.4 inverse flash
	;
	.word flash_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 40
	; 135.8 another inverse flash
	;
	.word flash_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 40
	; 135.5 glow right 9
	;
	.word storm09_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 40
	; 136 small glow right 0
	;
	.word storm10_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 80
	; 138.6 cloud glow 12,11,12
	;
	.word storm12_lzsa
	.byte 7
	.word storm11_lzsa
	.byte 7
	.word storm12_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 80
	; 139.6 small bolt center 1,2,3,4
	;
	.word storm01_lzsa
	.byte 7
	.word storm02_lzsa
	.byte 7
	.word storm03_lzsa
	.byte 7
	.word storm04_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 80
	; 141.4 right glow in cloud 10
	;
	.word storm10_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 80
	; 143 glow in center 5,6,5
	;
	.word storm05_lzsa
	.byte 7
	.word storm06_lzsa
	.byte 7
	.word storm05_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 80
	; 144.8 glow left 8
	;
	.word storm08_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 80
	; 145.7 center glow cloud 11,12
	;
	.word storm11_lzsa
	.byte 7
	.word storm12_lzsa
	.byte 7
	.word nothing_lzsa
	.byte 0
;	.word nothing_lzsa

	;==============
	; split, as was > 256

bolt_sequence:
	.byte 80
	;=======================
	; 147 bolt right
	;=======================
	;	13,14,15
	.word storm13_lzsa
	.byte 128+5	;	.word storm14_lzsa
	.byte 128+5	;	.word storm15_lzsa
	.byte 5
	; 	screen goes white
	;	*all white
	.word white_lzsa
	.byte 8
	;	lightning animation
	;	* bolt1, 2,3,4,5,6,7
	.word bolt1_lzsa
	.byte 128+5	;	.word bolt2_lzsa
	.byte 128+5	;	.word bolt3_lzsa
	.byte 128+5	;	.word bolt4_lzsa
	.byte 128+5	;	.word bolt5_lzsa
	.byte 128+5	;	.word bolt6_lzsa
	.byte 128+5	;	.word bolt7_lzsa
	.byte 5
	;	* all white (a while)
	.word white_lzsa
	; 	* all black (a while)
	.word 128+30,black_lzsa
	.byte 30
	; 148.3 big bolt behind car
	;	29 .. 38, 40.. 42 (38 twice as long?)
	.word storm29_lzsa
	.byte 128+5	;	.word storm30_lzsa
	.byte 128+5	;	.word storm31_lzsa
	.byte 128+5	;	.word storm32_lzsa
	.byte 128+5	;	.word storm33_lzsa
	.byte 128+5	;	.word storm34_lzsa
	.byte 128+5	;	.word storm35_lzsa
	.byte 128+5	;	.word storm36_lzsa
	.byte 128+5	;	.word storm37_lzsa
	.byte 128+5	;	.word storm38_lzsa
	.byte 128+5	;	.word storm40_lzsa
	.byte 128+5	;	.word storm41_lzsa
	.byte 128+5	;	.word storm42_lzsa
	.byte 5
	; by 150 faded out and on to tunnel
	.word nothing_lzsa
	.byte 0
;	.word nothing_lzsa




