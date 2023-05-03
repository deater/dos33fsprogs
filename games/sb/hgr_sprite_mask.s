	;===========================================
	; hgr draw sprite mask and save (only at 7-bit boundaries)
	;===========================================
	; SPRITE in INL/INH
	; Location at SPRITE_X SPRITE_Y

	; xsize, ysize  in first two bytes

	; sprite AT INL/INH

	; save at OUTL/OUTH

hgr_draw_sprite_mask_and_save:

	ldy	#0
	lda	(INL),Y			; load xsize
	sta	(OUTL),Y
	clc
	adc	SPRITE_X
	sta	sms_sprite_width_end_smc+1	; self modify for end of line

	iny				; load ysize
	lda	(INL),Y
	sta	(OUTL),Y
	sta	sms_sprite_ysize_smc+1	; self modify

	; point smc to sprite
	lda	INL			; 16-bit add
	sta	sms_sprite_smc1+1
	lda	INH
	sta	sms_sprite_smc1+2

	; point smc to sprite
	lda	OUTL			; 16-bit add
	sta	backup_sprite_smc1+1
	lda	OUTH
	sta	backup_sprite_smc1+2


	lda	MASKL
	sta	sms_mask_smc1+1
	lda	MASKH
	sta	sms_mask_smc1+2

	ldx	#0			; X is pointer offset
	stx	CURRENT_ROW		; actual row

	ldx	#2

hgr_sms_sprite_yloop:

	lda	CURRENT_ROW		; row

	clc
	adc	SPRITE_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y


;hgr_sprite_page_smc:
;	eor	#$00

	clc
	adc	DRAW_PAGE
	sta	GBASH

	ldy	SPRITE_X

sms_sprite_inner_loop:


	lda     (GBASL),Y			; load bg
backup_sprite_smc1:
	sta	$f000,X
sms_sprite_smc1:
        eor     $f000,X			; load sprite data
sms_mask_smc1:
	and	$f000,X
	eor	(GBASL),Y
	sta	(GBASL),Y		; store to screen

	inx				; increment sprite offset
	iny				; increment output position


sms_sprite_width_end_smc:
	cpy	#6			; see if reached end of row
	bne	sms_sprite_inner_loop	; if not, loop


	inc	CURRENT_ROW		; row
	lda	CURRENT_ROW		; row

sms_sprite_ysize_smc:
	cmp	#31			; see if at end
	bne	hgr_sms_sprite_yloop	; if not, loop

	rts

backup_sprite1 = $1800
backup_sprite2 = $1900
