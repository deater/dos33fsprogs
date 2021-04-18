	;======================
	; scroll credits
	;======================

end_credits:

	lda	KEYRESET
	bit	SET_TEXT		; switch to text mode

	; 0@24
	; 0@23,1@24
	; 0@22,1@23,2@24...
	; 0@0...


	; clear to space

	lda	#$a0
	sta	clear_all_color+1


	; X is starting YPOS to print at

	ldx	#46

scroll_loop:
;	jsr	HOME

	jsr	clear_all	; trashes A,Y

	ldy	#0
	stx	XPOS		; X is YPOS to print at
print_loop:

	lda	credit_list,Y
	sta	OUTL
	lda	credit_list+1,Y
	sta	OUTH

	tya
	pha

	ldy	XPOS			; YPOS on screen

	;============================
	; set BASL/BASH to offset w Y

	lda	gr_offsets,Y
	sta	BASL
	lda	gr_offsets+1,Y
	clc
	adc	DRAW_PAGE
	sta	BASH

	;============================
	; print the string
	jsr	print_string

	pla
	tay

	iny			; move to next line
	iny

	inc	XPOS
	inc	XPOS
	lda	XPOS

	cmp	#48		; if off screen, don't print
	bne	print_loop

	;====================
	; done printing

	jsr	page_flip	; flip to page

	;====================
	; delay a bit

	txa
	pha
	ldx	#40		; time to sleep (X*10ms)
	jsr	long_wait	; trashes A,X
	pla
	tax

	;===================
	; scroll

	dex
	dex
	bpl	scroll_loop

	;============================================
	; actual games pauses 10s, then scrolls again
	;============================================
	; delay 6s?

	ldx	#200
	jsr	long_wait

	ldx	#200
	jsr	long_wait

	ldx	#200
	jsr	long_wait

	jsr	HOME
	bit	KEYRESET

	;======================
	; print end message
	;======================

	lda	#0
	sta	DRAW_PAGE

	lda	#<end_message
	sta	OUTL
	lda	#>end_message
	sta	OUTH

	jsr	move_and_print

	rts


; 0123456789012345678901234567890123456789
;        DESIGNED BY ..... ERIC CHAHI
;
;        ARTWORK ......... ERIC CHAHI
;
; MUSIC BY ........ JEAN-FRANCOIS FREITAS
;
;              SOUND EFFECTS
;          JEAN-FRANCOIS FREITAS
;               ERIC CHAHI
;
;              APPLE II PORT
;              VINCE WEAVER
;
;             APPLE ][ FOREVER

credits0:.byte "",0
credits1:.byte "        DESIGNED BY ..... ERIC CHAHI",0
credits2:.byte "",0
credits3:.byte "        ARTWORK ......... ERIC CHAHI",0
credits4:.byte "",0
credits5:.byte " MUSIC BY ........ JEAN-FRANCOIS FREITAS",0
credits6:.byte "",0
credits7:.byte "              SOUND EFFECTS",0
credits8:.byte "          JEAN-FRANCOIS FREITAS",0
credits9:.byte "               ERIC CHAHI",0
credits10:.byte "",0
credits11:.byte "             APPLE II+ PORT",0
credits12:.byte "              VINCE WEAVER",0
credits13:.byte "",0
credits14:.byte "            APPLE ][ FOREVER",0

credit_list:
	.word credits0	; 0
	.word credits0	; 1
	.word credits0	; 2
	.word credits1	; 3
	.word credits2	; 4
	.word credits3	; 5
	.word credits4	; 6
	.word credits5	; 7
	.word credits6	; 8
	.word credits0	; 9
	.word credits7	; 10
	.word credits8	; 11
	.word credits9	; 12
	.word credits10	; 13
	.word credits11	; 14
	.word credits12	; 16
	.word credits0	; 15
	.word credits0	; 18
	.word credits13	; 17
	.word credits14 ; 19
	.word credits0	; 20
	.word credits0	; 21
	.word credits0	; 22

end_message:
.byte 6,10,"NOW GO BACK TO ANOTHER EARTH",0



