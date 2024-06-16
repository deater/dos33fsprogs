; Loader for Riven

.include "zp.inc"

.include "hardware.inc"

.include "common_defines.inc"

.include "qboot.inc"

.if DISK=39
.include "disk39_files/disk39_defines.inc"
.endif
.if DISK=40
.include "disk40_files/disk40_defines.inc"
.endif

LOAD_FIRST_SECTOR = 22 ; ???

tmpsec = $3C
;WHICH_LOAD=$80
;WHICH_SLOT=$DA
;CURRENT_DISK=$DC
;OUTL = $FE
;OUTH = $FF


qload_start:



	; 0..$10?
	; 0  1  2  3  4  5  6  7  8  9   a b  c  d  e  f  10
	; AA AA AA AA AA 07 05 40 20 01 01 01 00 0A 00 AA AA
	; 00 C6 00 00 ff 07 05 40 20 00 01 01 00 0a 00 00 AA


	; $300
	;	80+OK,	40 bad, 60 bad, 70 good, 68=bad

	;        0  1  2  3  4  5  6  7  8  9  A  B  C  D
	; $360 = DC E0 00 E4 E8 EC F0 F4 00 00 00 00   = bad
	; $360 = dc e0 00 e4 e8 ec f0 f4 f8 fc 00 00 00 01 00 00 02 03 = good
	; boot = ff ff 00 00 ff ff 00 00 ff ff 00 00 00 01 00 00 02 03

	; preshift table is $300 - $369

	; $36C to $3D5 is used as decode table by disk II drive

.if 0
	ldy	WHICH_SLOT		; temporarily save
	lda	#$AA
	ldx	#$2
zp_clear_loop:
	sta	$00,X
	inx
	bne	zp_clear_loop
	sty	WHICH_SLOT
.endif

	; init the write code
	lda	WHICH_SLOT
;	jsr	popwr_init

	; first time entry
	; start by loading text title

	lda	#LOAD_TITLE		; load title
	sta	WHICH_LOAD

	lda	#1
	sta	CURRENT_DISK		; current disk number
	sta	DRIVE1_DISK		; it's in drive1
	sta	CURRENT_DRIVE		; and currently using drive 1

	lda	#$FF
	sta	DRIVE1_TRACK
	sta	DRIVE2_TRACK

;	jsr	load_file		; actually load intro

;	jsr	$1000			; run intro

;	lda	#LOAD_TITLE		; next load title
;	sta	WHICH_LOAD

main_game_loop:
	jsr	load_file

	jsr	$4000			; all entry points currently $4000
	jmp	main_game_loop


	;====================================
	; loads file specified by WHICH_LOAD
	;====================================
load_file:
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
	bne	check_drive2

;	jsr	switch_drive1		; switch to drive1
	jmp	update_disk

check_drive2:
	cmp	DRIVE2_DISK
	bne	disk_not_found

;	jsr	switch_drive2		; switch to drive2
	jmp	update_disk

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

;	jsr	hgr_text_box

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

; common includes used by everyone

.include "zx02_optim.s"
.include "wait.s"
.include "draw_pointer.s"
.include "log_table.s"
.include "graphics_sprites/pointer_sprites.inc"
.include "hgr_14x14_sprite.s"
.include "keyboard.s"

.if DISK=39
.include "disk39_files/disk39_qload.inc"
.endif

.if DISK=40
.include "disk40_files/disk40_qload.inc"
.endif

qload_end:

.assert (>qload_end - >qload_start) < $8 , error, "loader too big"
