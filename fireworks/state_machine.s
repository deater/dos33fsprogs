	;=================================
	; action_stars
	;=================================
	; and take 4504 cycles to do it

	; we take 4501, so waste 3
action_stars:

	jsr	draw_stars			; 6+4492 = 4498

	ldy	FRAME	;nop			; 3

	jmp	check_keyboard			; 3


	;=================================
	; action_launch_firework
	;=================================
	; and take 4504 cycles to do it

	; we take 419 so waste 4085
action_launch_firework:

	; Try X=203 Y=4 cycles=405

        ldy	#4							; 2
Xloop1:	ldx	#203							; 2
Xloop2:	dex								; 2
	bne	Xloop2							; 2nt/3
	dey								; 2
	bne	Xloop1							; 2nt/3

	jsr	launch_firework			; 6+410 = 416

	jmp	check_keyboard			; 3

