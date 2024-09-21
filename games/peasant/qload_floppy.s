qload_floppy:

	; init the write code
	lda	WHICH_SLOT
	jsr	popwr_init

	; first time entry
	; start by loading text title

	lda	#LOAD_VID_LOGO		; load intro
	sta	WHICH_LOAD

	lda	#1
	sta	CURRENT_DISK		; current disk number

main_game_loop:

	jsr	load_file_internal	; actually load intro

entry_smc:
	jsr	$6000			; run intro

;	lda	#LOAD_TITLE		; next load title
;	sta	WHICH_LOAD


;	jsr	load_file_internal

;	jsr	$6000			; all entry points currently $6000
	jmp	main_game_loop


	;====================================
	; loads file specified by WHICH_LOAD
	;====================================
load_file_internal:
	ldx	WHICH_LOAD

	lda	which_disk_array,X		; get disk# for file to load
	cmp	CURRENT_DISK			; if not currently using
	bne	change_disk			; need to change disk

load_file_no_diskcheck:
	lda	load_address_array,X
	sta	load_address

	lda	track_array,X
	sta	load_track

	lda	sector_array,X
	sta	load_sector

	lda	length_array,X
	sta	load_length

	jsr	load_new

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

	lda	#<insert_disk_string
	sta	OUTL
	lda	#>insert_disk_string
	sta	OUTH

	ldx	WHICH_LOAD
	lda	which_disk_array,X
	clc
	adc	#48

	; patch error string to say correct disk to insert

	ldy	#27
	sta	(OUTL),Y

	jsr	hgr_text_box

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

LOAD_FIRST_SECTOR = 22

	ldx	#LOAD_FIRST_SECTOR	; load track 0 sector 0
	stx	WHICH_LOAD

	jsr	load_file_no_diskcheck

	pla
	sta	WHICH_LOAD
	tax

	; first sector now in $BC00
	;	offset 5B
	;		disk1 = $12
	;		disk2 = $32 ('2')
	;		disk3 = $33 ('3')

	lda	$BC5B
	cmp	#$12
	beq	is_disk1
	cmp	#$32
	beq	is_disk2
	cmp	#$33
	beq	is_disk3
	bne	change_disk		; unknown disk

is_disk1:
	lda	#1
	bne	disk_compare		; bra

is_disk2:
	lda	#2
	bne	disk_compare		; bra

is_disk3:
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

	ldx	CURRENT_DRIVE
	sta	DRIVE1_DISK-1,X		; indexed from 1

	jmp	load_file

; offset for disk number is 27
insert_disk_string:
.byte   0,43,24, 0,240,74
.byte   10,41
.byte "PLEASE INSERT DISK 1",13
.byte " THEN PRESS RETURN",0


