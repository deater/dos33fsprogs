; Display a 40x96 lo-res image

; by deater (Vince Weaver) <vince@deater.net>


appleII_intro:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE
	sta	DUDE_X
	sta	FOREVER_OFFSET

	;=============================
	; Load graphic page0

	lda	#<appleII_low
	sta	GBASL
	lda	#>appleII_low
	sta	GBASH
	lda	#$c
	jsr	load_rle_gr

	;=============================
	; Load graphic page1

	lda	#<appleII_high
	sta	GBASL
	lda	#>appleII_high
	sta	GBASH
	lda	#$10
	jsr	load_rle_gr

	; GR part
	bit	PAGE0

;	jsr	wait_until_keypressed


	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6+

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go to vblank

	; 5070+17030+4550=26650

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	lda	#0				; 2
	sta	DRAW_PAGE			; 3
	jsr	gr_clear_all			; 6+ 5454

	lda	#4				; 2
	sta	DRAW_PAGE			; 3
	jsr	gr_clear_all			; 6+ 5454

	; 26650
	;   -12
	; -5465
	; -5465
	;    -3 (jmp)
	;==========
	;  15705

	; FIXME: delay extra 33?
	; have no idea why this is needed
	lda	DRAW_PAGE
	lda	DRAW_PAGE
	lda	DRAW_PAGE
	lda	DRAW_PAGE
	lda	DRAW_PAGE
	lda	DRAW_PAGE
	lda	DRAW_PAGE
	lda	DRAW_PAGE
	lda	DRAW_PAGE
	lda	DRAW_PAGE
	lda	DRAW_PAGE


	; Try X=29 Y=104 cycles=15705

	ldy	#104							; 2
loopA:	ldx	#29							; 2
loopB:	dex								; 2
	bne	loopB							; 2nt/3
	dey								; 2
	bne	loopA							; 2nt/3

        jmp     display_loop						; 3

.align  $100


	;================================================
	; Display Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; We want to alternate between page1 and page2 every 65 cycles
        ;       vblank = 4550 cycles to do scrolling


	; 2 + 48*(  (4+2+25*(2+3)) + (4+2+23*(2+3)+4+5)) + 9)
	;     48*[(6+125)-1] + [(6+115+10)-1]

display_loop:

	ldy	#48						; 2

outer_loop:

	bit	PAGE0						; 4
	ldx	#25		; 130 cycles with PAGE0		; 2
page0_loop:			; delay 126+bit
	dex							; 2
	bne	page0_loop					; 2/3


	bit	PAGE1						; 4
	ldx	#23		; 130 cycles with PAGE1		; 2
page1_loop:			; delay 115+(7 loop)+4 (bit)+4(extra)
	dex							; 2
	bne	page1_loop					; 2/3

	nop							; 2
	lda	DRAW_PAGE					; 3

	dey							; 2
	bne	outer_loop					; 2/3



	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be:
	;		4550
	;		  +1 (fallthrough)
	;		  -2 initial conditions
	;	       -1174
	;		  -7 (keypress)
	;		  -3 (jump)
	;		=====
	;		3365

	jsr	do_nothing				; 6

	;========================
	; Add 8 to wipe_right
	; Add 12 to wipe_left
	; Add 16 to forever
	; Add 15 to donothing

	ldx	DUDE_X					; 3
	cpx	#40					; 2
	bcc	wipe_right	; blt			; 3
							; -1
	cpx	#80					; 2
	bcc	wipe_left	; blt			; 3
							; -1
	cpx	#192					; 2
	bcc	forever		; blt			; 3
							; -1

	;=========================
	; hold steady

done_done:
							; -1
	;===========================
	; delay 1174-15-3=1156

	; delay

	; Try X=45 Y=5 cycles=1156

	ldy	#5							; 2
loop11:	ldx	#45							; 2
loop21:	dex								; 2
	bne	loop21							; 2nt/3
	dey								; 2
	bne	loop11							; 2nt/3


	jmp	intro_wipe_done				;  3



	;=====================
	;=====================
	; wipe right
	;=====================
	;=====================
	; 24*(30+18)-1 +5+3 = 1159
	; 1174-1159-8=7

	; page0 -- copy from $c00
wipe_right:
	nop						; 2
	nop						; 2
	lda	WASTE_CYCLES				; 3
							;=====
							; 7
page0_loopy:
	lda	gr_offsets,Y				; 4+
	sta	page0_store_smc+1			; 4
	sta	page0_load_smc+1			; 4
	lda	gr_offsets+1,Y				; 4+
	clc						; 2
	adc	#$4					; 2
	sta	page0_store_smc+2			; 4
	adc	#$8					; 2
	sta	page0_load_smc+2			; 4
							;=====
							; 30

page0_load_smc:
	lda	$1000,X					; 4+
page0_store_smc:
	sta	$1000,X					; 5

	iny						; 2
	iny						; 2
	cpy	#48					; 2
	bne	page0_loopy				; 3
						;================
						; 	18

							; -1
	inc	DUDE_X					; 5
	jmp	intro_wipe_done				; 3

	;=====================
	;=====================
	; wipe left
	;=====================
	;=====================
	; 11+ 24*(28+18)-1 +5+3 = 1170
	; 1174-1122-12=40

	; page0 -- copy from $c00
wipe_left:
	inc	WASTE_CYCLES	; 5
	inc	WASTE_CYCLES	; 5
	inc	WASTE_CYCLES	; 5
	inc	WASTE_CYCLES	; 5
	inc	WASTE_CYCLES	; 5
	inc	WASTE_CYCLES	; 5
	inc	WASTE_CYCLES	; 5
	inc	WASTE_CYCLES	; 5

	; 40 -> 79 map to 39->0 = 39 - (X-40) = 79-X
	lda	#79					; 2
	sec						; 2
	sbc	DUDE_X					; 3
	tax						; 2
	ldy	#0					; 2
							;=====
							; 11
page1_loopy:
	lda	gr_offsets,Y				; 4+
	sta	page1_store_smc+1			; 4
	sta	page1_load_smc+1			; 4
	lda	gr_offsets+1,Y				; 4+
	clc						; 2
	sta	page1_store_smc+2			; 4
	adc	#$8					; 2
	sta	page1_load_smc+2			; 4
							;=====
							; 28

page1_load_smc:
	lda	$1000,X					; 4+
page1_store_smc:
	sta	$1000,X					; 5

	iny						; 2
	iny						; 2
	cpy	#48					; 2
	bne	page1_loopy				; 3
						;================
						; 	18

							; -1
	inc	DUDE_X					; 5
	jmp	intro_wipe_done				; 3


	;=========================
	; FOREVER
	;==========================
	; F@80, 11,32
	; O@96
	; R@112
	; E@128
	; V@144
	; E@160
	; R@176

forever:
							; -1
	;===========================
	; forever:
	;	1174 base
	;	 -16 previous if/else
	;	  -7 check
	;	 -18 new_forever
	;	 -38 colors
	;	 -14 putchar prep
	;	-365 putchar
	;	  -8 end
	;=====================
	;	708

	txa						; 2
	and	#$f					; 2
	beq	new_forever				; 3

							; -1
	nop						; 2
	nop						; 2
	nop						; 2
	nop						; 2
	nop						; 2

	nop						; 2
	nop						; 2
	nop						; 2
	jmp	write_forever				; 3

new_forever:
	inc	forever_string_smc+1			; 6
	lda	forever_x_smc+1				; 4
	clc						; 2
	adc	#4					; 2
	sta	forever_x_smc+1				; 4
							;=======
							; 18
write_forever:

	txa						; 2
	and	#$0c					; 2
	tax						; 2

	lda	colors_first,X				; 4+
	sta	colors_hi				; 4
	lda	colors_first+1,X			; 4+
	sta	colors_hi+1				; 4
	lda	colors_first+2,X			; 4+
	sta	colors_hi+2				; 4
	lda	colors_first+3,X			; 4+
	sta	colors_hi+3				; 4
							;======
							; 38
	; Colors
	;	0 	0	0	4
	;	0	0	4	C
	;	0	4	C	F

forever_string_smc:
	lda	forever_string				; 4+
forever_x_smc:
	ldx	#7					; 2
	ldy	#32					; 2

	jsr	put_char				; 6+365

	;=======
	; delay

	; Try X=19 Y=7 cycles=708

	ldy	#7							; 2
loop19:	ldx	#19							; 2
loop29:	dex								; 2
	bne	loop29							; 2nt/3
	dey								; 2
	bne	loop19							; 2nt/3


	inc	DUDE_X					; 5
	jmp	intro_wipe_done				; 3





	;==========================
	;==========================
intro_wipe_done:
	lda	KEYPRESS				; 4
	bpl	no_keypress2				; 3
	jmp	appleii_done
no_keypress2:

	jmp	display_loop				; 3

appleii_done:
	rts

.align $100

	;=================================
	; do nothing
	;=================================
	; and take 3365-12 = 3353 cycles to do it
do_nothing:

	; Try X=6 Y=93 cycles=3349R4

	nop
	nop

	ldy	#93							; 2
loop1:	ldx	#6							; 2
loop2:	dex								; 2
	bne	loop2							; 2nt/3
	dey								; 2
	bne	loop1							; 2nt/3

	rts								; 6



forever_string:
.byte	' ','F','O','R','E','V','E','R'


colors_first:	.byte $00,$00,$00,$00
colors_second:	.byte $00,$04,$40,$00
colors_third:	.byte $40,$4C,$C4,$04
colors_fourth:	.byte $C4,$CF,$FC,$4C
