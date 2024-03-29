; diamond scroll

; by Vince `deater` Weaver

FULLGR		= $C052
PAGE1		= $C054
PAGE2		= $C055
LORES		= $C056		; Enable LORES graphics

PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
SETGR		= $FB40
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

LINE		= $FF

diamond:

	jsr	SETGR
	bit	FULLGR

diamond_loop:


	; 4 -> 8 0100 1000 eor $C
page_smc:
	lda	#$4		; reset to beginning
	sta	inner_loop_smc+2

	lda	#8		; lines to count (*3=24)
	sta	LINE

	;============================
	; draw an interleaved line

line_loop:
	ldx	#119

screen_loop:

	txa			 ; extrapolate Y from X
	and	#$7
	tay

pattern_smc:
	lda	pattern1,Y

inner_loop_smc:
	sta	$400,X

	dex
	bpl	screen_loop

	;=================================
	; move to next pattern
	; assume we are in same 256 byte page (so high byte never change)

	jsr	scroll_pattern

	; move to next line

	clc
	lda	inner_loop_smc+1
	adc	#$80
	sta	inner_loop_smc+1	; FIXME just inc if carry set
	bcc	noflo
	inc	inner_loop_smc+2
noflo:

	dec	LINE
	bne	line_loop

	;=======================================
	; done drawing frame
	;=======================================

	; draw line pattern

	lda	#$0F			; white bar
	ldx	#21
draw_line_loop:

dll_smc:
	sta	$430,X			; partway down screen
	dex
	bne	draw_line_loop


	;=========================
	; scroll one line

	jsr	scroll_pattern

	; switch page
	lda	page_smc+1
	eor	#$c
	sta	page_smc+1
	sta	dll_smc+2
				; is 4 or 8
	lsr
	lsr			; now 0 or 1 (C is 1 or 0)
	and	#$1
	tax
	lda	PAGE1,X

	lda	#200
	jsr	WAIT

	; A is 0 after

	beq	diamond_loop


scroll_pattern:
	clc
	lda	pattern_smc+1
	adc	#8
	and	#$1f
	sta	pattern_smc+1
	rts


.align 32

pattern1:
	.byte $04,$40,$d4,$4d,$d4,$40,$04,$40
	.byte $d4,$4d,$04,$40,$04,$4d,$d4,$40
	.byte $d4,$40,$04,$40,$04,$40,$d4,$4d
	.byte $04,$4d,$d4,$40,$d4,$4d,$04,$40

pattern2:
	.byte $40,$d4,$4d,$04,$4d,$d4,$40,$04
	.byte $4d,$04,$40,$04,$40,$04,$4d,$d4
	.byte $4d,$d4,$40,$04,$40,$d4,$4d,$0d
	.byte $40,$04,$4d,$d4,$4d,$04,$40,$04

