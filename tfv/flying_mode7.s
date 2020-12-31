;===========================
; Draw the Mode7 Background
;===========================

; opening screen, original code
;	2d070 cycles = 184,432 = 5.4 fps
;	2da70 cycles (added in 2 cycle cpx)  a00 = 2560, yes, 32*40=1280
;	2aec3 cycles (update inner loop) = 175,811 = 5.7 fps
;	29af5 cycles (move things around) = 170,741 = 5.85 fps

;	flying_loop -> check_done	2040 - 214f		2E
;
;	check_done -> draw_background	214f - 219b		2E
;
;	draw_background -> check_over_water	219b - 219e	298ad
;
;	check_over_water -> no_splash	219e - 21d0		5b
;
;	no_splash -> done_flying_loop	21d0 - 229b		aa4




draw_background_mode7:

	; setup initial odd/even color mask
	lda	#$f0							; 2
	sta	COLOR_MASK						; 3

	; start Y at 8 (below horizon line)
	lda	#8							; 2
	sta	SCREEN_Y						; 3
								;=============
								;	 10

screeny_loop:
	and	#$fe		; be sure SCREEN_Y used later is even	; 2
	tay			; put in Y for lookup table later	; 2

	lda	COLOR_MASK	; flip mask for odd/even row plotting	; 3
	eor	#$ff							; 2
	sta	COLOR_MASK						; 3
	sta	mask_label+1	; setup self-modifying code		; 4

	bpl	odd_branch	; smc for even/odd line			; 2nt/3
	lda	#$1d		; ora abs,X opcode is $1d		; 2
	bne	ok_branch	; bra					; 3
odd_branch:
	lda	#$2c		; bit is $2c				; 2
ok_branch:
	sta	innersmc1	; actually update ora/bit		; 4
								;============
								;	 ?27

setup_gr_addr:
	lda	gr_offsets,Y	; lookup low-res memory row address	; 4
	sta	innersmc1+1	; smc low addr				; 4
	sta	innersmc2+1	; smc low addr				; 4

	lda	gr_offsets+1,Y	; load high part of address		; 4
	clc			; clear carry for add			; 2
	adc	DRAW_PAGE       ; add in draw page offset               ; 3
	sta	innersmc1+2	; smc high addr				; 4
	sta	innersmc2+2	; smc high addr				; 4

								;=============
								;	 29

calc_horizontal_scale:

	; Calculate the horizontal scale using a lookup table

	; horizontal_scale.i *ALWAYS* = 0

	;	unsigned char horizontal_lookup[7][32];
	;horizontal_scale.f=
	;	horizontal_lookup[space_z.i&0xf][(screen_y-8)/2];
	;		horizontal_lookup[(space_z<<5)+(screen_y-8)]


	clc								; 2
	lda	SCREEN_Y						; 3
spacez_shifted:
	adc	#0	; self-modify, loads (spacez<<5)-8		; 2
	tay								; 2
	lda	horizontal_lookup,Y					; 4
	sta	NUM1L	; HORIZ_SCALE_F is input to next mul		; 3
								;============
								;	 16

; mul2
	; calculate the distance of the line we are drawing
	; fixed_mul(&horizontal_scale,&scale,&distance);
	lda	#0	; HORIZ_SCALE_I is always zero			; 2
	sta	NUM1H							; 3
	; NUM1L was set to HORIZ_SCALE_F previously			;
	lda	#CONST_SCALE_I	; SCALE_I				; 2
	sta	NUM2H							; 3
	lda	#CONST_SCALE_F	; SCALE_F				; 2
	sta	NUM2L							; 3
	sec			; don't reuse previous settings		; 2
	jsr	multiply						; 6
	stx	DISTANCE_I						; 2
	sta	DISTANCE_F						; 2
								;==========
								;	 27

	; calculate the dx and dy to add to points in space
	; we add to the starting values on each row to get the next
	; space values

	; dx.i=fixed_sin[(angle+8)&0xf].i	// -sin()
	lda	ANGLE							; 3
	clc								; 2
	adc	#8							; 2
	and	#$f							; 2
	asl								; 2
	tay								; 2
	lda	fixed_sin,Y	; load integer half			; 4
	sta	NUM2H		; use as source in upcomnig mul		; 3


	; dx.f=fixed_sin[(angle+8)&0xf].f; 	// -sin()
	iny			; point to float half			; 2
	lda	fixed_sin,Y	; load it from lookup table		; 4
	sta	NUM2L		; use as source in upcoming mul		; 3
								;==========
								;	 29

;mul3
	; fixed_mul(&dx,&horizontal_scale,&dx);

				; DX_I:DX_F already set in NUM2H:NUM2L
	clc			; reuse HORIZ_SCALE in NUM1		; 2
	jsr	multiply						; 6
	stx	DX_I							; 3
	sta	DX_F							; 3
								;==========
								;	 14

	; dy.i=fixed_sin[(angle+4)&0xf].i; // cos()

	lda	ANGLE							; 3
	clc								; 2
	adc	#4							; 2
	and	#$f							; 2
	asl								; 2
	tay								; 2
	lda	fixed_sin,Y	; load integer half			; 4
	sta	NUM2H		; use as source in upcoming mul		; 3

	; dy.f=fixed_sin[(angle+4)&0xf].f; // cos()

	iny			; point to float half			; 2
	lda	fixed_sin,Y	; load from lookup table		; 4
	sta	NUM2L		; use as source in upcoming mul		; 3
								;==========
								;	 29
;mul4
	; fixed_mul(&dy,&horizontal_scale,&dy);

				; DY_I:DY_F already in NUM2H:NUM2L
	clc			; reuse horiz_scale in num1		; 2
	jsr	multiply						; 6
	stx	DY_I							; 3
	sta	DY_F							; 3
								;==========
								;	 14

	;=================================
	; calculate the starting position
	;=================================

			; fixed_add(&distance,&factor,&space_x);
	clc		; fixed_add(&distance,&factor,&space_y);	; 2
	lda	DISTANCE_F						; 3
	adc	FACTOR_F						; 3
	sta	SPACEY_F						; 3
	sta	SPACEX_F						; 3

	lda	DISTANCE_I						; 3
	adc	FACTOR_I						; 3
	sta	SPACEY_I						; 3
	sta	SPACEX_I						; 3
								;==========
								;	 26


	; temp.i=fixed_sin[(angle+4)&0xf].i; // cos()

	lda	ANGLE							; 3
	clc								; 2
	adc	#4							; 2
	and	#$f							; 2
	asl								; 2
	tay								; 2
	lda	fixed_sin,Y						; 4
	sta	NUM2H	; store as source for next mul			; 3


	; temp.f=fixed_sin[(angle+4)&0xf].f; // cos()
	iny								; 2
	lda	fixed_sin,Y						; 4
	sta	NUM2L	; store as source for next mul			; 3
								;==========
								;	 29

; mul5
	; fixed_mul(&space_x,&temp,&space_x);
	lda	SPACEX_I						; 3
	sta	NUM1H							; 3
	lda	SPACEX_F						; 3
	sta	NUM1L							; 3
			; NUM2H:NUM2L already set above
	sec		; don't reuse previous NUM1			; 2
	jsr	multiply						; 6
			; SPACEX_I in X					;
			; SPACEX_F in A					;
								;==========
								;	 20

	; fixed_add(&space_x,&cx,&space_x);
	clc								; 2
			; SPACEX_F still in A				;
	adc	CX_F							; 3
	sta	SPACEX_F						; 3
	txa		; SPACEX_I was in X				; 2
	adc	CX_I							; 3
	sta	SPACEX_I						; 3
								;===========
								;	 16


	; temp.i=fixed_sin[angle&0xf].i; // sin()
	lda	ANGLE							; 3
	and	#$f							; 2
	asl								; 2
	tay								; 2
	lda	fixed_sin,Y						; 4
	sta	NUM2H		; store for next mul			; 3

	; fixed_temp.f=fixed_sin[angle&0xf].f; // sin()
	iny								; 2
	lda	fixed_sin,Y						; 4
	sta	NUM2L		; store for next mul			; 3
								;==========
								;	 25

;mul6
	; fixed_mul(&space_y,&fixed_temp,&space_y);
	lda	SPACEY_I						; 3
	sta	NUM1H							; 3
	lda	SPACEY_F						; 3
	sta	NUM1L							; 3
				; NUM2H:NUM2L already set
	sec			; don't reuse previous num1		; 2
	jsr	multiply						; 6
				; SPACEY_I in X				;
				; SPACEY_F in A				;
								;==========
								;	 20

	; fixed_add(&space_y,&cy,&space_y);
	clc								; 2
				; SPACEY_F in A
	adc	CY_F							; 3
	sta	SPACEY_F						; 3
	txa			; SPACEY_I in X				; 2
	adc	CY_I							; 3
	sta	SPACEY_I						; 3
								;==========
								;	 16
; mul7
	; fixed_mul(&lowres_half,&dx,&temp);
	lda	#CONST_LOWRES_HALF_I					; 2
	sta	NUM1H							; 3
	lda	#CONST_LOWRES_HALF_F					; 2
	sta	NUM1L							; 3
	lda	DX_I							; 3
	sta	NUM2H							; 3
	sta	dxi_label+1	; for self modify			; 4
	lda	DX_F							; 3
	sta	dxf_label+1	; for self modify			; 4
	sta	NUM2L							; 3
	sec			; don't reuse previous num1		; 2
	jsr	multiply						; 6
				; TEMP_I in X				;
				; TEMP_F in A				;
								;==========
								;	 38


	; fixed_add(&space_x,&temp,&space_x);
	clc								; 2
				; TEMP_F in A
	adc	SPACEX_F						; 3
	sta	SPACEX_F						; 3
	txa			; TEMP_I in X				; 2
	adc	SPACEX_I						; 3
	sta	SPACEX_I						; 3
								;==========
								;	 16

;mul8
	; fixed_mul(&fixed_temp,&dy,&fixed_temp);
	lda	DY_I							; 3
	sta	NUM2H							; 3
	sta	dyi_label+1	; for self modify			; 4
	lda	DY_F							; 3
	sta	NUM2L							; 3
	sta	dyf_label+1	; for self modify			; 4
	clc	; reuse CONST_LOWRES_HALF from last time		; 2
	jsr	multiply						; 6
			; TEMP_I in X
			; TEMP_F in A
								;==========
								;	 28

	; fixed_add(&space_y,&temp,&space_y);
	clc								; 2
			; TEMP_F in A
	adc	SPACEY_F						; 3
	sta	SPACEY_F						; 3

	txa		; TEMP_I in X					; 2
	adc	SPACEY_I						; 3
	sta	SPACEY_I						; 3

								;==========
								;	 16


	ldx	#0	; was SCREEN_X					; 2
								;==========
								;	  2
	;===================================================
	; SCREEN_X LOOP!!!!
	;   every cycle in here counts for 32*40=1280 cycles
	;===================================================
screenx_loop:


nomatch:
	;====================================
	; do a full lookup, takes much longer
	; used to be a separate function but we inlined it here

	;====================
	; lookup_map
	;====================
	; finds value in space_x.i,space_y.i
	; returns color in A
	; CLOBBERS: A,Y

	; island is 8x8
	; map is 64x64 but anything not island is ocean

	lda	SPACEX_I						; 3
	sta	spacex_label+1	; self modifying code, LAST_SPACEX_I	; 4
	and	#CONST_MAP_MASK_X	; wrap at 64			; 2
	sta	SPACEX_I		; store i patch out		; 3
	tay				; copy to Y for later		; 2

	lda	SPACEY_I						; 3
	sta	spacey_label+1	; self modifying code, LAST_SPACEY_I	; 4
	and	#CONST_MAP_MASK_Y	; wrap to 64x64 grid		; 2
	sta	SPACEY_I						; 3

	asl								; 2
	asl								; 2
	asl				; multiply by 8			; 2
	clc								; 2
	adc	SPACEX_I		; add in X value		; 3
					; only valid if x<8 and y<8



	; SPACEX_I is also in y
	cpy	#$8							; 2
								;============
								;	 39

	bcs	ocean_color		; bge 8				; 2nt/3

	ldy	SPACEY_I						; 3
	cpy	#$8							; 2
								;=============
								;	  7

	bcs	ocean_color		; bge 8				; 2nt/3

	tay								; 2
	lda	flying_map,Y		; load from array		; 4
	jmp	update_cache						; 3
								;============
								;	11
ocean_color:
	; a was spacey<<3+spacex

	and	#$1f							; 2
	tay								; 2
	lda	water_map,Y		; the color of the sea		; 4
								;===========
								;	  8

update_cache:
	sta	map_color_label+1	; self-modifying		; 4

								;===========
								;	  4
match:

mask_label:
	; this is f0 or 0f depending on odd/even row
	and	#0	; COLOR_MASK (self modifying)			; 2

	; this is ora or bit depending on odd/even
innersmc1:
	ora	$400,X	; we're odd, or the bottom in			; 4
innersmc2:
	sta	$400,X	; plot double height pixel			; 5

								;============
								;	11

	;===================================
	; incremement column, see if done


	inx	; increment	SCREEN_X				; 2
	cpx	#40							; 2
	beq	done_screenx_loop	; branch until we've done 40	; 2nt/3
								;=============
								;	4/5

	;=======================================
	; advance to the next position in space

	; fixed_add(&space_x,&dx,&space_x);

	clc								; 2
	lda	SPACEX_F						; 3
dxf_label:
	adc	#0	; self modifying, is DX_F			; 2
	sta	SPACEX_F						; 3

	lda	SPACEX_I						; 3
dxi_label:
	adc	#0	; self modifying, is DX_I			; 2
	sta	SPACEX_I						; 3

								;==========
								;	 18

	; fixed_add(&space_y,&dy,&space_y);

	clc								; 2
	lda	SPACEY_F						; 3
dyf_label:
	adc	#0	; self modifyig, is DY_F			; 2
	sta	SPACEY_F						; 3
	lda	SPACEY_I						; 3
dyi_label:
	adc	#0	; self mofidying is DY_I			; 2
	sta	SPACEY_I						; 3
								;============
								;	 18

	; cache color and return if same as last time
;	lda	SPACEY_I						; 3
spacey_label:
	cmp	#0	; self modify, LAST_SPACEY_I			; 2
	bne	nomatch							; 2nt/3
	lda	SPACEX_I						; 3
spacex_label:
	cmp	#0	; self modify, LAST_SPACEX_I			; 2
	bne	nomatch							; 2nt/3
map_color_label:
	lda	#0	; self modify, LAST_MAP_COLOR			; 2
	jmp	match							; 3

done_screenx_loop:
	inc	SCREEN_Y						; 5
	lda	SCREEN_Y						; 3
	cmp	#40			; LOWRES height			; 2
	beq	done_screeny						; 2nt/3
	jmp	screeny_loop		; too far to branch		; 3
								;=============
								;	 15
done_screeny:
	rts								; 6


	;====================
	; lookup_map
	;====================
	; finds value in space_x.i,space_y.i
	; returns color in A
	; CLOBBERS: A,Y
	; this is used to check if above water or grass
	; the high-performance per-pixel version has been inlined
lookup_map:
	lda	SPACEX_I						; 3
	and	#CONST_MAP_MASK_X					; 2
	sta	SPACEX_I						; 3
	tay								; 2

	lda	SPACEY_I						; 3
	and	#CONST_MAP_MASK_Y	; wrap to 64x64 grid		; 2
	sta	SPACEY_I						; 3

	asl								; 2
	asl								; 2
	asl				; multiply by 8			; 2
	clc								; 2
	adc	SPACEX_I		; add in X value		; 3
					; only valid if x<8 and y<8

	; SPACEX_I is in y
	cpy	#$8							; 2
								;============
								;	 31

	bcs	ocean_color_outline	; bgt 8				;^2nt/3
	ldy	SPACEY_I						; 3
	cpy	#$8							; 2
	bcs	ocean_color_outline	; bgt 8				; 2nt/3

	tay								; 2
	lda	flying_map,Y		; load from array		; 4

	bcc	update_cache_outline					; 3

ocean_color_outline:
	and	#$1f							; 2
	tay								; 2
	lda	water_map,Y		; the color of the sea		; 4

update_cache_outline:
	rts								; 6



	;======================================
	; draw sky
	;======================================
	; Only draw sky if necessary
	; (at start, or if we have switched to text, we never overwrite it)
draw_sky:
								;	  6
	; Draw Sky on both pages
	; lines 0..6


	lda	#COLOR_BOTH_MEDIUMBLUE	; MEDIUMBLUE color		; 2
	ldx	#39

sky_loop:				; draw line across screen
	sta	$400,X
	sta	$480,X
	sta	$500,X
	sta	$800,X
	sta	$880,X
	sta	$900,X

	dex
	bpl	sky_loop

	; Draw Hazy Horizon

	lda	#$56			; Horizon is blue/grey		; 2
	ldx	#39
horizon_loop:				; draw line across screen
	sta	$580,X
	sta	$980,X

	dex
	bpl	horizon_loop

	rts


; 8.8 fixed point
; should we store as two arrays, one I one F?
fixed_sin:
	.byte $00,$00 ;  0.000000=00.00
	.byte $00,$61 ;  0.382683=00.61
	.byte $00,$b5 ;  0.707107=00.b5
	.byte $00,$ec ;  0.923880=00.ec
	.byte $01,$00 ;  1.000000=01.00
	.byte $00,$ec ;  0.923880=00.ec
	.byte $00,$b5 ;  0.707107=00.b5
	.byte $00,$61 ;  0.382683=00.61
	.byte $00,$00 ;  0.000000=00.00
	.byte $ff,$9f ; -0.382683=ff.9f
	.byte $ff,$4b ; -0.707107=ff.4b
	.byte $ff,$14 ; -0.923880=ff.14
	.byte $ff,$00 ; -1.000000=ff.00
	.byte $ff,$14 ; -0.923880=ff.14
	.byte $ff,$4b ; -0.707107=ff.4b
	.byte $ff,$9f ; -0.382683=ff.9f

fixed_sin_scale:
	.byte $00,$00
	.byte $00,$0c
	.byte $00,$16
	.byte $00,$1d
	.byte $00,$20
	.byte $00,$1d
	.byte $00,$16
	.byte $00,$0c
	.byte $00,$00
	.byte $ff,$f4
	.byte $ff,$ea
	.byte $ff,$e3
	.byte $ff,$e0
	.byte $ff,$e3
	.byte $ff,$ea
	.byte $ff,$f4

;horizontal_lookup_20:
;	.byte $0C,$0A,$09,$08,$07,$06,$05,$05,$04,$04,$04,$04,$03,$03,$03,$03
;	.byte $26,$20,$1B,$18,$15,$13,$11,$10,$0E,$0D,$0C,$0C,$0B,$0A,$0A,$09
;	.byte $40,$35,$2D,$28,$23,$20,$1D,$1A,$18,$16,$15,$14,$12,$11,$10,$10
;	.byte $59,$4A,$40,$38,$31,$2C,$28,$25,$22,$20,$1D,$1C,$1A,$18,$17,$16
;	.byte $73,$60,$52,$48,$40,$39,$34,$30,$2C,$29,$26,$24,$21,$20,$1E,$1C
;	.byte $8C,$75,$64,$58,$4E,$46,$40,$3A,$36,$32,$2E,$2C,$29,$27,$25,$23
;	.byte $A6,$8A,$76,$68,$5C,$53,$4B,$45,$40,$3B,$37,$34,$30,$2E,$2B,$29

	; we can guarantee 4 cycle indexed reads if we page-aligned this
;.align 256
horizontal_lookup:
	.byte $0C,$0B,$0A,$09,$09,$08,$08,$07,$07,$06,$06,$06,$05,$05,$05,$05
	.byte $04,$04,$04,$04,$04,$04,$04,$03,$03,$03,$03,$03,$03,$03,$03,$03
	.byte $26,$22,$20,$1D,$1B,$19,$18,$16,$15,$14,$13,$12,$11,$10,$10,$0F
	.byte $0E,$0E,$0D,$0D,$0C,$0C,$0C,$0B,$0B,$0A,$0A,$0A,$0A,$09,$09,$09
	.byte $40,$3A,$35,$31,$2D,$2A,$28,$25,$23,$21,$20,$1E,$1D,$1B,$1A,$19
	.byte $18,$17,$16,$16,$15,$14,$14,$13,$12,$12,$11,$11,$10,$10,$10,$0F
	.byte $59,$51,$4A,$44,$40,$3B,$38,$34,$31,$2F,$2C,$2A,$28,$26,$25,$23
	.byte $22,$21,$20,$1E,$1D,$1C,$1C,$1B,$1A,$19,$18,$18,$17,$16,$16,$15
	.byte $73,$68,$60,$58,$52,$4C,$48,$43,$40,$3C,$39,$36,$34,$32,$30,$2E
	.byte $2C,$2A,$29,$27,$26,$25,$24,$22,$21,$20,$20,$1F,$1E,$1D,$1C,$1C
	.byte $8C,$80,$75,$6C,$64,$5D,$58,$52,$4E,$4A,$46,$43,$40,$3D,$3A,$38
	.byte $36,$34,$32,$30,$2E,$2D,$2C,$2A,$29,$28,$27,$26,$25,$24,$23,$22
	.byte $A6,$97,$8A,$80,$76,$6E,$68,$61,$5C,$57,$53,$4F,$4B,$48,$45,$42
	.byte $40,$3D,$3B,$39,$37,$35,$34,$32,$30,$2F,$2E,$2C,$2B,$2A,$29,$28

