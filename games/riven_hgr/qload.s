; Loader for Riven

; Based on QLOAD by qkumba which loads raw tracks off of disks

; This particular version only supports using a single disk drive
;	(I have other versions that can look for disks across two drives)

.include "zp.inc"

.include "hardware.inc"

.include "common_defines.inc"

.include "qboot.inc"

.if DISK=01
.include "disk01_files/disk01_defines.inc"
.endif
.if DISK=39
.include "disk39_files/disk39_defines.inc"
.endif
.if DISK=40
.include "disk40_files/disk40_defines.inc"
.endif
.if DISK=43
.include "disk43_files/disk43_defines.inc"
.endif


qload_start:
	; preshift table is $300 - $369
	; $36C to $3D5 is used as decode table by disk II drive

	; init the write code if needed
	lda	WHICH_SLOT
;	jsr	popwr_init

	; first time entry
	; start by loading the title screen
	; also set value indicating this is a warm boot, not disk change

	lda	#1
	sta	NEW_GAME

	lda	#LOAD_TITLE		; load title
	sta	WHICH_LOAD

	lda	#1
	sta	CURRENT_DRIVE		; not needed for single drive code?

	lda	#$FF
	sta	DRIVE1_TRACK		; not needed for single drive code?
					; need to modify qboot in that case


main_game_loop:
	jsr	load_file

	jsr	$4000			; all entry points currently $4000

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
	; LEVEL_OVER bottom 4 bits hold which exit

change_disk:

	lda	LEVEL_OVER
	and	#$f
	sta	LEVEL_OVER
	tax

	; set up locations

	lda	disk_exit_load,X
	sta	WHICH_LOAD
	lda	disk_exit_level,X
	sta	LOCATION
	lda	disk_exit_direction,X
	sta	DIRECTION

	; see if disk we want is in drive

	; TODO: load TITLE
	;	check disk number
	;	if no match, wait again
	;	if escape pressed, go back somehow?

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

	lda	disk_exit_disk,X
	lsr
	lsr
	lsr
	lsr
	clc
	adc	#$30
	sta	(OUTL),Y

	iny

	lda	disk_exit_disk,X
	and	#$f
	clc
	adc	#$30
	sta	(OUTL),Y

	jsr	move_and_print
	jsr	move_and_print

fnf_keypress:
	lda	KEYPRESS
	bpl	fnf_keypress
	bit	KEYRESET

	;==============================================
	; actually verify proper disk is there
	; read T0:S0 and verify proper disk
verify_disk:
.if 0
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
.endif
	;==============================================
	; all good, retry original load
update_disk:

;	ldx	WHICH_LOAD
;	lda	disk_edit_disk,X
;	sta	CURRENT_DISK

;	ldx	CURRENT_DRIVE
;	sta	DRIVE1_DISK-1,X		; indexed from 1

	jmp	load_file


insert_disk_string:
.byte 9,20,"PLEASE INSERT DISK 01.",0	; 21+22 location of disk number
.byte 11,21,"THEN PRESS ANY KEY",0

; common includes used by everyone

.include "zx02_optim.s"
.include "wait.s"
.include "draw_pointer.s"
.include "log_table.s"
.include "graphics_sprites/pointer_sprites.inc"
.include "hgr_14x14_sprite.s"
.include "keyboard.s"
.include "text_print.s"
.include "gr_offsets.s"


.if DISK=01
.include "disk01_files/disk01_qload.inc"
.endif

.if DISK=39
.include "disk39_files/disk39_qload.inc"
.endif

.if DISK=40
.include "disk40_files/disk40_qload.inc"
.endif

.if DISK=43
.include "disk43_files/disk43_qload.inc"
.endif

qload_end:

.assert (>qload_end - >qload_start) < $8 , error, "loader too big"
