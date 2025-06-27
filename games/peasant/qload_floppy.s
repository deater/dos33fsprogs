qload_floppy:

	; init the write code
	lda	WHICH_SLOT
	jsr	popwr_init

	; set current disk
	lda	#1
	sta	CURRENT_DISK		; current disk number

	; first time entry
	; start by loading text title

	lda	#LOAD_VID_LOGO		; load videlectrix intro
	sta	WHICH_LOAD

main_game_loop:

	jsr	load_file_internal	; actually load intro

entry_point_smc:
	jsr	$6000			; run intro

	jmp	main_game_loop


	;====================================
	; loads file specified by WHICH_LOAD
	;====================================
load_file_internal:
	ldx	WHICH_LOAD

	lda	which_disk_array,X		; get disk# for file to load

	bmi	load_file_no_diskcheck		; if $FF file is on all disks

	cmp	CURRENT_DISK			; if not currently using
	bne	change_disk			; need to change disk

load_file_no_diskcheck:
	lda	load_address_array,X		; setup address
	sta	load_address
	sta	entry_point_smc+2		; self-modify entry point

	lda	track_array,X			; setup track
	sta	load_track

	lda	sector_array,X			; setup sector
	sta	load_sector

	lda	length_array,X			; setup length
	sta	load_length

	jsr	load_new			; load file

	rts

	;===================================================
	;===================================================
	; change disk
	;===================================================
	;===================================================
	; WHICH_LOAD is still in X?

change_disk:

	; see if disk we want is in drive1
check_drive1:
	lda	which_disk_array,X
	cmp	DRIVE1_DISK
	bne	disk_not_found

;	jsr	switch_drive1		; switch to drive1
;	jmp	update_disk

;check_drive2:
;	cmp	DRIVE2_DISK
;	bne	disk_not_found

;	jsr	switch_drive2		; switch to drive2
;	jmp	update_disk

disk_not_found:

	; check if disk in drive2
	; carry clear if not

;	jsr	check_floppy_in_drive2

;	bcc	nothing_in_drive2

	; a disk is in drive2, try to use it

;	bcs	verify_disk


nothing_in_drive2:

	; switch back to drive1
;	jsr	switch_drive1


	;==============================
	; print "insert disk" message

	; print to current screen

	lda	DRAW_PAGE
	sta	DRAW_PAGE_SAVE
	eor	#$20
	sta	DRAW_PAGE

	lda	#<insert_disk_string
	sta	OUTL
	lda	#>insert_disk_string
	sta	OUTH

	ldx	WHICH_LOAD
	lda	which_disk_array,X
	clc
	adc	#48

	; patch error string to say correct disk to insert

	ldy	#25
	sta	(OUTL),Y

	jsr	hgr_text_box

	; switch back

	lda	DRAW_PAGE_SAVE
	sta	DRAW_PAGE

fnf_keypress:
	lda	KEYPRESS
	bpl	fnf_keypress
	bit	KEYRESET

	;==============================================
	; actually verify proper disk is there
	; read T0:S0 and verify proper disk
verify_disk:
	lda	WHICH_LOAD
	pha

	ldx	#LOAD_FIRST_SECTOR	; load track 0 sector 0
	stx	WHICH_LOAD

	jsr	load_file_no_diskcheck

	pla
	sta	WHICH_LOAD
	tax

	; first sector now in load_buffer+$5B (currently $E85b)
	;	offset 5B
	;		disk1 = $12		; WHY???
	;		disk2 = $32 ('2')
	;		disk3 = $33 ('3')
	;		disk3 = $34 ('4')
	;		disk3 = $35 ('5')

	lda	load_buffer+$5B

	cmp	#$12
	beq	is_disk1
	cmp	#$32
	beq	is_disk2
	cmp	#$33
	beq	is_disk3
	cmp	#$34
	beq	is_disk4
	cmp	#$35
	beq	is_disk5
	bne	change_disk		; unknown disk

is_disk1:
	lda	#1
	bne	disk_compare		; bra

is_disk2:
	lda	#2
	bne	disk_compare		; bra

is_disk3:
	lda	#3
	bne	disk_compare		; bra

is_disk4:
	lda	#4
	bne	disk_compare		; bra

is_disk5:
	lda	#3

disk_compare:
	cmp	which_disk_array,X
	bne	change_disk		; disk mismatch

	;==============================================
	; all good, retry original load
update_disk:

	ldx	WHICH_LOAD
	lda	which_disk_array,X
	sta	CURRENT_DISK

; leftover from 2-drive support?
;	ldx	CURRENT_DRIVE
;	sta	DRIVE1_DISK-1,X		; indexed from 1

	jmp	load_file

; offset for disk number is 25
insert_disk_string:
;.byte   0,43,24, 0,240,74
.byte	 6,24, 33,74
.byte   10,41
.byte "PLEASE INSERT DISK 1",13
.byte " THEN PRESS RETURN",0

do_savegame:
	; spin up disk
	jsr     driveon

	; actually save it

	lda	#12                     ; save is track0 sector 12
	sta	requested_sector+1

	jsr	sector_write

	jsr	driveoff

	rts

