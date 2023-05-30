; Yet Another HR project
;
; by deater (Vince Weaver) <vince@deater.net>


.include "zp.inc"
.include "hardware.inc"


hires_start:

	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	;====================
	; set up tables
	;====================

	lda	#$20
	sta	HGR_PAGE
	jsr	hgr_make_tables

	;===================
	;===================
	; scroll the logo
	;===================
	;===================
scroll_logo:

	;===================
	; decomress to $a000

	; size in ldsizeh:ldsizel (f1/f0)

	lda	#<vid_top
	sta	ZX0_src
	lda	#>vid_top
	sta	ZX0_src+1


	lda	#$A0

	jsr	full_decomp

	;======================
	; scroll up vertically
	;======================

	jsr	hgr_vscroll


	;===================
	; Do Title Screen
	;===================
load_loop:

	;==========================
	; Load Title Image
	;===========================

load_title_image:

	; size in ldsizeh:ldsizel (f1/f0)

	lda	#<title_data
	sta	ZX0_src
	lda	#>title_data
	sta	ZX0_src+1


	lda	#$20


	jsr	full_decomp

;	rts



wait_until_keypress:
	lda	KEYPRESS				; 4
	bpl	wait_until_keypress			; 3
	bit	KEYRESET	; clear the keyboard buffer

	and	#$7f
	cmp	#'1'
	bcc	which_ok
	cmp	#'4'
	bcs	which_ok

	jmp	done

which_ok:
	jmp	load_loop


done:
	and	#$f
	sta	WHICH_LOAD
	rts

	.include	"zx02_optim.s"
	.include	"hgr_tables.s"
	.include	"hgr_vscroll.s"

title_data:
	.incbin "graphics/czmg4ap_title.hgr.zx02"
vid_top:
	.incbin "graphics/videlectrix_top.hgr.zx02"
