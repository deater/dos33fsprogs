; Loader

.include "zp.inc"
.include "hardware.inc"
.include "music.inc"

;.include "common_defines.inc"
.include "qboot.inc"

qload_start:

	; init the write code
;	lda	WHICH_SLOT
;	jsr	popwr_init

	; first time entry
	; start by loading text title

;	lda	#0			; load ZW engine
;	sta	WHICH_LOAD

	lda	#1
	sta	CURRENT_DISK		; current disk number

;	jsr	load_file

	jmp	trogdor_start

;	jmp	$2000			; jump to ZW

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
	.byte 1,1,1,1		; MUSIC, TROGDOR, TITLE, FLAMES

load_address_array:
	.byte $D0,$80,$40,$E3	; MUSIC, TROGDOR, TITLE, FLAMES

start_address:
	.byte $D0,$80,$40,$E3	; MUSIC, TROGDOR, TITLE, FLAMES

track_array:
	.byte 4,12,11,6		; MUSIC, TROGDOR, TITLE, FLAMES

sector_array:
	.byte 0,0,0,0		; MUSIC, TROGDOR, TITLE, FLAMES

length_array:
	.byte 32,64,32,24	; MUSIC, TROGDOR, TITLE, FLAMES

PT3_ENABLE_APPLE_IIC = 1

	.include	"wait.s"

	.include	"start.s"

	.include	"lc_detect.s"

	.include	"wait_a_bit.s"
	.include	"gr_fast_clear.s"
	.include	"text_print.s"
	.include	"gr_offsets.s"
	.include	"hgr_clear_screen.s"
	.include	"hgr_copy_fast.s"
	.include	"hgr_page_flip.s"

	.include	"pt3_lib_detect_model.s"
	.include	"pt3_lib_mockingboard_detect.s"

mod7_table      = $1c00
div7_table      = $1d00
hposn_low       = $1e00
hposn_high      = $1f00

        .include        "hgr_table.s"

qload_end:

.assert (>qload_end - >qload_start) < $e , error, "loader too big"
