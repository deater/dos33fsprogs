
gs_interrupt_handler:
	; swap back in language card

	; read/write RAM, use $d000 bank1
	bit	LCBANK1
	bit	LCBANK1

	jmp	interrupt_handler
