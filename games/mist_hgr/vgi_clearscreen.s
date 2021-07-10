
vgi_clearscreen:

	lda	P0
	jsr	BKGND0

	jmp	vgi_loop		; return
