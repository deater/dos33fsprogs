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
	; Load graphic hgr

	lda	#<wreath_hgr
	sta	LZ4_SRC
	lda	#>wreath_hgr
	sta	LZ4_SRC+1

	lda	#<(wreath_hgr_end-8)	; skip checksum at end
	sta	LZ4_END
	lda	#>(wreath_hgr_end-8)	; skip checksum at end
	sta	LZ4_END+1

	lda	#<$2000
	sta	LZ4_DST
	lda	#>$2000
	sta	LZ4_DST+1

	jsr	lz4_decode

	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

	; so we have 5070 + 4550 = 9620 to kill

;	jsr	gr_copy_to_current		; 6+ 9292

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


;	jsr	play_music		; 6+1032

	; Try X=196 Y=2 cycles=1973

	; Try X=59 Y=10 cycles=3011

	ldy	#2							; 2
wrloopC:ldx	#196							; 2
wrloopD:dex								; 2
	bne	wrloopD							; 2nt/3
	dey								; 2
	bne	wrloopC							; 2nt/3


wr_all_gr:
	; 23 lines of this

	; 23 * 65 = 1495
	;             -4
	;            -13
	;       =========
	;	    1478

	bit	LORES						; 4

	; Try X=41 Y=7 cycles=1478

	ldy	#7							; 2
wrloopE:ldx	#41							; 2
wrloopF:dex								; 2
	bne	wrloopF							; 2nt/3
	dey								; 2
	bne	wrloopE							; 2nt/3



;======================================================
; We have 4550 cycles in the vblank, use them wisely
;======================================================

	; do_nothing should be      4550
	;			      -7 timeout
	;			     -34 keypress
	;			===========
	;			     468



	; Try X=11 Y=8 cycles=489 R2
	; Try X=31 Y=3 cycles=484
	; Try X=22 Y=4 cycles=465 R3

	lda	$0

	ldy	#4							; 2
wrloop1:ldx	#22							; 2
wrloop2:dex								; 2
	bne	wrloop2							; 2nt/3
	dey								; 2
	bne	wrloop1							; 2nt/3


	inc	FRAME						; 5
	lda	FRAME						; 3
	and	#3			; 15 Hz			; 2
	sta	FRAME						; 3
	beq	wr_frame_oflo					; 3
							;============
							;        16
								; -1
	lda	$0			; nop			;  3
	jmp	wr_frame_noflo					;  3
wr_frame_oflo:
	inc	FRAMEH						; 5
wr_frame_noflo:


	; no keypress =  10+(24)   = 34
	; left pressed = 9+8+12+(5)= 34
	; right pressed = 9+8+5+12 = 34

	lda	KEYPRESS				; 4
	bpl	wr_no_keypress				; 3
							; -1
	jmp	wr_handle_keypress			; 3
wr_no_keypress:
	inc	$0					; 5
	dec	$0					; 5
	inc	$0					; 5
	dec	$0					; 5
	nop						; 2
	nop						; 2

	jmp	wreath_display_loop			; 3

wr_handle_keypress:
	bit	KEYRESET	; clear keypress	; 4
	cmp	#'Q'|$80				; 2
	beq	wr_exit					; 3
							; -1
wr_exit:
wr_real_exit:
	bit	KEYRESET
	rts						; 6


