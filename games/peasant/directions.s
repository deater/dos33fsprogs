
	;************************
	; Tips
	;************************
directions:
	lda	#<(tips_lzsa)
	sta	getsrc_smc+1
	lda	#>(tips_lzsa)
	sta	getsrc_smc+2

	lda	#$40

	jsr	decompress_lzsa2_fast

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

directions_text:
	    ;0123456789012345678901234567890123456789
.byte  4,46,"Here's how things work round here:",0
.byte  0,60,"Use ARROWS or W,A,S,D to move",0
.byte  0,69,"Press RETURN to enter commands",0
.byte  0,78,"-Look around by typing stuff like",0
.byte  1,87,"'look tree' or just plain 'look'",0
.byte  0,96,"-Talk to folks by typing stuff like",0
.byte 1,105,"'talk man'",0
.byte 0,114,"-Take items by typing 'get (item)'",0
.byte 0,123,"-Use items by typing 'use (item)' You",0
.byte 1,132,"can also 'give (item)' 'throw (item)'",0
.byte 1,141,"or some other action words",0
.byte 0,150,"-Type 'inv' to see your INVENTORY",0
.byte 0,159,"-Type 'save' to save your game and",0
.byte 1,168,"'load' to load one.",0
.byte 7,180,"press any key to start game",0
