	;===========================================
	; hgr draw sprite (only at 7-bit boundaries)
	;===========================================
	; attempts to shift to allow arbitray odd/even columns
	;
	; *cannot* handle sprites bigger than a 256 byte page

	; SPRITE in INL/INH
	;	note: xsize,ysize in first two bytes
	;	total bytes in text two bytes
	;	mask data immediately follows sprite data

	; Location at SPRITE_X SPRITE_Y
	;	note: sprite_x is column, so Xcoord/7

	; Save at OUTL/OUTH

hgr_draw_sprite:
	lda	SPRITE_X
	ror
	bcs	hgr_draw_sprite_odd

hgr_draw_sprite_even:
	ldy	#0
	lda	(INL),Y			; load xsize
	sta	(OUTL),Y		; store to screen backup
	clc
	adc	SPRITE_X
	sta	sprite_width_end_smc+1	; self modify for end of line

	iny				; load ysize
	lda	(INL),Y
	sta	(OUTL),Y		; store to screen backup
	sta	sprite_ysize_smc+1	; self modify for end row

	; point smc to sprite
	lda	INL
	sta	sprite_smc1+1
	lda	INH
	sta	sprite_smc1+2
	sta	INH

	; point smc to backup
	lda	OUTL
	sta	backup_sprite_smc1+1
	lda	OUTH
	sta	backup_sprite_smc1+2

	; point smc to mask
	lda	MASKL
	sta	sprite_mask_smc1+1
	lda	MASKH
	sta	sprite_mask_smc1+2

	ldx	#0			; X is pointer offset
	stx	CURRENT_ROW		; actual row

	ldx	#2			; start two bytes in (past x/y)

hgr_sprite_yloop:

	lda	CURRENT_ROW		; row

	clc
	adc	SPRITE_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y

	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	SPRITE_X

sprite_inner_loop:

	lda     (GBASL),Y		; load bg
backup_sprite_smc1:
	sta	$f000,X
sprite_smc1:
        eor     $f000,X			; load sprite data
sprite_mask_smc1:
	and	$f000,X
	eor	(GBASL),Y
	sta	(GBASL),Y		; store to screen

	inx				; increment sprite offset
	iny				; increment output position


sprite_width_end_smc:
	cpy	#6			; see if reached end of row
	bne	sprite_inner_loop	; if not, loop


	inc	CURRENT_ROW		; row
	lda	CURRENT_ROW		; row

sprite_ysize_smc:
	cmp	#31			; see if at end
	bne	hgr_sprite_yloop	; if not, loop

	rts

hgr_draw_sprite_odd:

	ldy	#0
	lda	(INL),Y			; load xsize
	sta	(OUTL),Y		; store to screen backup
	clc
	adc	SPRITE_X
	sta	osprite_width_end_smc+1	; self modify for end of line

	iny
	lda	(INL),Y			; load ysize
	sta	(OUTL),Y		; store to screen backup
	sta	osprite_ysize_smc+1	; self modify for end row

	; point smc to sprite
	lda	INL
	sta	osprite_smc1+1
	lda	INH
	sta	osprite_smc1+2

	; point smc to backup
	lda	OUTL
	sta	obackup_sprite_smc1+1
	lda	OUTH
	sta	obackup_sprite_smc1+2

	; point smc to mask
	lda	MASKL
	sta	osprite_mask_smc1+1
	lda	MASKH
	sta	osprite_mask_smc1+2


	ldx	#0			; X is pointer offset
	stx	CURRENT_ROW		; actual row

	ldx	#2

ohgr_sprite_yloop:

	lda	CURRENT_ROW		; row

	clc
	adc	SPRITE_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y

	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	SPRITE_X

	lda	#$0
	sta	SPRITE_TEMP	; default high bit to 0
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

	and	TEMP
	sta	TEMP

osprite_smc1:
        lda	$f000,X			; load sprite data

	rol	SPRITE_TEMP
	rol
	sta	SPRITE_TEMP
	ora	TEMP

	and	#$7f	; force purple/green

	sta	(GBASL),Y		; store to screen


	inx				; increment sprite offset
	iny				; increment output position



osprite_width_end_smc:
	cpy	#6			; see if reached end of row
	bne	osprite_inner_loop	; if not, loop

	inc	CURRENT_ROW		; row
	lda	CURRENT_ROW		; row

osprite_ysize_smc:
	cmp	#31			; see if at end
	bne	ohgr_sprite_yloop	; if not, loop

	rts


.if 0




;hgr_sprite_page_smc:
;	eor	#$00




backup_sprite1 = $1800
backup_sprite2 = $1900

.endif
