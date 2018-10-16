; Finally Arriving

; Simple Text/GR split

; Some zero-page action
;TFV_X = 0
;TFV_Y = 1


arriving_there:


	;===================
	; init screen
	bit	KEYRESET

setup_arrival:


	;===================
	; init vars

	lda	#0
	sta	FRAME
	sta	FRAMEH
	sta	TFV_X

	lda	#8
	sta	DRAW_PAGE

;	lda	#22
;	sta	TFV_Y

	;=============================
	; Load graphic page0

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00


	lda	#<arrival
	sta	GBASL
	lda	#>arrival
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
arloopA:ldx	#7							; 2
arloopB:dex								; 2
	bne	arloopB							; 2nt/3
	dey								; 2
	bne	arloopA							; 2nt/3

	jmp	ar_begin_loop
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



ar_begin_loop:

	; 3120
	;   -4	set_text
	;  -25	inc frame
	;  -17	set state
	;  -11  move
	;   -8	check if done
	;=======
	; 3055

	bit	SET_TEXT						; 4

	; Update frame count
	; no carry:	13+(12) = 25
	; carry:	13+12 = 25

	inc	FRAME							; 5
	lda	FRAME							; 3
	cmp	#12							; 2
	bne	ar_waste_12						; 3
								;============
								;        13

									; -1
	lda	#0							; 2
	sta	FRAME							; 3
	inc	FRAMEH							; 5
	jmp	ar_no_carry						; 3
								;============
								;        12
ar_waste_12:
	lda	$0	; 3
	lda	$0	; 3
	lda	$0	; 3
	lda	$0	; 3

ar_no_carry:

	;=================
	; check if done
	;=================

	lda	FRAMEH							; 3
	cmp	#35							; 2
	bne	ar_not_done						; 3
	jmp	ar_all_done
ar_not_done:
								;===========
								;         8

	; Set the state
	; STATE0 = 5+4+(5)+3 = 17
	; STATE2 = 5+5+4+3     = 17
	; STATE4 = 5+5+2+3+(2) =17


	cmp	#5							; 2
	bcs	ar_state_notzero	; bge				; 3
ar_state_zero:
									; -1
	lda	$0	; nop						; 3
	nop								; 2
	ldx	#0							; 2
	jmp	ar_set_state						; 3
ar_state_notzero:
	cmp	#25							; 2
	bcs	ar_state_four		; bge				; 3
ar_state_two:
									; -1
	ldx	#2							; 2
	jmp	ar_set_state						; 3
ar_state_four:
	nop								; 2
	ldx	#4							; 2

ar_set_state:
	stx	STATE							; 3

	;=====
	; Move
	; if move, 6+5=11
	; if not move, 6+5=11
	lda	FRAME		; only ove if FRAME==0			; 3
	beq	ar_move							; 3

ar_nomove:								; -1
	lda	$0	;nop						; 3
	jmp	ar_done_move						; 3
ar_move:
	inc	TFV_X							; 5
ar_done_move:




	; Try X=86 Y=7 cycles=3053 R2
	nop

	ldy	#7							; 2
arloop8:ldx	#86							; 2
arloop9:dex								; 2
	bne	arloop9							; 2nt/3
	dey								; 2
	bne	arloop8							; 2nt/3


	;==========================
	; Set graphics mode, delay until done displaying the yard
	;==========================

	bit	SET_GR			; 4

	; Try X=75 Y=15 cycles=5716

	ldy	#15							; 2
arloop6:ldx	#75							; 2
arloop7:dex								; 2
	bne	arloop7							; 2nt/3
	dey								; 2
	bne	arloop6							; 2nt/3

	;===============================
	; Draw the Field
	;===============================
draw_the_field:
	jsr	erase_field					; 6+1249

	;===============================
	; Draw one of three states
	;===============================
	; STATE0 = draw nothing
	; STATE2 = draw open door + walking TFV+susie
	; STATE4 = draw TFV on bird

	; Set up jump table that runs same speed on 6502 and 65c02
	ldy	STATE						; 3
	lda	ar_jump_table+1,y				; 4
	pha							; 3
	lda	ar_jump_table,y					; 4
	pha							; 3
	rts							; 6

                                                        ;=============
                                                        ;        23

ar_jump_table:
	.word   (ar_state0-1)
	.word   (ar_state2-1)
	.word   (ar_state4-1)

ar_back_from_jumptable:


	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================

	; do_nothing should be      3640 (bottom of GR screen)
	;			    4550 (vblank)
	;			   -1255 (clear yard)
	;			     -23 (setup jump table)
	;			   -5259 (in state code)
	;			     -10 keypress
	;			===========
	;			     1643


	; Try X=163 Y=2 cycles=1643

	ldy	#2							; 2
arloop1:ldx	#163							; 2
arloop2:dex								; 2
	bne	arloop2							; 2nt/3
	dey								; 2
	bne	arloop1							; 2nt/3


	lda	KEYPRESS				; 4
	bpl	ar_no_keypress				; 3
	jmp	ar_all_done
ar_no_keypress:

	jmp	ar_begin_loop				; 3

ar_all_done:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6



	;=====================
	; State0 : do nothing
	;=====================
	; Delay 5259
	;      -2072
	;         -3
	;===========
	;       3184

ar_state0:


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


	; Try X=211 Y=3 cycles=3184

	ldy	#3							; 2
arloopT:ldx	#211							; 2
arloopU:dex								; 2
	bne	arloopU							; 2nt/3
	dey								; 2
	bne	arloopT							; 2nt/3

	jmp	ar_back_from_jumptable				; 3



	;======================================================
	; State2 : draw walking
	;======================================================
	; 1490 = 1471+19 (draw tfv)
	;   33 (draw susie)
	; 2072 (draw bird)
	; 1661 (draw door)
	;    3 (return)
	;==========
	; 5259

ar_state2:

	lda	TFV_X					; 3
	sta	XPOS					; 3
	lda     #24					; 2
	sta	YPOS					; 3

	lda	FRAMEH					; 3
	and	#$1					; 2
	beq	ar_walk					; 3
						;===========
						;	 19


ar_stand:
	; draw deater standing				; -1
	lda	#>tfv_stand_right			; 2
	sta	INH					; 3
        lda	#<tfv_stand_right			; 2
	sta	INL					; 3
	jsr	put_sprite                              ; 6

	; need to waste 61 cycles
	lda	#34					; 2
	jsr	delay_a					; 25+34 = 59

	jmp	ar_susie				; 3
                                                        ;=========
                                                        ; 18 + 1392 = 1410


ar_walk:
	; draw deater walking
	lda	#>tfv_walk_right			; 2
	sta	INH					; 3
        lda	#<tfv_walk_right			; 2
	sta	INL					; 3
	jsr	put_sprite                              ; 6
                                                        ;=========
                                                        ; 16 + 1455 = 1471


	; draw susie
	; 33 cycles
ar_susie:
	; draw susie at TFV_X-5, IFF TFV_X>10
	lda	TFV_X					; 3
	sec						; 2
	sbc	#5					; 2
	tax						; 2
	cpx	#5					; 2
	bcs	ar_yes_susie	; bge			; 3
						;============
						;	14
ar_no_susie:
							; -1
	inc	TFV_Y					; 5
	dec	TFV_Y					; 5
	nop						; 2
	nop						; 2
	lda	$0					; 3
	jmp	ar_done_susie				; 3
						;============
						;        19
ar_yes_susie:
	lda	#0					; 2
	sta	$450,X					; 5
	sta	$451,X					; 5
	lda	#$0f					; 2
	sta	$452,X					; 5
ar_done_susie:
						;===========
						;	 19


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
ar_draw_door:
	; draw door
	lda	#>door_sprite				; 2
	sta	INH					; 3
        lda	#<door_sprite				; 2
	sta	INL					; 3

	lda	#5					; 2
	sta	XPOS					; 3
	lda     #24					; 2
	sta	YPOS					; 3

	jsr	put_sprite                              ; 6
                                                        ;=========
                                                        ; 26 + 1635 = 1661



	jmp	ar_back_from_jumptable				; 3



	;======================================================
	; State4 : on bird
	;======================================================
	;  5259
	; -2227 = 2208+19 (draw bird)
	; -1661 (draw door)
	;    -6 (return)
	;==========
	; 1365

ar_state4:

	lda	TFV_X					; 3
	sta	XPOS					; 3
	lda     #20					; 2
	sta	YPOS					; 3

	lda	FRAMEH					; 3
	and	#$1					; 2
	beq	ar_bwalk				; 3
						;===========
						;	 19


ar_bstand:
	; draw bird/rider standing				; -1
	lda	#>bird_rider_stand_right		; 2
	sta	INH					; 3
        lda	#<bird_rider_stand_right		; 2
	sta	INL					; 3
	jsr	put_sprite                              ; 6

	jmp	ar_done_bwalk				; 3
                                                        ;=========
                                                        ; 18 + 2190 = 2208


ar_bwalk:
	; draw bird/rider walking
	lda	#>bird_rider_walk_right			; 2
	sta	INH					; 3
        lda	#<bird_rider_walk_right			; 2
	sta	INL					; 3
	jsr	put_sprite                              ; 6
	nop
	inc	TFV_Y
	inc	TFV_Y
	inc	TFV_Y
                                                        ;=========
                                                        ; 16 + 2175

ar_done_bwalk:
	; delay

	; Try X=67 Y=4 cycles=1365

	ldy	#4							; 2
arloopV:ldx	#67							; 2
arloopW:dex								; 2
	bne	arloopW							; 2nt/3
	dey								; 2
	bne	arloopV							; 2nt/3

	jmp	ar_draw_door


	;======================
	; erase field
	;======================
	; erase to green 4-25, 24-35

        ; 1209 cycles
	; 4+ 21*[30 + 5 ] + 5 = 744
erase_field:

	lda     #$44 		; green					; 2
	ldx	#20		; 4 - 25				; 2
field_loop:
	sta	$628+9,X	; 24					; 5
	sta	$6a8+9,X	; 26					; 5
	sta	$728+9,X	; 28					; 5
	sta	$7a8+9,X	; 30					; 5
	sta	$450+9,X	; 32					; 5
	sta	$4d0+9,X	; 34					; 5

	dex								; 2
	bpl	field_loop						; 3
									; -1
	rts								; 6

