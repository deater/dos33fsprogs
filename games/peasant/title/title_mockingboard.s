	;=========================
	;=========================
	; mockingboard titlescreen
	;=========================
	;=========================

	; we can be fancier as music is played in the background

mockingboard_title:

	;===================================
	; Setup Mockingboard
	;===================================

PT3_ENABLE_APPLE_IIC = 1

	;==================================
	; load music into the language card
	;	into $D000 set 2
	;==================================

	; switch in language card
	; read/write RAM, $d000 bank 2

	lda	$C083
	lda	$C083

	; actually load it
	lda	#LOAD_MUSIC
	sta	WHICH_LOAD

	jsr	load_file

	lda	#0
	sta	DONE_PLAYING

	lda	#1
	sta	LOOP

	jsr     mockingboard_patch      ; patch to work in slots other than 4?

	;=======================
	; Set up 50Hz interrupt
	;========================

	jsr     mockingboard_init
	jsr     mockingboard_setup_interrupt

	;============================
	; Init the Mockingboard
	;============================

	jsr     reset_ay_both
	jsr     clear_ay_both

	;==================
	; init song
	;==================

	jsr	pt3_init_song


	;=======================
	; start music
	;=======================

	cli

	lda	#$20
	sta	DRAW_PAGE

	lda	#$0
	sta	FLAME_COUNT


	; TODO:
	;	full page flipping?
	;	better trogdor integration?
	;		the actual game things are drawn and the lightning
	;		sprite is an animation

mockingboard_title_loop:

	lda	C_VOLUME	; see if volume on trogdor channel
	beq	no_trog

	bit	PAGE1		; if it did, flip page to trogdor
	jmp	done_trog

no_trog:
	bit	PAGE2		; otherwise stay at regular

done_trog:

	;===============================
	; do flame animations

				; work on flame
	lda	FRAME		; skip most of time
	and	#$3
	bne	no_flame_increment
flame_increment:
	inc	FLAME_COUNT
	lda	FLAME_COUNT
	cmp	#3
	bne	no_flame_increment
	lda	#0
	sta	FLAME_COUNT

no_flame_increment:


	lda	#32		; 224/7
	sta	CURSOR_X

	lda	#48
	sta	CURSOR_Y

	ldx	FLAME_COUNT
	lda	fire_sprites_l,X
	sta	INL
	lda	fire_sprites_h,X
	sta	INH
	jsr	hgr_draw_sprite



	;===============================
	; do "press any key" flash

	lda	FRAME
	and	#$20
	beq	no_message
yes_message:

	lda	#2		; 14/7
	sta	CURSOR_X

	lda	#134
	sta	CURSOR_Y

	lda	#<direction_sprite
	sta	INL
	lda	#>direction_sprite
	sta	INH
	jsr	hgr_draw_sprite

	jmp	done_message
no_message:

	lda	#2		; 14/7
	sta	VGI_RX1
	lda	#134
	sta	VGI_RY1

	lda	#25		; 175/7
	sta	VGI_RX2
	lda	#141
	sta	VGI_RY2

	lda	#0			; color black

	jsr	hgr_rectangle_color

done_message:

	;===============================
	; increment the frame count

	inc	FRAME

	lda	KEYPRESS				; 4
	bpl	mockingboard_title_loop			; 3

	;==========================
	; key was pressed, exit

	bit	KEYRESET		; clear the keyboard buffer

	bit	PAGE2			; return to viewing PAGE2


	;==============
	; disable music

	sei	; disable music

	jsr	clear_ay_both

	rts


fire_sprites_l:
	.byte <fire0_sprite,<fire1_sprite,<fire2_sprite

fire_sprites_h:
	.byte >fire0_sprite,>fire1_sprite,>fire2_sprite




; old code


.if 0
	; we're supposed to animate flame, flash the "CLICK ANYWHERE" sign
	; and show trogdor when his music plays

reset_altfire:
	lda	#50
	sta	ALTFIRE				; start on yy=50 on screen

	lda	#<altfire_sprite		; point to alternate fire
	sta	alt_smc1+1			; sprite in memory
	sta	alt_smc2+1

	lda	#>altfire_sprite
	sta	alt_smc1+2
	sta	alt_smc2+2

title_loop:

	lda	C_VOLUME	; see if volume on trogdor channel
	beq	no_trog

	bit	PAGE1		; if it did, flip page to trogdor
	jmp	done_trog

no_trog:
	bit	PAGE2		; otherwise stay at regular

done_trog:

				; work on flame
	lda	FRAME		; skip most of time
	and	#$3f
	bne	altfire_good

	; do altfire loop

	ldx	ALTFIRE		; point (GBASL) to current line to copy
	lda	hposn_high,X
	sta	GBASH
	lda	hposn_low,X
	sta	GBASL

	ldy	#34		; xx=34*7
inner_altfire:

	; swap sprite data with screen data

	lda	(GBASL),Y	; get pixels from screen
	pha			; save for later
alt_smc1:
	lda	$d000		; get pixels from sprite
	sta	(GBASL),Y	; store to screen
	pla			; restore saved pixels
alt_smc2:
	sta	$d000		; store to pixel area

	inc	alt_smc1+1	; increment the sprite pointers
	inc	alt_smc2+1
	bne	alt_noflo

	inc	alt_smc1+2	; handle 16-bit if overflowed
	inc	alt_smc2+2

alt_noflo:
	iny
	cpy	#40		; continue to xx=(40*7)
	bne	inner_altfire


	inc	ALTFIRE
	lda	ALTFIRE
	cmp	#135		; continue until yy=135
	beq	reset_altfire

altfire_good:

	inc	FRAME

	lda	KEYPRESS				; 4
	bpl	title_loop				; 3
.endif

