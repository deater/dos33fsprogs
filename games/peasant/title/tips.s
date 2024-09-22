	;************************
	; Tips
	;************************

directions:
	lda	#<(tips_zx02)
	sta	zx_src_l+1
	lda	#>(tips_zx02)
	sta	zx_src_h+1

	lda	#$40

	jsr	zx02_full_decomp

	lda     #<directions_text
	sta	OUTL
	lda	#>directions_text
	sta	OUTH

	ldx	#15
directions_loop:
	txa
	pha

	jsr	hgr_put_string

	pla
	tax
	dex
	bne	directions_loop

	jsr	wait_until_keypress

	rts

; FIXME: should we describe backspace somehow?

directions_text:
	    ;0123456789012345678901234567890123456789
.byte  4,46,"Here's how things work round here:",0
.byte  0,60,"Use ARROWS to move ;,/ also up,down",0
.byte  0,69,"Backspace using DELETE or Control-B",0
.byte  0,78,"Press RETURN to enter commands",0
.byte  0,87,"-Look around by typing stuff like",0
.byte  1,96,"'look tree' or just plain 'look'",0
.byte 0,105,"-Talk to folks, for example 'talk man'",0
.byte 0,114,"-Take items by typing 'get (item)'",0
.byte 0,123,"-Use items by typing 'use (item)' You",0
.byte 1,132,"can also 'give (item)' 'throw (item)'",0
.byte 1,141,"or some other action words",0
.byte 0,150,"-Type 'inv' to see your INVENTORY",0
.byte 0,159,"-Type 'save' to save your game and",0
.byte 1,168,"'load' to load one.",0
.byte 7,180,"press any key to start game",0

;.byte  0,96,"-Talk to folks by typing stuff like",0
;.byte 1,105,"'talk man'",0
