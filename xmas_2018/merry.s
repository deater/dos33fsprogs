;=====================================
; XMAS2018 -- Merry Christmas Part
;=====================================

merry:

	;===================
	; init screen

	;===================
	; init vars
	lda	#15
	sta	XPOS
	lda	#38
	sta	YPOS

	lda	#0
	sta	FRAME
	sta	FRAMEH

	;=============================
	; Load graphic hgr -- already loaded at $6000


	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

	; so we have 5070 + 4550 = 9620 to kill

	; FIXME: clear page0/page1 screens

;	jsr	gr_copy_to_current		; 6+ 9292

	; now we have 322 left

	; GR part
	bit	HIRES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4
	bit	PAGE1							; 4

	; 9620
	;  -12 mode set
	;  - 3 for jmp
	;=======
	; 9605

	; Try X=136 Y=14 cycles=9605

	ldy	#14							; 2
meloopA:ldx	#136							; 2
meloopB:dex								; 2
	bne	meloopB							; 2nt/3
	dey								; 2
	bne	meloopA							; 2nt/3

	jmp	merry_begin_loop
.align  $100


	;================================================
	; Merry Christmas Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

merry_begin_loop:

merry_display_loop:

	; 192 lines of hires page1
	; (192*65) = 12480

	; Try X=24 Y=99 cycles=12475 R5

	lda	$0
	nop

	ldy	#99							; 2
meloopE:ldx	#24							; 2
meloopF:dex								; 2
	bne	meloopF							; 2nt/3
	dey								; 2
	bne	meloopE							; 2nt/3



;======================================================
; We have 4550 cycles in the vblank, use them wisely
;======================================================

	; do_nothing should be      4550
	;			     -10 keypress
	;			===========
	;			    4540


;	jsr	play_music		; 6+1032


	jsr	scroll_hgr_loop


	; Try X=9 Y=89 cycles=4540

	ldy	#89							; 2
meloop1:ldx	#9							; 2
meloop2:dex								; 2
	bne	meloop2							; 2nt/3
	dey								; 2
	bne	meloop1							; 2nt/3

	; no keypress =  10+(24)   = 34

	bit	KEYRESET	; clear keypress	; 4

me_keyloop:
	lda	KEYPRESS				; 4
	bpl	me_keyloop				; 3
							; -1
;	jmp	me_handle_keypress			; 3
me_no_keypress:
;	jmp	merry_display_loop			; 3

me_handle_keypress:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6




;		  0     1     2     3     4     5     6     7
;	00	= $2000 $2400 $2800 $2c00 $3000 $3400 $3800 $3c00
;	08	= $2080 $2480 $2880 $2c80 $3080 $3480 $3880 $3c80
;	16	= $2100 $2500 $2900 $2d00 $3100 $3500 $3900 $3d00
;	24	= $2180 $2580 $2980 $2d80 $3180 $3580 $3980 $3d80
;	32	= $2200 $2600 $2a00 $2e00 $3200 $3600 $3a00 $3e00
;	40	= $2280 $2680 $2a80 $2e80 $3280 $3680 $3a80 $3e80
;	48	= $2300 $2700 $2b00 $2f00 $3300 $3700 $3b00 $3f00
;	56	= $2380 $2780 $2b80 $2f80 $3380 $3780 $3b80 $3f80
;	-----
;	64	= $2028 $2428 $2828 $2c28 $3028 $3428 $3828 $3c28
;	72	= $20a8 $24a8 $28a8 $2ca8 $30a8 $34a8 $38a8 $3ca8
;	80	= $2128 $2528 $2928 $2d28 $3128 $3528 $3928 $3d28
;	88	= $21a8 $25a8 $29a8 $2da8 $31a8 $35a8 $39a8 $3da8
;	96	= $2228 $2628 $2a28 $2e28 $3228 $3628 $3a28 $3e28
;	104	= $22a8 $26a8 $2aa8 $2ea8 $32a8 $36a8 $3aa8 $3ea8
;	112	= $2328 $2728 $2b28 $2f28 $3328 $3728 $3b28 $3f28
;	120	= $23a8 $27a8 $2ba8 $2fa8 $33a8 $37a8 $3ba8 $3fa8
;	-----
;	128	= $2050 $2450 $2850 $2c50 $3050 $3450 $3850 $3c50
;	136	= $20d0 $24d0 $28d0 $2cd0 $30d0 $34d0 $38d0 $3cd0
;	144	= $2150 $2550 $2950 $2d50 $3150 $3550 $3950 $3d50
;	152	= $21d0 $25d0 $29d0 $2dd0 $31d0 $35d0 $39d0 $3dd0
;	160	= $2250 $2650 $2a50 $2e50 $3250 $3650 $3a50 $3e50
;	168	= $22d0 $26d0 $2ad0 $2ed0 $32d0 $36d0 $3ad0 $3ed0
;	176	= $2350 $2750 $2b50 $2f50 $3350 $3750 $3b50 $3f50
;	184	= $23d0 $27d0 $2bd0 $2fd0 $33d0 $37d0 $3bd0 $3fd0
;	-----

;	int count=0;

HIGH	=	$00
CURRENT	=	$01
NEXT	=	$02

	;===========================================
	;===========================================
	;===========================================

scroll_hgr_loop:

	lda	#$40							; 2
	sta	OUTH							; 3
	lda	#$60							; 2
	sta	INH							; 3
	lda	#$0							; 2
	sta	INL							; 3
	sta	OUTL							; 3
	sta	COUNT

left_one_loop:

	ldy	#0							; 2
page1_loop:
	lda	(OUTL),Y	; get pixel block of interest		; 5
	sta	CURRENT							; 3

	iny								; 2
	lda	(OUTL),Y	; get subsequent pixel block		; 5
								;(note, 6 if off end?)
	sta	NEXT							; 3
	dey			; restore Y				; 2

; if ((count mod 7==2) || (count mod 7==6)) {
;			ram[HIGH]=ram[NEXT]&0x80;
;}
;		else {

	lda	CURRENT							; 3
	and	#$80							; 2
	sta	HIGH							; 3
;		}
;		if (y==39) ram[NEXT]=ram[y_indirect(INL,0)];

	lda	NEXT							; 3
	and	#$3							; 2
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
	sta	NEXT							; 3

	lda	CURRENT							; 3
	lsr								; 2
	lsr								; 2
	and	#$1f							; 2
	ora	HIGH							; 3
	ora	NEXT							; 3

	sta	(OUTL),Y						; 6

	iny								; 2
	cpy	#40							; 2
	bne	page1_loop						; 3
									; -1
.if 0

	for(y=0;y<40;y++) {
		ram[CURRENT]=ram[y_indirect(INL,y)];
		ram[NEXT]=ram[y_indirect(INL,y+1)];
		if ((count mod 7==2) ||(count mod 7==6)) {
			ram[HIGH]=ram[NEXT]&0x80;
		}
		else {
			ram[HIGH]=ram[CURRENT]&0x80;
		}

		a=ram[NEXT];
		and(0x3);
		asl();
		asl();
		asl();
		asl();
		asl();
		ram[NEXT]=a;

		a=ram[CURRENT];
		lsr();
		lsr();			// current>>=2;
		and(0x1f);		// current&=0x1f;
		ora_mem(HIGH);
		ora_mem(NEXT);
		ram[y_indirect(INL,y)]=a;
	}
.endif

	clc								; 2
	lda	INL							; 3
	adc	#$80							; 2
	sta	INL							; 3
	lda	INH							; 3
	adc	#$0							; 2
	sta	INH							; 3

	clc		; needed?					; 2
	lda	OUTL							; 3
	adc	#$80							; 2
	sta	OUTL							; 3
	lda	OUTH							; 3
	adc	#$0							; 2
	sta	OUTH							; 3

	cmp	#$60							; 2
	bne	left_one_loop

	lda	KEYPRESS						; 4
	bmi	scroll_done						; 3

	inc	COUNT							; 5
	lda	COUNT							; 3
	cmp	#140							; 2
	beq	scroll_done						; 3

									;-1
	jmp	scroll_hgr_loop						; 3
scroll_done:

	rts								; 6
