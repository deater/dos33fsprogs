	; note: no longer on fire once have helm on?

	; appears in your hand when "The fabled Trog-Sword"
	;	message appears
	;
	; keeper starts to retreat
	;	2 frames, raise sword a bit
	;	raise it whole way up, then raise it back down
	;	then curtain begins to part


	; plays little fanfare as you get sword

get_sword:

	lda	#0
	sta	SWORD_COUNT

	lda	#8
	sta	KEEPER_COUNT


get_sword_loop:

	;========================
	; draw_scene

	jsr	update_screen


	;=============================
	; draw curtain if necessary

	sec
	lda	SWORD_COUNT
	sbc	#37
	bmi	no_curtain

	tax

	lda	#35			; 245/7
	sta	CURSOR_X
	lda	#112
	sta	CURSOR_Y

	lda	curtain_sprites_l,X
	sta	INL
	lda	curtain_sprites_h,X
	sta	INH

	jsr	hgr_draw_sprite

no_curtain:
	;========================
	; draw base sprite

	ldx	PEASANT_X			; one to left
	dex
	stx	SPRITE_X
	lda	PEASANT_Y
	sta	SPRITE_Y

	ldx	#13				; base keeper sprite

        jsr     hgr_draw_sprite_mask


	;========================
	; draw overlay sprite

	ldx	PEASANT_X			; one to right
	inx
	stx	SPRITE_X

	ldx	SWORD_COUNT
	ldy	which_sword_sprite,X

	clc
	lda	PEASANT_Y
	adc	sword_y_offset,Y
	sta	SPRITE_Y

	tya
	clc
	adc	#14
	tax					; offset

        jsr     hgr_draw_sprite_mask



	;=====================
	; increment frame

	inc	FRAME


	;=======================
	; flip page

;       jsr     wait_vblank

	jsr	hgr_page_flip


	;=======================
	; move to next frame
	inc	SWORD_COUNT

	dec	KEEPER_COUNT
	bne	keeper_ok
	lda	#SUPPRESS_KEEPER
	sta	SUPPRESS_DRAWING
keeper_ok:

	;=======================
	; see if done animation

	lda	SWORD_COUNT
	cmp	#40
	beq	done_get_sword

	jmp	get_sword_loop

done_get_sword:

	;==========================
	; switch to sword outfit

	lda	#PEASANT_OUTFIT_SWORD
	jsr	load_peasant_sprites

	;===========================
	; setup curtain

	jsr	setup_curtain_bg

	rts


	;==============================
	; setup curtain
	;==============================
	; set curtain to open if necessary

setup_curtain_bg:

	; save current draw page

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; means draw to $6000
	sta	DRAW_PAGE

	; draw new curtain in background

	lda	#35			; 245/7
	sta	CURSOR_X
	lda	#112
	sta	CURSOR_Y

	lda	#<curtain2
	sta	INL
	lda	#>curtain2
	sta	INH

	jsr	hgr_draw_sprite

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

	rts


curtain_sprites_l:
	.byte	<curtain0,<curtain1,<curtain2
curtain_sprites_h:
	.byte	>curtain0,>curtain1,>curtain2

which_sword_sprite:
.byte	0,0,1,1,2,2,3,3,4,4	; keeper is gone
.byte	5,5,6,6,7,7,8,8,8,8
.byte	7,7,6,6,5,5,4,4,3,3
.byte	2,2,1,1,0,0
.byte	0,0,0
; then curtain opens (while making "success" noise)


sword_y_offset:
.byte	6,6,6,0,-6
.byte	-12,-15,-17,-19

