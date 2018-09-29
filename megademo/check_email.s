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

	jmp	em_begin_loop
.align  $100


	;================================================
	; Email Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was


	; For this part we want

	; T00000000000000000000 G0000000000000000000000
	; T00000000000000000000 G0000000000000000000000
	; T00000000000000000000 G1111111111111111111111
	; T00000000000000000000 G1111111111111111111111
	; T11111111111111111111 G0000000000000000000000
	; T11111111111111111111 G0000000000000000000000
	; T11111111111111111111 G1111111111111111111111
	; T11111111111111111111 G1111111111111111111111

	; 0,1,0,1 0,0,1,1
	; 54,55,54,55  54,54,55,55

em_begin_loop:

em_display_loop:

	ldy	#96
em_outer_loop:

	bit	PAGE0			; 4
	lda	#$54			; 2
	sta	draw_line_p1+1		; 4
	jsr	draw_line_1		; 6
	bit	PAGE0			; 4
	lda	#$54			; 2
	sta	draw_line_p2+1		; 4
	jsr	draw_line_2		; 6

	dey							; 2
	bne	em_outer_loop					; 3
								; -1


	; 8+17+14 +8+15
;em_begin_loop:
;
;em_display_loop:
;
;	ldy	#96						; 2

;em_outer_loop:

; line0

;	bit	PAGE0						; 4

;	lda	$0						; 3
;	lda	$0						; 3
;	lda	$0						; 3
;	lda	$0						; 3
;	lda	$0						; 3
;	bit	SET_TEXT					; 4

;	nop							; 2
;	nop							; 2
;	nop							; 2
;	nop							; 2
;	nop							; 2

							;==============
							;	33

;	bit	PAGE0						; 4
;	bit	SET_GR						; 4
;	lda	$0
;	lda	$0
;	lda	$0
;	lda	$0
;	lda	$0
;	lda	$0
;	lda	$0
;	lda	$0

							;==============
							;	32

; line1
;	bit	PAGE0						; 4


;	lda	$0						; 3
;	lda	$0						; 3
;	lda	$0						; 3
;	lda	$0						; 3
;	lda	$0						; 3

;	bit	SET_TEXT					; 4
;	nop							; 2
;	nop							; 2
;	nop							; 2
;	nop							; 2
;	nop							; 2
;
							;==============
							;	33

;	bit	PAGE0						; 4
;	bit	SET_GR						; 4


;	lda	$0						; 3
;	lda	$0						; 3
;	lda	$0						; 3
;	nop							; 2
;	nop							; 2
;	nop							; 2
;	nop							; 2
;	nop							; 2

							;==============
							;	27

;em_page1_loop:

;	dey							; 2
;	bne	em_outer_loop					; 3
								; -1


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




draw_line_1:	; line0

	; come in with 16
;	bit	PAGE0						; 4
;	lda	$0						; 3
;	lda	$0						; 3
;	lda	$0						; 3
;	lda	$0						; 3
	lda	$0						; 3

	bit	SET_TEXT					; 4
	nop							; 2
	nop							; 2
	nop							; 2
	nop							; 2
	nop							; 2

							;==============
							;	33


draw_line_p1:
	bit	PAGE0						; 4
	bit	SET_GR						; 4
	lda	$0
	lda	$0
	lda	$0
	lda	$0

	nop
	nop
	nop
;	lda	$0
;	lda	$0
	rts

							;==============
							;	32


draw_line_2:	; line0

	; come in with 16
;	bit	PAGE0						; 4
;	lda	$0						; 3
;	lda	$0						; 3
;	lda	$0						; 3
;	lda	$0						; 3
	lda	$0						; 3

	bit	SET_TEXT					; 4
	nop							; 2
	nop							; 2
	nop							; 2
	nop							; 2
	nop							; 2

							;==============
							;	33

draw_line_p2:
	bit	PAGE0						; 4
	bit	SET_GR						; 4
	lda	$0
	lda	$0
	lda	$0
;	lda	$0
;	nop
	nop
	nop
;	lda	$0
;	lda	$0
	rts
							;==============
							;	32




.include "email_40_96.inc"


