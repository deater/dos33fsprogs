	;====================================
	; draw pointer
	;====================================


draw_pointer:

	lda	#0
	sta	OVER_LEMMING

	jsr	save_bg_14x14		; save old bg

	; for now assume the only 14x14 sprites are the pointers

	lda	CURSOR_X
	sta	XPOS
        lda     CURSOR_Y
	sta	YPOS

	; see if over lemming

	; TODO

	; see if X1 < X < X2
;	lda	CURSOR_X
;	ldy	#LOCATION_SPECIAL_X1
;	cmp	(LOCATION_STRUCT_L),Y
;	bcc	finger_not_special	; blt

;	ldy	#LOCATION_SPECIAL_X2
;	cmp	(LOCATION_STRUCT_L),Y
;	bcs	finger_not_special	; bge

	; see if Y1 < Y < Y2
;	lda	CURSOR_Y
;	ldy	#LOCATION_SPECIAL_Y1
;	cmp	(LOCATION_STRUCT_L),Y
;	bcc	finger_not_special	; blt

;	ldy	#LOCATION_SPECIAL_Y2
;	cmp	(LOCATION_STRUCT_L),Y
;	bcs	finger_not_special	; bge



	lda     #<crosshair_sprite_l
	sta	INL
	lda     #>crosshair_sprite_l
	sta	INH
	jsr	hgr_draw_sprite_14x14

	rts
