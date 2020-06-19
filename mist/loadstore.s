
	;===================================
	;===================================
	; load the game
	;===================================
	;===================================

load_game:
	bit	KEYRESET	; clear keyboard buffer

	bit	SET_TEXT	; set text mode

	jsr	clear_all	; clear screen

	lda	#<load_message
	sta	OUTL
	lda	#>load_message
	sta	OUTH
	jsr	move_and_print

	lda	#<are_you_sure
	sta	OUTL
	lda	#>are_you_sure
	sta	OUTH
	jsr	move_and_print

	jsr	page_flip

wait_load_confirmation:
	lda	KEYPRESS
	bpl	wait_load_confirmation

	bit	KEYRESET		; clear keypress

	bit	SET_GR			; turn graphics back on

	rts

	;===================================
	;===================================
	; save the game
	;===================================
	;===================================

save_game:
	bit	KEYRESET	; clear keyboard buffer

	bit	SET_TEXT	; set text mode

	jsr	clear_all	; clear screen

	lda	#<save_message
	sta	OUTL
	lda	#>save_message
	sta	OUTH
	jsr	move_and_print

	lda	#<are_you_sure
	sta	OUTL
	lda	#>are_you_sure
	sta	OUTH
	jsr	move_and_print

	jsr	page_flip

wait_save_confirmation:
	lda	KEYPRESS
	bpl	wait_save_confirmation

	bit	KEYRESET		; clear keypress

	bit	SET_GR			; turn graphics back on

	rts





load_message:
.byte  10,5,"LOAD GAME FROM DISK",0

save_message:
.byte  11,5,"SAVE GAME TO DISK",0

are_you_sure:
.byte  10,7,"ARE YOU SURE? (Y/N)",0

