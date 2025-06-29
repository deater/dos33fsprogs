	;=================================================
	; hgr draw sprite with mask (only at 7-bit boundaries)
	;=================================================
	; *cannot* handle sprites bigger than a 256 byte page
	;
	; attempts to shift to allow arbitray odd/even columns
	;
	; ideally foreground sprite palette has precedence over background
	;	can be in either mode.  Set USE_BG_PALETTE = 1

	; Location at SPRITE_X SPRITE_Y
	;	note: sprite_x is column, so Xcoord/7

	; which sprite in X

	; if Ypos+SPRITE_Y>191 we clip to 191
hgdsm_early_exit:
	rts

hgr_draw_sprite_mask:

	lda	SPRITE_Y
	cmp	#192			; exit if try to draw off bottom
	bcs	hgdsm_early_exit	; bge

	; generate x-end for both restore as well as inner loop

	lda	sprites_xsize,X
	clc
	adc	SPRITE_X
	sta	hgr_sprite_mask_width_end_smc+1	; self modify for end of line

	; handle ysize for both restore as well as outer loop

	lda	sprites_ysize,X
	sta	hgr_sprite_mask_ysize_smc+1	; self modify for end row
	clc
	adc	SPRITE_Y
	cmp	#192
	bcc	hgr_sprite_mask_ysize_ok		; blt

hgr_sprite_mask_ysize_not_ok:

	; adjust self modify
	; want it to be (192-SPRITE_Y)

	lda	#192
	sec
	sbc	SPRITE_Y
	sta	hgr_sprite_mask_ysize_smc+1	; self modify for end row

	lda	#191				; max out yend

hgr_sprite_mask_ysize_ok:

	; point smc to sprite

	lda	sprites_data_l,X
	sta	hgr_sm_data_smc1+1
	sta	hgr_sm_data_smc2+1

	lda	sprites_data_h,X
	sta	hgr_sm_data_smc1+2
	sta	hgr_sm_data_smc2+2

	; point smc to mask

	lda	sprites_mask_l,X
	sta	hgr_sm_mask_smc1+1
	sta	hgr_sm_mask_smc2+1

	lda	sprites_mask_h,X
	sta	hgr_sm_mask_smc1+2
	sta	hgr_sm_mask_smc2+2

	;=============================
	; set up outer loop


	ldx	#0			; X is pointer offset
	stx	CURRENT_ROW		; actual row

hgr_sprite_mask_yloop:


	lda	CURRENT_ROW		; row

	clc
	adc	SPRITE_Y		; add in sprite_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y
	clc
	adc	DRAW_PAGE
	sta	GBASH

	; setup Xpos for inner loop

	ldy	SPRITE_X

	; values to shift in for odd columns

	lda	#$0
	sta	SPRITE_TEMP	; default high bit to 0
	sta	MASK_TEMP	; defailt high bit to 0


hgr_sprite_mask_inner_loop:

	; pick if even or odd code

	lda	SPRITE_X
	ror
	bcs	hgr_draw_sprite_odd


	;================================

hgr_draw_sprite_even:


hgr_sm_data_smc1:
        lda     $f000,X			; load sprite data
	sta	TEMP_SPRITE
hgr_sm_mask_smc1:
	lda	$f000,X			; mask

	jmp	hgr_draw_sprite_both

hgr_draw_sprite_odd:

hgr_sm_data_smc2:
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

hgr_sm_mask_smc2:
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


	; what if we want to use background palette?
	; if so TEMP_SPRITE should be anded with $7f previously
	; and temp mask should have high bit set

.if USE_BG_PALETTE
	lda	TEMP_SPRITE
	and	#$7f
	sta	TEMP_SPRITE		; clear palette bit on sprite

	lda	TEMP_MASK
	ora	#$80
	sta	TEMP_MASK
.endif

	lda     (GBASL),Y		; load bg

	and	TEMP_MASK
	ora	TEMP_SPRITE
	sta	(GBASL),Y		; store to screen

	inx				; increment sprite offset
	iny				; increment output position


hgr_sprite_mask_width_end_smc:
	cpy	#6				; see if reached end of row
	bne	hgr_sprite_mask_inner_loop	; if not, loop

	inc	CURRENT_ROW			; row
	lda	CURRENT_ROW			; row

hgr_sprite_mask_ysize_smc:
	cmp	#31				; see if at end
	bne	hgr_sprite_mask_yloop		; if not, loop

	rts


