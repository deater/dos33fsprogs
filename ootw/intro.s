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

	jmp	elevator_exit

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

;===============================
;===============================
; Elevator going down
;===============================
;===============================

elevator:
	;=============================
	; Load background to $c00 and $1000

	lda	#>(elevator_rle)
	sta	GBASH
	lda	#<(elevator_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr
	lda	#>(elevator_rle)
	sta	GBASH
	lda	#<(elevator_rle)
	sta	GBASL
	lda	#$10			; load to off-screen $c00
	jsr	load_rle_gr


	jsr	gr_copy_to_current

	lda	#$66
	sta	COLOR

	; elevator outer door

	ldx	#39
	stx	V2
	ldx	#4
	ldy	#14
	jsr	vlin	; X, V2 at Y

	ldx	#35
	stx	V2
	ldx	#7
	ldy	#18

	jsr	vlin	; X, V2 at Y

	; elevator inner door
	ldx	#2
	stx	ELEVATOR_COUNT
elevator_middle:
	ldx	#38
	stx	V2
	ldx	#5
	ldy	#15

	jsr	vlin	; X, V2 at Y

	ldx	#36
	stx	V2
	ldx	#6
	ldy	#17

	jsr	vlin	; X, V2 at Y

elevator_inner:
	ldx	#37
	stx	V2
	ldx	#5
	ldy	#16

	jsr	vlin	; X, V2 at Y



	jsr	page_flip

	jsr	gr_copy_to_current

	ldx	#50
	jsr	long_wait

	dec	ELEVATOR_COUNT
	lda	ELEVATOR_COUNT
	beq	elevator_inner
	cmp	#1
	beq	elevator_middle

	; door closed

	jsr	page_flip

	ldx	#100
	jsr	long_wait

	;======================
	; yellow line goes down
	;======================

	lda	#0
	sta	COLOR
	lda	#5
	sta	V2
yellow_line_down:

	jsr	gr_copy_to_current

	ldx	#5
	ldy	#16
	jsr	vlin	; X, V2 at Y

	jsr	page_flip

	ldx	#12
	jsr	long_wait

	inc	V2
	lda	V2
	cmp	#38
	bne	yellow_line_down

	lda	DRAW_PAGE
	pha

	lda	#$c				; erase yellow line
	sta	DRAW_PAGE			; on page $1000 version
	ldx	#5
	ldy	#16
	jsr	vlin	; X, V2 at Y

	pla
	sta	DRAW_PAGE

	;========================
	; change floor indicators
	;========================

	lda	#$33
	sta	COLOR
	lda	#5
	sta	V2

	; 16,1
	jsr	gr_copy_to_current_1000
	ldx	#16
	lda	#1
	jsr	plot
	jsr	page_flip
	ldx	#150
	jsr	long_wait

	; 18,2
	jsr	gr_copy_to_current_1000
	ldx	#18
	lda	#2
	jsr	plot
	jsr	page_flip
	ldx	#150
	jsr	long_wait

	; 14,2
	jsr	gr_copy_to_current_1000
	ldx	#14
	lda	#2
	jsr	plot
	jsr	page_flip
	ldx	#150
	jsr	long_wait

	; 16,3
	jsr	gr_copy_to_current_1000
	ldx	#16
	lda	#3
	jsr	plot
	jsr	page_flip
	ldx	#150
	jsr	long_wait

	; 18,4
	jsr	gr_copy_to_current_1000
	ldx	#18
	lda	#4
	jsr	plot
	jsr	page_flip
	ldx	#150
	jsr	long_wait

	;====================
	; dark elevator
	;====================

	; clear $c00 to black

	lda	DRAW_PAGE
	pha

	lda	#$8
	sta	DRAW_PAGE
	jsr	clear_all

	pla
	sta	DRAW_PAGE

	; blue from 20, 30 - 20,34 and yellow (brown?) from 20,0 to 20,30
	; scrolls down until all yellow

	lda	#30
	sta	ELEVATOR_COUNT
going_down_loop:

	jsr	gr_copy_to_current	; copy black screen in

	; draw the yellow part

	lda	#$DD
	sta	COLOR
	lda	ELEVATOR_COUNT
	sta	V2
	ldx	#0
	ldy	#20
	jsr	vlin	; X, V2 at Y

	lda	#$22			; draw the blue part
	sta	COLOR

	lda	ELEVATOR_COUNT
	clc
	adc	#4
	cmp	#40
	bmi	not_too_big

	lda	#40
not_too_big:
	sta	V2
	ldx	ELEVATOR_COUNT
	ldy	#20
	jsr	vlin	; X, V2 at Y

	jsr	page_flip

	ldx	#8			; pause
	jsr	long_wait

	inc	ELEVATOR_COUNT
	lda	ELEVATOR_COUNT
	cmp	#40
	bne	going_down_loop

	;=====================
	; all yellow for a bit
	;=====================

	jsr	gr_copy_to_current	; copy black screen in
	lda	#$DD
	sta	COLOR
	lda	#40
	sta	V2
	ldx	#0
	ldy	#20
	jsr	vlin	; X, V2 at Y
	jsr	page_flip

	ldx	#100			; wait a bit
	jsr	long_wait


	; single blue dot
	; solid blue line 10 later

	lda	#2
	sta	ELEVATOR_CYCLE

going_down_repeat:

	lda	#1
	sta	ELEVATOR_COUNT
going_down_blue:

	jsr	gr_copy_to_current	; copy black screen in

	; draw the blue part

	lda	#$22
	sta	COLOR
	lda	ELEVATOR_COUNT
	sta	V2
	ldx	#0
	ldy	#20
	jsr	vlin	; X, V2 at Y

gdb_smc:
	lda	#$dd			; draw the blue part
	sta	COLOR

	lda	#40
	sta	V2
	ldx	ELEVATOR_COUNT
	ldy	#20
	jsr	vlin	; X, V2 at Y

	jsr	page_flip

	ldx	#8			; pause
	jsr	long_wait

	inc	ELEVATOR_COUNT
	lda	ELEVATOR_COUNT
	cmp	#40
	bne	going_down_blue

	dec	ELEVATOR_CYCLE
	beq	elevator_exit


	lda	#1
	sta	ELEVATOR_COUNT
going_down_black:

	jsr	gr_copy_to_current	; copy black screen in

	; draw the blue part

	lda	#$00
	sta	COLOR
	lda	ELEVATOR_COUNT
	sta	V2
	ldx	#0
	ldy	#20
	jsr	vlin	; X, V2 at Y

	lda	#$22			; draw the blue part
	sta	COLOR

	lda	#40
	sta	V2
	ldx	ELEVATOR_COUNT
	ldy	#20
	jsr	vlin	; X, V2 at Y

	jsr	page_flip

	ldx	#8			; pause
	jsr	long_wait

	inc	ELEVATOR_COUNT
	lda	ELEVATOR_COUNT
	cmp	#40
	bne	going_down_black

	lda	#$00
	sta	gdb_smc+1

	jmp	going_down_repeat


	; black, 2, blue, black about 20
	; blue until hit bottom, doors open



elevator_exit:

	ldx	#100			; pause
	jsr	long_wait



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

	lda	#>(walking00_rle)
	sta	GBASH
	lda	#<(walking00_rle)
	sta	GBASL
	lda	#$10			; load to off-screen $1000
	jsr	load_rle_gr


	lda	#10
	sta	ELEVATOR_COUNT

elevator_open_loop:
	jsr	gr_overlay		; note: overwrites color
	lda	#$00
	sta	COLOR

; Would have liked to have a central purple stripe, but not easy

; 9 10 11 12 13 14 15 16 17 18 19     20    21 22 23 24 25 26 27 28 29 30


	lda	ELEVATOR_COUNT
	sta	ELEVATOR_CYCLE
elevator_inner_loop:
	lda	#9
	clc
	adc	ELEVATOR_CYCLE
	tay

	lda	#40
	sta	V2
	ldx	#0
	jsr	vlin	; X, V2 at Y

	sec
	lda	#30
	sbc	ELEVATOR_CYCLE
	tay

	lda	#40
	sta	V2
	ldx	#0
	jsr	vlin	; X, V2 at Y

	dec	ELEVATOR_CYCLE
	bne	elevator_inner_loop

	jsr	page_flip

	ldx	#30
	jsr	long_wait

	dec	ELEVATOR_COUNT
	bne	elevator_open_loop

	;==================================
	; draw walking off the elevator

	lda	#<walking_sequence
	sta	INTRO_LOOPL
	lda	#>walking_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence




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
.include "gr_vlin.s"
.include "gr_plot.s"
.include "gr_fast_clear.s"

; background graphics
.include "intro_graphics/01_building/intro_building.inc"
.include "intro_graphics/01_building/intro_building_car.inc"
.include "intro_graphics/01_building/intro_car.inc"

.include "intro_graphics/02_outer_door/outer_door.inc"
.include "intro_graphics/02_outer_door/feet.inc"

.include "intro_graphics/03_elevator/intro_elevator.inc"
.include "intro_graphics/03_elevator/intro_off_elevator.inc"
.include "intro_graphics/03_elevator/intro_walking.inc"

.include "intro_graphics/04_keypad/intro_scanner_door.inc"
.include "intro_graphics/04_keypad/intro_keypad.inc"

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

	jsr	long_wait

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


	;=====================
	; long(er) wait
	; waits approximately ?? ms

long_wait:
	lda	#64
	jsr	WAIT			; delay
	dex
	bne	long_wait
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

; Walking off elevator sequence

walking_sequence:
	.byte	20
	.word	walking01_rle
	.byte	20
	.word	walking02_rle
	.byte	20
	.word	walking03_rle
	.byte	20
	.word	walking04_rle
	.byte	20
	.word	walking05_rle
	.byte	20
	.word	walking06_rle
	.byte	20
	.word	walking07_rle
	.byte	20
	.word	walking08_rle
	.byte	0



