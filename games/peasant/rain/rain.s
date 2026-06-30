
	;=====================
	;=====================
	; draw_rain
	;=====================
	;=====================

draw_rain:

	;=====================
	; draw puddles
	;=====================

	;=============================
	; select which of 3 locations

	lda	FRAME			; get from FRAME
	and	#$C
	lsr
	lsr
	tax

	lda	puddle_list_x_l,X	; self modify which list
	sta	pl_smc1+1
	lda	puddle_list_x_h,X
	sta	pl_smc1+2

	lda	puddle_list_y_l,X
	sta	pl_smc2+1
	lda	puddle_list_y_h,X
	sta	pl_smc2+2


	;==========================
	; draw puddle loop

	lda	#0				; draw some puddles
	sta	WHICH_DROP
puddle_loop:

	ldx	WHICH_DROP
pl_smc1:
	lda	puddle_locations0_x,X		; get x location
	bmi	done_puddles			; if negative, done
	sta	SPRITE_X
pl_smc2:
	lda	puddle_locations0_y,X		; get y location
	sta	SPRITE_Y

	lda	FRAME				; get which sprite
	and	#$3				; based on FRAME
	tax
	jsr	hgr_draw_sprite_mask		; draw it

	inc	WHICH_DROP			; move to next puddle

	bne	puddle_loop			; bra

done_puddles:


	;=================================
	; draw rain
	;=================================
	; we have two rain frames
	; we have two colors of rain


	lda	FRAME			; see which frame to draw
	and	#1
	beq	rain_frame_even

rain_frame_odd:
	lda	#<light_rain_locations1_x
	sta	rllx_smc+1
	lda	#>light_rain_locations1_x
	sta	rllx_smc+2

	lda	#<dark_rain_locations1_x
	sta	rdlx_smc+1
	lda	#>dark_rain_locations1_x
	sta	rdlx_smc+2

	lda	#<light_rain_locations1_y
	sta	rlly_smc+1
	lda	#>light_rain_locations1_y
	sta	rlly_smc+2

	lda	#<dark_rain_locations1_y
	sta	rdly_smc+1
	lda	#>dark_rain_locations1_y
	sta	rdly_smc+2


	jmp	rain_frame_common

rain_frame_even:
	lda	#<light_rain_locations2_x
	sta	rllx_smc+1
	lda	#>light_rain_locations2_x
	sta	rllx_smc+2

	lda	#<dark_rain_locations2_x
	sta	rdlx_smc+1
	lda	#>dark_rain_locations2_x
	sta	rdlx_smc+2

	lda	#<light_rain_locations2_y
	sta	rlly_smc+1
	lda	#>light_rain_locations2_y
	sta	rlly_smc+2

	lda	#<dark_rain_locations2_y
	sta	rdly_smc+1
	lda	#>dark_rain_locations2_y
	sta	rdly_smc+2

rain_frame_common:

	;=====================================
	; loop through all the light drops first

	lda	#<rain_sprite1
	sta	which_rain_smc+1
	lda	#>rain_sprite1
	sta	which_rain_smc+2

	lda	#0
	sta	WHICH_DROP

rain_loop_light:
	ldx	WHICH_DROP

rllx_smc:
	ldy	light_rain_locations1_x,X
	bmi	rain_loop_light_done
rlly_smc:
	lda	light_rain_locations1_y,X

	tax

	jsr	draw_rain_drop

	inc	WHICH_DROP

	jmp	rain_loop_light

rain_loop_light_done:



	;=====================================
	; loop through all the dark drops next

	lda	#<rain_sprite2
	sta	which_rain_smc+1
	lda	#>rain_sprite2
	sta	which_rain_smc+2

	lda	#0
	sta	WHICH_DROP

rain_loop_dark:
	ldx	WHICH_DROP

rdlx_smc:
	ldy	dark_rain_locations1_x,X
	bmi	rain_loop_dark_done
rdly_smc:
	lda	dark_rain_locations1_y,X

	tax

	jsr	draw_rain_drop

	inc	WHICH_DROP

	jmp	rain_loop_dark

rain_loop_dark_done:


	rts


	;======================
	; draw rain drop
	;======================
	; x-position in Y
	; y-position in X

draw_rain_drop:
	sty	COUNT			; X-position

	ldy	#0			; sprite offset

raindrop_loop:
	lda	hposn_low,X
	clc
	adc	COUNT
	sta	rl_smc1+1
	sta	rl_smc2+1

	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	rl_smc1+2
	sta	rl_smc2+2
rl_smc1:
	lda	$2000				; load screen value

;	eor	rain_sprite1,Y

	and	rain_mask1,Y
which_rain_smc:
	ora	rain_sprite1,Y


rl_smc2:
	sta	$2000				; save back out

	inx
	iny
	cpy	#7
	bne	raindrop_loop

	rts


rain_sprite1:			;		flip
	.byte $60		; X 000 0011	X 110 0000
	.byte $70		; X 000 0111	X 111 0000
	.byte $38		; X 000 1110	X 011 1000
	.byte $1C		; X 001 1100	X 001 1100
	.byte $0E		; X 011 1000	X 000 1110
	.byte $07		; X 111 0000	X 000 0111
	.byte $03		; X 110 0000	X 000 0011

rain_sprite2:			;		flip
	.byte $60		; X 000 0011	X 110 0000
	.byte $00		; X 000 0111	X 111 0000
	.byte $38		; X 000 1110	X 011 1000
	.byte $00		; X 001 1100	X 001 1100
	.byte $0E		; X 011 1000	X 000 1110
	.byte $00		; X 111 0000	X 000 0111
	.byte $03		; X 110 0000	X 000 0011

rain_mask1:			;		flip
	.byte $9f		; X 000 0011	X 110 0000
	.byte $8f		; X 000 0111	X 111 0000
	.byte $C7		; X 000 1110	X 011 1000
	.byte $E3		; X 001 1100	X 001 1100
	.byte $F1		; X 011 1000	X 000 1110
	.byte $F8		; X 111 0000	X 000 0111
	.byte $FC		; X 110 0000	X 000 0011


light_rain_locations1_x:
	.byte 9		; 63,36
	.byte 16	; 112,46
	.byte 27	; 189,26
	.byte 32	; 224,32
	.byte 39	; 273,35
	.byte 36	; 252,81
	.byte 30	; 210,92
	.byte 23	; 161,91
	.byte 18	; 126,84
	.byte 6		; 42,152
	.byte 10	; 70,157
	.byte 18	; 126,158
	.byte 24	; 168,147
	.byte 38	; 266,143
	.byte 32	; 224,166
	.byte $FF

light_rain_locations1_y:
	.byte 36	; 63,36
	.byte 46	; 112,46
	.byte 26	; 189,26
	.byte 32	; 224,32
	.byte 35	; 273,35
	.byte 81	; 252,81
	.byte 92	; 210,92
	.byte 91	; 161,91
	.byte 84	; 126,84
	.byte 152	; 42,152
	.byte 157	; 70,157
	.byte 158	; 126,158
	.byte 147	; 168,147
	.byte 143	; 266,143
	.byte 166	; 224,166

dark_rain_locations1_x:
	.byte	1	;7,49
	.byte	6	;42,63
	.byte	21	;147,37
	.byte	26	;182,58
	.byte	38	;266,70
	.byte	29	;203,69
	.byte	9	;63,104
	.byte	13	;91,124
	.byte	32	;224,127
	.byte	$FF

dark_rain_locations1_y:
	.byte	49	;7,49
	.byte	63	;42,63
	.byte	37	;147,37
	.byte	58	;182,58
	.byte	70	;266,70
	.byte	69	;203,69
	.byte	104	;63,104
	.byte	124	;91,124
	.byte	127	;224,127



light_rain_locations2_x:
	.byte 23	; 161,54
	.byte 27	; 189,59
	.byte 34	; 238,59
	.byte 12	; 84,116
	.byte 16	; 112,123
	.byte 23	; 161,123
	.byte 30	; 210,112
	.byte 37	; 259,130
	.byte $FF

light_rain_locations2_y:
	.byte 54	; 161,54
	.byte 59	; 189,59
	.byte 59	; 238,59
	.byte 116	; 84,116
	.byte 123	; 112,123
	.byte 123	; 161,123
	.byte 112	; 210,112
	.byte 130	; 259,130
	.byte $FF


dark_rain_locations2_x:
	.byte	6	;42,21
	.byte	12	;84,28
	.byte	30	;210,24
	.byte	34	;238,35
	.byte	38	;266,92
	.byte	19	;133,91
	.byte	15	;105,70
	.byte	22	;154,14
	.byte	$FF

dark_rain_locations2_y:
	.byte	21	;42,21
	.byte	28	;84,28
	.byte	24	;209,24
	.byte	35	;238,35
	.byte	92	;266,92
	.byte	91	;133,91
	.byte	70	;105,70
	.byte	14	;154,14


.include "sprites/rain_sprites.inc"

sprites_mask_l:
	.byte	<splash_sprite0,<splash_sprite1,<splash_sprite2,<splash_sprite3

sprites_mask_h:
	.byte	>splash_sprite0,>splash_sprite1,>splash_sprite2,>splash_sprite3

sprites_data_l:
	.byte	<splash_sprite0,<splash_sprite1,<splash_sprite2,<splash_sprite3

sprites_data_h:
	.byte	>splash_sprite0,>splash_sprite1,>splash_sprite2,>splash_sprite3


sprites_xsize:
	.byte	2,2,2,2

sprites_ysize:
	.byte	9,9,9,9


puddle_locations0_x:
	.byte 18		; 126,73
	.byte 24		; 168,81
	.byte 30		; 210,74
	.byte 36		; 252,105
	.byte 32		; 224,146
	.byte 16		; 112,157
	.byte  7		; 42,166
	.byte  4		; 28,102
	.byte $ff
puddle_locations0_y:
	.byte 73		; 126,73
	.byte 81		; 168,81
	.byte 74		; 210,74
	.byte 105		; 252,105
	.byte 146		; 224,146
	.byte 157		; 112,157
	.byte 166		; 42,166
	.byte 102		; 28,102


puddle_locations1_x:
	.byte 0			; 0,67
	.byte 14		; 98,91
	.byte 22		; 154,68
	.byte 30		; 210,77
	.byte 34		; 238,69
	.byte 26		; 182,168
	.byte  7		; 28,140
	.byte $ff
puddle_locations1_y:
	.byte 67		; 0,67
	.byte 91		; 98,91
	.byte 68		; 154,68
	.byte 77		; 210,77
	.byte 69		; 238,69
	.byte 168		; 182,168
	.byte 140		; 28,140


puddle_locations2_x:
	.byte 0			; 0,74
	.byte 12		; 84,73
	.byte 30		; 210,79
	.byte 34		; 238,128
	.byte 18		; 126,113
	.byte 30		; 210,163
	.byte 14		; 98,166
	.byte  2		; 14,165
	.byte $ff

puddle_locations2_y:
	.byte 74		; 0,74
	.byte 73		; 84,73
	.byte 79		; 210,79
	.byte 128		; 238,128
	.byte 113		; 126,113
	.byte 163		; 210,163
	.byte 166		; 98,166
	.byte 165		; 14,165
	.byte $ff


puddle_list_x_l:
	.byte <puddle_locations0_x
	.byte <puddle_locations1_x
	.byte <puddle_locations0_x
	.byte <puddle_locations2_x

puddle_list_x_h:
	.byte >puddle_locations0_x
	.byte >puddle_locations1_x
	.byte >puddle_locations0_x
	.byte >puddle_locations2_x

puddle_list_y_l:
	.byte <puddle_locations0_y
	.byte <puddle_locations1_y
	.byte <puddle_locations0_y
	.byte <puddle_locations2_y

puddle_list_y_h:
	.byte >puddle_locations0_y
	.byte >puddle_locations1_y
	.byte >puddle_locations0_y
	.byte >puddle_locations2_y


