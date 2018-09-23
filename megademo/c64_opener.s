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
	; - 16 = 9604

	; Try X=57 Y=33 cycles=9604

	ldy	#33							; 2
loopcoA:ldx	#57							; 2
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

	; kill 65*192 = 12480

	; Try X=24 Y=99 cycles=12475 R5

	nop
	lda	$0

	ldy     #99							; 2
loopcoC:ldx	#24							; 2
loopcoD:dex								; 2
	bne	loopcoD							; 2nt/3
	dey								; 2
	bne	loopcoC							; 2nt/3



	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be      4550
	;			     -10 keyboard handling
	;			 =  4540

	clc								; 2
	lda	BOTTOM							; 3
	adc	#1							; 2
	sta	BOTTOM							; 3
	cmp	#30							; 2
	bne	not_thirty						; 3/2
thirty:
	lda	#0							; 2
	sta	BOTTOM							; 3
	lda	TOP							; 3
	clc								; 2
	adc	#1							; 2
	sta	TOP							; 3
not_thirty:



	; handle the cursor
	; FIXME: not aligned well.  Do we care?

	lda	TOP							; 3
	and	#$1							; 2
	beq	cursor_off						; 3/2
cursor_on:
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



cursor_done:



	; Try X=9 Y=89 cycles=4540

	nop
	lda	$0

	ldy     #89							; 2
loopcoE:ldx	#9							; 2
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
