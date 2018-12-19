;=====================================
; XMAS2018 -- Wreath Part
;=====================================


wreath:

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

	; setup candle flames
	lda	#254
	sta	FLAME1
	lda	#252
	sta	FLAME2
	lda	#250
	sta	FLAME3
	lda	#248
	sta	FLAME4
	lda	#246
	sta	FLAME5

	;=============================
	; Wreath image already loaded to $2000 (HGR Page 0)

	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

	; so we have 5070 + 4550 = 9620 to kill

	; FIXME: clear page0 screen

	jsr	clear_top			; 6+5410

	; now we have  left

	; GR part
;	bit	HIRES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	; 9620
	;-5416 clear gr page0 top
	;   -8 mode set
	;  - 3 for jmp
	;=======
	; 4193

	; Try X=25 Y=32 cycles=4193

        ldy	#32							; 2
wrloopA:ldx	#25							; 2
wrloopB:dex								; 2
	bne	wrloopB							; 2nt/3
	dey								; 2
	bne	wrloopA							; 2nt/3

	jmp	wreath_begin_loop

.include "sprites.inc"

.align  $100


	;================================================
	; Wreath Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

wreath_begin_loop:

wreath_display_loop:

	; (40*65)-4 = 2596

	; 40 lines of LORES
	bit	LORES							; 4

	; Try X=42 Y=12 cycles=2593 R3

	lda	$0	; nop						; 3

	ldy	#12							; 2
wrloopC:ldx	#42							; 2
wrloopD:dex								; 2
	bne	wrloopD							; 2nt/3
	dey								; 2
	bne	wrloopC							; 2nt/3


	; rest of screen is hires page0
	; (152*65)-4 = 9876

	bit	HIRES							; 4

	; Try X=13 Y=139 cycles=9870 R6

	nop
	nop
	nop

	ldy	#139							; 2
wrloopE:ldx	#13							; 2
wrloopF:dex								; 2
	bne	wrloopF							; 2nt/3
	dey								; 2
	bne	wrloopE							; 2nt/3



;======================================================
; We have 4550 cycles in the vblank, use them wisely
;======================================================

	; do_nothing should be      4550
	; play music		    1023
	; sprites 10+(409*3+316*2)= 1869
	;			     -38 frame adjust
	;                             -7 end detect
	;			     -10 keypress
	;			===========
	;			    1603



	inc	FRAME						; 5
	lda	FRAME						; 3
	and	#63						; 2
	beq	wframing					; 3

								; -1
	inc	FLAME1						; 5
	dec	FLAME1						; 5
	inc	FLAME1						; 5
	dec	FLAME1						; 5
	lda	$0						; 3
	jmp	done_wframing					; 3
wframing:
	inc	FLAME1						; 5
	inc	FLAME2						; 5
	inc	FLAME3						; 5
	inc	FLAME4						; 5
	inc	FLAME5						; 5

done_wframing:
							;=============
							;       38


	jsr	play_music		; 6+1017


	;========================
	; draw sprites
	;========================

	lda	FRAME						; 3
	lsr							; 2
	and	#3						; 2
	sta	FLAME_STATE					; 3
							;===========
							;	 10

	; Candle 1 (Hope)

	lda	#>wide_flame0					; 2
	sta	INH						; 3

	lda	FLAME1						; 3
	bpl	flame1_lit					; 3

								; -1
	lda	$0						; 3
	lda	#<wide_empty					; 2
	jmp	flame1_go					; 3

flame1_lit:
	ldx	FLAME_STATE					; 3
	lda	wide_lookup,X					; 4
flame1_go:
	sta	INL						; 3

	lda	#4						; 2
	sta	XPOS						; 3
	lda	#4						; 2
	sta	YPOS						; 3
	jsr	put_sprite_no_transparency			; 6+372
							;===============
							;tot=	409
	; Candle 2 (Peace)

	lda	#>flame0					; 2
	sta	INH						; 3

	lda	FLAME2						; 3
	bpl	flame2_lit					; 3

								; -1
	lda	$0						; 3
	lda	#<empty						; 2
	jmp	flame2_go					; 3

flame2_lit:
	ldx	FLAME_STATE					; 3
	lda	flame_lookup,X					; 4
flame2_go:
	sta	INL						; 3

	lda	#14						; 2
	sta	XPOS						; 3
	lda	#4						; 2
	sta	YPOS						; 3
	jsr	put_sprite_no_transparency			; 6+279
							;===============
							;	316

	; Candle 3 (Joy)

	lda	#>flame0					; 2
	sta	INH						; 3

	lda	FLAME3						; 3
	bpl	flame3_lit					; 3

								; -1
	lda	$0						; 3
	lda	#<empty						; 2
	jmp	flame3_go					; 3

flame3_lit:
	ldx	FLAME_STATE					; 3
	lda	flame_lookup,X					; 4
flame3_go:
	sta	INL						; 3

	lda	#31						; 2
	sta	XPOS						; 3
	lda	#4						; 2
	sta	YPOS						; 3
	jsr	put_sprite_no_transparency			; 6+279
							;===============
							;	316

	; Candle 4 (Love)

	lda	#>wide_flame0					; 2
	sta	INH						; 3

	lda	FLAME4						; 3
	bpl	flame4_lit					; 3

								; -1
	lda	$0						; 3
	lda	#<wide_empty					; 2
	jmp	flame4_go					; 3

flame4_lit:
	ldx	FLAME_STATE					; 3
	lda	wide_lookup,X					; 4
flame4_go:
	sta	INL						; 3

	lda	#26						; 2
	sta	XPOS						; 3
	lda	#4						; 2
	sta	YPOS						; 3
	jsr	put_sprite_no_transparency			;31+372
							;===============
							;	409

	; Candle 5 (Christmas)

	lda	#>wide_flame0					; 2
	sta	INH						; 3

	lda	FLAME5						; 3
	bpl	flame5_lit					; 3

								; -1
	lda	$0						; 3
	lda	#<wide_empty					; 2
	jmp	flame5_go					; 3

flame5_lit:
	ldx	FLAME_STATE					; 3
	lda	wide_lookup,X					; 4
flame5_go:
	sta	INL						; 3

	lda	#20						; 2
	sta	XPOS						; 3
	lda	#4						; 2
	sta	YPOS						; 3
	jsr	put_sprite_no_transparency			; 6+372
							;===============
							;	409


	; Try X=159 Y=2 cycles=1603

	ldy	#2							; 2
wrloop1:ldx	#159							; 2
wrloop2:dex								; 2
	bne	wrloop2							; 2nt/3
	dey								; 2
	bne	wrloop1							; 2nt/3


	lda	FLAME1						; 3
	cmp	#30		; length of song?		; 2
	beq	wreath_done					; 3
								; -1
							;===============
							;         7




	; no keypress =  10+(24)   = 34

	lda	KEYPRESS				; 4
	bpl	wr_no_keypress				; 3
							; -1
	jmp	wreath_done				; 3
wr_no_keypress:
	jmp	wreath_display_loop			; 3

wreath_done:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6




