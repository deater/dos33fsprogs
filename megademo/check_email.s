; Display e-mail demo

; 40x96 graphics as well as half-screen text manipulation


check_email:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE

	;=============================
	; Load graphic page0

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00


	lda	#<email_low
	sta	GBASL
	lda	#>email_low
	sta	GBASH
	jsr	load_rle_gr

	lda	#4
	sta	DRAW_PAGE

	jsr	gr_copy_to_current	; copy to page1

	; GR part
	bit	PAGE1
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	;=============================
	; Load graphic page1

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00

	lda	#<email_high
	sta	GBASL
	lda	#>email_high
	sta	GBASH
	jsr	load_rle_gr

	lda	#0
	sta	DRAW_PAGE

	jsr	gr_copy_to_current

	; GR part
	bit	PAGE0


	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

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
celoopA:ldx	#9							; 2
celoopB:dex								; 2
	bne	celoopB							; 2nt/3
	dey								; 2
	bne	celoopA							; 2nt/3

	jmp	em_display_loop
.align  $100


	;================================================
	; Email Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; We want to alternate between page1 and page2 every 65 cycles
        ;       vblank = 4550 cycles to do scrolling


	; 2 + 48*(  (4+2+25*(2+3)) + (4+2+23*(2+3)+4+5)) + 9)
	;     48*[(6+125)-1] + [(6+115+10)-1]

	; For this part we want

	; T00000000000000000000 G0000000000000000000000
	; T00000000000000000000 G0000000000000000000000
	; T00000000000000000000 G1111111111111111111111
	; T00000000000000000000 G1111111111111111111111
	; T11111111111111111111 G0000000000000000000000
	; T11111111111111111111 G0000000000000000000000
	; T11111111111111111111 G1111111111111111111111
	; T11111111111111111111 G1111111111111111111111


em_display_loop:

	ldy	#48						; 2

em_outer_loop:

	bit	PAGE0						; 4
	ldx	#25		; 130 cycles with PAGE0		; 2
em_page0_loop:			; delay 126+bit
	dex							; 2
	bne	em_page0_loop					; 2/3


	bit	PAGE1						; 4
	ldx	#23		; 130 cycles with PAGE1		; 2
em_page1_loop:			; delay 115+(7 loop)+4 (bit)+4(extra)
	dex							; 2
	bne	em_page1_loop					; 2/3

	nop							; 2
	lda	DRAW_PAGE					; 3

	dey							; 2
	bne	em_outer_loop					; 2/3



	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================
	; do_nothing should be      4550+1 -2-9 -7= 4533

	jsr	do_nothing				; 6

	lda	KEYPRESS				; 4
	bpl	em_no_keypress				; 3
	jmp	em_start_over
em_no_keypress:

	jmp	em_display_loop				; 3

em_start_over:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6



.include "email_40_96.inc"


