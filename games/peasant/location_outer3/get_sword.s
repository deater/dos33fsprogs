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
	sta	KEEPER_COUNT

get_sword_loop:

	;=======================
	; move to next frame

	dec	KEEPER_COUNT

	;=======================
	; see if done animation

	lda	KEEPER_COUNT
	beq	done_get_sword

	;========================
	; draw_scene

	jsr	update_screen

	;========================
	; draw base sprite

	lda	PEASANT_X
	sta	SPRITE_X
	lda	PEASANT_Y
	sta	SPRITE_Y

	ldx	#13				; base keeper sprite

        jsr     hgr_draw_sprite_mask


	;=====================
	; increment frame

	inc	FRAME


	;=======================
	; flip page

;       jsr     wait_vblank

	jsr	hgr_page_flip

	jmp	get_sword_loop

done_get_sword:
	rts


sword_y_offset:
.byte	0

.if 0
keeper_x:
.byte  28,28,28,28
.byte  29,29,29,29



keeper_y:
.byte	67,66,65,64
.byte   63,62,62,61


which_keeper_sprite:
.byte   1, 1, 1, 1
.byte   1, 1, 0, 0

.endif
