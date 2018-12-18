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
	sta	FRAMEH

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
	; sprites (536*3+374*2)	=   ;2356
	;			     398
	;			     -18 frame adjust
	;                             -7 end detect
	;			     -10 keypress
	;			===========
	;			    1136



	inc	FRAME						; 5
	lda	FRAME						; 3
	and	#63						; 2
	beq	wframing					; 3

								; -1
	lda	$0						; 3
	jmp	done_wframing					; 3
wframing:
	inc	FRAMEH						; 5
done_wframing:
							;=============
							;       18

	lda	FRAMEH						; 3
	cmp	#30		; length of song?		; 2
	beq	wreath_done					; 3
								; -1
							;===============
							;         7



	jsr	play_music		; 6+1017


	;========================
	; draw sprites
	;========================

	; Candle 1 (Hope)

	lda	#>wide_flame0					; 2
	sta	INH						; 3
	lda	#<wide_flame0					; 2
	sta	INL						; 3

	lda	#4						; 2
	sta	XPOS						; 3
	lda	#4						; 2
	sta	YPOS						; 3
	jsr	put_sprite_no_transparency			; 6+372
							;===============
							;	398
.if 0
	; Candle 2 (Peace)

	lda	#>flame0					; 2
	sta	INH						; 3
	lda	#<flame0					; 2
	sta	INL						; 3

	lda	#14						; 2
	sta	XPOS						; 3
	lda	#4						; 2
	sta	YPOS						; 3
	jsr	put_sprite_no_transparency					; 6+348
							;===============
							;	374

	; Candle 3 (Joy)

	lda	#>flame0					; 2
	sta	INH						; 3
	lda	#<flame0					; 2
	sta	INL						; 3

	lda	#31						; 2
	sta	XPOS						; 3
	lda	#4						; 2
	sta	YPOS						; 3
	jsr	put_sprite_no_transparency					; 6+348
							;===============
							;	374

	; Candle 4 (Love)

	lda	#>wide_flame1					; 2
	sta	INH						; 3
	lda	#<wide_flame0					; 2
	sta	INL						; 3

	lda	#26						; 2
	sta	XPOS						; 3
	lda	#4						; 2
	sta	YPOS						; 3
	jsr	put_sprite_no_transparency					; 6+510
							;===============
							;	536

	; Candle 5 (Christmas)

	lda	#>wide_flame0					; 2
	sta	INH						; 3
	lda	#<wide_flame0					; 2
	sta	INL						; 3

	lda	#20						; 2
	sta	XPOS						; 3
	lda	#4						; 2
	sta	YPOS						; 3
	jsr	put_sprite_no_transparency					; 6+510
							;===============
							;	536
.endif

	; Try X=225 Y=1 cycles=1132 R4
	; Try X=205 Y=3 cycles=3094

	ldy	#3							; 2
wrloop1:ldx	#205							; 2
wrloop2:dex								; 2
	bne	wrloop2							; 2nt/3
	dey								; 2
	bne	wrloop1							; 2nt/3

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


.include "sprites.inc"

