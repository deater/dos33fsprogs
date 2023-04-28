; VMW Productions DHIRES/ZX02 image viewer
;
; by deater (Vince Weaver) <vince@deater.net>

; todo help menu, timed slideshow mode
;	move to being a bootsector

.include "zp.inc"
.include "hardware.inc"

WHICH = $E0

hires_start:

	;===================
	; Init RTS disk code
	;===================

	jsr	rts_init

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	sta	AN3		; set double hires
	sta	EIGHTYCOLON	; 80 column
	sta	SET80COL	; 80 store

	bit	PAGE1	; start in page1

	lda	#0
	sta	WHICH

	;===================
	; Load graphics
	;===================
load_loop:

	;=============================

	ldx	WHICH

	lda	bin_filenames_low,X
	sta	OUTL
	lda	bin_filenames_high,X
	sta	OUTH

	lda	aux_filenames_low,X
	sta	INL
	lda	aux_filenames_high,X
	sta	INH

	jsr	load_image

wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer

	cmp	#$88		; left button
	bne	inc_which

	dec	WHICH
	bpl	which_ok

	ldx	#(MAX_FILES-1)
	bne	store_which		; bra

inc_which:
	inc	WHICH
	ldx	WHICH
	cpx	#MAX_FILES
	bcc	which_ok		; blt

	ldx	#0
store_which:
	stx	WHICH

which_ok:
	jmp	load_loop


	;==========================
	; Load Image
	;===========================

load_image:
	bit	PAGE1

	jsr	opendir_filename	; open and read entire file into memory

	lda	#<$A000
	sta	zx_src_l+1

	lda	#>$A000
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	; auxiliary part

	lda	INL
	sta	OUTL
	lda	INH
	sta	OUTH

	jsr	opendir_filename	; open and read entire file into memory

	bit	PAGE2

	lda	#<$A000
	sta	zx_src_l+1

	lda	#>$A000
	sta	zx_src_h+1

	lda	#$20

	jsr	zx02_full_decomp

	rts

	.include	"zx02_optim.s"
	.include	"rts.s"

;
