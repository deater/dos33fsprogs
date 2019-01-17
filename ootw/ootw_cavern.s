; Cavern scene (with the slugs)



ootw_cavern:
	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR



	;===========================
	; Clear both bottoms

	lda	#$4
	sta	DRAW_PAGE
	jsr     clear_bottom

	lda	#$0
	sta	DRAW_PAGE
	jsr     clear_bottom

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE


	;=============================
	; Load background to $c00

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL			; load image off-screen $c00

	lda     #>(cavern_rle)
        sta     GBASH
	lda     #<(cavern_rle)
        sta     GBASL
	jsr	load_rle_gr

	;=================================
	; copy to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current


	;=================================
	; setup vars
;	lda	#22
;	sta	PHYSICIST_Y
;	lda	#20
;	sta	PHYSICIST_X

;	lda	#1
;	sta	DIRECTION

	lda	#0
	sta	GAIT
	sta	GAME_OVER

	lda	#30
	sta	TENTACLE_PROGRESS

	;============================
	; Cavern Loop (not a palindrome)
	;============================
cavern_loop:

	; check keyboard

	jsr	handle_keypress_cavern

	;================================
	; copy background to current page

	jsr	gr_copy_to_current


	;===============
	; draw physicist

	jsr	draw_physicist

	;===============
	; draw slugs

	jsr	draw_slugs

	;======================
	; draw falling boulders


	;=======================
	; page flip

	jsr	page_flip

	;========================
	; inc frame count

	inc	FRAMEL
	bne	frame_no_oflo_c
	inc	FRAMEH

frame_no_oflo_c:

	; pause?

	; see if game over
	lda	GAME_OVER
	cmp	#$ff
	beq	done_cavern

	; see if left level
	cmp	#1
	bne	still_in_cavern

	lda	#37
	sta	PHYSICIST_X
	jmp	ootw_pool

still_in_cavern:
	; loop forever

	jmp	cavern_loop

done_cavern:
	rts


;======================================
; handle keypress
;======================================

handle_keypress_cavern:

	lda	KEYPRESS						; 4
	bpl	no_keypress_c						; 3

									; -1

	and	#$7f		; clear high bit

check_quit_c:
	cmp	#'Q'
	beq	quit_c
	cmp	#27
	bne	check_left_c
quit_c:
	lda	#$ff
	sta	GAME_OVER
	rts

check_left_c:
	cmp	#'A'
	beq	left_c
	cmp	#$8		; left arrow
	bne	check_right_c
left_c:
	lda	DIRECTION
	bne	face_left_c

	dec	PHYSICIST_X
	bpl	just_fine_left_c
too_far_left_c:

	lda	#1
	sta	GAME_OVER
	rts

just_fine_left_c:

	inc	GAIT
	inc	GAIT

	jmp	done_keypress_c

face_left_c:
	lda	#0
	sta	DIRECTION
	sta	GAIT
	jmp	done_keypress_c

check_right_c:
	cmp	#'D'
	beq	right_c
	cmp	#$15
	bne	unknown_c
right_c:
	lda	DIRECTION
	beq	face_right_c

	inc	PHYSICIST_X
	lda	PHYSICIST_X
	cmp	#37
	bne	just_fine_right_c
too_far_right_c:
	dec	PHYSICIST_X
just_fine_right_c:


	inc	GAIT
	inc	GAIT
	jmp	done_keypress_c

face_right_c:
	lda	#0
	sta	GAIT
	lda	#1
	sta	DIRECTION
	jmp	done_keypress_c

unknown_c:
done_keypress_c:
	bit	KEYRESET	; clear the keyboard strobe		; 4


no_keypress_c:
	rts								; 6


;==================================
; draw slugs
;==================================

slugg0_out:	.byte	$1
slugg0_x:	.byte	$01
slugg0_dir:	.byte	$1
slugg0_gait:	.byte	$0

; ___  _-_

draw_slugs:

	lda	slugg0_out
	beq	slug_done		; don't draw if not there

	inc	slugg0_gait

	lda	slugg0_gait
	and	#$1f
	cmp	#$00
	bne	slug_no_move

slug_move:
	lda	slugg0_x
	clc
	adc	slugg0_dir
	sta	slugg0_x

	cmp	#37
	beq	remove_slug

slug_no_move:

	lda	slugg0_gait
	and	#$10
	beq	slug_squinched

slug_flat:
	lda	#<slug1
	sta	INL
	lda	#>slug1
	sta	INH
	bne	slug_selected

slug_squinched:
	lda	#<slug2
	sta	INL
	lda	#>slug2
	sta	INH

slug_selected:


	lda	slugg0_x
	sta	XPOS
	lda	#34
	sta	YPOS

	lda	DIRECTION
	bmi	slug_right

slug_left:
        jsr	put_sprite
	jmp	slug_done

slug_right:
	jsr	put_sprite_flipped

slug_done:
	rts

remove_slug:
	lda	#0
	sta	slugg0_out
	rts
