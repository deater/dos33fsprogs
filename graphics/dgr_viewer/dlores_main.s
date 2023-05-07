; VMW Productions DGR/ZX02 viewer

; by Vince `deater` Weaver <vince@deater.net>


.include "zp.inc"
.include "hardware.inc"

WHICH = $E0

dgr_start:

	;===================
	; Init RTS disk code
	;===================

	jsr	rts_init

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	lda	SET_GR		; graphics
	lda	LORES		; lores
	sta	SET80COL	; enable 80-column hardware
	lda	FULLGR		; mixset
	sta	CLRAN3		; enable double-wide graphics

	sta	EIGHTYSTOREON	; PAGE2 remaps MAIN:page1 writes to AUX:page1


        lda     #0
        sta     WHICH

	;===================
	; Load graphics
	;===================
load_loop:

	;=============================

	ldx     WHICH

	lda	main_filenames_low,X
	sta	OUTL
	lda	main_filenames_high,X
	sta	OUTH

	lda	aux_filenames_low,X
	sta	INL
	lda	aux_filenames_high,X
	sta	INH

	jsr	load_image

wait_until_keypress:
	lda	KEYBOARD                                ; 4
	bpl	wait_until_keypress                     ; 3
	bit	KEYRESET	; clear the keyboard buffer

	cmp	#$88		; left button
	bne	inc_which

	dec	WHICH
	bpl	which_ok

	ldx	#(MAX_FILES-1)
	bne	store_which	; bra

inc_which:
	inc	WHICH
	ldx	WHICH
	cpx	#MAX_FILES
	bcc	which_ok	; blt


	ldx     #0
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

	lda	#$0c

	jsr	zx02_full_decomp

	jsr	copy_to_400		; try to avoid holes

	bit	PAGE2

	lda	INL
	sta	OUTL
	lda	INH
	sta	OUTH

	jsr	opendir_filename	; open and read entire file into memory

	lda	#<$A000
	sta	zx_src_l+1

	lda	#>$A000
	sta	zx_src_h+1

	lda	#$0c

	jsr	zx02_full_decomp

	jsr	copy_to_400		; try to avoid holes

	rts



	;=========================
	; copy to 400
	;=========================
copy_to_400:


	ldx	#119
looper1:
	lda	$c00,X
	sta	$400,X

	lda	$c80,X
	sta	$480,X

	lda	$d00,X
	sta	$500,X

	lda	$d80,X
	sta	$580,X

	lda	$e00,X
	sta	$600,X

	lda	$e80,X
	sta	$680,X

	lda	$f00,X
	sta	$700,X

	lda	$f80,X
	sta	$780,X
	dex
	bpl	looper1

	rts


	.include "zx02_optim.s"
	.include "rts.s"
