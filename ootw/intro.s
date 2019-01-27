;=====================================
; Intro

.include "zp.inc"
.include "hardware.inc"

intro:

	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR

	;===========================
	; Setup pages (is this necessary?)

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE

;===============================
;===============================
; Opening scene with car
;===============================
;===============================

	;=============================
	; Load background to $c00

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL			; load image off-screen $c00

	lda	#>(building_rle)
	sta	GBASH
	lda	#<(building_rle)
	sta	GBASL
	jsr	load_rle_gr

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

building_loop:
	lda	KEYPRESS
	bpl	building_loop

	;===============================
	; Walk into door

	;===============================
	; Elevator going down

	;===============================
	; Getting out of Elevator

	;===============================
	; Keycode

	;===============================
	; Scanner

	;===============================
	; Spinny DNA / Key

	;===============================
	; Sitting at Desk

	;===============================
	; Peanut OS

	;===============================
	; Particle Accelerator Screen

	;===============================
	; Soda

	;===============================
	; More crazy screen

	;===============================
	; Thunderstorm Outside

	;===============================
	; Tunnel 1

	;===============================
	; Tunnel 2

	;===============================
	; Zappo
















	rts

.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_copy.s"
.include "gr_offsets.s"

.include "intro_building.inc"
