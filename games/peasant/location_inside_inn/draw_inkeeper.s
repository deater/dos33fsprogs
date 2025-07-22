
	;=============================
	; draw inkeeper
	;=============================
draw_inkeeper:

	; TODO: is he always drawn?

	lda	FRAME
	and	#$7
	tax

	lda	keeper_sprites_l,X
	sta	INL
	lda	keeper_sprites_h,X
	sta	INH

        lda     #10		; 70/7
        sta     CURSOR_X
        lda     #60
        sta     CURSOR_Y

        jsr     hgr_draw_sprite

done_innkeeper:
	rts



keeper_sprites_l:
	.byte <keeper0,<keeper1,<keeper2,<keeper3
	.byte <keeper3,<keeper2,<keeper1,<keeper0

keeper_sprites_h:
	.byte >keeper0,>keeper1,>keeper2,>keeper3
	.byte >keeper3,>keeper2,>keeper1,>keeper0
