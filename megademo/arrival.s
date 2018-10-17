; Finally Arriving

; Simple Text/GR split

; Some zero-page action
;TFV_X = 0
;TFV_Y = 1
TFG_X = 2
HEART_X = 3
HEART_Y = 4

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

	lda	#0
	sta	TFV_X

	lda	#8
	sta	DRAW_PAGE

	lda	#14
	sta	HEART_X

	lda	#20
	sta	HEART_Y

	lda	#22
	sta	TFG_X


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
	; Arrival Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; want 12*4 = 48 lines of TEXT = 3120-4=3116
	; want 144-48 = 96 lines of undisturbed LORES = 6240 - 4 = 6236
	; 	lores lines 24-36 (80 - 143) are changing
	;	so don't do much then
	; want 192-144=48 lines of LORES = 3120



ar_begin_loop:

	; 3120
	;   -4	set_text
	;  -25	inc frame
	;  -17	set state
	;  -43  move
	;   -8	check if done
	;=======
	; 3023

	bit	SET_TEXT						; 4

	;====================
	; Update frame count
	;====================
	; no carry:	13+(12) = 25
	; carry:	13+12 = 25

	inc	FRAME							; 5
	lda	FRAME							; 3
	cmp	#20							; 2
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
	cmp	#45							; 2
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
	cmp	#16							; 2
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

	;====================
	; Move TFV
	;====================
	; if move, 6+13=19
	; if not move, 6+13=19
	lda	FRAME		; only move if FRAME==0			; 3
	beq	arv_move						; 3

arv_nomove:								; -1
	lda	$0	;nop						; 3
	lda	$0	;nop						; 3
	lda	$0	;nop						; 3
	nop								; 2
	jmp	arv_done_move						; 3
arv_move:
	lda	STATE							; 3
	lsr								; 2
	clc								; 2
	adc	TFV_X							; 3
	sta	TFV_X							; 3
arv_done_move:

	;====================
	; Move TFG
	; if move, 6+18=24
	; if not move, 6+18=24
	lda	FRAME		; only move if FRAME===0		; 3
	beq	arg_move						; 3

arg_nomove:								; -1
	lda	$0	;nop						; 3
	lda	$0	;nop						; 3
	lda	$0	;nop						; 3
	lda	$0	;nop						; 3
	nop								; 2
	nop								; 2
	jmp	arg_done_move						; 3
arg_move:
	lda	STATE							; 3
	and	FRAMEH							; 3
	lsr								; 2
	eor	#$ff		; make negative				; 2
	sec								; 2
	adc	TFG_X							; 3
	sta	TFG_X							; 3
arg_done_move:



	; Try X=29 Y=20 cycles=3021 R2

	nop

	ldy	#20							; 2
arloop8:ldx	#29							; 2
arloop9:dex								; 2
	bne	arloop9							; 2nt/3
	dey								; 2
	bne	arloop8							; 2nt/3


	;==========================
	; Set graphics mode, delay until done displaying the yard
	;==========================

	bit	SET_GR			; 4

	; Try X=53 Y=23 cycles=6234 R2

	nop

	ldy	#23							; 2
arloop6:ldx	#53							; 2
arloop7:dex								; 2
	bne	arloop7							; 2nt/3
	dey								; 2
	bne	arloop6							; 2nt/3

	;===============================
	; Draw the Field
	;===============================
draw_the_field:


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

	; do_nothing should be      3120 (bottom of GR screen)
	;			    4550 (vblank)
	;			     -23 (setup jump table)
	;			   -6237 (in state code)
	;			     -10 keypress
	;			===========
	;			     1400

	; Try X=5 Y=45 cycles=1396 R4


	nop
	nop

	ldy	#45							; 2
arloop1:ldx	#5							; 2
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
	; Delay 6237
	;      -1524
	;         -3
	;===========
	;       4710

ar_state0:

	; draw fs standing
	lda	#>tfg_stand_left			; 2
	sta	INH					; 3
	lda	#<tfg_stand_left			; 2
	sta	INL					; 3

	lda	#22					; 2
	sta	XPOS					; 3
	lda     #24					; 2
	sta	YPOS					; 3

	jsr	put_sprite                              ; 6
                                                        ;=========
                                                        ; 26 + 1498 = 1524

	; Try X=35 Y=26 cycles=4707 R3
	lda	$0
	ldy	#26							; 2
arloopT:ldx	#35							; 2
arloopU:dex								; 2
	bne	arloopU							; 2nt/3
	dey								; 2
	bne	arloopT							; 2nt/3

	jmp	ar_back_from_jumptable				; 3



	;======================================================
	; State2 : draw walking
	;======================================================
	;  785 = erase field
	;    3 (return)
	; 1490 = 1471+19 (draw tfv)
	;   33 (draw susie)
	; 1538 = 1519+19 (draw fs)
	; 1937 (draw falls)

	;==========
	; 5786
	; - 6237
.align $100
ar_state2:
	jsr	erase_field				; 6+779

; Try X=2 Y=28 cycles=449 R2
nop
	ldy	#28							; 2
arloopZ:ldx	#2							; 2
arloopX:dex								; 2
	bne	arloopX							; 2nt/3
	dey								; 2
	bne	arloopZ							; 2nt/3
;
;	jmp	ar_back_from_jumptable				; 3

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

	jmp	girl_walk				; 3
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


	; girl walk
girl_walk:
	lda	TFG_X					; 3
	sta	XPOS					; 3
	lda     #24					; 2
	sta	YPOS					; 3

	lda	FRAMEH					; 3
	and	#$1					; 2
	beq	arg_walk				; 3
						;===========
						;	 19


arg_stand:
	; draw fs standing				; -1
	lda	#>tfg_stand_left			; 2
	sta	INH					; 3
        lda	#<tfg_stand_left			; 2
	sta	INL					; 3
	jsr	put_sprite                              ; 6

	lda	$0	; nop				; 3

	jmp	ar_susie				; 3
                                                        ;=========
                                                        ; 21 + 1498 = 1519


arg_walk:
	; draw fs walking
	lda	#>tfg_walk_left				; 2
	sta	INH					; 3
        lda	#<tfg_walk_left				; 2
	sta	INL					; 3
	jsr	put_sprite                              ; 6
                                                        ;=========
                                                        ; 16 + 1503 = 1519


	; draw susie
	; 33 cycles
ar_susie:
	; draw susie at TFV_X-5, IFF TFV_X>10
	lda	TFV_X					; 3
	sec						; 2
	sbc	#4					; 2
	tax						; 2
	cpx	#1					; 2
	bpl	ar_yes_susie	; bge			; 3
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
	sta	$4d0,X					; 5
	sta	$4d1,X					; 5
	lda	#$0f					; 2
	sta	$4d2,X					; 5
ar_done_susie:
						;===========
						;	 19



ar_draw_wfall:
	; draw minifalls
	lda	#>wfall_sprite				; 2
	sta	INH					; 3
        lda	#<wfall_sprite				; 2
	sta	INL					; 3

	lda	#0					; 2
	sta	XPOS					; 3
	lda     #24					; 2
	sta	YPOS					; 3

	jsr	put_sprite                              ; 6
                                                        ;=========
                                                        ; 26 + 1911 = 1937



	jmp	ar_back_from_jumptable				; 3



	;======================================================
	; State4 : heart
	;======================================================
	;  6237
	;  -464 (draw heart)
	;  -217 (erase heart)
	;    -3 = return
	;==========
	; 5553


ar_state4:

	jsr	erase_heart				; 6+211

	lda	HEART_X					; 3
	sta	XPOS					; 3
	lda     HEART_Y					; 3
	sta	YPOS					; 3

	; draw fs standing
	lda	#>heart_sprite				; 2
	sta	INH					; 3
	lda	#<heart_sprite				; 2
	sta	INL					; 3

	jsr	put_sprite                              ; 6
                                                        ;=========
                                                        ; 28 + 436 = 464


ar_done_heart:
	; delay


	; Try X=21 Y=50 cycles=5551 R2

	nop

	ldy	#50							; 2
arloopV:ldx	#21							; 2
arloopW:dex								; 2
	bne	arloopW							; 2nt/3
	dey								; 2
	bne	arloopV							; 2nt/3

	jmp	ar_back_from_jumptable

heart_path:
	.byte	$14,$20
	.byte	$14,$20
	.byte	$13,$18
	.byte	$13,$18
	.byte	$14,$16
	.byte	$15,$16
;	.byte	$15,$14
;	.byte	$14,$14



	;======================
	; erase field
	;======================
	; erase to green 4-25, 24-35

	; 4+ 22*[30 + 5 ] + 5 = 779
erase_field:

	lda     #$44 		; green					; 2
	ldx	#21		; 4 - 25				; 2
field_loop:
	sta	$628+4,X	; 24					; 5
	sta	$6a8+4,X	; 26					; 5
	sta	$728+4,X	; 28					; 5
	sta	$7a8+4,X	; 30					; 5
	sta	$450+4,X	; 32					; 5
	sta	$4d0+4,X	; 34					; 5

	dex								; 2
	bpl	field_loop						; 3
									; -1
	rts								; 6


	;======================
	; erase heart
	;======================
	; erase to black, (13-18,14-20)
	; erase to green  (13-18,20-24)

	; 2+ 6*[29 + 5 ] + 5 = 211
erase_heart:


	ldx	#5		; 13 - 18				; 2
heart_loop:
	lda	#$00		; black					; 2
	sta	$780+13,X	; 14					; 5
	sta	$428+13,X	; 16					; 5
	sta	$4a8+13,X	; 18					; 5
	lda     #$44 		; green					; 2
	sta	$528+13,X	; 20					; 5
	sta	$5a8+13,X	; 22					; 5
	dex								; 2
	bpl	heart_loop						; 3
									; -1
	rts								; 6

