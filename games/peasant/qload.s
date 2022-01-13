; Loader for Peasant's Quest

.include "zp.inc"

;LOAD_TEXT_TITLE = 16 ; ???
LOAD_FIRST_SECTOR = 22 ; ???

tmpsec = $3C
;WHICH_LOAD=$80
;WHICH_SLOT=$DA
;CURRENT_DISK=$DC
;OUTL = $FE
;OUTH = $FF

.include "hardware.inc"

;.include "common_defines.inc"
.include "qboot.inc"

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
	jsr	popwr_init

	; first time entry
	; start by loading text title

	lda	#LOAD_VID_LOGO		; load intro
	sta	WHICH_LOAD

	lda	#1
	sta	CURRENT_DISK		; current disk number
	sta	DRIVE1_DISK		; it's in drive1
	sta	CURRENT_DRIVE		; and currently using drive 1

	lda	#$ff
	sta	DRIVE1_TRACK
	sta	DRIVE2_TRACK

	jsr	load_file		; actually load intro

	jsr	$6000			; run intro

	lda	#LOAD_TITLE		; next load title
	sta	WHICH_LOAD

	bit	$C054
	bit	$C051

main_game_loop:
	jsr	load_file

	jsr	$6000			; all entry points currently $6000
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

	jsr	switch_drive1		; switch to drive1
	jmp	update_disk

check_drive2:
	cmp	DRIVE2_DISK
	bne	disk_not_found

	jsr	switch_drive2		; switch to drive2
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


which_disk_array:
	.byte 1,1,1,2		; VID_LOGO, TITLE, INTRO. COPY_CHECK
	.byte 1,1,1,1		; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte 2,2,1,2		; TROGDOR, ENDING, MUSIC, CLIFF
	.byte 2,1,1,2		; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte 2,2,2		; INSIDE, ARCHERY, MAP
	.byte 1,1,1		; SAVE1, SAVE2, SAVE3
	.byte $f		; disk detect

load_address_array:
	.byte $60,$60,$60,$60	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte $60,$60,$60,$60	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte $60,$60,$D0,$60	; TROGDOR, ENDING, MUSIC, CLIFF
	.byte $60,$D0,$20,$60	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte $60,$60,$60	; INSIDE, ARCHERY, MAP
	.byte $BC,$BC,$BC	; SAVE1, SAVE2, SAVE3
	.byte $BC		; disk detect

track_array:
        .byte  4, 6, 9,1	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte 15,20,25,30	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte 19,24, 3,29	; TROGDOR, ENDING, MUSIC, CLIFF
	.byte  3,14,13,14	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte  9,6,4		; INSIDE, ARCHERY, MAP
	.byte  0, 0, 0		; SAVE1, SAVE2, SAVE3
	.byte  0		; disk detect

sector_array:
        .byte  0, 0, 0, 0	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte  0, 0, 0, 0	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte  0, 0, 0, 0	; TROGDOR, ENDING, MUSIC, CLIFF
	.byte  0, 0, 0, 0	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte  0, 0, 0		; INSIDE, ARCHERY, MAP
	.byte  11,12,13		; SAVE1, SAVE2, SAVE3
	.byte  0		; disk detect

length_array:
        .byte  32, 50, 60, 20	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte  80, 88, 88, 80	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte  80, 80, 16, 80	; TROGDOR, ENDING, MUSIC, CLIFF
	.byte  16, 16, 18, 80	; GAME_OVER, INVENTORY, PARSE_INPUT, INN
	.byte  80, 64, 16	; INSIDE, ARCHERY, MAP
	.byte   1,1,1		; SAVE1, SAVE2, SAVE3
	.byte   1		; disk detect

.include "qkumba_popwr.s"

.include "drive2.s"

.include "decompress_fast_v2.s"

.include "hgr_font.s"
.include "draw_box.s"
.include "hgr_rectangle.s"
.include "hgr_1x28_sprite_mask.s"
.include "hgr_partial_save.s"
.include "hgr_input.s"
.include "hgr_tables.s"
.include "hgr_text_box.s"
.include "clear_bottom.s"
.include "hgr_hgr2.s"		; this one is maybe only needed once?
.include "gr_offsets.s"
.include "loadsave_menu.s"
.include "wait_keypress.s"
.include "random16.s"
.include "score.s"
.include "speaker_beeps.s"

peasant_text:
	.byte 25,2,"Peasant's Quest",0

qload_end:

;.assert (>qload_end - >qload_start) < $e , error, "loader too big"
.assert (>qload_end - >qload_start) < $15 , error, "loader too big"
