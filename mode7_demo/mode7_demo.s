.include "zp.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	clear_screens		 ; clear top/bottom of page 0/1
	jsr     set_gr_page0

	lda	#$4
	sta	DRAW_PAGE

	lda	#<demo_rle
	sta	GBASL
	lda	#>demo_rle
	sta	GBASH

	; Load offscreen
	lda	#<$c00
	sta	BASL
	lda	#>$c00
	sta	BASH

	jsr	load_rle_gr

loop_forever:

	lda	#<fade_lookup
	sta	GBASL
	lda	#>fade_lookup
	sta	GBASH

	jsr	gr_fade
	jsr	page_flip

	lda	#200
	jsr	WAIT

	lda	#<(fade_lookup+16)
	sta	GBASL
	lda	#>(fade_lookup+16)
	sta	GBASH

	jsr	gr_fade
	jsr	page_flip

	lda	#200
	jsr	WAIT

	lda	#<(fade_lookup+32)
	sta	GBASL
	lda	#>(fade_lookup+32)
	sta	GBASH

	jsr	gr_fade
	jsr	page_flip

	lda	#200
	jsr	WAIT

	lda	#<(fade_lookup+48)
	sta	GBASL
	lda	#>(fade_lookup+48)
	sta	GBASH

	jsr	gr_fade
	jsr	page_flip

	lda	#200
	jsr	WAIT



	jmp	loop_forever


;================================================
; Fade in/out lowres graphics
; GR image should be in $C00

gr_fade:

	ldx	 #0		; set ypos to zero			; 2

gr_copy_loop:
	lda	gr_offsets,X	; lookup low byte for line addr		; 4+

	sta	gr_copy_line1+1	; out and in are the same		; 4
	sta	gr_copy_line2+1						; 4

	lda	gr_offsets+1,X	; lookup high byte for line addr	; 4+
	clc								; 2
	adc	DRAW_PAGE						; 3
	sta	gr_copy_line2+2						; 4

	lda	gr_offsets+1,X	; lookup high byte for line addr	; 4+
	adc	#$8		; for now, fixed 0xc			; 2
	sta	gr_copy_line1+2						; 4

	ldy     #0		; set xpos counter to 0			; 2


	cpx	#$8		; don't want to copy bottom 4*40	; 2
	bcs	gr_copy_above4						; 2nt/3

gr_copy_below4:
	ldy	#119		; for early ones, copy 120 bytes	; 2
	bcc	gr_copy_line1	;					; 3

gr_copy_above4:			; for last four, just copy 80 bytes
	ldy	#79							; 2

gr_copy_line1:
	lda	$ffff,Y		; load a byte (self modified)		; 4+
	pha

	sty	TEMPY		; save Y

	; do high nibble
	and	#$f0
	lsr
	lsr
	lsr
	lsr

	tay
	lda	(GBASL),Y
	and	#$f0
	sta	TEMP

	; do low nibble
	pla
	and	#$0f

	tay
	lda	(GBASL),Y
	and	#$0f
	ora	TEMP

	ldy	TEMPY		; restore Y

gr_copy_line2:
	sta	$ffff,Y		; store a byte (self modified)		; 5
	dey			; decrement pointer			; 2
	bpl	gr_copy_line1	;					; 2nt/3

gr_copy_line_done:
	inx			; increment ypos value			; 2
	inx			; twice, as address is 2 bytes		; 2
	cpx	#16		; there are 8*2 of them			; 2
	bne	gr_copy_loop	; if not, loop				; 3
	rts								; 6


;===============================================
; External modules
;===============================================

.include "../asm_routines/gr_unrle.s"
.include "../asm_routines/hlin_clearscreen.s"
.include "../asm_routines/gr_setpage.s"
.include "../asm_routines/pageflip.s"

.include "mode7_demo_backgrounds.inc"


; Fade paramaters
fade_lookup:
.byte	$00,$11,$22,$33,$44,$55,$66,$77, $88,$99,$aa,$bb,$cc,$dd,$ee,$ff
.byte   $00,$00,$00,$22,$00,$00,$22,$55, $55,$88,$55,$33,$44,$88,$44,$77
.byte	$00,$00,$00,$00,$00,$00,$55,$00, $00,$00,$00,$00,$88,$00,$00,$55
.byte	$00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
