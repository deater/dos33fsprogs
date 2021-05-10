; Loader for ootw

;.include "../zp.inc"
;.include "../hardware.inc"

;.include "common_defines.inc"
.include "qboot.inc"

qload_start:

	jsr	load_file

	; always enter at $5000

	jmp	$5000

	;====================================
	; loads file specified by WHICH_LOAD
	;====================================
load_file:
	ldx	#0

;	lda	which_disk_array,X
;	cmp	CURRENT_DISK
;	bne	change_disk

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
.if 0
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
.endif

which_disk_array:
	.byte 1,1,1,1		;


load_address_array:
        .byte $50		;

track_array:
        .byte  2		;


sector_array:
        .byte  0		;


length_array:
        .byte 112		;



	; include common libraries...

qload_end:

.assert (>qload_end - >qload_start) < $e , error, "loader too big"
