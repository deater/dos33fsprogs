
kerrek_move_early_out:
	rts

	;=======================
	;=======================
	; kerrek move
	;=======================
	;=======================
	;
	; note no more collision, and no more movement
	; we do increment frame though


kerrek_move:

	inc 	KERREK_COUNT
	lda	KERREK_COUNT
	and	#$7			; 0..7
	sta	KERREK_COUNT


	rts

