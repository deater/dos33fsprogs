	;================================
	; spacebars gameplay
	;================================
game:

	;===================
	; init screen
	bit	KEYRESET

	;===================
	; init vars
	lda	#15
	sta	XPOS
	lda	#38
	sta	YPOS


	;=============================
	; Load graphic hgr

	lda	#<background_hgr
	sta	LZ4_SRC
	lda	#>background_hgr
	sta	LZ4_SRC+1

	lda	#<(background_hgr_end-8)	; skip checksum at end
	sta	LZ4_END
	lda	#>(background_hgr_end-8)	; skip checksum at end
	sta	LZ4_END+1

	lda	#<$2000
	sta	LZ4_DST
	lda	#>$2000
	sta	LZ4_DST+1

	jsr	lz4_decode


	;=============================
	; Load graphic page1 $800

	lda	#4
	sta	DRAW_PAGE

	lda	#$22
	jsr	clear_gr


	;=============================
	; Load graphic page2 $c00


	lda	#8
	sta	DRAW_PAGE

	lda	#$44
	jsr	clear_gr


	lda	#0
	sta	DRAW_PAGE

	; GR part
	bit	PAGE0


	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

	; so we have 5070 + 4550 = 9620 to kill

	jsr	gr_copy_to_current		; 6+ 9292

	; now we have 322 left

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	; 322 - 12 = 310
	; - 3 for jmp
	; 307

	; Try X=9 Y=6 cycles=307

        ldy	#6							; 2
sbloopA:ldx	#9							; 2
sbloopB:dex								; 2
	bne	sbloopB							; 2nt/3
	dey								; 2
	bne	sbloopA							; 2nt/3

	jmp	sb_begin_loop
.align  $100


	;================================================
	; Spacebars Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

sb_begin_loop:

sb_display_loop:

	; 0-7  = text mode
;          1         2         3
;0123456789012345678901234567890123456789
;LEVEL: 6 LIVES: 2 SCORE: 01978 HI: 02018

	; 8-47 = hgr
	; 48 - 191 = split	.. 144 = 36grlins 
	; 	6	4	25+16+8+16  NNNNNNNN
	;	7	6	25+15+10+15 LNNNNNN
	;	8	8	25+14+12+14 NNNNNNN
	;	9	10	25+13+14+13 LNNNNN
	;	10	12	25+12+16+12
	;	11	14	25+11+18+11
	;	12	16	25+10+20+10
	;	13	18	25+09+22+09
	;	14	20	25+08+24+08
	;	15	22	25+07+26+07
	;	16	24	25+06+28+06
	;	17	26	25+05+30+05
	;	18	28	25+04+32+04
	;	19	30	25+03+34+03
	;	20	32	25+02+36+02
	;	21	34	25+01+38+01
	;	22	36	25+00
	;	23	38	25+12
	;	24	40	25+12


	; 8 lines of text mode


	ldy	#8					; 2

sb_text_loop:
	bit	SET_TEXT				; 4
	lda	#29					; 2
	jsr	delay_a					; 25+29

	dey						; 2
	bne	sb_text_loop				; 3
						;================
						;	65


							; -1


sb_hgr_loop:
	; delay 40*65 =  2600
	;                    -2
	;		     +1
	;		     -8
	;=========================
	;		2591

	bit	SET_GR				; 4
	bit	HIRES				; 4



	; draw sprite at same time
	lda	#>ship_forward						; 2
	sta	INH							; 3
	lda	#<ship_forward						; 2
	sta	INL							; 3
	jsr	put_sprite						; 6
								; + 2164
								;===========
								; 2180



	; Try X=1 Y=235 cycles=2586 R5

	; Try X=7 Y=10 cycles=411
;	nop		; 2
;	lda	$0	; 3

	ldy	#10							; 2
sbloopC:ldx	#7							; 2
sbloopD:dex								; 2
	bne	sbloopD							; 2nt/3
	dey								; 2
	bne	sbloopC							; 2nt/3




sb_mixed:
	lda	$0		;kill 6 cycles (room for rts)	; 2
	ldx	#9					; 2
	ldy	#14 ; 126				; 2

sb_mixed_loop:
	lda	ss_multiples,x				; 4
	sta	split_smc+1				; 4
split_smc:
	jsr	split_4					; 6+46
	dey						; 2
	bne	sb_mixed_loop				; 3

							; -1
	nop						; 2
	ldy	#14					; 2
	dex						; 2
	bne	split_smc				; 3

							; -1

						; need to kill
						; -6 from offset
						; +1 fall through
						; -9 from check 
						; +1 from other fallthrough
					;================
					;	 -13



sb_all_gr:
	; 18 lines of this

	; 18 * 65 = 1170
	;             -4
	;            -13
	;       =========
	;	    1153

	bit	LORES						; 4

	; Try X=6 Y=32 cycles=1153

	ldy	#32							; 2
sbloopE:ldx	#6							; 2
sbloopF:dex								; 2
	bne	sbloopF							; 2nt/3
	dey								; 2
	bne	sbloopE							; 2nt/3



	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================

	; do_nothing should be      4550
	;			     -10 keypress
	;				-1 adjust center mark back
	;			===========
	;			    4539

	; Try X=9 Y=89 cycles=4540
	; Try X=3 Y=216 cycles=4537 R2

	nop

	ldy	#216							; 2
sbloop1:ldx	#3							; 2
sbloop2:dex								; 2
	bne	sbloop2							; 2nt/3
	dey								; 2
	bne	sbloop1							; 2nt/3

	lda	KEYPRESS				; 4
	bpl	sb_no_keypress				; 3
	jmp	sb_start_over
sb_no_keypress:

	jmp	sb_display_loop				; 3

sb_start_over:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6





.align $100
.include "screen_split.s"


;.include "deater.inc"
background_hgr:
.incbin "SB_BACKGROUNDC.BIN.lz4",11
background_hgr_end:

