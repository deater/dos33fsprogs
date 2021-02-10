
	;=================================
	; load game!  for now, debugging
	;=================================
	; eventually load values from file like MYST does
	; also provide multiple load games
load_game:

	lda	#LOAD_FLYING
	sta	WHICH_LOAD
	lda	#$90
	sta	HERO_HP_LO
	lda	#$02
	sta	HERO_HP_HI
	lda	#$20
	sta	HERO_MP
	sta	HERO_MP_MAX
	lda	#3
	sta	HERO_LIMIT
	lda	#$03
	sta	HERO_LEVEL
	lda	#$50
	sta	HERO_XP
	lda	#$25
	sta	HERO_MONEY
	lda	#'D'
	sta	HERO_NAME
	lda	#'E'
	sta	HERO_NAME1
	lda	#'A'
	sta	HERO_NAME2
	lda	#'T'
	sta	HERO_NAME3
	lda	#'E'
	sta	HERO_NAME4
	lda	#'R'
	sta	HERO_NAME5
	lda	#0
	sta	HERO_NAME6
	lda	#0
	sta	HERO_STATE
	lda	#25
	sta	HERO_STEPS
	lda	#00
	sta	TFV_X
	sta	TFV_Y
	sta	MAP_X

	lda	#$ff
	sta	HERO_INVENTORY1
	sta	HERO_INVENTORY2
	lda	#$3
	sta	HERO_INVENTORY3


	rts
