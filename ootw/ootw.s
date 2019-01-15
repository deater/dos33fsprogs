	; Ootw

.include "zp.inc"
.include "hardware.inc"



title_screen:
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

	; draw physicist

	jsr	draw_physicist


	; draw bad guys

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

check_left:
	cmp	#'A'
	beq	left
	cmp	#$8		; left arrow
	bne	check_right
left:
	lda	DIRECTION
	bne	face_left

	dec	PHYSICIST_X
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


.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "gr_putsprite.s"
.include "gr_offsets.s"
.include "ootw_backgrounds.inc"
.include "ootw_sprites.inc"

