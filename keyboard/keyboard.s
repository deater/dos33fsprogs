; HARDWARE LOCATIONS

KEYPRESS        =       $C000
KEYRESET        =       $C010
KEYSTROBE	=	$C010

; on original Apple II/II+
;	read KEYPRESS
;		if bit 7 set, means key was pressed, value in lower 7 bits
;	access KEYSTROBE to clear value and allow another keypress to happen
; on Apple IIe
;	can read KEYSTROBE.  bit 7 is "any key is down"


; test keyboard

keyboard:

	ldy	#0

keyboard_loop:
	lda	KEYPRESS
	bpl	keyboard_loop

	ora	#$80
	sta	$400,Y
	iny
	bit	KEYRESET

	jmp	keyboard_loop

