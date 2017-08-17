
flying_start:

	jsr     set_gr_page0

flying_loop:
	jsr	gr_copy_to_current

	jsr	put_sprite

	jsr	wait_until_keypressed

	lda	LASTKEY

	cmp	#('Q')
	bne	skipskip
	rts
skipskip:

	cmp	#('I')
	bne	check_down
	dec	YPOS
	dec	YPOS

check_down:
	cmp	#('M')
	bne	check_left
	inc	YPOS
	inc	YPOS

check_left:
	cmp	#('J')
	bne	check_right
	dec	XPOS

check_right:
	cmp	#('K')
	bne	check_done
	inc	XPOS

check_done:
	jmp	flying_loop



