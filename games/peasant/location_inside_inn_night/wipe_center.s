

	; over-writes DRAW screen
	; based on FRAME

wipe_center_to_scene:

	; does reverse, writes it over the scene in progress

	; doesn't wipe the title for some reason?
	; let's say 40x192	192/4 = 48  (half = 96)
	;   2x2		19,21	  8	 92,100
	;   4x4		18,22    16	 88,104
	;   8x8		16,24	 32	 80,112
	;  16x16	12,28	 64	 64,128
	;  24x24	 8,32	 96	 48,144
	;  32x32	 4,36	128	 32,160
	;  40x40	 0,40	160	 16,176
	;  40x48	 0,40	192	  0,192


wipe_center_loop:

	lda	FRAME
	lsr
	tax

	lda	wipe_x1,X
	sta	wipe_x1_smc+1
	lda	wipe_x2,X
	sta	wipe_x2_smc+1
	lda	wipe_y1,X
	sta	wipe_y1_smc+1
	lda	wipe_y2,X
	sta	wipe_y2_smc+1

wipe_y1_smc:
	ldx	#0

wipe_center_yloop:

	lda	hposn_low,X
	sta	wipe_output_smc+1
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	wipe_output_smc+2


	lda	#$0

wipe_x1_smc:
	ldy	#4
wipe_center_xloop:

wipe_output_smc:
	sta	$4000,Y
	iny
wipe_x2_smc:
	cpy	#26
	bne	wipe_center_xloop

	inx
wipe_y2_smc:
	cpx	#191
	bne	wipe_center_yloop


	rts

wipe_x1:
	.byte 0,0,4,8,12,16,18,19
;	.byte 19,18,16,12,8,4,0,0
wipe_x2:
;	.byte 21,22,24,28,32,36,40,40
	.byte 40,40,36,32,28,24,22,21
wipe_y1:
;	.byte 92,88,80,64,48,32,16,0
	.byte 0,16,32,48,64,80,88,92
wipe_y2:
;	.byte 100,104,112,128,144,160,176,192
	.byte 192,176,160,144,128,112,104,100
