; Loader for Surprise

.include "zp.inc"
.include "../hardware.inc"

.include "common_defines.inc"
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

	jmp	farm_start

;	jmp	$2000			; jump to ZW

	;====================================
	; loads file specified by WHICH_LOAD
	;====================================
load_file:
	ldx	WHICH_LOAD

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

	jsr	load_new

	rts


which_disk_array:
	.byte 1,1,1		; ???, BG_LOAD, ANIMATION

load_address_array:
	.byte $D0,$60,$60	; ???, BG_LOAD, ANIMATION

start_address:
	.byte $D0,$60,$60	; ???, BG_LOAD, ANIMATION

track_array:
	.byte 2,2,5		; ???, BG_LOAD, ANIMATION

sector_array:
	.byte 0,0,0		; ???, BG_LOAD, ANIMATION

length_array:
	.byte 48,16,96		; ???, BG_LOAD, ANIMATION


	.include	"../wait.s"

	.include	"../wait_a_bit.s"
	.include	"../gr_fast_clear.s"
	.include	"../text_print.s"
	.include	"../gr_offsets.s"

        .include        "../hgr_table.s"
	.include	"../hgr_page_flip.s"
	.include	"../wait_keypress.s"
	.include	"../zx02_optim.s"
	.include	"../hgr_clear_screen.s"

	.include	"start.s"

qload_end:

.assert (>qload_end - >qload_start) < $e , error, "loader too big"
