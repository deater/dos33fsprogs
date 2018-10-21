; C64 Opener
; all good demos start with the C64 boot screen, right?

; Apple II has a lot of trouble making clear text with bluish background
; it looks a lot cleaner in black+white

; Zero page addresses

c64_opener:

	;===================
	; init vars
	;===================
	lda	#0
	sta	FRAME
	sta	FRAMEH

	;===================
	; setup graphics
	;===================

	; We assume that the c64 image was put in $2000 by the loader

	;===================
	; setup text
	;===================

	lda	#8
	sta	DRAW_PAGE

	lda	#$A0			; regular spaces
	jsr	clear_gr

	lda	#<apple2_text
	sta	OUTL
	lda	#>apple2_text
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

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

	;	5070+4550 = 9620
	;                    -16
	;		      -3
	;                     +1 to get things aligned?
	;                  -9298
	;                 =======
	;		     304

	jsr	gr_copy_to_current	; 6+ 9292

	; Try X=29 Y=2 cycles=303

	; Try X=59 Y=1 cycles=302 R2

	nop

	ldy	#1							; 2
loopcoA:ldx	#59							; 2
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


c64_split:
c64_mixed:
	jmp	c64_kill_time					; 3

	; Put smc here to jmp to kill_time until we hit state2?

; EA	nop		; kill 6 cycles (room for rts)		; 2
; A2 08	ldx     #8	; width of opening in table		; 2
	ldy     #24	; height?				; 2

c64_mixed_loop:
c64_smc2:
	lda	c64_multiples+17,x ; lookup split size	; 4    \
	sta	c64_smc+1	; modify code		; 4    |
c64_smc:						;      |-- 65
        jsr	tsplit_4				; 6+46 |
        dey						; 2    |
        bne     c64_mixed_loop				; 3    /

							; -1
        nop						; 2
        ldy     #24					; 2
        dex						; 2
        bne     c64_smc					; 3

                                                        ; -1

           ; need to kill
						; -6 from offset
						; +1 fall through
						; -9 from check
						; +1 from other fallthrough
					;================
					;        -13

c64_done_screen:

;======================================================
; We have 4550 cycles in the vblank, use them wisely
;======================================================
	; do_nothing should be      4550
	;			     -13 from screen drawing
	;			     -10 keyboard handling
	;			     -27 frameh adjustment
	;			     -44 state2 handling
	;			     -24 done_blinding
	;			      -7 check if past time
	;			     -46 cursor blink
	;==================================
	;			 =  4379


	; run the 2Hz counter, overflow at 30 60Hz frames
	clc								; 2
	lda	FRAME							; 3
	adc	#1							; 2
	sta	FRAME							; 3

	cmp	#30							; 2
	bne	not_thirty						; 3
								;===========
								;	15
thirty:
									; -1
	lda	#0							; 2
	sta	FRAME							; 3
	inc	FRAMEH							; 5
	jmp	done_thirty						; 3
								;===========
								;	 12

not_thirty:
	lda	$0	; nop						; 3
	lda	$0	; nop						; 3
	lda	$0	; nop						; 3
	lda	$0	; nop						; 3
								;===========
								;	 12

done_thirty:


c64_window_adjust:

	;===========================
	; If > 3.5s then patch SMC and move window
	;===========================
	; < 7 = 8+36 = 44
	; > 7, not tick = 8+36=44

	lda	FRAMEH							; 3
	cmp	#7							; 2
	bcc	c64_not_state2						; 3
								;============
								;	  8

	; Update the code to not kill_time but do the split		; -1
	lda	#$EA							; 2
	sta	c64_mixed						; 4
	lda	#$A2							; 2
	sta	c64_mixed+1						; 4
	lda	#$08							; 2
	sta	c64_mixed+2						; 4

	lda	FRAME							; 3
	and	#$03							; 2
	bne	blj							; 3
								;===========
								;	25

									; -1
c64_smc3:
	dec	c64_smc2+1						; 6
	jmp	blj_done						; 3
								;============
								;	8
blj:
	nop
	lda	$0
	lda	$0
blj_done:



	jmp	c64_done_states						; 3

							;===================
							;		36
c64_not_state2:
	inc	$0	; 5
	dec	$0	; 5
	inc	$0	; 5
	dec	$0	; 5
	inc	$0	; 5
	dec	$0	; 5
	lda	$0	; 3
	lda	$0	; 3



c64_done_states:

	;=======================
	; see if done blinding
	;=======================
	;

	lda	FRAMEH							; 3
	cmp	#9							; 2
	bne	c64_wait_blinding					; 3
								;===========
								;	  8

									; -1
	lda	#$ea							; 2
	sta	c64_smc3						; 4
	sta	c64_smc3+1						; 4
	sta	c64_smc3+2						; 4
	jmp	c64_done_blinding					; 3
								;===========
								;        16
c64_wait_blinding:
	lda	$0
	lda	$0
	lda	$0
	lda	$0
	nop
	nop

c64_done_blinding:



	;=======================
	; see if done
	;=======================

	lda	FRAMEH							; 3
	cmp	#22							; 2
	beq	done_c64						; 3
									; -1
								;============
								;	  7

c64_blink_cursor:
	; handle the cursor
	; FIXME: not aligned well.  Do we care?

	lda	FRAMEH							; 3
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

;	Try X=96 Y=9 cycles=4375 R4

	nop
	nop

	ldy	#9							; 2
loopcoE:ldx	#96							; 2
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
	bit	KEYRESET
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



	;===========================================
	; c64_kill_time
	;===========================================
	; do nothing but blink cursor
	; 192 * 65 = 12480 cycles
	;              - 3 jsr in
	;		-3 jmp back
	;		+13 to match split
	;           ========
	;            12487
c64_kill_time:

	; Try X=165 Y=15 cycles=12466 R8

	; Try X=33 Y=73 cycles=12484 R3

	lda	$0

	ldy     #73							; 2
loopc6a:ldx	#33							; 2
loopc6b:dex								; 2
	bne	loopc6b							; 2nt/3
	dey								; 2
	bne	loopc6a							; 2nt/3


	jmp	c64_done_screen						; 3


.align $100


apple2_text:
.byte 16,0
.asciiz "APPLE ]["
.byte 4,20
.asciiz "NONE OF THIS SHOULD BE POSSIBLE,"
.byte 5,21
.asciiz "RACING THE BEAM TO THE EXTREME"

; NOTE: Needs to start at least 15 bytes into the page
c64_multiples:
	.byte	184,184
	.byte	184,184,184,184,184,184,184,184
        .byte   161,138,115, 92, 69 ,46,23,   0
	.byte	0,0,0,0,0,0,0,0
	; end is c64_multiples+24


