
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
.byte  0,60,"-Look around by typing stuff like",0
.byte  1,69,"'look tree' or just plain 'look'",0
.byte  0,78,"-Talk to folks by typing stuff like",0
.byte  1,87,"'talk man'",0
.byte  0,96,"-Take items by typing 'get (item)'",0
.byte 0,105,"-Use items by typing 'use (item)' You",0
.byte 1,114,"can also 'give (item)' 'throw (item)'",0
.byte 1,123,"or some other action words",0
.byte 0,132,"-Type 'inv' to see your INVENTORY",0
.byte 0,141,"-Type 'save' to save your game and",0
.byte 1,150,"'load' to load one.",0
.byte 0,159,"-press + and - to speed up or slow down",0
.byte 1,168,"your character",0
.byte 7,180,"click anywheres to start game",0
