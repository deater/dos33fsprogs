	;===========================================
	; hgr draw sprite (only at 7-bit boundaries)
	;===========================================
	; *cannot* handle sprites bigger than a 256 byte page
	;
	; attempts to shift to allow arbitray odd/even columns
	;
	; ideally foreground sprite palette has precedence over background

	; Location at SPRITE_X SPRITE_Y
	;	note: sprite_x is column, so Xcoord/7

	; which sprite in X
	; where to save in Y

hgr_draw_sprite:

	; backup location for eventual restore
	lda	SPRITE_X
	sta	save_xstart,Y
	lda	SPRITE_Y
	sta	save_ystart,Y

	; generate x-end for both restore as well as inner loop

	lda	sprites_xsize,X
	clc
	adc	SPRITE_X
	sta	sprite_width_end_smc+1	; self modify for end of line
	sta	save_xend,Y

	; handle ysize for both restore as well as outer loop

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

	;=============================
	; set up outer loop


	ldx	#0			; X is pointer offset
	stx	CURRENT_ROW		; actual row

hgr_sprite_yloop:


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

	; setup Xpos for inner loop

	ldy	SPRITE_X

	; values to shift in for odd columns

	lda	#$0
	sta	SPRITE_TEMP	; default high bit to 0
	sta	MASK_TEMP	; defailt high bit to 0


sprite_inner_loop:

	; pick if even or odd code

	lda	SPRITE_X
	ror
	bcs	hgr_draw_sprite_odd


	;================================

hgr_draw_sprite_even:


sprite_smc1:
        lda     $f000,X			; load sprite data
	sta	TEMP_SPRITE
sprite_mask_smc1:
	lda	$f000,X			; mask

	jmp	hgr_draw_sprite_both

hgr_draw_sprite_odd:

osprite_smc1:
        lda	$f000,X			; load sprite data

					;            PSSS SSSS
					; rol   C=P, SSSS SSST

					; want to set bit7 to C?

	rol	SPRITE_TEMP
	rol
	sta	SPRITE_TEMP
	bcc	pal0
pal1:
	ora	#$80			; set pal bit
	bne	pal_done
pal0:
	and	#$7f			; clear pal bit

pal_done:
	sta	TEMP_SPRITE

osprite_mask_smc1:
        lda	$f000,X			; load mask data

	rol	MASK_TEMP
	rol
	sta	MASK_TEMP

hgr_draw_sprite_both:
	eor	#$FF
	and	#$7F
	sta	TEMP_MASK

					;   BBBB BBBB	; background
					; & 1111 0000	; mask
					;  ============
					;   BBBB 0000
					; | 0000 SSSS   ; sprite
					; =============
					;   BBBB SSSS


	; do the actual sprite-ing

	lda     (GBASL),Y		; load bg

;	eor	TEMP_SPRITE
	and	TEMP_MASK

	ora	TEMP_SPRITE

;	eor	(GBASL),Y
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


