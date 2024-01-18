	; On Apple IIgs the interrupt handler clears the
	; Language Card settings

	; If you have your player in the Language card area ($D000-$FFFF)
	; You will need to have this code elsewhere, and jump through
	; this to the actual handler

gs_interrupt_handler:
	; swap back in language card

	; read/write RAM, use $d000 bank1
	bit	$C083
	bit	$C083

	jmp	interrupt_handler
