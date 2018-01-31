; Closing Credits

;===========
; CONSTANTS
;===========
	NUM_CREDITS	EQU 10

	;===============
	; Init screen
	;===============

	;===========================
	;===========================
	; Main Loop
	;===========================
	;===========================

forever_loop:
	ldx	#0
	stx	YY

	lda	#>credits
	sta	OUTH
	lda	#<credits
	sta	OUTL

outer_loop:


credit_loop:

	ldy	#0
	lda	(OUTL),Y

	clc
	adc	#7

	sta	CH

	lda	#22
	sta	CV

	lda	#$f6	; - 10
	sta	XX
inner_loop:

	jsr	htab_vtab

	ldy	#1
print_loop:
	lda	(OUTL),Y
	beq	done_print

	clc
	adc	XX

	ora	#$80
	sta	(BASL),Y
	iny
	jmp	print_loop
done_print:



	;==================
	; flip pages
	;==================

	jsr	page_flip						; 6


	;==================
	; delay?
	;==================

	lda	#$C0
	bit	SPEAKER
	jsr	WAIT

	ldx	XX
	inx
	stx	XX
	cpx	#1
	bne	inner_loop

	;==================
	; Delay since done
	;==================

	lda	#$F0
	jsr	WAIT
	lda	#$F0
	jsr	WAIT
	lda	#$F0
	jsr	WAIT
	lda	#$F0
	jsr	WAIT

	;==================
	; Next credit
	;==================

	lda	#8
	sta	CH
	lda	#22
	sta	CV

	lda	OUTH
	pha
	lda	OUTL
	pha

	lda	#>empty
	sta	OUTH
	lda	#<empty
	sta	OUTL

	jsr	print_both_pages

	pla
	sta	OUTL
	pla
	sta	OUTH

	ldy	#0
skip_credit:
	lda	(OUTL),Y

	inc	OUTL
	bne	overflow
	inc	OUTH
overflow:
	cmp	#0
	beq	done_skip
	jmp	skip_credit
done_skip:

	ldx	YY
	inx
	stx	YY
	cpx	#10
	beq	forever
	jmp	outer_loop

	;==================
	; loop forever
	;==================
forever:
	jmp	forever_loop						; 3


	;===============================
	; draw the above-credits chrome
	;===============================

credits_draw_bottom:

	lda	#$ff
	sta	COLOR

        ; HLIN Y, V2 AT A
	ldy	#7
	lda	#32
	sta	V2
	lda	#38
	jsr	hlin_double

	lda	#$75
	sta	COLOR

	; hlin_double(PAGE0,0,6,38);

	ldy	#0
	lda	#6
	sta	V2
	lda	#38
	jsr	hlin_double

	; hlin_double(PAGE0,33,40,38);

	ldy	#33
	lda	#40
	sta	V2
	lda	#38
	jsr	hlin_double

	; hlin_double(PAGE0,8,31,36);

	ldy	#8
	lda	#31
	sta	V2
	lda	#36
	jsr	hlin_double

	lda	#$70
	sta	COLOR

	; hlin_double(PAGE0,7,7,36);

	ldy	#7
	lda	#7
	sta	V2
	lda	#36
	jsr	hlin_double

	; hlin_double(PAGE0,32,32,36);
	ldy	#32
	lda	#32
	sta	V2
	lda	#36
	jsr	hlin_double		; make this a jump and tail-call?

	rts

	;============================
	; Draw text mode boilerplate
	;============================
credits_draw_text_background:
	; text wings

	lda	#$20
	sta	COLOR

	; hlin_double(0,7,40)
	ldy	#0
	lda	#7
	sta	V2
	lda	#40
	jsr	hlin_double

	; hlin_double(32,40,40)
	ldy	#32
	lda	#40
	sta	V2
	lda	#40
	jsr	hlin_double

	; hlin_double(0,7,44)
	ldy	#0
	lda	#7
	sta	V2
	lda	#44
	jsr	hlin_double

	; hlin_double(0,7,44)
	ldy	#32
	lda	#40
	sta	V2
	lda	#44
	jsr	hlin_double

	; hlin_double(7,33,48)
	ldy	#7
	lda	#32
	sta	V2
	lda	#46
	jsr	hlin_double

	lda	#11
	sta	CH
	lda	#20
	sta	CV

	lda	#>thankz
	sta	OUTH
	lda	#<thankz
	sta	OUTL

	jsr	move_and_print

	rts

empty:
.asciiz	"                      "

; offset can't be 0 or it confuses the next-credit code
credits:
.byte 7
.asciiz	"FROGGYSUE"
.byte 7
.asciiz	"PIANOMAN08"
.byte 7
.asciiz	"UTOPIA BBS"
.byte 5
.asciiz	"THE 7HORSEMEN"
.byte 2
.asciiz	"WEAVE'S WORLD TALKER"
.byte 6
.asciiz	"STEALTHSUSIE"
.byte 3
.asciiz	"ECE GRAD BOWLING"
.byte 6
.asciiz	"CORNELL GCF"
.byte 1
.asciiz	"ALL MSTIES EVERYWHERE"
.byte 10
.asciiz	"..."

thankz:
.asciiz	"SPECIAL THANKS TO:"

