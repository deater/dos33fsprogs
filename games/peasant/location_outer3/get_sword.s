	; note: no longer on fire once have helm on?

	; appears in your hand when "The fabled Trog-Sword"
	;	message appears
	;
	; keeper starts to retreat
	;	2 frames, raise sword a bit
	;	raise it whole way up, then raise it back down
	;	then curtain begins to part


get_sword:

	lda	#19
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


