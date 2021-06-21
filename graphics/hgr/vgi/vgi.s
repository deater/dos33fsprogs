; VGI

.include "zp.inc"
.include "hardware.inc"

VGI_MAXLEN	=	7

vgi_test:
	jsr	SETGR
	jsr	HGR
	bit	FULLGR

	jsr	make_tables

	; get pointer to image data

	lda	#<rocket_data
	sta	VGIL
	lda	#>rocket_data
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

	bit	FULLGR


	lda	#<rocket_data
	sta	VGIL
	lda	#>rocket_data
	sta	VGIH

	jsr	play_vgi

	jsr	wait_until_keypress

	bit	TEXTGR


;	jmp	loopy
done:
	jmp	done


	;==================================
	; play_vgi
	;==================================
play_vgi:

vgi_loop:

	ldy	#0
data_smc:
	lda	(VGIL),Y
	sta	VGI_BUFFER,Y
	iny
	cpy	#VGI_MAXLEN
	bne	data_smc

	lda	TYPE
	and	#$f

	clc
	adc	VGIL
	sta	VGIL
	bcc	no_oflo
	inc	VGIH
no_oflo:

	lda	TYPE
	lsr
	lsr
	lsr
	lsr

	; look up action in jump table
	asl
	tax
	lda	vgi_rts_table+1,X
	pha
	lda	vgi_rts_table,X
	pha
	rts				; "jump" to subroutine

vgi_rts_table:
	.word vgi_clearscreen-1		; 0 = clearscreen
	.word vgi_simple_rectangle-1	; 1 = simple rectangle
	.word vgi_circle-1		; 2 = plain circle
	.word vgi_filled_circle-1	; 3 = filled circle
	.word vgi_point-1		; 4 = dot
	.word vgi_lineto-1		; 5 = line to
	.word vgi_dithered_rectangle-1	; 6 = dithered rectangle
	.word vgi_vertical_triangle-1	; 7 = vertical triangle
	.word vgi_horizontal_triangle-1	; 8 = horizontal triangle
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1		; 15 = done

all_done:
	rts


.include "vgi_clearscreen.s"
.include "vgi_circles.s"
.include "vgi_rectangle.s"
.include "vgi_lines.s"
.include "vgi_triangles.s"

.include "clock.data"
.include "rocket.data"



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
.byte "THERE IS A METTALIC DOOR BLOCKING YOU",0

; OPEN DOOR

string6:
.byte "THE DOOR IS LOCKED.  ATRUS HATES YOU",0

string7:
.byte "SORRY, I DON'T UNDERSTAND THAT",0


; PICK UP PAGE
; WHICH PAGE?
; THE RED ONE
; I'D SAY IT'S MORE OF A PURPLE COLOR
; JUST PICK IT UP!

; THIS WEIRD FIREPLACE HAS MANY BUTTONS

; PRESS BUTTON

; WHICH ONE?

; REALLY?


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
