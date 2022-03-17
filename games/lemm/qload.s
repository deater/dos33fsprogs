; Loader for MIST

.include "zp.inc"
.include "hardware.inc"

;.include "common_defines.inc"
.include "qboot.inc"

LOAD_TEXT_TITLE = 0

qload_start:

	; init the write code
;	lda	WHICH_SLOT
;	jsr	popwr_init

	; first time entry
	; start by loading text title

	lda	#LOAD_TEXT_TITLE	; load title
	sta	WHICH_LOAD

	lda	#1
	sta	CURRENT_DISK		; current disk number

	jsr	load_file

	jsr	$6000
.if 0
	lda	#LOAD_TITLE		; load title
	sta	WHICH_LOAD

main_game_loop:
	jsr	load_file

	lda	WHICH_LOAD
	bne	not_title

start_title:
	jsr	$4000
	jmp	main_game_loop

not_title:
	jsr	$2000
	jmp	main_game_loop
.endif

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

	jsr	load_new

	rts

	;===================================================
	;===================================================
	; change disk
	;===================================================
	;===================================================

change_disk:
.if 0
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
	;	offset 59
	;		disk1 = $0a
	;		disk2 = $32 ('2')
	;		disk3 = $33 ('3')

	lda	$c59
	cmp	#$0a
	beq	is_disk1
	cmp	#$32
	beq	is_disk2
	cmp	#$33
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

.endif

which_disk_array:
	.byte 1,1,3,3		; LEMM
	.byte 1,1,3,2		;
	.byte 2,1,2,2		;
	.byte 1,1,1,3		;
	.byte 1			;
	.byte 1,1,1,1,1		;
	.byte $f		;

load_address_array:
        .byte $60,$20,$20,$20	; LEMM
	.byte $20,$20,$20,$20	;
	.byte $20,$20,$20,$20	;
	.byte $20,$20,$20,$20	;
	.byte $08		;
	.byte $0E,$0E,$0E,$0E	;
	.byte $0E		;
	.byte $0C		;

track_array:
        .byte  3, 8, 1,21	; LEMM
	.byte 18,31,11, 1	;
	.byte 27,26,10,20	;
	.byte 30,32,28,30	;
	.byte  0		;
	.byte  0, 0, 0, 0, 0	;
	.byte  0		;

sector_array:
        .byte  0, 0, 0, 0	; LEMM
	.byte  0, 8, 0, 0	;
	.byte  0, 0, 0, 0	;
	.byte  0,13, 0, 1	;
	.byte  6		;
	.byte 11,12,13,14,15	;
	.byte  0		;

length_array:
        .byte  96,159,157,145	; LEMM
	.byte 128, 20,158,135	;
	.byte  61, 31,159,109	;
	.byte  20, 33, 27, 78	;
	.byte   3		;
	.byte   1,1,1,1,1	;
	.byte   1		;

	.include	"audio.s"
	.include	"decompress_fast_v2.s"
	.include	"gr_offsets.s"


qload_end:

.assert (>qload_end - >qload_start) < $e , error, "loader too big"
