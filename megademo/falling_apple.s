; Display Falling Apple II and message


falling_apple:

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


	lda	#<apple_low
	sta	GBASL
	lda	#>apple_low
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

	lda	#<apple_high
	sta	GBASL
	lda	#>apple_high
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
faloopA:ldx	#9							; 2
faloopB:dex								; 2
	bne	faloopB							; 2nt/3
	dey								; 2
	bne	faloopA							; 2nt/3

        jmp	fa_display_loop						; 3
.align  $100


	;================================================
	; Display Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; We want to alternate between page1 and page2 every 65 cycles

	; 2 + 48*(  (4+2+25*(2+3)) + (4+2+23*(2+3)+4+5)) + 9)
	;     48*[(6+125)-1] + [(6+115+10)-1]

fa_display_loop:

	ldy	#48						; 2

outer_loop:

	bit	PAGE0						; 4
	ldx	#25		; 130 cycles with PAGE0		; 2
page0_loop:			; delay 126+bit
	dex							; 2
	bne	page0_loop					; 2/3


	bit	PAGE1						; 4
	ldx	#23		; 130 cycles with PAGE1		; 2
page1_loop:			; delay 115+(7 loop)+4 (bit)+4(extra)
	dex							; 2
	bne	page1_loop					; 2/3

	nop							; 2
	lda	DRAW_PAGE					; 3

	dey							; 2
	bne	outer_loop					; 2/3



;======================================================
; We have 4550 cycles in the vblank, use them wisely
;======================================================
	; 4550 cycles
	;   +1-2 from above
	;  -10 keypress
	;================
	; 4539


	; Try X=24 Y=36 cycles=4537 R2

	nop	; 2

	ldy	#36							; 2
faloop1:ldx	#24							; 2
faloop2:dex								; 2
	bne	faloop2							; 2nt/3
	dey								; 2
	bne	faloop1							; 2nt/3


	;=====================
	; check for keypress
	; 10 cycles

	lda	KEYPRESS				; 4
	bpl	fa_no_keypress				; 3
	jmp	fa_done
fa_no_keypress:

	jmp	fa_display_loop				; 3

fa_done:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6




;.include "../asm_routines/gr_unrle.s"
;.include "gr_copy.s"

;.include "apple_40_96.inc"


