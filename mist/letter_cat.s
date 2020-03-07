; Catherine,
; I've left for you a message
; of utmost importance in
; our fore-chamber beside
; the dock.  Enter the number
; of Marker Switches on
; this island into the imager
; to retrieve the message.
;             Yours,
;                 Atrus

letter:
;        01234567890123456789
.byte  9,1,"  CATHERINE,          ",0
.byte  9,3,"  I THINK SOME WEIRD  ",0
.byte  9,5,"  GUY IS OUT ROAMING  ",0
.byte  9,7,"  AROUND OUR ISLAND!  ",0
.byte  9,9,"  MAYBE HE CAN SOLVE  ",0
.byte 9,11,"  ALL OF OUR DEEP     ",0
.byte 9,13,"  FAMILY PROBLEMS     ",0
.byte 9,15,"  WHILE I MESS        ",0
.byte 9,17,"  WITH MY BOOKS.      ",0
.byte 9,19,"         YOURS,       ",0
.byte 9,21,"             ATRUS    ",0

clear_line:
.byte 9,0, "                      ",0

	;================
	; read the letter

read_letter:
;	jsr	TEXT
;	jsr	HOME
	bit	KEYRESET

	bit	SET_TEXT

	jsr	clear_all

	; clear

	ldx	#0
clear_line_loop:
	lda	#<clear_line
	sta	OUTL
	lda	#>clear_line
	sta	OUTH


	stx	clear_line+1
	jsr	move_and_print
	inx
	cpx	#24
	bne	clear_line_loop


	lda	#<letter
	sta	OUTL
	lda	#>letter
	sta	OUTH

	ldx	#0
letter_loop:
	jsr	move_and_print

	inx
	cpx	#12
	bne	letter_loop

	jsr	page_flip

wait_done_letter:
	lda	KEYPRESS
	bpl	wait_done_letter
	bit	KEYRESET

	; turn graphics back on

	bit	SET_GR
;	bit	PAGE0
;	bit	FULLGR

	rts


