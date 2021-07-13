

end_level:

	; set WHICH_LOAD first

	bit	TEXTGR
	jsr	clear_bottom

	lda     #<loading_message
	sta	OUTL
	lda	#>loading_message
	sta	OUTH

	jsr	move_and_print

	; exit back to loader

	rts

loading_message:
.byte  0,20,"LOADING...",0
