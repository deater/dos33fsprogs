; Loader for Riven

; Based on QLOAD by qkumba which loads raw tracks off of disks

; This particular version only supports using a single disk drive
;	(I have other versions that can look for disks across two drives)

; it also loads the QLOAD paramaters from disk separately

QLOAD_TABLE = $1200
QLOAD_DISK	= $1200
LOAD_ADDRESS_ARRAY = QLOAD_TABLE+1
TRACK_ARRAY	= QLOAD_TABLE+9
SECTOR_ARRAY	= QLOAD_TABLE+17
LENGTH_ARRAY	= QLOAD_TABLE+25
DISK_EXIT_DISK	= QLOAD_TABLE+33
DISK_EXIT_DNI_H = QLOAD_TABLE+37
DISK_EXIT_DNI_L = QLOAD_TABLE+41
DISK_EXIT_LOAD	= QLOAD_TABLE+45
DISK_EXIT_LEVEL = QLOAD_TABLE+49
DISK_EXIT_DIRECTION = QLOAD_TABLE+53


.include "zp.inc"

.include "hardware.inc"

.include "common_defines.inc"

.include "qboot.inc"


qload_start:
	; preshift table is $300 - $369
	; $36C to $3D5 is used as decode table by disk II drive

	; init the write code if needed
;	lda	WHICH_SLOT
;	jsr	popwr_init

	; first time entry

	lda	#1
	sta	NEW_GAME

	; load the QLOAD offsets file to $1200

	jsr	load_qload_offsets

	lda	QLOAD_DISK		; get disk number (BCD)
	sta	CURRENT_DISK

	lda	#0			; load title, always 0th
	sta	WHICH_LOAD

;	lda	#1
;	sta	CURRENT_DRIVE		; not needed for single drive code?

;	lda	#$FF
;	sta	DRIVE1_TRACK		; not needed for single drive code?
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


	lda	LOAD_ADDRESS_ARRAY,X
	sta	load_address

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

	lda	#$8
	sta	load_sector

	lda	#$1
	sta	load_length

	jmp	load_new


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

.include "print_dni_numbers.s"
.include "number_sprites.inc"

qload_end:

.assert (>qload_end - >qload_start) < $9 , error, "loader too big"
