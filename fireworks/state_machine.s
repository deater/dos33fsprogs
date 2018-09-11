	;=================================
	; do nothing
	;=================================
	; and take 4533-6 = 4527 cycles to do it
do_nothing:

	; Try X=4 Y=174 cycles=4525 R2

	nop	; 2

	ldy	#174							; 2
loop1:
	ldx	#4							; 2
loop2:
	dex								; 2
	bne	loop2							; 2nt/3

	dey								; 2
	bne	loop1							; 2nt/3


	rts							; 6


	;=================================
	; action_stars
	;=================================
	; and take 4533-6 = 4527 cycles to do it
action_stars:

	jsr	draw_stars			; 6+4492 = 4498
						; 4527 - 4498 = 29

	; Try X=4 Y=1 cycles=27 R2

	nop

	ldy	#1							; 2
bloop1:
	ldx	#4							; 2
bloop2:
	dex								; 2
	bne	bloop2							; 2nt/3

	dey								; 2
	bne	bloop1							; 2nt/3


	rts							; 6
