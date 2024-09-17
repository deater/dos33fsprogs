	;===============================================
	; hgr draw sprite, with bg mask in GR $400
	;===============================================
	; used primarily to draw Rather Dashing
	;===============================================
	; *cannot* handle sprites bigger than 256 bytes
	;
	; attempts to shift for odd/even column
	; ideally sprite palette has precedence over background
	;     if completely transparent then let bg keep palette

	; Location at CURSOR_X CURSOR_Y

	; for now, BG mask is only all or nothing (from LORES)
	; so we just skip drawing if behind
	; this version handles arbitrary width sprites, which complicates
	;	things

	; X is sprite to draw

	; Y is save slot

hgr_draw_sprite_bg_mask:

	;===================================
	; save info on background to restore

	lda	#1			; can't inc as inc,Y not possible
	sta	save_valid,Y

	lda	CURSOR_X
	sta	save_xstart,Y

	lda	CURSOR_Y
	sta	save_ystart,Y

	;==================================
	; calculate end of sprite on screen for Xpos loop
	; also save for background restore

	lda	peasant_sprites_xsize,X
	clc
	adc	CURSOR_X
	sta	hdsb_width_smc+1
	sta	save_xend,Y

	;================================
	; calculate bottom of sprite for Ypos loop
	; also save for background restore

	lda	peasant_sprites_ysize,X
	sta	hdsb_ysize_smc+1
	clc
	adc	CURSOR_Y
	sta	save_yend,Y

	;================================
	; calculate peasant priority
	; based on head location
	; see chart later
	;	in theory only need to do this if PEASANT_Y changes

	lda	CURSOR_Y
	sec
	sbc	#48			; Y=48
	lsr				; div by 8
	lsr
	lsr
	clc
	adc	#2
	sta	PEASANT_PRIORITY

	;==================================
	; set up sprite pointers
	lda	peasant_sprites_data_l,X
	sta	h728_smc1+1
	sta	h728_smc2+1
	lda	peasant_sprites_data_h,X
	sta	h728_smc1+2
	sta	h728_smc2+2

	;==================================
	; set up mask pointers
	lda	peasant_mask_data_l,X
	sta	h728_smc3+1
	sta	h728_smc4+1
	lda	peasant_mask_data_h,X
	sta	h728_smc3+2
	sta	h728_smc4+2

	;===============================
	; main loop
	;	X = sprite pointer
	;	Y = col counter

	ldx	#0			; reset sprite pointer
	stx	CURRENT_ROW		; also zero out row counter

hgr_sprite_bm_yloop:


	; we need to re-calculate masks every 4th row

	lda	CURRENT_ROW
	and	#$3			; only update every 4th
	bne	mask_good


	;======================
	; recalculate mask
	;	assume max width 3?  This might change some day...

mask_recalc:

	txa				; save sprite pointer
	pha

	lda	CURRENT_ROW
	clc
	adc	CURSOR_Y
	tax				; X has row

	ldy	CURSOR_X		; Y has column
					; FIXME: we have multi-width now
	jsr	update_bg_mask

	pla				; restore sprite pointer
	tax

mask_good:

	lda	CURRENT_ROW

	clc
	adc	CURSOR_Y		; add in cursor_y

	; calc GBASL/GBASH

	tay				; get output ROW into GBASL/H
	lda	hposn_low,Y
	sta	GBASL
	lda	hposn_high,Y
	sta	GBASH			; always page2


	;============================
	; set up inner loop

	ldy	CURSOR_X

	lda	#0
	sta	SPRITE_TEMP
	sta	MASK_TEMP

hsbm_inner_loop:

	lda	MASK0
	bne	draw_sprite_skip

	;============================
	; not masked so actually draw

	;=========================
	; pick if even or odd

	lda	CURSOR_X
	ror
	bcs	hsbm_draw_sprite_odd

	;============================

hsbm_draw_sprite_even:

h728_smc1:
	lda	$d000,X		; load sprite value
	sta	TEMP_SPRITE
h728_smc3:
	lda	$d000,X		; load mask value

	jmp	hsbm_draw_sprite_both


hsbm_draw_sprite_odd:

h728_smc2:
        lda     $f000,X                 ; load sprite data

                                        ;            PSSS SSSS
                                        ; rol   C=P, SSSS SSST

                                        ; want to set bit7 to C?

	rol	SPRITE_TEMP
	rol
	sta	SPRITE_TEMP
	bcc	hsbm_pal0
hsbm_pal1:
	ora	#$80                    ; set pal bit
	bne     hsbm_pal_done
hsbm_pal0:
	and	#$7f                    ; clear pal bit

hsbm_pal_done:
        sta     TEMP_SPRITE

h728_smc4:
        lda     $f000,X                 ; load sprite data

	rol	MASK_TEMP
	rol
	sta	MASK_TEMP

hsbm_draw_sprite_both:
	eor	#$FF
	and	#$7F
	sta	TEMP_MASK

	; if mask is $7f then skip drawing
	cmp	#$7f
	beq	draw_sprite_skip

	; do actual sprite-ing

	lda	(GBASL),Y	; load background
	and	TEMP_MASK
	ora	TEMP_SPRITE

	sta	(GBASL),Y	; store out

draw_sprite_skip:

	inx			; increment sprite pointer
	iny			; increment column




hdsb_width_smc:
	cpy	#6
	bne	hsbm_inner_loop



;	inc	MASK_COUNTDOWN	; increment row

	inc	CURRENT_ROW
	lda	CURRENT_ROW

hdsb_ysize_smc:
	cmp	#28
	bne	hgr_sprite_bm_yloop

	rts


	;===================
	; update_bg_mask
	;===================
	; updates the drawing mask for 3d positioning
	;	based on colors on lo-res screen
	;
	; need to convert hi-res co-ords to lo-res coords
	;	xpos already the same
	;	ypos need to divide by four
	;	then need to get top/bottom nibble
	; 		rrrr rtii	top 5 bits row, bit 2 top/bottom

	; Column (xpos/7) in Y
	; Row in X
	; updates MASK0..MASK2

update_bg_mask:

	sty	xsave	; save xpos
mask_try_again:
	stx	ysave	; save ypos

	txa
	and	#$04	; see if odd/even in the lo-res lookup
	beq	bg_mask_even

	; setup mask based on odd/even

bg_mask_odd:
	lda	#$f0
	bne	bg_mask_mask		; bra

bg_mask_even:
	lda	#$0f
bg_mask_mask:
	sta	MASK

	; X is current row here

	; converting to which row in lores
	;	0 -> 0 low
	;	4 -> 0 high
	;	8 -> 1 low
	;	....
	;     191 -> 23 high

	txa
	lsr
	lsr		; need to divide by 8 then * 2
	lsr		; can't just div by 4 as we need to mask bottom bit
	asl		; because our lookup is multiple of two
	tax

	; set up row for mask lookup

	lda	gr_offsets,X
	sta	BASL
	lda	gr_offsets+1,X
	sta	BASH

	; read out current mask color

	lda	(BASL),Y

	; get high/low properly

	ldy	MASK
;	cpy	#$f0
;	bne	mask_bottom
	bpl	mask_bottom
mask_top:
	lsr
	lsr
	lsr
	lsr
;	jmp	mask_mask_mask
mask_bottom:
	and	#$0f		; ok to always do this?

mask_mask_mask:
	sta	MASK0

	; special cases?

	cmp	#$0			; 0 means collision, find mask
	bne	mask_not_zero		; by iteratively going down till

	; mask 0 here, which means can't walk there but doesn't give
	;	prioirty.  This can happen if there's a don't walk spot
	;	above you even if not on it. In this case, find the actual
	;	mask by looking down the screen until we find an actual
	;	proper mask value

	ldy	xsave

	ldx	ysave			; move to next lower lookup value
	inx
	inx
	inx
	inx
	jmp	mask_try_again

mask_not_zero:
	cmp	#$f			; priority F means always on top
	beq	mask_true

	cmp	PEASANT_PRIORITY
	beq	mask_false		; branch less than equal
	bcc	mask_false		; blt

mask_true:
	lda	#$ff
	sta	MASK0
	rts

mask_false:
	lda	#$00
	sta	MASK0
	rts


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; priorities
; 0 = collision
; 1 = bg = always draw		; Y-48
; 2 	0-55
; 3 	56-63			; 8/8+2 = 3
; 4 	64-71			; 16/8+2 = 4
; 5 	72-79
; 6 	80-87			; 32/8+2 = 6
; 7 	88-95
; 8 	96-103
; 9 	104-111
; 10 	112-119
; 11 	120-127
; 12 	128-135			; 8
; 13 	136-143
; 14	144-151
; 15 = fg = always hide
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;====================
; save area
;====================

ysave:
.byte $00
xsave:
.byte $00
