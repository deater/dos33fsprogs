	;=============================
	; update remaining_all
	;=============================
update_remaining_all:

	ldx	#0
ura_loop:
	txa
	pha
	jsr	update_remaining
	pla
	tax
	inx
	cpx	#8
	bne	ura_loop
	rts


	;=============================
	; update remaining
	;=============================
	; X is which one to update
update_remaining:
	txa
	pha

        jsr     hgr_sprite_page_toggle		; toggle page (bg)

	lda	CLIMBER_COUNT,X
	tay

        lda     littlenums_l,Y
        sta     INL
        lda     littlenums_h,Y
        sta     INH

        lda     remaining_x,X
        sta     XPOS
        lda     #169
        sta     YPOS

	jsr	hgr_draw_sprite

	;

	pla
	tax

        jsr     hgr_sprite_page_toggle		; toggle page (bg)

	lda	CLIMBER_COUNT,X
	tay

        lda     littlenums_l,Y
        sta     INL
        lda     littlenums_h,Y
        sta     INH

        lda     remaining_x,X
        sta     XPOS
        lda     #169
        sta     YPOS

	jsr	hgr_draw_sprite

	rts


	; X locations to print the counts at
	; approximate, 7-bit boundaries where graphics are on 8-bit
remaining_x:
	.byte 5,7,10,12,14,17,19,21

littlenums_l:
	.byte <little00_sprite,<little01_sprite,<little02_sprite
	.byte <little03_sprite,<little04_sprite,<little05_sprite
	.byte <little06_sprite,<little07_sprite,<little08_sprite
	.byte <little09_sprite,<little10_sprite,<little11_sprite
	.byte <little12_sprite,<little13_sprite,<little14_sprite
	.byte <little15_sprite,<little16_sprite,<little17_sprite
	.byte <little18_sprite,<little19_sprite,<little20_sprite

littlenums_h:
	.byte >little00_sprite,>little01_sprite,>little02_sprite
	.byte >little03_sprite,>little04_sprite,>little05_sprite
	.byte >little06_sprite,>little07_sprite,>little08_sprite
	.byte >little09_sprite,>little10_sprite,>little11_sprite
	.byte >little12_sprite,>little13_sprite,>little14_sprite
	.byte >little15_sprite,>little16_sprite,>little17_sprite
	.byte >little18_sprite,>little19_sprite,>little20_sprite



	;=============================
	; update selection
	;=============================
update_selection:
	lda	BUTTON_LOCATION
	bne	actually_update_selection
	rts

actually_update_selection:
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
