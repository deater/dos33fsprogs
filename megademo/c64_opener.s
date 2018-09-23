; C64 Opener
; all good demos start with the C64 boot screen, right?

; Apple II has a lot of trouble making clear text with bluish background
; would be a lot clearer if I used black and white

TOP = $F0
BOTTOM = $F1

c64_opener:
	;===================
	; init vars
	;===================
	lda	#0
	sta	TOP
	sta	BOTTOM

	;===================
	; set graphics mode
	;===================

	bit	PAGE0                   ; first graphics page
	bit	FULLGR			; full screen graphics
	bit	HIRES			; hires mode !!!
	bit	SET_GR			; graphics mode

	lda	#<c64
	sta	LZ4_SRC
	lda	#>c64
	sta	LZ4_SRC+1

	lda	#<c64_end
	sta	LZ4_END
	lda	#>c64_end
	sta	LZ4_END+1


	lda	#<$2000
	sta	LZ4_DST
	lda	#>$2000
	sta	LZ4_DST+1

	jsr	lz4_decode


	jsr	wait_until_keypress


	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6

	bit	PAGE0                   ; first graphics page		; 4
	bit	FULLGR			; full screen graphics		; 4
	bit	HIRES			; hires mode !!!		; 4
	bit	SET_GR			; graphics mode			; 4

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 + 4550 lines to go (9620)
	; - 16 = 9604, -3 for jmp = 9601

	; Try X=18 Y=100 cycles=9601

	ldy	#100							; 2
loopcoA:ldx	#18							; 2
loopcoB:dex								; 2
	bne	loopcoB							; 2nt/3
	dey								; 2
	bne	loopcoA							; 2nt/3

        jmp     c64_split
.align  $100


	;================================================
	; c64_split
	;================================================
	; We want to:
	;	Wait 3s, just flashing cursor@1Hz
	;	Then slowly open to text page0
	; Count to 480?
	; Width = 0 - 40, 10 steps

c64_split:

	; curtain open
	; 0 = delay 65
	; 1 = delay 25+18, 4 open, 18
	; 2 = delay 25+16, 8 open, 16
	; 3 = delay 25+14, 12 open, 14
	; 3 = delay 25+12, 16 open, 12
	; 3 = delay 25+10, 20 open, 10
	; 3 = delay 25+ 8, 24 open, 8
	; 3 = delay 25+ 6, 28 open, 6
	; 3 = delay 25+ 4, 32 open, 4
	; 3 = delay 25+ 2, 36 open, 2
	; 3 = delay 25+ 0, 40 open, 0

	ldx	#192							; 2
xloop:
	lda	#6		; 					; 2
	jsr	delay_a						; 25+6= 31
								;===========
								;	 33

	bit	SET_TEXT						; 4
	nop								; 2
	nop								; 2
	bit	SET_GR							; 4
								;===========
								;	 12

	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	lda	$0							; 3
	dex								; 2
	bne	xloop							; 3
								;============
								;	 20
	; kill 65*192 = 12480

	; Try X=24 Y=99 cycles=12475 R5

;	nop
;	lda	$0
;
;	ldy     #99							; 2
;loopcoC:ldx	#24							; 2
;loopcoD:dex								; 2
;	bne	loopcoD							; 2nt/3
;	dey								; 2
;	bne	loopcoC							; 2nt/3



	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be      4550
	;			     -10 keyboard handling
	;			      -1 leftover from main screen
	;			     -15
	;			     -12
	;			     -46
	;			 =  4466


	; run the 2Hz counter, overflow at 30 60Hz frames
	clc								; 2
	lda	BOTTOM							; 3
	adc	#1							; 2
	sta	BOTTOM							; 3
	cmp	#30							; 2
	bne	not_thirty						; 3
								;===========
								;	15
thirty:
									; -1
	lda	#0							; 2
	sta	BOTTOM							; 3
	inc	TOP							; 5
	jmp	done_thirty						; 3
								;===========
								;	 12

not_thirty:
	lda	TOP							; 3
	lda	TOP							; 3
	lda	TOP							; 3
	lda	TOP							; 3
								;===========
								;	 12

done_thirty:
	; handle the cursor
	; FIXME: not aligned well.  Do we care?

	lda	TOP							; 3
	and	#$1							; 2
	beq	cursor_off						; 3
								;============
								;         8
cursor_on:
									; -1
	; it's lSB first
	; blue is 6
	; 1 1111110
	lda	#$fE	; blue						; 2
	sta	$3300	; 52						; 4
	sta	$3B00	; 54						; 4
	sta	$2380	; 56						; 4
	sta	$2B80	; 58						; 4
	; purple is 2
	; 0 1111110
	lda	#$7E	; purple					; 2
	sta	$3700	; 53						; 4
	sta	$3F00	; 55						; 4
	sta	$2780	; 57						; 4
	sta	$2F80	; 59						; 4

	jmp	cursor_done						; 3
								;============
								;	 38
cursor_off:
	; blue is 6
	; 1 1010101
	lda	#$d5	; blue						; 2
	sta	$3300	; 52						; 4
	sta	$3B00	; 54						; 4
	sta	$2380	; 56						; 4
	sta	$2B80	; 58						; 4
	; purple is 2
	; 0 1010101
	lda	#$55	; purple					; 2
	sta	$3700	; 53						; 4
	sta	$3F00	; 55						; 4
	sta	$2780	; 57						; 4
	sta	$2F80	; 59						; 4
	nop								; 2
								;============
								;	 38


cursor_done:

	; Try X=17 Y=49 cycles=4460 R6
	nop
	nop
	nop

	ldy     #49							; 2
loopcoE:ldx	#17							; 2
loopcoF:dex								; 2
	bne	loopcoF							; 2nt/3
	dey								; 2
	bne	loopcoE							; 2nt/3


	lda	KEYPRESS				; 4
	bpl	no_c64_keypress				; 3
	jmp	done_c64
no_c64_keypress:

	jmp	c64_split				; 3

done_c64:
	rts						; 6

	;===================
	; graphics
	;===================
c64:
.incbin "c64.img.lz4",11
c64_end:
