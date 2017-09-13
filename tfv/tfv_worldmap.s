ODD		EQU	$7B
DIRECTION	EQU	$7C
REFRESH		EQU	$7D

; In Town

; Puzzle Room
; Get through office
; Have to run away?  What happens if die?  No save game?  Code?

; Construct the LED circuit
; Zaps through cloud
; Susie joins your party

; Final Battle
; Play music, lightning effects?
; TFV only hit for one damage, susie for 100

;	Map
;
;	0	1	2	3
;
; 0	BEACH	ARCTIC	ARCTIC	BELAIR
;		TREE	MOUNATIN
;
; 1	BEACH	LANDING	GRASS	FOREST
;	PINETREE	MOUNTAIN
;
; 2	BEACH	GRASS	GRASS	FOREST
;	PALMTREE	MOUNTAIN
;
; 3	BEACH	DESERT	COLLEGE	BEACH
;		CACTUS	PARK



world_map:

	;===================
	; Clear screen/pages
	;===================

	jsr     clear_screens
	jsr     set_gr_page0

	;===============
	; Init Variables
	;===============

	lda	#$0
	sta	ODD

	lda	#$1
	sta	DIRECTION
	sta	REFRESH

worldmap_loop:

worldmap_keyboard:

	jsr     get_key		; get keypress

	lda     LASTKEY

	cmp     #('Q')          ; if quit, then return
	bne     worldmap_check_up
        rts

worldmap_check_up:


	lda	REFRESH
	beq	worldmap_copy_background

	jsr	load_map_bg

	dec	REFRESH

worldmap_copy_background:

	jsr	gr_copy_to_current
        jsr	page_flip

	jmp	worldmap_loop



load_map_bg:

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL		; load image off-screen 0xc00

	lda	#>(landing_rle)
	sta	GBASH
        lda	#<(landing_rle)
        sta	GBASL
        jsr	load_rle_gr

	;; grsim_unrle(landing_rle,0x800);

	rts
