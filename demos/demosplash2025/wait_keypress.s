wait_until_keypress:
	bit	KEYRESET						; 4
wait_until_keypress_loop:
	lda	KEYPRESS						; 4
	bpl	wait_until_keypress_loop				; 2/3
	bit	KEYRESET	; clear the keyboard buffer		; 4
	rts								; 6
