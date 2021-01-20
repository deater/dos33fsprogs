
	;=================================
	; load game!  for now, debugging
	;=================================
	; eventually load values from file like MYST does
	; also provide multiple load games
load_game:


	lda	#$03
	sta	HERO_LEVEL

	lda	#$02
	sta	HERO_HP_HI
	lda	#$90
	sta	HERO_HP_LO
	sta	HERO_MP
	sta	HERO_MP_MAX
	lda	#LOAD_FLYING
	sta	WHICH_LOAD

	rts
