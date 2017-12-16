
	;======================
	; memset
	;======================
	; a=value
	; x=length
	; MEMPTRL/MEMPTRH is address
memset:
	ldy	#0
memset_loop:
	sta	MEMPTRL,Y
	iny
	dex
	bne	memset_loop
	rts

