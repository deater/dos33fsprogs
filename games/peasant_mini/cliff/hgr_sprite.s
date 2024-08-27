	;===========================================
	; hgr draw sprite (only at 7-bit boundaries)
	;===========================================
	; attempts to shift to allow arbitray odd/even columns
	;
	; *cannot* handle sprites bigger than a 256 byte page

	; Location at SPRITE_X SPRITE_Y
	;	note: sprite_x is column, so Xcoord/7

	; which sprite in X
	; where to save in Y

hgr_draw_sprite:

	; backup location in case we need to restore
	lda	SPRITE_X
	sta	save_xstart,Y
	lda	SPRITE_Y
	sta	save_ystart,Y

	; handle xsize

	lda	sprites_xsize,X
	clc
	adc	SPRITE_X
	sta	sprite_width_end_smc+1	; self modify for end of line
	sta	osprite_width_end_smc+1	; self modify for end of line
	sta	save_xend,Y

	; handle ysize

	lda	sprites_ysize,X
	sta	sprite_ysize_smc+1	; self modify for end row
	clc
	adc	SPRITE_Y
	sta	save_yend,Y

	; point smc to sprite
	lda	sprites_data_l,X
	sta	sprite_smc1+1
	sta	osprite_smc1+1
	lda	sprites_data_h,X
	sta	sprite_smc1+2
	sta	osprite_smc1+2

	; point smc to mask
	lda	sprites_mask_l,X
	sta	sprite_mask_smc1+1
	sta	osprite_mask_smc1+1
	lda	sprites_mask_h,X
	sta	sprite_mask_smc1+2
	sta	osprite_mask_smc1+2


	ldx	#0			; X is pointer offset
	stx	CURRENT_ROW		; actual row

hgr_sprite_yloop:

	; pick if even or odd code

	lda	SPRITE_X
	ror
	bcs	hgr_draw_sprite_odd


	;================================

hgr_draw_sprite_even:

	lda	CURRENT_ROW		; row

	clc
	adc	SPRITE_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y

; always PAGE2
;	clc
;	adc	DRAW_PAGE
	sta	GBASH

	ldy	SPRITE_X

sprite_inner_loop:

	lda     (GBASL),Y		; load bg
backup_sprite_smc1:
	sta	$f000,X
sprite_smc1:
        eor     $f000,X			; load sprite data
sprite_mask_smc1:
	and	$f000,X			; mask
	eor	(GBASL),Y
	sta	(GBASL),Y		; store to screen

	inx				; increment sprite offset
	iny				; increment output position


sprite_width_end_smc:
	cpy	#6			; see if reached end of row
	bne	sprite_inner_loop	; if not, loop

	jmp	common_common


	;============================================


hgr_draw_sprite_odd:

	lda	CURRENT_ROW		; row

	clc
	adc	SPRITE_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y

;	clc
;	adc	DRAW_PAGE
	sta	GBASH

	ldy	SPRITE_X

	lda	#$0
	sta	SPRITE_TEMP	; default high bit to 0
	lda	#$ff		; because we have to invert FIXME
	sta	MASK_TEMP	; defailt high bit to 0

osprite_inner_loop:

	lda	(GBASL),Y		; load bg data
	sta	TEMP

obackup_sprite_smc1:
	sta	$f000,X			; store backup

osprite_mask_smc1:
        lda	$f000,X			; load mask data

	eor	#$FF

	rol	MASK_TEMP
	rol
	sta	MASK_TEMP
	and	#$7f

	and	TEMP
	sta	TEMP

osprite_smc1:
        lda	$f000,X			; load sprite data

	rol	SPRITE_TEMP
	rol
	sta	SPRITE_TEMP
	and	#$7f	; force purple/green

	ora	TEMP

	sta	(GBASL),Y		; store to screen




	inx				; increment sprite offset
	iny				; increment output position



osprite_width_end_smc:
	cpy	#6			; see if reached end of row
	bne	osprite_inner_loop	; if not, loop

common_common:

	inc	CURRENT_ROW		; row
	lda	CURRENT_ROW		; row

sprite_ysize_smc:
	cmp	#31			; see if at end
	bne	hgr_sprite_yloop	; if not, loop

	rts


