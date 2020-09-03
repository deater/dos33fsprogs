; Loader for MIST

.include "zp.inc"
.include "hardware.inc"

.include "common_defines.inc"

qload_start:

	; first time entry
	; start by loading text title

	lda	#LOAD_TEXT_TITLE	; load title
	sta	WHICH_LOAD

	lda	#1
	sta	CURRENT_DISK		; current disk number

	jsr	load_file

	jsr	$800

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



; FIXME: have to keep these in sync

driveoff =$1122
load_new = $119D
load_address=$11C0
load_track=load_address+1
load_sector=load_address+2
load_length=load_address+3


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
	;		disk1 = $d0
	;		disk2 = $32 ('2')
	;		disk3 = $33 ('3')

	lda	$c59
	cmp	#$d0
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


which_disk_array:
	.byte 1,1,3,3		; MIST_TITLE,MIST,MECHE,SELENA
	.byte 1,1,3,2		; OCTAGON,VIEWER,STONEY,CHANNEL
	.byte 2,1,2,2		; CABIN,DENTIST,ARBOR,NIBEL
	.byte 1,1,1,3		; SHIP,GENERATOR,D'NI,SUB
	.byte 1			; TEXT_TITLE
	.byte 1,1,1,1,1		; SAVE1,SAVE2,SAVE3,SAVE4,SAVE5
	.byte $f		; FIRST_SECTOR

load_address_array:
        .byte $40,$20,$20,$20	; MIST_TITLE,MIST,MECHE,SELENA
	.byte $20,$20,$20,$20	; OCTAGON,VIEWER,STONEY,CHANNEL
	.byte $20,$20,$20,$20	; CABIN,DENTIST,ARBOR,NIBEL
	.byte $20,$20,$20,$20	; SHIP,GENERATOR,D'NI,SUB
	.byte $08		; TEXT_TITLE
	.byte $0E,$0E,$0E,$0E
	.byte $0E		; SAVE1,SAVE2,SAVE3,SAVE4,SAVE5
	.byte $0C		; FIRST_SECTOR

track_array:
        .byte  2, 8, 1,11	; MIST_TITLE,MIST,MECHE,SELENA
	.byte 18,31,21, 1	; OCTAGON,VIEWER,STONEY,CHANNEL
	.byte 27,26,10,20	; CABIN,DENTIST,ARBOR,NIBEL
	.byte 30,32,28,31	; SHIP,GENERATOR,D'NI,SUB
	.byte  0		; TEXT_TITLE
	.byte  0, 0, 0, 0, 0	; SAVE1,SAVE2,SAVE3,SAVE4,SAVE5
	.byte  0		; FIRST_SECTOR

sector_array:
        .byte  0, 0, 0, 0	; MIST_TITLE,MIST,MECHE,SELENA
	.byte  0, 8, 0, 0	; OCTAGON,VIEWER,STONEY,CHANNEL
	.byte  0, 0, 0, 0	; CABIN,DENTIST,ARBOR,NIBEL
	.byte  0,12, 0, 0	; SHIP,GENERATOR,D'NI,SUB
	.byte  6		; TEXT_TITLE
	.byte 11,12,13,14,15	; SAVE1,SAVE2,SAVE3,SAVE4,SAVE5
	.byte  0		; FIRST_SECTOR

length_array:
        .byte  83,159,157,145	; MIST_TITLE,MIST,MECHE,SELENA
	.byte 128, 19,158,135	; OCTAGON,VIEWER,STONEY,CHANNEL
	.byte  61, 31,159,109	; CABIN,DENTIST,ARBOR,NIBEL
	.byte  20, 33, 27, 54	; SHIP,GENERATOR,D'NI,SUB
	.byte   3		; TEXT_TITLE
	.byte   1,1,1,1,1	; SAVE1,SAVE2,SAVE3,SAVE4,SAVE5
	.byte   1		; FIRST_SECTOR

;	.include	"qkumba_popwr.s"

        .include        "audio.s"
	.include	"linking_noise.s"
        .include        "decompress_fast_v2.s"
        .include        "draw_pointer.s"
        .include        "end_level.s"
	.include        "gr_copy.s"
        .include        "gr_fast_clear.s"
        .include        "gr_offsets.s"
        .include        "gr_pageflip.s"
        .include        "gr_putsprite_crop.s"
        .include        "keyboard.s"
        .include        "text_print.s"
	.include	"loadstore.s"

        .include        "page_sprites.inc"
	.include        "common_sprites.inc"

qload_end:

.assert (>qload_end - >qload_start) < $e , error, "loader too big"
