
	;=====================
	; draw_rain
draw_rain:

	;==========================
	; draw puddles

	lda	#0
	sta	WHICH_DROP
puddle_loop:

	ldx	WHICH_DROP

	lda	puddle_locations_x,X
	bmi	done_puddles
	sta	SPRITE_X
	lda	puddle_locations_y,X
	sta	SPRITE_Y

	lda	FRAME
	and	#$3
	tax
	jsr	hgr_draw_sprite_mask

	inc	WHICH_DROP
	bne	puddle_loop			; bra

done_puddles:


	lda	#0
	sta	WHICH_DROP
rain_loop:
	ldx	WHICH_DROP


	lda	WHICH_RAIN
	bne	rain_loop_dark

rain_loop_light:
	ldy	light_rain_locations_x,X
	bmi	rain_loop_done
	lda	light_rain_locations_y,X
	jmp	rain_loop_common

rain_loop_dark:
	ldy	dark_rain_locations_x,X
	bmi	rain_loop_done
	lda	dark_rain_locations_y,X

rain_loop_common:

	tax

	jsr	draw_rain_drop

	inc	WHICH_DROP
;	lda	WHICH_DROP
;	cmp	#15
	bne	rain_loop

rain_loop_done:

	rts


	;======================
	; draw rain drop
	;======================
	; x-position in Y
	; y-position in X

draw_rain_drop:
;	ldy	#1			; x position
	sty	COUNT

;	ldx	#49			; y position

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
;	ora	rain_sprite1,Y


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


rain_mask1:			;		flip
	.byte $9f		; X 000 0011	X 110 0000
	.byte $8f		; X 000 0111	X 111 0000
	.byte $C7		; X 000 1110	X 011 1000
	.byte $E3		; X 001 1100	X 001 1100
	.byte $F1		; X 011 1000	X 000 1110
	.byte $F8		; X 111 0000	X 000 0111
	.byte $FC		; X 110 0000	X 000 0011



light_rain_locations_x:
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

light_rain_locations_y:
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

dark_rain_locations_x:
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

dark_rain_locations_y:
	.byte	49	;7,49
	.byte	63	;42,63
	.byte	37	;147,37
	.byte	58	;182,58
	.byte	70	;266,70
	.byte	69	;203,69
	.byte	104	;63,104
	.byte	124	;91,124
	.byte	127	;224,127


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


puddle_locations_x:
	.byte 18		; 126,73
	.byte 24		; 168,81
	.byte 30		; 210,74
	.byte 36		; 252,105
	.byte 32		; 224,146
	.byte 16		; 112,157
	.byte  7		; 42,166
	.byte  4		; 28,102
	.byte $ff
puddle_locations_y:
	.byte 73		; 126,73
	.byte 81		; 168,81
	.byte 74		; 210,74
	.byte 105		; 252,105
	.byte 146		; 224,146
	.byte 157		; 112,157
	.byte 166		; 42,166
	.byte 102		; 28,102

