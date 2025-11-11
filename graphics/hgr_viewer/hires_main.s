; VMW Productions HIRES/ZX02 image viewer
;
; by deater (Vince Weaver) <vince@deater.net>

; todo help menu, timed slideshow mode
;	move to being a bootsector

.include "zp.inc"
.include "hardware.inc"

WHICH		= $E0
WHICH_BCD	= $E1
IS_TEXT		= $E2


hires_start:

	;===================
	; Init RTS disk code
	;===================

	jsr	rts_init

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	lda	#0
	sta	WHICH
	sta	WHICH_BCD
	sta	IS_TEXT
	sta	DRAW_PAGE

	jsr	set_normal


	;===================
	; Load graphics
	;===================
load_loop:

	;=============================
	; load from disk

	ldx	WHICH

	lda	filenames_low,X
	sta	OUTL
	lda	filenames_high,X
	sta	OUTH

	jsr	load_image

	;=============================
	; update text screen

	;======================
	; update which image

	lda	WHICH_BCD
	and	#$f
	clc
	adc	#$B0
	sta	file_offset+8

	lda	WHICH_BCD
	lsr
	lsr
	lsr
	lsr
	and	#$f
	clc
	adc	#$B0
	sta	file_offset+7

	;================================
	; update filename


	; clear first
	lda	#' '|$80
	ldx	#19
clear_filename_loop:
	sta	filename_offset+12,X
	dex
	bpl	clear_filename_loop

	; copy filename data

	ldx	WHICH
	lda	authors_low,X
	sta	OUTL
	lda	authors_high,X
	sta	OUTH

	ldy	#0
copy_filenames_loop:
	lda	(OUTL),Y
	beq	done_copy_filenames_loop
	sta	filename_offset+12,Y
	iny
	bne	copy_filenames_loop	; bra

done_copy_filenames_loop:



	;================================
	; update author


	; clear first
	lda	#' '|$80
	ldx	#19
clear_author_loop:
	sta	author_offset+12,X
	dex
	bpl	clear_author_loop

	; copy author data

	ldx	WHICH
	lda	authors_low,X
	sta	OUTL
	lda	authors_high,X
	sta	OUTH

	ldy	#0
copy_author_loop:
	lda	(OUTL),Y
	beq	done_copy_author_loop
	sta	author_offset+12,Y
	iny
	bne	copy_author_loop	; bra

done_copy_author_loop:



	;===============================
	; clear screen (Causes flicker)

	jsr	HOME

	;===============================
	; print text

	lda	#<image_info
	sta	OUTL
	lda	#>image_info
	sta	OUTH

	jsr	move_and_print_list


wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer

	;=========================
	; check if escape
check_escape:
	cmp	#$9B
	bne	check_left

	lda	IS_TEXT
	eor	#$1		; toggle
	sta	IS_TEXT		; 0 or 1

	tax

	sta	SET_GR,X	; set graphics or text (gr=2050 text=2051)


	jmp	which_ok


	;=========================
	; check if left key
check_left:
	cmp	#$88		; left key
	bne	do_right_key	; anything else is right key

	;======================================
	; move to previous image
do_left_key:
	sed
	sec
	lda	WHICH_BCD
	sbc	#1
	sta	WHICH_BCD
	cld

	dec	WHICH
	bpl	which_ok

	lda	#(((MAX_FILES-1)/10)<<4) | ((MAX_FILES-1) .MOD 10)

	sta	WHICH_BCD

	ldx	#(MAX_FILES-1)
	bne	store_which		; bra

	;==========================
	; move to next image
do_right_key:
	sed
	clc
	lda	WHICH_BCD
	adc	#$1
	sta	WHICH_BCD
	cld

	inc	WHICH
	ldx	WHICH
	cpx	#MAX_FILES		; wrap at max
	bcc	which_ok		; blt

	; overflowed, reset

	ldx	#0
	stx	WHICH_BCD

	;==========================
	; common update
store_which:
	stx	WHICH

which_ok:
	jmp	load_loop


	;==========================
	; Load Image
	;===========================

load_image:
	jsr	opendir_filename	; open and read entire file into memory

	; size in ldsizeh:ldsizel (f1/f0)

	lda	#$a0
	sta	zx_src_h+1
	lda	#$00
	sta	zx_src_l+1

	lda	#$20			; destination

	jsr	zx02_full_decomp

	rts

	.include	"zx02_optim.s"
	.include	"rts.s"
	.include	"text_print.s"
	.include	"gr_offsets_split.s"

;



image_info:
.byte 0,0,"HGR FILE VIEWER",0
file_offset:
.byte 0,2,"FILE 00 OF ",((MAX_FILES-1)/10)+'0'+$80,((MAX_FILES-1) .MOD 10)+'0'+$80,0
;                    01234567890123456789
filename_offset:
.byte 0,4,"FILENAME:                     ",0
author_offset:
.byte 0,5,"AUTHOR:                       ",0
.byte 0,20,"PRESS ESC TO RETURN TO GRAPHICS",0
.byte $ff
