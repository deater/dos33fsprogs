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
	sta	ADV_Y
	lda	#20
	sta	ADV_X

game_loop:

	; check keyboard

	jsr	handle_keypress

	; copy background to current page

	jsr	gr_copy_to_current

	; draw adventurer

	lda	#>stand_right
	sta	INH
	lda	#<stand_right
	sta	INL

done_walking:


        lda     ADV_X
        sta     XPOS
        lda     ADV_Y
        sta     YPOS

        jsr     put_sprite



	; draw bad guys

	; draw foreground

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
	dec	ADV_X
	jmp	done_keypress

check_right:
	cmp	#'D'
	beq	right
	cmp	#$15
	bne	unknown
right:
	inc	ADV_X
	jmp	done_keypress

unknown:
done_keypress:
	bit	KEYRESET	; clear the keyboard strobe		; 4


no_keypress:
	rts								; 6



;.include "wait_keypress.s"
.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_fast_clear.s"
.include "gr_copy.s"
.include "gr_putsprite.s"
.include "gr_offsets.s"
.include "ootw_backgrounds.inc"
.include "ootw_sprites.inc"

