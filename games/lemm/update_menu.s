	;=============================
	; update menu
	;=============================
update_menu:
	lda	BUTTON_LOCATION
	bne	actually_update_menu
	rts

actually_update_menu:
	ldx	#7
	stx	HGR_COLOR

	lda	BUTTON_LOCATION
	jsr	draw_button

	rts

	;========================
	; erase menu
	;========================
erase_menu:
	lda	BUTTON_LOCATION
	bne	actually_erase_menu
	rts

actually_erase_menu:
	ldx	#0
	stx	HGR_COLOR

	lda	BUTTON_LOCATION
	jsr	draw_button

	rts



	;====================
	; draw button
	;====================

draw_button:
	; location is (1+BUTTON_LOCATION)*16

	; two hlins

	lda	BUTTON_LOCATION
	clc
	adc	#1
	asl
	asl
	asl
	asl
	tax
	sta	button_smc1+1
	sta	button_smc2+1
	sta	button_smc3+1
	clc
	adc	#15
	sta	button_smc4+1

	; draw on both pages
	jsr	actual_button_draw
	jsr	hgr_hlin_page_toggle
	jsr	hgr_vlin_page_toggle
	jsr	actual_button_draw
	jsr	hgr_hlin_page_toggle
	jsr	hgr_vlin_page_toggle
	rts

actual_button_draw:

button_smc1:
	ldx	#144
	lda	#168
	ldy	#15
	jsr	hgr_hlin	; (x,a) to (x+y,a)

button_smc2:
	ldx	#144
	lda	#191
	ldy	#15
	jsr	hgr_hlin	; (x,a) to (x+y,a)

	; two vlins
button_smc3:
	ldx	#144
	lda	#168
	ldy	#23
	jsr	hgr_vlin	; (x,a) to (x,a+y)

button_smc4:
	ldx	#159
	lda	#168
	ldy	#23
	jsr	hgr_vlin	; (x,a) to (x,a+y)

	rts
