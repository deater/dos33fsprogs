; VGI Myst

.include "zp.inc"
.include "hardware.inc"


vgi_myst:
	jsr	SETGR
	jsr	HGR
	bit	FULLGR

	jsr	make_tables

	; get pointer to image data

	lda	#<path_data
	sta	VGIL
	lda	#>path_data
	sta	VGIH

;	lda	#<clock_data
;	sta	VGIL
;	lda	#>clock_data
;	sta	VGIH

	jsr	play_vgi

	jsr	wait_until_keypress

	bit	TEXTGR

	jsr	CROUT1		; print linefeed/cr

loopy:
	lda	#<string1
	sta	OUTL
	lda	#>string1
	sta	OUTH

	jsr	fake_input
	jsr	fake_input
	jsr	fake_input

	; Rocket

	bit	FULLGR

	lda	#<rocket_data
	sta	VGIL
	lda	#>rocket_data
	sta	VGIH

	jsr	play_vgi

	jsr	wait_until_keypress

	bit	TEXTGR

	jsr	CROUT1		; print linefeed/cr

	lda	#<string4
	sta	OUTL
	lda	#>string4
	sta	OUTH

	jsr	fake_input


	; Rocket Door

	bit	FULLGR

	lda	#<rocket_door_data
	sta	VGIL
	lda	#>rocket_door_data
	sta	VGIH

	jsr	play_vgi

	jsr	wait_until_keypress

	bit	TEXTGR

	jsr	CROUT1		; print linefeed/cr

	lda	#<string5
	sta	OUTL
	lda	#>string5
	sta	OUTH

	jsr	fake_input
	jsr	fake_input

	; Red Book

	bit	FULLGR

	lda	#<red_book_data
	sta	VGIL
	lda	#>red_book_data
	sta	VGIH

	jsr	play_vgi

	jsr	wait_until_keypress

	bit	TEXTGR


	jsr	CROUT1		; print linefeed/cr

	lda	#<string7
	sta	OUTL
	lda	#>string7
	sta	OUTH

	jsr	fake_input
	jsr	fake_input
	jsr	fake_input


	;==========================
	; Fireplace

	bit	FULLGR

	lda	#<fireplace_data
	sta	VGIL
	lda	#>fireplace_data
	sta	VGIH

	jsr	play_vgi

	jsr	wait_until_keypress

	bit	TEXTGR


	jsr	CROUT1		; print linefeed/cr

	lda	#<string10
	sta	OUTL
	lda	#>string10
	sta	OUTH

	jsr	fake_input
	jsr	fake_input
	jsr	fake_input



;	jmp	loopy
done:
	jmp	done

.include "vgi_common.s"

.include "clock.data"
.include "rocket.data"
.include "rocket_door.data"
.include "red_book.data"
.include "fireplace.data"
.include "path.data"

; string data
;

string1:
.byte "YOU SEE A CLOCK TOWER READING 12:00",13
.byte "     LEFT/RIGHT/FORWARD",13,0

; SWIM TO TOWER
string2:
.byte "YOU DON'T KNOW HOW TO ",34,"SWIM",34,13,0

; WADE TO TOWER
string3:
.byte "THE KRAKEN WILL EAT YOU",13,0

; I AM WILLING TO TAKE THAT RISK

string4:
.byte "YOU SEE A MYSTERIOUS SPACESHIP",13
.byte "     LEFT/RIGHT/FORWARD",13,0

string5:
.byte "YOU ARE CLOSE TO THE SPACESHIP",13
.byte "YOU SEE A DOOR",13,0

; OPEN DOOR

string6:
.byte "THE DOOR IS LOCKED",13
.byte "ATRUS HATES YOU",13,0

;string7:
;.byte "SORRY, I DON'T UNDERSTAND THAT",0

string7:
.byte "YOU SEE A RED BOOK",13
.byte "NEXT TO IT IS A PAGE",13,0

string8:
.byte "WHICH PAGE?",13,0

string9:
.byte "I'D SAY IT'S MORE OF A PURPLE COLOR",13,0

string10:
.byte "THIS IS A MOST UNUSUAL FIREPLACE",13
.byte "THERE ARE MANY BUTTONS HERE",13,0

string11:
.byte "WHICH BUTTON?",13,0

string12:
.byte "THAT WAS NOT THE RIGHT ONE",13,0

; PICK UP PAGE
; WHICH PAGE?
; THE RED ONE
; I'D SAY IT'S MORE OF A PURPLE COLOR
; JUST PICK IT UP!

; THIS WEIRD FIREPLACE HAS MANY BUTTONS

; PRESS BUTTON

; WHICH ONE?

; REALLY?

; WHICH ONE (0..126)

; NOTHING HAPPENS

	;=========================
	; print_string
	;=========================
print_string:
	ldy	#0

print_string_loop:
	lda	(OUTL),Y
	beq	done_print_string

	ora	#$80
	jsr	COUT

	iny

	jmp	print_string_loop

done_print_string:
	tya		; point to next string
	sec
	adc	OUTL
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH
	rts

	;============================
	; WAIT UNTIL KEYPRESS
	;============================

wait_until_keypress:

	lda	KEYPRESS
	bpl	wait_until_keypress

	bit	KEYRESET

	rts

	;=============================
	; fake input
	;=============================
fake_input:
	jsr	print_string

	jsr	CROUT1		; print linefeed/cr

	lda	#'>'+$80
	jsr	COUT
	lda	#' '+$80
	jsr	COUT

	jsr	GETLN1

	rts
