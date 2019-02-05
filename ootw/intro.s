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

	;==================================
	; draw the car driving up

	lda	#<building_sequence
	sta	INTRO_LOOPL
	lda	#>building_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	;==================================
	; Load building with car background

	lda	#>(building_car_rle)
	sta	GBASH
	lda	#<(building_car_rle)
	sta	GBASL

	lda	#$0c				; load to $c00

	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip


	;==================================
	; draw getting out of the car

	lda	#<outtacar_sequence
	sta	INTRO_LOOPL
	lda	#>outtacar_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


;===============================
;===============================
; Walk into door
;===============================
;===============================

	;=============================
	; Load background to $c00

	lda	#>(outer_door_rle)
	sta	GBASH
	lda	#<(outer_door_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip


	;==================================
	; draw feet going into door

	lda	#<feet_sequence
	sta	INTRO_LOOPL
	lda	#>feet_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence



door_loop:
	lda	KEYPRESS
	bpl	door_loop
	bit	KEYRESET



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

.include "intro_graphics/02_outer_door/outer_door.inc"
.include "intro_graphics/02_outer_door/feet.inc"

.include "intro_graphics/03_elevator/intro_elevator.inc"

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


	;=================================
	; Display a sequence of images

run_sequence:
	ldy	#0

run_sequence_loop:
	lda	(INTRO_LOOPL),Y		; get time
	beq	run_sequence_done
	tax

run_sequence_timer:
	lda	#64
	jsr	WAIT			; delay
	dex
	bne	run_sequence_timer

	iny

	lda	(INTRO_LOOPL),Y
	sta	GBASL
	iny
	lda	(INTRO_LOOPL),Y
	sta	GBASH
	iny
	sty	INTRO_LOOPER		; save for later
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip
	ldy	INTRO_LOOPER

	jmp	run_sequence_loop
run_sequence_done:
	rts

;========================
; Car driving up sequence

building_sequence:
	.byte	128
	.word	intro_car1
	.byte	2
	.word	intro_car2
	.byte	2
	.word	intro_car3
	.byte	2
	.word	intro_car4
	.byte	2
	.word	intro_car5
	.byte	2
	.word	intro_car6
	.byte	2
	.word	intro_car7
	.byte	2
	.word	intro_car8
	.byte	2
	.word	intro_car9
	.byte	128
	.word	intro_car10
	.byte	0

;========================
; Getting out of car sequence

outtacar_sequence:
	.byte	100
	.word	intro_car12
	.byte	50
	.word	intro_car13
	.byte	50
	.word	intro_car14
	.byte	200
	.word	intro_car14
	.byte	0

; Getting out of car sequence

feet_sequence:
	.byte	100
	.word	feet01_rle
	.byte	10
	.word	feet02_rle
	.byte	10
	.word	feet03_rle
	.byte	10
	.word	feet04_rle
	.byte	10
	.word	feet05_rle
	.byte	10
	.word	feet06_rle
	.byte	10
	.word	feet07_rle
	.byte	10
	.word	feet08_rle
	.byte	30
	.word	feet09_rle
	.byte	10
	.word	feet10_rle
	.byte	10
	.word	feet11_rle
	.byte	10
	.word	feet12_rle
	.byte	10
	.word	feet13_rle
	.byte	10
	.word	feet14_rle
	.byte	10
	.word	feet15_rle
	.byte	10
	.word	blank_rle
	.byte	100
	.word	blank_rle
	.byte	0

