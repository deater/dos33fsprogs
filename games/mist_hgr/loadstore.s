
	;===================================
	;===================================
	; load the game
	;===================================
	;===================================
load_game:

	lda	#<load_message
	sta	OUTL
	lda	#>load_message
	sta	OUTH

	jsr	confirm_slot

	bcs	done_load

	; actually load it
	clc
	adc	#LOAD_SAVE1
	sta	WHICH_LOAD

	jsr	load_file

	; copy to zero page

	ldx	#0
load_loop:
	lda	$e00,X
	sta	WHICH_LOAD,X
	inx
	cpx	#(END_OF_SAVE-WHICH_LOAD+1)
	bne	load_loop

	lda	#$ff
	sta	LEVEL_OVER

done_load:

	bit	SET_GR			; turn graphics back on

	rts

	;===================================
	;===================================
	; save the game
	;===================================
	;===================================

save_game:

	lda	#<save_message
	sta	OUTL
	lda	#>save_message
	sta	OUTH

	jsr	confirm_slot

	bcs	done_save

	pha


	;========================
	; actually save
actually_save:

	;===============================
	; first load something from
	; disk1/track0 to seek the head there

	lda	WHICH_LOAD
	pha

	lda	#LOAD_SAVE1
	sta	WHICH_LOAD
	jsr	load_file

	pla
	sta	WHICH_LOAD

	; copy save data to $d00

	ldx	#0
copy_loop:
	lda	WHICH_LOAD,X
	sta	$d00,X
	inx
	cpx	#(END_OF_SAVE-WHICH_LOAD+1)
	bne	copy_loop

	; spin up disk
	jsr	driveon

	; actually save it
	pla
	clc
	adc	#11
	sta	requested_sector+1

	jsr	sector_write

	jsr	driveoff

done_save:

	jsr	change_location		; restore graphics

	rts






	;================================
	; confirm and get slot number
	;================================
	; call with first message in OUTL/OUTH
	; return: carry set if skipping

confirm_slot:

	bit	KEYRESET	; clear keyboard buffer

	;===============================
	; print "are you sure" message

	bit	SET_TEXT	; set text mode

	lda     #' '|$80
	sta	clear_all_color+1
	jsr	clear_all	; clear screen

	jsr	move_and_print

	lda	#<are_you_sure
	sta	OUTL
	lda	#>are_you_sure
	sta	OUTH
	jsr	move_and_print

;	jsr	page_flip

wait_confirmation:
	lda	KEYPRESS
	bpl	wait_confirmation

	bit	KEYRESET		; clear keypress

	and	#$7f
	cmp	#'Y'
	bne	dont_do_it

	;===============================
	; print "Which one?"

	jsr	clear_all	; clear screen

	lda	#<which_message
	sta	OUTL
	lda	#>which_message
	sta	OUTH
	jsr	move_and_print

;	jsr	page_flip

which_slot:
	lda	KEYPRESS
	bpl	which_slot

	bit	KEYRESET		; clear keypress

	and	#$7f
	sec
	sbc	#'1'

	bmi	dont_do_it
	cmp	#5
	bcs	dont_do_it

	clc
	rts

dont_do_it:
	sec
	rts


which_message:
.byte  9,5,"WHICH SLOT (1-5)?",0

load_message:
.byte  10,5,"LOAD GAME FROM DISK",0

save_message:
.byte  11,5,"SAVE GAME TO DISK",0

are_you_sure:
.byte  10,7,"ARE YOU SURE? (Y/N)",0

;save_filename:
;.byte "SAVE0",0
