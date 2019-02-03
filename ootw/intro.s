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
	; Setup pages

	lda	#4
	sta	DRAW_PAGE
	lda	#0
	sta	DISP_PAGE

;===============================
;===============================
; Opening scene with car
;===============================
;===============================

	;=============================
	; Load background to $c00

	lda	#>(building_rle)
	sta	GBASH
	lda	#<(building_rle)
	sta	GBASL

	lda	#$0c				; load to $c00

	jsr	load_rle_gr

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip

building_loop:
	lda	KEYPRESS
	bpl	building_loop
	bit	KEYRESET

	lda	#>(intro_car1)
	sta	GBASH
	lda	#<(intro_car1)
	sta	GBASL
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

building_loop2:
	lda	KEYPRESS
	bpl	building_loop2
	bit	KEYRESET

	lda	#>(intro_car2)
	sta	GBASH
	lda	#<(intro_car2)
	sta	GBASL
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

building_loop3:
	lda	KEYPRESS
	bpl	building_loop3
	bit	KEYRESET

	lda	#>(intro_car3)
	sta	GBASH
	lda	#<(intro_car3)
	sta	GBASL
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

building_loop4:
	lda	KEYPRESS
	bpl	building_loop4
	bit	KEYRESET

	lda	#>(intro_car4)
	sta	GBASH
	lda	#<(intro_car4)
	sta	GBASL
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

building_loop5:
	lda	KEYPRESS
	bpl	building_loop5
	bit	KEYRESET

	lda	#>(intro_car5)
	sta	GBASH
	lda	#<(intro_car5)
	sta	GBASL
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

building_loop6:
	lda	KEYPRESS
	bpl	building_loop6
	bit	KEYRESET

	lda	#>(intro_car6)
	sta	GBASH
	lda	#<(intro_car6)
	sta	GBASL
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

building_loop7:
	lda	KEYPRESS
	bpl	building_loop7
	bit	KEYRESET

	lda	#>(intro_car7)
	sta	GBASH
	lda	#<(intro_car7)
	sta	GBASL
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

building_loop8:
	lda	KEYPRESS
	bpl	building_loop8
	bit	KEYRESET

	lda	#>(intro_car8)
	sta	GBASH
	lda	#<(intro_car8)
	sta	GBASL
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

building_loop9:
	lda	KEYPRESS
	bpl	building_loop9
	bit	KEYRESET

	lda	#>(intro_car9)
	sta	GBASH
	lda	#<(intro_car9)
	sta	GBASL
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

building_loop10:
	lda	KEYPRESS
	bpl	building_loop10
	bit	KEYRESET

	lda	#>(intro_car10)
	sta	GBASH
	lda	#<(intro_car10)
	sta	GBASL
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

building_loop11:
	lda	KEYPRESS
	bpl	building_loop11
	bit	KEYRESET


	;=============================
	; Load background to $c00

	lda	#>(building_car_rle)
	sta	GBASH
	lda	#<(building_car_rle)
	sta	GBASL

	lda	#$0c				; load to $c00

	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip

building_loop12:
	lda	KEYPRESS
	bpl	building_loop12
	bit	KEYRESET


	lda	#>(intro_car12)
	sta	GBASH
	lda	#<(intro_car12)
	sta	GBASL
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

building_loop13:
	lda	KEYPRESS
	bpl	building_loop13
	bit	KEYRESET


	lda	#>(intro_car13)
	sta	GBASH
	lda	#<(intro_car13)
	sta	GBASL
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

building_loop14:
	lda	KEYPRESS
	bpl	building_loop14
	bit	KEYRESET

	lda	#>(intro_car14)
	sta	GBASH
	lda	#<(intro_car14)
	sta	GBASL
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip

building_loop15:
	lda	KEYPRESS
	bpl	building_loop15
	bit	KEYRESET











;===============================
;===============================
; Walk into door
;===============================
;===============================




;===============================
;===============================
; Elevator going down
;===============================
;===============================

	;=============================
	; Load background to $c00

	lda	#>(elevator_rle)
	sta	GBASH
	lda	#<(elevator_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

elevator_loop:
	lda	KEYPRESS
	bpl	elevator_loop
	bit	KEYRESET


;===============================
;===============================
; Getting out of Elevator
;===============================
;===============================


	;=============================
	; Load background to $c00

	lda	#>(off_elevator_rle)
	sta	GBASH
	lda	#<(off_elevator_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

off_elevator_loop:
	lda	KEYPRESS
	bpl	off_elevator_loop
	bit	KEYRESET


;===============================
;===============================
; Keycode
;===============================
;===============================

	;=============================
	; Load background to $c00

	lda	#>(keypad_rle)
	sta	GBASH
	lda	#<(keypad_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

keypad_loop:
	lda	KEYPRESS
	bpl	keypad_loop
	bit	KEYRESET


;===============================
;===============================
; Scanner
;===============================
;===============================


	;=============================
	; Load background to $c00

	lda	#>(scanner_rle)
	sta	GBASH
	lda	#<(scanner_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

scanner_loop:
	lda	KEYPRESS
	bpl	scanner_loop
	bit	KEYRESET


;===============================
;===============================
; Spinny DNA / Key
;===============================
;===============================


;===============================
; Sitting at Desk
;===============================

	;=============================
	; Load background to $c00

	lda	#>(unzapped_rle)
	sta	GBASH
	lda	#<(unzapped_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

unzapped_loop:
	lda	KEYPRESS
	bpl	unzapped_loop
	bit	KEYRESET

;===============================
; Peanut OS
;===============================

;===============================
; Particle Accelerator Screen
;===============================

;===============================
;===============================
; Opening Soda
;===============================
;===============================

	;=============================
	; Load background to $c00

	lda	#>(open_soda_rle)
	sta	GBASH
	lda	#<(open_soda_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

open_soda_loop:
	lda	KEYPRESS
	bpl	open_soda_loop
	bit	KEYRESET

;===============================
;===============================
; Drinking Soda
;===============================
;===============================


	;=============================
	; Load background to $c00

	lda	#>(drinking_rle)
	sta	GBASH
	lda	#<(drinking_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

drinking_loop:
	lda	KEYPRESS
	bpl	drinking_loop
	bit	KEYRESET

;===============================
;===============================
; More crazy screen
;===============================
;===============================

	;=============================
	; Load background to $c00

	lda	#>(collider_ui_rle)
	sta	GBASH
	lda	#<(collider_ui_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

collider_ui_loop:
	lda	KEYPRESS
	bpl	collider_ui_loop
	bit	KEYRESET


;===============================
;===============================
; Thunderstorm Outside
;===============================
;===============================


;===============================
;===============================
; Tunnel 1
;===============================
;===============================

	;=============================
	; Load background to $c00

	lda	#>(tunnel1_rle)
	sta	GBASH
	lda	#<(tunnel1_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

tunnel1_loop:
	lda	KEYPRESS
	bpl	tunnel1_loop
	bit	KEYRESET



;===============================
;===============================
; Tunnel 2
;===============================
;===============================


	;=============================
	; Load background to $c00

	lda	#>(tunnel2_rle)
	sta	GBASH
	lda	#<(tunnel2_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

tunnel2_loop:
	lda	KEYPRESS
	bpl	tunnel2_loop
	bit	KEYRESET


;===============================
;===============================
; Zappo / Gone
;===============================
;===============================


	;=============================
	; Load background to $c00

	lda	#>(gone_rle)
	sta	GBASH
	lda	#<(gone_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

gone_loop:
	lda	KEYPRESS
	bpl	gone_loop
	bit	KEYRESET













	rts

.include "gr_pageflip.s"
.include "gr_unrle.s"
.include "gr_copy.s"
.include "gr_offsets.s"
.include "gr_overlay.s"

; background graphics
.include "intro_graphics/01_building/intro_building.inc"
.include "intro_graphics/01_building/intro_building_car.inc"
.include "intro_graphics/01_building/intro_car.inc"


.include "intro_elevator.inc"
.include "intro_off_elevator.inc"
.include "intro_keypad.inc"
.include "intro_scanner.inc"
.include "intro_open_soda.inc"
.include "intro_drinking.inc"
.include "intro_unzapped.inc"
.include "intro_collider_ui.inc"
.include "intro_tunnel1.inc"
.include "intro_tunnel2.inc"
.include "intro_gone.inc"


