; Peasant's Quest / New Game

; included by intro.s

; by Vince `deater` Weaver	vince@deater.net

	;=============================
	; start new game
	;=============================
start_new_game:

	;===================================================
	; load inventory code to language card $d000 bank 2

	; switch in language card
        ; read/write RAM, $d000 bank 2

        lda     LCBANK2
        lda     LCBANK2

        ; actually load it
        lda     #LOAD_INVENTORY
        sta     WHICH_LOAD

        jsr     load_file

	; read/write RAM, $d000 bank 1

        lda     LCBANK1
        lda     LCBANK1

	; load parse_input compressed to $2000

        lda     #LOAD_PARSE_INPUT
        sta     WHICH_LOAD

        jsr     load_file

	; decompress to $EE00

	lda	#$00
	sta	getsrc_smc+1
        lda	#$20
        sta     getsrc_smc+2

        lda     #$EE

        jsr     decompress_lzsa2_fast



	; start in PEASANT2 file

	lda	#LOAD_PEASANT2
	sta	WHICH_LOAD

	;=========================
	; init peasant position
	; draw at 18,108

	lda	#18
	sta	PEASANT_X
	lda	#108
	sta	PEASANT_Y

	; set direction

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

	; set not walking

	lda	#0
	sta	PEASANT_XADD
	sta	PEASANT_YADD

	; set score to 0

	lda	#0
	sta	SCORE_HUNDREDS

	lda	#$00
	sta	SCORE_TENSONES

	; map location

	lda	#4
	sta	MAP_X
	lda	#1
	sta	MAP_Y

	; inventory is only t-shirt

	lda	#$00
	sta	INVENTORY_1
	sta	INVENTORY_2
	lda	#INV3_SHIRT
	sta	INVENTORY_3

	; inventory items gone

	; 1100 1011
	lda	#$00
	sta	INVENTORY_1_GONE
	; 0001 1101
;	lda	#$00
	sta	INVENTORY_2_GONE
	;
;	lda	#$00
	sta	INVENTORY_3_GONE

	; setup game state

	lda	#0
	sta	GAME_STATE_0
	sta	GAME_STATE_1
	sta	GAME_STATE_2
	sta	NED_STATUS
	sta	BUSH_STATUS
	sta	KERREK_STATE
	sta	ARROW_SCORE

	rts

