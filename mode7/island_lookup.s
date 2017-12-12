
	;====================================
	; do a full lookup, takes much longer
	; used to be a separate function but we inlined it here

	;====================
	; lookup_map
	;====================
	; finds value in space_x.i,space_y.i
	; returns color in A
	; CLOBBERS: A,Y

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

	bcs	@ocean_color		; bgt 8				; 2nt/3
	ldy	SPACEY_I						; 3
	cpy	#$8							; 2
								;=============
								;	  7

	bcs	@ocean_color		; bgt 8				; 2nt/3

	tay								; 2
	lda	flying_map,Y		; load from array		; 4

	bcc	@update_cache						; 3
								;============
								;	11
@ocean_color:
	and	#$1f							; 2
	tay								; 2
	lda	water_map,Y		; the color of the sea		; 4
								;===========
								;	  8

@update_cache:
	sta	map_color_label+1	; self-modifying		; 4

								;===========
								;	  4

;	rts								; 6
