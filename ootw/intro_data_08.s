; background graphics

.include "intro_graphics/08_lightning/lightning.inc"


	; Lightning sequence
lightning_sequence:
	; 125 start
	; 126, small central lightning 1,2,3,4
	;
	.byte 100
	.word storm01_rle
	.byte 7
	.word storm02_rle
	.byte 7
	.word storm03_rle
	.byte 7
	.word storm04_rle
	.byte 7
	; 128.2 center glow in cloud 5,6,5
	;
	.word nothing_rle
	.byte 100
	.word storm05_rle
	.byte 7
	.word storm06_rle
	.byte 7
	.word storm05_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 128.7 inverse flash
	;
	.word flash_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 129.6 center left glow in cloud 8
	;
	.word storm08_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 130.1 glow in cloud, right 9
	;
	.word storm09_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 130.4 glow in cloud, right 10
	;
	.word storm10_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 131.7 small glow, center right 11,12
	;
	.word storm11_rle
	.byte 7
	.word storm12_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 133.5 lightning bolt right 13,14,15,16
	;
	.word storm13_rle
	.byte 7
	.word storm14_rle
	.byte 7
	.word storm15_rle
	.byte 7
	.word storm16_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 134.7 glow center left 8
	;
	.word storm08_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 135.2 small glow center 5,6,5
	;
	.word storm05_rle
	.byte 7
	.word storm06_rle
	.byte 7
	.word storm05_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 135.4 inverse flash
	;
	.word flash_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 135.8 another inverse flash
	;
	.word flash_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 135.5 glow right 9
	;
	.word storm09_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 136 small glow right 0
	;
	.word storm10_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 138.6 cloud glow 12,11,12
	;
	.word storm12_rle
	.byte 7
	.word storm11_rle
	.byte 7
	.word storm12_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 139.6 small bolt center 1,2,3,4
	;
	.word storm01_rle
	.byte 7
	.word storm02_rle
	.byte 7
	.word storm03_rle
	.byte 7
	.word storm04_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 141.4 right glow in cloud 10
	;
	.word storm10_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 143 glow in center 5,6,5
	;
	.word storm05_rle
	.byte 7
	.word storm06_rle
	.byte 7
	.word storm05_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 144.8 glow left 8
	;
	.word storm08_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 145.7 center glow cloud 11,12
	;
	.word storm11_rle
	.byte 7
	.word storm12_rle
	.byte 7
	.word nothing_rle
	.byte 0
;	.word nothing_rle

	;==============
	; split, as was > 256

bolt_sequence:
	.byte 80
	;=======================
	; 147 bolt right
	;=======================
	;	13,14,15
	.word storm13_rle
	.byte 128+5	;	.word storm14_rle
	.byte 128+5	;	.word storm15_rle
	.byte 5
	; 	screen goes white
	;	*all white
	.word white_rle
	.byte 8
	;	lightning animation
	;	* bolt1, 2,3,4,5,6,7
	.word bolt1_rle
	.byte 128+5	;	.word bolt2_rle
	.byte 128+5	;	.word bolt3_rle
	.byte 128+5	;	.word bolt4_rle
	.byte 128+5	;	.word bolt5_rle
	.byte 128+5	;	.word bolt6_rle
	.byte 128+5	;	.word bolt7_rle
	.byte 5
	;	* all white (a while)
	.word white_rle
	; 	* all black (a while)
	.word 128+30,black_rle
	.byte 30
	; 148.3 big bolt behind car
	;	29 .. 38, 40.. 42 (38 twice as long?)
	.word storm29_rle
	.byte 128+5	;	.word storm30_rle
	.byte 128+5	;	.word storm31_rle
	.byte 128+5	;	.word storm32_rle
	.byte 128+5	;	.word storm33_rle
	.byte 128+5	;	.word storm34_rle
	.byte 128+5	;	.word storm35_rle
	.byte 128+5	;	.word storm36_rle
	.byte 128+5	;	.word storm37_rle
	.byte 128+5	;	.word storm38_rle
	.byte 128+5	;	.word storm40_rle
	.byte 128+5	;	.word storm41_rle
	.byte 128+5	;	.word storm42_rle
	.byte 5
	; by 150 faded out and on to tunnel
	.word nothing_rle
	.byte 0
;	.word nothing_rle



