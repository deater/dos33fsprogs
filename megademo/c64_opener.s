; C64 Opener
; all good demos start with the C64 boot screen, right?

; Apple II has a lot of trouble making clear text with bluish background
; it looks a lot cleaner in black+white

; Zero page addresses

TOP	= $F0
BOTTOM	= $F1

c64_opener:

	;===================
	; init vars
	;===================
	lda	#0
	sta	TOP
	sta	BOTTOM

	;===================
	; setup graphics
	;===================

	; We assume that the c64 image was put in $2000 by the loader

	bit	PAGE0                   ; first graphics page
	bit	FULLGR			; full screen graphics
	bit	HIRES			; hires mode !!!
	bit	SET_GR			; graphics mode

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

        beq	c64_split
;.align  $100


	;================================================
	; c64_split
	;================================================
	; We want to:
	;	Wait 3s, just flashing cursor@1Hz
	;	Then slowly open to text page0
	; Count to 480?
	; Width = 0 - 40, 10 steps

c64_split:


;=========================
; Top third

; DdBbbNnNnNnNnNnNnNnNnNnNn NnNnNnNnNnNnNnNnTtttGgggNnNnNnNnNnNnNnNn	16= 4W



	ldx	#64							; 2
	jmp	c64_loop_1_five_in					; 3
c64_loop_1:
	lda	$0							; 3
	nop								; 2
c64_loop_1_five_in:
	lda	$0							; 3
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
								;=============
								;	 25

	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
								;============
								;	16

	bit	SET_TEXT						; 4
	bit	SET_GR							; 4

	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
								;============
								;	16
c64_loop_1_end:
	dex								; 2
	bne	c64_loop_1						; 3
								;============
								;	  5




;=========================
; Middle third

; DdBbbNnNnNnNnNnNnNnNnNnLl lNnNnNnNnNnTtttNnNnNnNnNnGgggNnNnNnNnLll	11=14W


									; 5-1=4
	ldx	#64							; 2
	jmp	c64_loop_2_four_in					; 3

c64_loop_2:
	nop								; 2
	nop								; 2
c64_loop_2_four_in:
	nop								; 2
	lda	$0							; 3
	lda	$0							; 3
	nop								; 2
	nop								; 2
	nop								; 2
	lda	$0
								;=============
								;	 20

	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	bit	SET_TEXT						; 4

	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2

	bit	SET_GR							; 4

	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	lda	$0

c64_loop_2_end:
	dex								; 2
	bne	c64_loop_2						; 3
								;============
								;	  5


;=========================
; Bottom third

; DdBbbNnNnNnNnNnNnNnNnNnNn NnTtttNnNnNnNnNnNnNnNnNnNnNnNnNnNnGgggNn	 2=32W

									; 5-1=4
	ldx	#64							; 2
	jmp	c64_loop_3_four_in					; 3

c64_loop_3:
	nop								; 2
	nop								; 2
c64_loop_3_four_in:
	nop								; 2
	lda	$0							; 3
	lda	$0							; 3
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
								;=============
								;	 20

	nop								; 2
	bit	SET_TEXT						; 4
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
								;============
								;	16





	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	nop								; 2
	bit	SET_GR							; 4
	nop								; 2
								;============
								;	16
c64_loop_3_end:
	dex								; 2
	bne	c64_loop_3						; 3
								;============
								;	  5

									; -1


	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be      4550
	;			     -10 keyboard handling
	;			      +1 leftover from main screen
	;			     -15
	;			     -12
	;			     -46
	;			 =  4468


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

	; Try X=17 Y=49 cycles=4460 R8
	nop
	lda	$0
	lda	$0

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
	; c64 graphic, load at $2000-$4000 to start with
	;===================
;c64:
;.incbin "c64.img"
;c64_end:


;=========================================================
; DdBbbNnNnNnNnNnNnNnNnNnNn NnNnNnNnNnNnNnNnNnNnNnNnNnNnNnNnNnNnNnNn	Nothing
; DdBbbNnNnNnNnNnNnNnNnNnNn NnNnNnNnNnNnNnNnTtttGgggNnNnNnNnNnNnNnNn	16= 4W
; DdBbbNnNnNnNnNnNnNnNnNnLl lNnNnNnNnNnNnNnTtttNnGgggNnNnNnNnNnNnLll	15= 6W
; DdBbbNnNnNnNnNnNnNnNnNnNn NnNnNnNnNnNnNnTtttNnNnGgggNnNnNnNnNnNnNn	14= 8W
; DdBbbNnNnNnNnNnNnNnNnNnLl lNnNnNnNnNnNnTtttNnNnNnGgggNnNnNnNnNnLll	13=10W
; DdBbbNnNnNnNnNnNnNnNnNnNn NnNnNnNnNnNnTtttNnNnNnNnGgggNnNnNnNnNnNn	12=12W
; DdBbbNnNnNnNnNnNnNnNnNnLl lNnNnNnNnNnTtttNnNnNnNnNnGgggNnNnNnNnLll	11=14W
; DdBbbNnNnNnNnNnNnNnNnNnNn NnNnNnNnNnTtttNnNnNnNnNnNnGgggNnNnNnNnNn	10=16W
; DdBbbNnNnNnNnNnNnNnNnNnLl lNnNnNnNnTtttNnNnNnNnNnNnNnGgggNnNnNnLll	 9=18W
; DdBbbNnNnNnNnNnNnNnNnNnNn NnNnNnNnTtttNnNnNnNnNnNnNnNnGgggNnNnNnNn	 8=20W
; DdBbbNnNnNnNnNnNnNnNnNnLl lNnNnNnTtttNnNnNnNnNnNnNnNnNnGgggNnNnLll	 7=22W
; DdBbbNnNnNnNnNnNnNnNnNnNn NnNnNnTtttNnNnNnNnNnNnNnNnNnNnGgggNnNnNn	 6=24W
; DdBbbNnNnNnNnNnNnNnNnNnLl lNnNnTtttNnNnNnNnNnNnNnNnNnNnNnGgggNnLll	 5=26W
; DdBbbNnNnNnNnNnNnNnNnNnNn NnNnTtttNnNnNnNnNnNnNnNnNnNnNnNnGgggNnNn	 4=28W
; DdBbbNnNnNnNnNnNnNnNnNnLl lNnTtttNnNnNnNnNnNnNnNnNnNnNnNnNnGgggLll	 3=30W
; DdBbbNnNnNnNnNnNnNnNnNnNn NnTtttNnNnNnNnNnNnNnNnNnNnNnNnNnNnGgggNn	 2=32W

; nLllDdBbbNnNnNnNnNnNnLllN nTtttNnNnNnNnNnNnNnNnNnNnNnNnNnNnNnGgggN     NOPE
; DdBbbNnNnNnNnNnNnNnNnNnNn TtttNnNnNnNnNnNnNnNnNnNnNnNnNnNnNnNnGggg	 0=36W




