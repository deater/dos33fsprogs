	; Ootw

.include "zp.inc"
.include "hardware.inc"



ootw:
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

	lda     #>(planet_rle)
        sta     GBASH
	lda     #<(planet_rle)
        sta     GBASL
	jsr	load_rle_gr

	;=================================
	; copy to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current


	;=================================
	; setup vars
	lda	#22
	sta	PHYSICIST_Y
	lda	#20
	sta	PHYSICIST_X

	lda	#1
	sta	DIRECTION

	lda	#0
	sta	GAIT

game_loop:

	; check keyboard

	jsr	handle_keypress

	; copy background to current page

	jsr	gr_copy_to_current


	;=======================
	; draw pool ripples

	lda	FRAMEL
	and	#$30		; 0110 1100
	lsr
	lsr
	lsr
	tax

	lda	pool_ripples,X
	sta	INL
	lda	pool_ripples+1,X
	sta	INH

	lda	#9
	sta	XPOS
	lda	#30
	sta	YPOS

	jsr	put_sprite


	lda	FRAMEL
	and	#$30		; 0110 1100
	lsr
	lsr
	lsr
	clc
	adc	#2
	and	#$6
	tax

	lda	pool_ripples,X
	sta	INL
	lda	pool_ripples+1,X
	sta	INH


	lda	#27
	sta	XPOS
	lda	#30
	sta	YPOS

	jsr	put_sprite


	lda	FRAMEL
	and	#$30		; 0110 1100
	lsr
	lsr
	lsr
	clc
	adc	#4
	and	#$6
	tax

	lda     #18
	sta     XPOS
	lda     #28
	sta     YPOS

	jsr	put_sprite



	; draw physicist

	jsr	draw_physicist


	; draw slugs

	jsr	draw_slugs

	; draw foreground

	lda	#>foreground_plant
	sta	INH
	lda	#<foreground_plant
	sta	INL

        lda     #4
        sta     XPOS
        lda     #30
        sta     YPOS

	jsr	put_sprite

	; page flip

	jsr	page_flip


	; inc frame count

	inc	FRAMEL
	bne	frame_no_oflo
	inc	FRAMEH

frame_no_oflo:

	; pause?

	; loop forever

	jmp	game_loop


;======================================
; handle keypress
;======================================

handle_keypress:

	lda	KEYPRESS						; 4
	bpl	no_keypress						; 3

									; -1

	and	#$7f		; clear high bit

check_quit:
	cmp	#'Q'
	beq	quit
	cmp	#27
	bne	check_left
quit:
	jmp	quit_level

check_left:
	cmp	#'A'
	beq	left
	cmp	#$8		; left arrow
	bne	check_right
left:
	lda	DIRECTION
	bne	face_left

	dec	PHYSICIST_X
	bpl	just_fine_left
too_far_left:
	inc	PHYSICIST_X
just_fine_left:

	inc	GAIT
	inc	GAIT

	jmp	done_keypress

face_left:
	lda	#0
	sta	DIRECTION
	sta	GAIT
	jmp	done_keypress

check_right:
	cmp	#'D'
	beq	right
	cmp	#$15
	bne	unknown
right:
	lda	DIRECTION
	beq	face_right

	inc	PHYSICIST_X
	lda	PHYSICIST_X
	cmp	#37
	bne	just_fine_right
too_far_right:
	dec	PHYSICIST_X
just_fine_right:


	inc	GAIT
	inc	GAIT
	jmp	done_keypress

face_right:
	lda	#0
	sta	GAIT
	lda	#1
	sta	DIRECTION
	jmp	done_keypress

unknown:
done_keypress:
	bit	KEYRESET	; clear the keyboard strobe		; 4


no_keypress:
	rts								; 6



;======================================
; draw physicist
;======================================

draw_physicist:

	lda	GAIT
	and	#$f
	sta	GAIT
	tax

	lda	phys_walk_progression,X
	sta	INL

	lda	phys_walk_progression+1,X
	sta	INH

	lda	PHYSICIST_X
	sta	XPOS
	lda	PHYSICIST_Y
	sta	YPOS

	lda	DIRECTION
	bne	facing_right

facing_left:
        jmp	put_sprite

facing_right:
	jmp	put_sprite_flipped


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


;===========================
; quit_level
;===========================

quit_level:
	jsr	TEXT
	jsr	HOME
	lda	KEYRESET		; clear strobe

	lda	#0
	sta	DRAW_PAGE

	lda	#<end_message
	sta	OUTL
	lda	#>end_message
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print

wait_loop:
	lda	KEYPRESS
	bpl	wait_loop

	lda	KEYRESET		; clear strobe

	jmp	ootw


end_message:
.byte	8,10,"PRESS RETURN TO CONTINUE",0
.byte	11,20,"ACCESS CODE: IH8S",0

.include "text_print.s"
.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "gr_putsprite.s"
.include "gr_offsets.s"
.include "ootw_backgrounds.inc"
.include "ootw_sprites.inc"
