	;=================================
	; action_stars
	;=================================
	; and take 4504 cycles to do it

	; we take 4501, so waste 3
action_stars:

	jsr	draw_stars			; 6+4492 = 4498

	ldy	FRAME	;nop			; 3

	jmp	fw_check_keyboard		; 3


	;=================================
	; action_launch_firework
	;=================================
	; and take 4504 cycles to do it

	; we take 423 so waste 4081
action_launch_firework:

	; Try X=26 Y=30 cycles=4081

        ldy	#30							; 2
Xloop1:	ldx	#26							; 2
Xloop2:	dex								; 2
	bne	Xloop2							; 2nt/3
	dey								; 2
	bne	Xloop1							; 2nt/3

	jsr	launch_firework			; 6+414 = 420

	jmp	fw_check_keyboard			; 3


	;=================================
	; action_move_rocket
	;=================================
	; and take 4504 cycles to do it

	; we take 1245 so waste 3259
action_move_rocket:

	; Try X=35 Y=18 cycles=3259

        ldy	#18							; 2
Yloop1:	ldx	#35							; 2
Yloop2:	dex								; 2
	bne	Yloop2							; 2nt/3
	dey								; 2
	bne	Yloop1							; 2nt/3

	jsr	move_rocket			; 6+1236 = 1242

	jmp	fw_check_keyboard			; 3


	;=================================
	; action_start_explosion
	;=================================
	; and take 4504 cycles to do it

	; we take 449 so waste 4055
action_start_explosion:

	; Try X=15 Y=50 cycles=4051 R4

	nop
	nop

        ldy	#50							; 2
Zloop1:	ldx	#15							; 2
Zloop2:	dex								; 2
	bne	Zloop2							; 2nt/3
	dey								; 2
	bne	Zloop1							; 2nt/3

	jsr	start_explosion			; 6+440 = 446

	jmp	fw_check_keyboard			; 3

.align $100

	;=================================
	; action_continue_explosion
	;=================================
	; and take 4504 cycles to do it

	; we take 4495 so waste 9
action_continue_explosion:
	lda	STATE	; nop 3
	lda	STATE	; nop 3
	lda	STATE	; nop 3

	jsr	continue_explosion			; 6+4486 = 4492

	jmp	fw_check_keyboard				; 3




	;=================================
	; action_stall_rocket
	;=================================
	; and take 4504 cycles to do it

	; 4504 - 8 = 4496
action_stall_rocket:

	lda	#STATE_MOVE_ROCKET					; 2
	sta	STATE							; 3


	; Try X=12 Y=68 cycles=4489 R7
	nop	;
	nop	;
	lda	STATE	;3

        ldy	#68							; 2
Bloop1:	ldx	#12							; 2
Bloop2:	dex								; 2
	bne	Bloop2							; 2nt/3
	dey								; 2
	bne	Bloop1							; 2nt/3

	jmp	fw_check_keyboard			; 3

