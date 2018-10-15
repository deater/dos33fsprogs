; Leaving house

; Simple Text/GR split

; STATE??? Wait 1 s
; STATE??? Open door
; STATE1 = Walk over to bird (3s? 20steps? so at ~5Hz? 12 ticks per step?)
;   56789012345678901234
; STATE2 = get on bird
; STATE3 = ride off on bird


; Some zero-page action
TFV_X = 0
TFV_Y = 1


leaving_home:


	;===================
	; init screen
	bit	KEYRESET

setup_leaving:


	;===================
	; init vars

	lda	#0
	sta	FRAME
	sta	FRAMEH

	lda	#8
	sta	DRAW_PAGE
	lda	#5
	sta	TFV_X
	lda	#22
	sta	TFV_Y

	;=============================
	; Load graphic page0

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00


	lda	#<leaving
	sta	GBASL
	lda	#>leaving
	sta	GBASH
	jsr	load_rle_gr

	lda	#$a0
	ldy	#10
	jsr	clear_page_loop			; make top 6 lines spaces

	lda	#0
	sta	DRAW_PAGE

	bit	PAGE0

	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

	jsr	gr_copy_to_current		; 6+ 9292

	; now we have 322 left

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	jsr	draw_moon_sky						; 6+54

	; 322 - 12 = 310
	; - 3 for jmp
	; 307	- 60 for sky = 247

	; Try X=9 Y=6 cycles=307
	; Try X=7 Y=6 cycles=247

        ldy	#6							; 2
lvloopA:ldx	#7							; 2
lvloopB:dex								; 2
	bne	lvloopB							; 2nt/3
	dey								; 2
	bne	lvloopA							; 2nt/3

	jmp	lv_begin_loop
.align  $100


	;================================================
	; Leaving Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; want 12*4 = 48 lines of TEXT = 3120-4=3116
	; want 136-48 = 88 lines of undisturbed LORES = 5720 - 4 = 5716
	; 	lores lines 20-33 (80 - 135) are changing
	;	so don't do much then
	; want 192-136=56 lines of LORES = 3640



lv_begin_loop:

	; 3120
	;   -4	set_text
	;  -25	inc frame
	;   -8	check if done
	;=======
	; 3083

	bit	SET_TEXT						; 4

	; Update frame count
	; no carry:	13+(12) = 25
	; carry:	13+12 = 25

	inc	FRAME							; 5
	lda	FRAME							; 3
	cmp	#12							; 2
	bne	lv_waste_12						; 3
								;============
								;        13

									; -1
	lda	#0							; 2
	sta	FRAME							; 3
	inc	FRAMEH							; 5
	jmp	lv_no_carry						; 3
								;============
								;        12
lv_waste_12:
	lda	$0	; 3
	lda	$0	; 3
	lda	$0	; 3
	lda	$0	; 3

lv_no_carry:

	;=================
	; check if done
	;=================

	lda	FRAMEH							; 3
	cmp	#25							; 2
	bne	lv_not_done						; 3
	jmp	lv_all_done
lv_not_done:
								;===========
								;         8

	; Try X=204 Y=3 cycles=3079 R4
	nop
	nop

	ldy	#3							; 2
lvloop8:ldx	#204							; 2
lvloop9:dex								; 2
	bne	lvloop9							; 2nt/3
	dey								; 2
	bne	lvloop8							; 2nt/3

	bit	SET_GR			; 4

	; Try X=75 Y=15 cycles=5716

	ldy	#15							; 2
lvloop6:ldx	#75							; 2
lvloop7:dex								; 2
	bne	lvloop7							; 2nt/3
	dey								; 2
	bne	lvloop6							; 2nt/3

	;===============================
	; do stuff
	;===============================

	jsr	erase_yard					; 6+1249

	; draw deater
	lda	#>tfv_stand_right			; 2
	sta	INH					; 3
        lda	#<tfv_stand_right			; 2
	sta	INL					; 3

	lda	#20					; 2
	sta	XPOS					; 3
	lda     #22					; 2
	sta	YPOS					; 3

	jsr	put_sprite                              ; 6
                                                        ;=========
                                                        ; 26 + 1392 = 1418

	; draw susie
	ldx	#15					; 2
	lda	#0					; 2
	sta	$450,X					; 5
	sta	$451,X					; 5
	lda	#$0f					; 2
	sta	$452,X					; 5
							;=========
							; 21

	; draw bird
	lda	#>bird_stand_right_sprite		; 2
	sta	INH					; 3
        lda	#<bird_stand_right_sprite		; 2
	sta	INL					; 3

	lda	#24					; 2
	sta	XPOS					; 3
	lda     #20					; 2
	sta	YPOS					; 3

	jsr	put_sprite                              ; 6
                                                        ;=========
                                                        ; 26 + 2046 = 2072

	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================



	; do_nothing should be      3640 (bottom of GR screen)
	;			    4550 (vblank)
	;			   -1255 (clear yard)
	;                          -1418 (draw tfv)
	;			   -2072 (draw bird)
	;                            -21 (draw susie)
	;			     -10 keypress
	;			===========
	;			    3414

	; Try X=67 Y=10 cycles=3411 R3
	lda	$0

	ldy	#10							; 2
lvloop1:ldx	#67							; 2
lvloop2:dex								; 2
	bne	lvloop2							; 2nt/3
	dey								; 2
	bne	lvloop1							; 2nt/3

	lda	KEYPRESS				; 4
	bpl	lv_no_keypress				; 3
	jmp	lv_all_done
lv_no_keypress:

	jmp	lv_begin_loop				; 3

lv_all_done:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6





        ; 1209 cycles
	; 4+ 31*[35 + 5 ] + 5 = 1249
erase_yard:

	lda     #$44 		; green					; 2
	ldx	#30		; 9 - 40				; 2
yard_loop:
	sta	$528+9,X	; 20					; 5
	sta	$5a8+9,X	; 22					; 5
	sta	$628+9,X	; 24					; 5
	sta	$6a8+9,X	; 26					; 5
	sta	$728+9,X	; 28					; 5
	sta	$7a8+9,X	; 30					; 5
	sta	$450+9,X	; 32					; 5

	dex								; 2
	bpl	yard_loop						; 3
									; -1
	rts								; 6

