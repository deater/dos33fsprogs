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

	; init the write code
	lda	WHICH_SLOT
	jsr	popwr_init

	; first time entry
	; start by loading text title

	lda	#LOAD_VID_LOGO		; load intro
	sta	WHICH_LOAD

	lda	#1
	sta	CURRENT_DISK		; current disk number

	jsr	load_file

	jsr	$6000

	lda	#LOAD_TITLE		; load title
	sta	WHICH_LOAD

main_game_loop:
	jsr	load_file

;	lda	WHICH_LOAD
;	bne	not_title


start_title:
	jsr	$6000
	jmp	main_game_loop

;not_title:
;	jsr	$2000
;	jmp	main_game_loop

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

;	ldy	#0

;quick_print:
;	lda	(OUTL),Y
;	beq	quick_print_done
;	jsr	COUT1
;	iny
;	jmp	quick_print

;quick_print_done:

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

	; first sector now in $BC00
	;	offset 5B
	;		disk1 = $d0
	;		disk2 = $32 ('2')
	;		disk3 = $33 ('3')

	lda	$BC5B
	cmp	#$d0
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

	ldx	WHICH_LOAD
	lda	which_disk_array,X
	sta	CURRENT_DISK

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
	.byte 2,1,1,1		; GAME_OVER, INVENTORY, DIALOG2
	.byte 1			;
	.byte 1,1,1,1,1		; SAVE1, SAVE2, SAVE3
	.byte $f		; disk detect

load_address_array:
	.byte $60,$60,$60,$60	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte $60,$60,$60,$60	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte $60,$60,$D0,$60	; TROGDOR, ENDING, MUSIC, CLIFF
	.byte $60,$D0,$20,$40	; GAME_OVER, INVENTORY, DIALOG2
	.byte $08		;
	.byte $BC,$BC,$BC,$0A	; SAVE1, SAVE2, SAVE3
	.byte $0A		;
	.byte $BC		; disk detect

track_array:
        .byte  4, 6, 9,1	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte 15,20,25,30	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte 19,24, 3,29	; TROGDOR, ENDING, MUSIC, CLIFF
	.byte  3,14,13,30	; GAME_OVER, INVENTORY, DIALOG2
	.byte  0		;
	.byte  0, 0, 0, 0, 0	; SAVE1, SAVE2, SAVE3
	.byte  0		; disk detect

sector_array:
        .byte  0, 0, 0, 0	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte  0, 0, 0, 0	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte  0, 0, 0, 0	; TROGDOR, ENDING, MUSIC, CLIFF
	.byte  0, 0, 0, 1	; GAME_OVER, INVENTORY, DIALOG2
	.byte  6		;
	.byte 11,12,13,14,15	; SAVE1, SAVE2, SAVE3
	.byte  0		; disk detect

length_array:
        .byte  32, 50, 60, 20	; VID_LOGO, TITLE, INTRO, COPY_CHECK
	.byte  80, 88, 88, 80	; PEASANT1, PEASANT2, PEASANT3, PEASANT4
	.byte  80, 80, 16, 80	; TROGDOR, ENDING, MUSIC, CLIFF
	.byte  16, 16, 16, 78	; GAME_OVER, INVENTORY, DIALOG2
	.byte   3		;
	.byte   1,1,1,1,1	; SAVE1, SAVE2, SAVE3
	.byte   1		; disk detect

.include "qkumba_popwr.s"

.include "decompress_fast_v2.s"

.include "hgr_font.s"
.include "draw_box.s"
.include "hgr_rectangle.s"
.include "hgr_1x28_sprite_mask.s"
.include "hgr_1x5_sprite.s"
.include "hgr_partial_save.s"
.include "hgr_input.s"
.include "hgr_tables.s"
.include "hgr_text_box.s"
.include "clear_bottom.s"
.include "hgr_hgr2.s"		; this one is maybe only needed once?
.include "gr_offsets.s"
.include "loadsave_menu.s"
.include "wait_keypress.s"

peasant_text:
	.byte 25,2,"Peasant's Quest",0

qload_end:

;.assert (>qload_end - >qload_start) < $e , error, "loader too big"
.assert (>qload_end - >qload_start) < $15 , error, "loader too big"
