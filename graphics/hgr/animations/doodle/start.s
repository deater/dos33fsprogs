; surprise startup

;
; by deater (Vince Weaver) <vince@deater.net>

DEBUG=0

farm_start:
	;=====================
	; initializations
	;=====================

	bit	PAGE1
	bit	KEYRESET

	; init vars

	lda	#0
	sta	DRAW_PAGE

	;=====================
	; clear text screen

	lda	#$A0
	jsr	clear_top_a
	jsr	clear_bottom

	; print start message

	jsr	set_normal

	lda	#<start_message
	sta	OUTL
	lda	#>start_message
	sta	OUTH

	jsr	move_and_print_list


	;=========================================
	;=========================================
	; start loading the demo
	;=========================================
	;=========================================

	jsr	hgr_make_tables


	;=======================
	;=======================
	; Run BG_LOAD
	;=======================
	;=======================

	; load from disk

	lda	#PART_BG_LOAD
	sta	WHICH_LOAD
	jsr	load_file

	; Do decompress

	jsr	$6000

	;=======================
	;=======================
	; setup graphics
	;=======================
	;=======================

	bit	SET_GR
	bit	HIRES
	bit	FULLGR

	bit	PAGE2			; display page1

;oog:
;	jsr	wait_until_keypress
;	jsr	hgr_page_flip

;	jmp	oog





	;=======================
	;=======================
	; Run ANIMATION
	;=======================
	;=======================

	; load from disk

	lda	#PART_ANIMATION	; Load bucket
	sta	WHICH_LOAD
	jsr	load_file

	; Run Animation

	jsr	$6000

blah:
	jmp	blah


start_message:	  ;01234567890123456789012345678901234567890
	.byte 0,0,"LOADING DOODLE",0
	.byte $FF
