;=====================================
; XMAS2018 -- Ball Part
;=====================================


ball:

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
	;  ball graphic already loaded to $4000 (HGR page1)

	;=============================
	; set up scrolling

	lda	#0
	sta	OFFSET

	;=============================
	; decompress scroll image to $800

	lda     #<greets
	sta	LZ4_SRC
	lda	#>greets
	sta	LZ4_SRC+1

	lda	#<(greets_end-8)	; skip checksum at end
	sta	LZ4_END
	lda	#>(greets_end-8)	; skip checksum at end
	sta	LZ4_END+1

	lda	#<$800
	sta	LZ4_DST
	lda	#>$800
	sta	LZ4_DST+1

	jsr	lz4_decode

	lda	#237
	sta	SCROLL_LENGTH

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
	;  -16 mode set
	;  - 3 for jmp
	;=======
	; 9601

	; Try X=18 Y=100 cycles=9601

	ldy	#100							; 2
baloopA:ldx	#18							; 2
baloopB:dex								; 2
	bne	baloopB							; 2nt/3
	dey								; 2
	bne	baloopA							; 2nt/3

	jmp	ball_begin_loop
.align  $100


	;================================================
	; Ball Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

ball_begin_loop:

ball_display_loop:

	; draw 160 lines of hires PAGE1
	bit	HIRES							; 4
	bit	PAGE1							; 4

	; (160*65)-8 = 10392

	; Try X=43 Y=47 cycles=10388 R4

	nop
	nop

	ldy	#47							; 2
baloopC:ldx	#43							; 2
baloopD:dex								; 2
	bne	baloopD							; 2nt/3
	dey								; 2
	bne	baloopC							; 2nt/3


	; draw 32 (4) lines of lores PAGE0
	bit	LORES							; 4
	bit	PAGE0							; 4

	; (32*65)-8 = 2072

	; Try X=1 Y=188 cycles=2069

	lda	$0

	ldy	#188							; 2
baloopE:ldx	#1							; 2
baloopF:dex								; 2
	bne	baloopF							; 2nt/3
	dey								; 2
	bne	baloopE							; 2nt/3



;======================================================
; We have 4550 cycles in the vblank, use them wisely
;======================================================

	; do_nothing should be      4550
	;                          -1023 music
	;                          -1841 scroll/else
	;			     -18 frame adjust
	;			     -10 keypress
	;			      -8 pick which
	;			      -7 check for end
	;			===========
	;			    1643

	inc	FRAME						; 5
	lda	FRAME						; 3
	and	#63						; 2
	beq	framing						; 3

								; -1
	lda	$0						; 3
	jmp	done_framing					; 3
framing:
	inc	FRAMEH						; 5
done_framing:
							;=============
							;	18


	lda	FRAMEH						; 3
	cmp	#10		; length of song?		; 2
	beq	ball_done					; 3
								; -1
							;===============
							;         7




	jsr	play_music		; 6+1017


	; slow things down a bit

	lda	FRAME						; 3
	and	#1						; 2
	beq	do_scrolling					; 3
							;=============
							;         8

do_nothing:
								; -1

	; 1839 - 1 + 3 = 1841

	; Try X=60 Y=6 cycles=1837 R2

	nop

	ldy	#6							; 2
baloopQ:ldx	#60							; 2
baloopR:dex								; 2
	bne	baloopR							; 2nt/3
	dey								; 2
	bne	baloopQ							; 2nt/3

	jmp	done_actions						; 3


do_scrolling:
	jsr	scroll_loop		; 6+1835
					;=========
					; 1841
done_actions:

	; Try X=163 Y=2 cycles=1643

	ldy	#2							; 2
baloop1:ldx	#163							; 2
baloop2:dex								; 2
	bne	baloop2							; 2nt/3
	dey								; 2
	bne	baloop1							; 2nt/3

	; keypress = 10

	lda	KEYPRESS				; 4
	bpl	ba_no_keypress				; 3
							; -1
	jmp	ball_done				; 3
ba_no_keypress:
	jmp	ball_display_loop			; 3

ball_done:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6


.include "gr_scroll.s"
greets:
.incbin "greets.raw.lz4",11
greets_end:
