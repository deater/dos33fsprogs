; Closing Credits

NUM_CREDITS	EQU 18

	;===================
	; init credits
	;===================

init_credits:
	ldy	#0
	lda	(OUTL),Y	; get the first byte of credit
				; which is the X-coord

	sta	CH		; store HTAB value

	lda	#22		; text Y=22
	sta	CV		; store VTAB value

	lda	#$f0		; -16
	sta	NAMEX		; we're clicking 10 times to get to our char

	rts


	;===========================
	;===========================
	; draw_credits
	;===========================
	;===========================

draw_credits:

credit_loop:

inner_loop:

	jsr	htab_vtab	; put the cursor (BASL/BASH) at CH,CV

	ldy	#1		; skip the x-coord to get to string
print_loop:
	lda	(OUTL),Y	; get the character
	beq	done_print	; if 0 then end of string

	clc
	adc	NAMEX		; subtract the char back

	ora	#$80		; convert ASCII to apple normal text
	sta	(BASL),Y	; store it directly to screen
	iny			; point to next character
	jmp	print_loop	; loop

done_print:

	;==================
	; click
	;==================

	lda	LOOP		; get wait-at-end loop counter
	beq	not_waiting	; if not waiting, skip ahead

	clc			; decrement counter
	adc	#$ff
	sta	LOOP

	bne	done_click	; if not zero, skip ahead

	jsr	next_credit	; was zero, skip to next credit
	jsr	init_credits

	jmp	done_click

not_waiting:
	lda	FRAME_COUNT	; slow down by x128
	and	#$7f
	beq	done_click

	bit	SPEAKER		; click the speaker

	ldx	NAMEX		; get the mutate counter
	inx			; increment
	stx	NAMEX
	cpx	#0		; if not 1, then continue
	bne	done_click

	lda	YY
	cmp	#NUM_CREDITS-1	; wait after NUM_CREDITS-1
	bne	short_loop
long_loop:
	lda	#$ff
	bne	store_loop
short_loop:
	lda	#$40		; set delay to show the credit before
store_loop:
	sta	LOOP		; continuing

done_click:
	rts

	;==================
	; Next credit
	;==================
next_credit:

	lda	#8			; point to text line
	sta	CH
	lda	#22
	sta	CV

	lda	OUTH			; save credits pointer
	pha
	lda	OUTL
	pha

	lda	#>empty			; point to empty string
	sta	OUTH
	lda	#<empty
	sta	OUTL

	jsr	print_both_pages	; clear line on both pages

	pla				; restore credits pointer
	sta	OUTL
	pla
	sta	OUTH

	ldy	#0
skip_credit:				; skip ahead to next credit
	lda	(OUTL),Y

	inc	OUTL
	bne	overflow
	inc	OUTH
overflow:
	cmp	#0
	beq	done_skip
	bne	skip_credit
done_skip:

	ldx	YY			; increment credit pointer
	inx
	stx	YY

	rts


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
	jmp	hlin_double		; tail call, will return for us

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

	jmp	move_and_print		; tail call

empty:
.asciiz	"                      "

; offset can't be 0 or it confuses the next-credit code

; subtract one from centering(?)
credits:
.byte 11		; 17
.asciiz "MUSIC: WAVE BY EA"
.byte 11		; 16
.asciiz "LZ4 CODE: QKUMBA"
.byte 11		; 16
.asciiz "FASTMUL: S. JUDD"
.byte 14		; 9
.asciiz	"FROGGYSUE"
.byte 14		; 10
.asciiz	"UTOPIA BBS"
.byte 10		; 18
.asciiz "FORD PERFECT (SIC)"
.byte 14		; 10
.asciiz	"PIANOMAN08"
.byte 12		; 13
.asciiz	"THE 7HORSEMEN"
.byte 9		; 20
;.asciiz "MITHLUIN AND ROOSTER"
.asciiz  "AAAAAAAAAAAAAAAAAAAA"
.byte 13		; 12
;.asciiz "TALON KARRDE"
.asciiz  "AAAAAAAAAAAA"
.byte 9		; 20
;.asciiz	"WEAVE'S WORLD TALKER"
.asciiz	"AAAAAAAAAAAAAAAAAAAA"
.byte 12		; 14
;.asciiz "DAISY AND JUNE"
.asciiz  "AAAAAAAAAAAAAA"
.byte 11		; 17
;.asciiz "TALBOT 0101B CREW"
.asciiz "AAAAAAAAAAAAAAAAA"
.byte 12		; 13
.asciiz	"STEALTH SUSIE"
.byte 11		; 16
;.asciiz "ECE GRAD BOWLING"
.asciiz	 "AAAAAAAAAAAAAAAA"
.byte 13		; 11
.asciiz	"CORNELL GCF"
.byte 8		; 21
.asciiz	"ALL MSTIES EVERYWHERE"
.byte 17		; 3
.asciiz	"..."

thankz:
.asciiz	"SPECIAL THANKS TO:"

