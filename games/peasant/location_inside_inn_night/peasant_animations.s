	;==============================
	;==============================
	; falling pot
	;==============================
	;==============================

	; 0: p0 flat feet
	; 1: p1 right hand up
	; 2: p2 right hand up higher
	; 3: p3 right hand up to top of head
	; 4: p4 stand on tiptoes (up)
	; 5: p3  (down)
	; 6: p4  (up)
	; 7: p3  (down)
	; 8:  erase pot
	;     p4 (up), pot0 tilts right
	; 9:  p4 (up), pot5 center
	; 10: p4 (up), pot1 left
	; 11: p4 (up), pot5 center
	; 12: p4 (up)  pot0 right
	; 13: p4 (up)  pot2 falls a bit
	; 14: p4 (up)  pot3 falls more rotating
	; 15: p4 (up)  pot4 falls just above head
	; 16: p5 falls on head, arms up
	; 17: p6 arms down  		    wiggle arms up and down 4 times
	; 18: p5 arms up
	; 19: p6 arms down
	; 20: p5 arms up
	; 21: p6 arms down
	; 22: p5 arms up
	; 23: p6 arms down

animate_falling_pot:

	lda	#0
	sta	POT_COUNT
	sta	FRAME

	lda	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

falling_loop:

	; remove pot from shelf frame 8

	lda	POT_COUNT
	cmp	#8
	bne	pot_still_there

	jsr	remove_pot_from_shelf

pot_still_there:

	jsr	update_screen

	; draw peasant

	ldy	POT_COUNT
	ldx	peasant_sequence,Y
	bmi	skip_draw_pot

	lda	pantry_peasant_l,X
	sta	INL
	lda	pantry_peasant_h,X
	sta	INH

	lda	#26
	sta	CURSOR_X
	lda	pantry_peasant_y,X
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	; draw pot

	ldy	POT_COUNT
	ldx	pot_sequence,Y
	bmi	skip_draw_pot

	lda	pantry_pot_l,X
	sta	INL
	lda	pantry_pot_h,X
	sta	INH

	lda	pantry_pot_x,X
	sta	CURSOR_X
	lda	pantry_pot_y,X
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

skip_draw_pot:

	; flip page

	jsr	hgr_page_flip

	inc	FRAME			; slow down animation
	lda	FRAME
	and	#$3
	bne	falling_loop

	inc	POT_COUNT
	lda	POT_COUNT
	cmp	#24
	bne	falling_loop

done_falling:
	lda	SUPPRESS_DRAWING
	and	#<(~SUPPRESS_PEASANT)
	sta	SUPPRESS_DRAWING

	rts

peasant_sequence:
	.byte 0,1,2,3, 4,3,4,3
	.byte 4,4,4,4, 4,4,4,4
	.byte 5,6,5,6, 5,6,5,6


pantry_peasant_y:
	.byte 68,68,68,68, 65,67,67


pantry_peasant_l:
	.byte <pantry_peasant0,<pantry_peasant1,<pantry_peasant2
	.byte <pantry_peasant3,<pantry_peasant4,<pantry_peasant5
	.byte <pantry_peasant6

pantry_peasant_h:
	.byte >pantry_peasant0,>pantry_peasant1,>pantry_peasant2
	.byte >pantry_peasant3,>pantry_peasant4,>pantry_peasant5
	.byte >pantry_peasant6

pot_sequence:
	.byte $FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF
	.byte 0,5,1,5, 0,2,3,4
	.byte $FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF

pantry_pot_x:
	.byte 24,24,25,25,26,25

pantry_pot_y:
	.byte 41,40,41,46,55,42

pantry_pot_l:
	.byte <pantry_pot0,<pantry_pot1,<pantry_pot2
	.byte <pantry_pot3,<pantry_pot4,<pantry_pot5

pantry_pot_h:
	.byte >pantry_pot0,>pantry_pot1,>pantry_pot2
	.byte >pantry_pot3,>pantry_pot4,>pantry_pot5




	;==============================
	;==============================
	; remove pot from shelf
	;==============================
	;==============================

remove_pot_from_shelf:

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE

	lda	#$40			; draw to $6000
	sta	DRAW_PAGE

	lda	#<pantry_no_pot
	sta	INL
	lda	#>pantry_no_pot
	sta	INH

	lda	#25			; 175/7 = 25
	sta	CURSOR_X
	lda	#42
	sta	CURSOR_Y

	jsr	hgr_draw_sprite


	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE
	rts



	;==============================
	;==============================
	; roll in bed
	;==============================
	;==============================
roll_in_bed:
	; UP->LEFT_>UP->RIGHT->up->left->up

	lda	#0
	sta	FRAME

	lda	#SUPPRESS_PEASANT
	sta	SUPPRESS_DRAWING

	lda	#$20		; draw to page2
	sta	DRAW_PAGE
	bit	PAGE1		; page1 should be clear?

roll_in_bed_loop:

	;========================
	; update screen

	jsr	update_screen

	;=========================
	; draw peasant

	lda	FRAME
	lsr
	lsr
	lsr	; slow down a bit
	tay

	ldx	roll_in_bed_pattern,Y
	bmi	done_peasant_sleep

	lda	sleep_sprite_l,X
	sta	INL
	lda	sleep_sprite_h,X
	sta	INH

	lda	#32			; 224/7 = 32
	sta	CURSOR_X
	lda	#131
	sta	CURSOR_Y

	jsr	hgr_draw_sprite

	;===========================
	; special case if FRAME<16

	lda	FRAME
	cmp	#16
	bcs	skip_wipe

	;=====================
	; do reverse wipe

	jsr	wipe_center_to_scene

skip_wipe:

	jsr	hgr_page_flip

	inc	FRAME

	jmp	roll_in_bed_loop

done_peasant_sleep:

	lda	#0
	sta	SUPPRESS_DRAWING

	rts


roll_in_bed_pattern:
	.byte 0,1,0,2,0,1,0,2,0,$FF


sleep_sprite_l:
	.byte <sleep0,<sleep1,<sleep2

sleep_sprite_h:
	.byte >sleep0,>sleep1,>sleep2
