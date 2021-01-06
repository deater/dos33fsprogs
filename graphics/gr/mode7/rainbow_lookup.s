	;====================
	; lookup_map
	;====================
	; finds value in space_x.i,space_y.i
	; returns color in A
	; CLOBBERS: A,Y

	lda	SPACEX_I                                                ; 3
	sta	spacex_label+1  ; self modifying code, LAST_SPACEX_I    ; 4

	lda	SPACEY_I                                                ; 3
	sta	spacey_label+1  ; self modifying code, LAST_SPACEY_I    ; 4

	lda	SPACEX_I
	and	#$f
	sta	TEMP
	asl
	asl
	asl
	asl
	ora	TEMP
	eor	SPACEY_I

	sta	map_color_label+1	; self-modifying
