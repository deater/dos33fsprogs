	;=================================
	; action_stars
	;=================================
	; and take 4504 cycles to do it

	; we take 4501, so waste 3
action_stars:

	jsr	draw_stars			; 6+4492 = 4498

	ldy	FRAME	;nop			; 3

	jmp	check_keyboard			; 3

