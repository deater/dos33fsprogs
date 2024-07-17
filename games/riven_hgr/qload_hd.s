qload_hd:

	; init the write code if needed
	; ???

	; first time entry

	lda	#1
	sta	NEW_GAME

	; load the QLOAD offsets file to $1200

	jsr	load_qload_offsets

	lda	QLOAD_DISK		; get disk number (BCD)
	sta	CURRENT_DISK

	lda	#0			; load title, always 0th
	sta	WHICH_LOAD

main_game_loop:
	jsr	load_file

entry_smc:
	jsr	$4000			; most entry points currently $4000

	; CHECK LEVEL_OVER
	;	if high bit set, jump to change_disk

	lda	LEVEL_OVER
	bmi	change_disk

	jmp	main_game_loop


	;====================================
	; loads file specified by WHICH_LOAD
	;====================================
load_file:
	ldx	WHICH_LOAD

	lda	LOAD_ADDRESS_ARRAY,X
	sta	load_address
	sta	entry_smc+2

	lda	TRACK_ARRAY,X
	sta	load_track

	lda	SECTOR_ARRAY,X
	sta	load_sector

	lda	LENGTH_ARRAY,X
	sta	load_length

	jsr	load_new

	rts

	;===================================================
	;===================================================
	; change disk
	;===================================================
	;===================================================
	; LEVEL_OVER bottom 4 bits hold which exit

change_disk:

	lda	LEVEL_OVER
	and	#$f
	sta	LEVEL_OVER
	tax

	; set up locations
	lda	DISK_EXIT_DISK,X
	sta	NEW_DISK

	lda	DISK_EXIT_LOAD,X
	sta	WHICH_LOAD
	lda	DISK_EXIT_LEVEL,X
	sta	LOCATION
	lda	DISK_EXIT_DIRECTION,X
	sta	DIRECTION

	lda	DISK_EXIT_DNI_H,X
	sta	NUMBER_HIGH
	lda	DISK_EXIT_DNI_L,X
	sta	NUMBER_LOW


	; see if disk we want is in drive

	;==============================
	; print "insert disk" message

	; TODO: switch to GR and print D'NI number too

	jsr	GR
	jsr	HOME

	bit	LORES

	lda	#<insert_disk_string
	sta	OUTL
	lda	#>insert_disk_string
	sta	OUTH

	; patch error string to say correct disk to insert

	ldy	#21

	lda	NEW_DISK
	lsr
	lsr
	lsr
	lsr
	clc
	adc	#$30
	sta	(OUTL),Y

	iny

	lda	NEW_DISK
	and	#$f
	clc
	adc	#$30
	sta	(OUTL),Y

	jsr	move_and_print
	jsr	move_and_print

	lda	#4
	sta	XPOS
	lda	#5
	sta	YPOS

	jsr	draw_full_dni_number


fnf_keypress:
	lda	KEYPRESS
	bpl	fnf_keypress
	bit	KEYRESET


	;==========================
	; load QLOAD table
	;	check if disk matches
verify_disk:

	jsr	load_qload_offsets

	lda	QLOAD_TABLE
	cmp	NEW_DISK
	bne	fnf_keypress



	;==============================================
	; all good, continue
update_disk:

	jmp	main_game_loop


insert_disk_string:
.byte 9,20,"PLEASE INSERT DISK 01.",0	; 21+22 location of disk number
.byte 11,21,"THEN PRESS ANY KEY",0


load_qload_offsets:
	lda	#$12
	sta	load_address

	lda	#$0
	sta	load_track

	lda	#$01		; track 0 sector 1
	sta	load_sector

	lda	#$1
	sta	load_length

	jmp	load_new




