; Loader for ootw

.include "../zp.inc"
.include "../hardware.inc"

.include "common_defines.inc"
.include "qboot.inc"

qload_start:

	; first time entry
	; start by loading text title

	jsr	title			; display title / get which to load

	; get the current disk we're on

	lda	$8A5			; from boot sector
	sta	CURRENT_DISK		; current disk number


main_game_loop:
	jsr	load_file

	; always enter at $1800

	jsr	$1800
	jmp	main_game_loop

	;====================================
	; loads file specified by WHICH_LOAD
	;====================================
load_file:
	ldx	WHICH_LOAD

	lda	which_disk_array,X
	cmp	CURRENT_DISK
	bne	change_disk

load_file_no_diskcheck:
	lda	load_address_array,X
	sta	load_address

	lda	track_array,X
	sta	load_track

	lda	sector_array,X
	sta	load_sector

	lda	length_array,X
	sta	load_length

	jsr	load_new		; FIXME: tail call

	rts

	;===================================================
	;===================================================
	; change disk
	;===================================================
	;===================================================

change_disk:

	; turn off disk drive light

	jsr	driveoff

	jsr	TEXT
	jsr	HOME

	lda	#<error_string
	sta	OUTL
	lda	#>error_string
	sta	OUTH

	ldx	WHICH_LOAD
	lda	which_disk_array,X
	clc
	adc	#48

	ldy	#19
	sta	(OUTL),Y

	ldy	#0

quick_print:
	lda	(OUTL),Y
	beq	quick_print_done
	jsr	COUT1
	iny
	jmp	quick_print

quick_print_done:

fnf_keypress:
	lda	KEYPRESS
	bpl	fnf_keypress
	bit	KEYRESET

	;==============================================
	; actually verify proper disk is there
	; read T0:S0 and verify proper disk

	lda	WHICH_LOAD
	pha

	ldx	#LOAD_FIRST_SECTOR	; load track 0 sector 0
	stx	WHICH_LOAD

	jsr	load_file_no_diskcheck

	pla
	sta	WHICH_LOAD
	tax

	; first sector now in $c00
	;		disk1 = $01
	;		disk2 = $02
	;		disk3 = $03

	lda	$ca5
	cmp	#$01
	beq	is_disk1
	cmp	#$02
	beq	is_disk2
	cmp	#$03
	beq	is_disk3
	bne	change_disk		; unknown disk

is_disk1:
	lda	#1
	bne	disk_compare

is_disk2:
	lda	#2
	bne	disk_compare

is_disk3:
	lda	#3

disk_compare:
	cmp	which_disk_array,X
	bne	change_disk		; disk mismatch

	;==============================================
	; all good, retry original load

	jsr	HOME

	ldx	WHICH_LOAD
	lda	which_disk_array,X
	sta	CURRENT_DISK

	jmp	load_file

; offset for disk number is 19
error_string:
.byte "PLEASE INSERT DISK 1, PRESS RETURN",0


which_disk_array:
	.byte 1,1,1,1		; INTRO,C1,C2,C3
	.byte 1,1,2,2		; C4,C5,C6,C7
	.byte 2,2,2,3		; C8,C9,C10,C11
	.byte 3,3,3,3		; C12,C13,C14,C15
	.byte 3			; ENDING
	.byte $f,$f		; TITLE,FIRST_SECTOR

load_address_array:
        .byte $18,$18,$18,$18	; INTRO,C1,C2,C3
	.byte $18,$18,$18,$18	; C4,C5,C6,C7
	.byte $18,$18,$18,$18	; C8,C9,C10,C11
	.byte $18,$18,$18,$18	; C12,C13,C14,C15
	.byte $18		; ENDING
	.byte $18,$0C		; TITLE,FIRST_SECTOR

track_array:
        .byte  2,11,17,25	; INTRO,C1,C2,C3
	.byte 26,30, 2, 5	; C4,C5,C6,C7
	.byte  8,11,14, 2	; C8,C9,C10,C11
	.byte  5, 8,11,17	; C12,C13,C14,C15
	.byte 24		; ENDING
	.byte 99,0		; TITLE,FIRST_SECTOR


sector_array:
        .byte  0, 0, 0, 0	; INTRO,C1,C2,C3
	.byte  0, 0, 0, 0	; C4,C5,C6,C7
	.byte  0, 0, 0, 0	; C8,C9,C10,C11
	.byte  0, 0, 0, 0	; C12,C13,C14,C15
	.byte  0		; ENDING
	.byte  0, 0		; TITLE,FIRST_SECTOR


length_array:
        .byte 137, 95,125, 14	; INTRO,C1,C2,C3
	.byte  62, 41, 38, 38	; C4,C5,C6,C7
	.byte  39, 38, 38, 38	; C8,C9,C10,C11
	.byte  38, 39, 86, 97	; C12,C13,C14,C15
	.byte  90		; ENDING
	.byte   1,  1		; TITLE,FIRST_SECTOR



	; include common libraries...


.include "title.s"

qload_end:

.assert (>qload_end - >qload_start) < $e , error, "loader too big"
