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

	jmp	scanner

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

	ldx	#25
	jsr	long_wait		; pause

	dec	ELEVATOR_COUNT
	bne	elevator_open_loop

	;==================================
	; draw walking off the elevator

	lda	#<walking_sequence
	sta	INTRO_LOOPL
	lda	#>walking_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	;======================================
	; make background black and pause a bit

	jsr	clear_all
	jsr	page_flip

	ldx	#80
	jsr	long_wait

;===============================
;===============================
; Keycode
;===============================
;===============================

keypad:
	;=============================
	; Load background to $c00

	lda	#>(scanner_door_rle)
	sta	GBASH
	lda	#<(scanner_door_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	lda	#<approach_sequence
	sta	INTRO_LOOPL
	lda	#>approach_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


	;=============================
	; Load background to $c00

	lda	#>(keypad_rle)
	sta	GBASH
	lda	#<(keypad_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	;==================================
	; draw walking off the elevator

	lda	#<keypad_sequence
	sta	INTRO_LOOPL
	lda	#>keypad_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


	;==================================
	; doop opening sequence

	lda	#>(scanner_door_rle)
	sta	GBASH
	lda	#<(scanner_door_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr


	lda	#<opening_sequence
	sta	INTRO_LOOPL
	lda	#>opening_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


;===============================
;===============================
; Scanner
;===============================
;===============================

scanner:
	lda	#>(scanner_rle)
	sta	GBASH
	lda	#<(scanner_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<scanning_sequence
	sta	INTRO_LOOPL
	lda	#>scanning_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

;===============================
;===============================
; Spinny DNA / Key
;===============================
;===============================

	lda	#>(ai_bg_rle)
	sta	GBASH
	lda	#<(ai_bg_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	clear_bottom
	bit	TEXTGR			; split graphics/text

	jsr	gr_copy_to_current
	jsr	page_flip

	; Identification (nothing)


	lda	#<ai_sequence
	sta	INTRO_LOOPL
	lda	#>ai_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence_static


	; slices        / | - / nothing (pause)
	; more slices   / | - / nothing (pause)
	; small circle  / | - / nothing (pause)
	; big circle    / | - / nothing (pause)
	;                   -   !!! DNA START 1 line
	;                     /   !!! DNA start 1 line
	;                         !!! DNA 2 lines
	; DNA 5 lines
	; Good evening professor.
	; DNA all lines

	; Key             |
	; I see you have driven here in your \ Ferrari.
	; Key                - / nothing (pause)

uz_loop:
	lda	KEYPRESS
	bpl	uz_loop
	bit	KEYRESET

;===============================
; Sitting at Desk
;===============================

	lda	#>(desktop_rle)
	sta	GBASH
	lda	#<(desktop_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	gr_copy_to_current

	bit	FULLGR			; back to full graphics

	jsr	page_flip

	;=================================
	; Display rises up
	;=================================

	lda	#<powerup_sequence
	sta	INTRO_LOOPL
	lda	#>powerup_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


	;=================================
	; Zoom in, mouse move
	;=================================
	; FIXME: shimmery edges to display?

	lda	#>(desktop_bg_rle)
	sta	GBASH
	lda	#<(desktop_bg_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<cursor_sequence
	sta	INTRO_LOOPL
	lda	#>cursor_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


;===============================
; Peanut OS
;===============================
	;           1         2         3
	; 0123456789012345678901234567890123456789
	;
	; Copyright (c) 1977 Peanut Computer, Inc.
	; All rights reserved.
	;
	; CDOS Version 5.01
	;
	; > #

	lda	#$a0
	jsr	clear_top_a
	jsr	clear_bottom

	lda	#<peanut
	sta	OUTL
	lda	#>peanut
	sta	OUTH

	jsr	move_and_print_list

	jsr	page_flip

	bit     SET_TEXT


	; RUN PROJECT 23# (typed)
	; #


peanut_loop:
	lda	KEYPRESS
	bpl	peanut_loop
	bit	KEYRESET



;===============================
; Particle Accelerator Screen
;===============================

	; MODIFICATION OF PARAMETERS
	; RELATING TO PARTICLE
	; ACCELERATOR (SYNCHOTRON).
	;____________    E: 23%
	; ROOM 3   X:\	 g: .005
	;           : :
	;	    : :  RK: 77.2L
	;           : :
	;___________:_:	 opt: g+
	; ROOM 1   X: :
	;	    : :	  Shield:
	;	    : :	 1: OFF
	;	    : :	 2: ON
	;	    : :	 3: ON
	;           : :
	;	    : :	 P^: 1
        ; __________: :
	;/__________|/

	lda	#$a0
	jsr	clear_top_a
	jsr	clear_bottom

	lda	#<accelerator
	sta	OUTL
	lda	#>accelerator
	sta	OUTH

	jsr	move_and_print_list

	jsr	page_flip


	; cursor down, change g+ to g-

	; FLASH: RUN EXPERIMENT ?
	;				Y


;======================
; Accelerate
;======================
	bit	SET_GR

	lda	#>(collider_ui_rle)
	sta	GBASH
	lda	#<(collider_ui_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip


	; --- Theoretical study ---
	;
	; - Phase 0:
	; INJECTION of particles
	; into synchrotron

	; dark blue going around
	; - Phase 1:
	; Particle ACCELERATION.
	;

	; 5 times around?

	; - Phase 2:
	; EJECTION of particles
	; on the shield.

	; smash on shield

	; A  N  A  L  Y  S  I  S


	; - RESULT:
	; Probability of creating:
	;  ANTIMATTER: 91.V %
	;  NEUTRINO 27:  0.04 %
	;  NEUTRINO 424: 18 %

	; Practical verification Y/N ?

	; THE EXPERIMENT WILL BEGIN IN 20 SECONDS

	; 19, 18, 17


peanut_loop2:
	lda	KEYPRESS
	bpl	peanut_loop2
	bit	KEYRESET


;===============================
;===============================
; Opening Soda
;===============================
;===============================

	lda	#>(soda_bg_rle)
	sta	GBASH
	lda	#<(soda_bg_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<soda_sequence
	sta	INTRO_LOOPL
	lda	#>soda_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


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

	jsr	gr_copy_to_current
	jsr	page_flip

drinking_loop:
	lda	KEYPRESS
	bpl	drinking_loop
	bit	KEYRESET

;===============================
;===============================
; More crazy screen
;===============================
;===============================

	; THE EXPERIMENT WILL BEGIN IN 5  SECONDS

	; Shield 9A.5F Ok
	; Flux % 5.0177 Ok
	; CDI Vector ok
	; %%%ddd ok
	; Race-Track ok
	;    -----REPEAT
	; 4  SECONDS
	; Shield "
	;    -----REPEAT
	; 3 SECONDS
	; Sheild "
	;    -----REPEAT
	; 2 SECONDS
	; 1 SECONDS (at CDI Vector)
	; 0 SECONDS (at %%%)
	; EXPERIMENT LINES GOES AWAY
	; Stop printing at race track
	; dark blue going around track

	lda	#>(collider_ui_rle)
	sta	GBASH
	lda	#<(collider_ui_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip

collider_ui_loop:
	lda	KEYPRESS
	bpl	collider_ui_loop
	bit	KEYRESET


;===============================
;===============================
; Thunderstorm Outside
;===============================
;===============================

	lda	#>(building_car_rle)
	sta	GBASH
	lda	#<(building_car_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip

outside_loop:
	lda	KEYPRESS
	bpl	outside_loop
	bit	KEYRESET


;===============================
;===============================
; Tunnel 1
;===============================
;===============================

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
.include "text_print.s"

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
.include "intro_graphics/04_keypad/intro_approach.inc"
.include "intro_graphics/04_keypad/intro_keypad_bg.inc"
.include "intro_graphics/04_keypad/intro_hands.inc"
.include "intro_graphics/04_keypad/intro_opening.inc"

.include "intro_graphics/05_scanner/intro_scanner.inc"
.include "intro_graphics/05_scanner/intro_scanning.inc"
.include "intro_graphics/05_scanner/intro_ai_bg.inc"
.include "intro_graphics/05_scanner/intro_ai.inc"

.include "intro_graphics/06_console/intro_desktop.inc"
.include "intro_graphics/06_console/intro_cursor.inc"
.include "intro_graphics/06_console/intro_collider_ui.inc"

.include "intro_graphics/07_soda/intro_open_soda.inc"
.include "intro_graphics/07_soda/intro_drinking.inc"


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



	;=================================
	; Display a sequence of images
	; with static overlay

run_sequence_static:
	ldy	#0				; init

run_sequence_static_loop:
	lda	(INTRO_LOOPL),Y			; pause for time
	beq	run_sequence_static_done
	tax
	jsr	long_wait

	iny					; point to overlay

	lda	#8				; set up static loop
	sta	STATIC_LOOPER

	sty	INTRO_LOOPER		; save for later

static_loop:

	lda	(INTRO_LOOPL),Y
	sta	GBASL
	iny
	lda	(INTRO_LOOPL),Y
	sta	GBASH

	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay

	ldy	STATIC_LOOPER
	lda	static_pattern,Y
	sta	GBASL
	lda	static_pattern+1,Y
	sta	GBASH

	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay_noload




	jsr	page_flip

	ldy	INTRO_LOOPER

	ldx	#3
	jsr	long_wait

	dec	STATIC_LOOPER
	dec	STATIC_LOOPER

	bpl	static_loop

	iny
	iny

	jmp	run_sequence_static_loop
run_sequence_static_done:
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
	.byte	20
	.word	walking08_rle
	.byte	0

; Approaching keypad sequence

approach_sequence:
	.byte	20
	.word	approach01_rle
	.byte	20
	.word	approach02_rle
	.byte	20
	.word	approach03_rle
	.byte	20
	.word	approach04_rle
	.byte	20
	.word	approach05_rle
	.byte	20
	.word	approach06_rle
	.byte	20
	.word	approach07_rle
	.byte	80
	.word	approach07_rle
	.byte	0

; Using keypad sequence

keypad_sequence:
	.byte	9
	.word	hand04_01_rle
	.byte	9
	.word	hand04_02_rle
	.byte	9
	.word	hand04_03_rle
	.byte	9
	.word	hand04_02_rle
	.byte	9
	.word	hand05_01_rle
	.byte	9
	.word	hand05_02_rle
	.byte	9
	.word	hand05_03_rle
	.byte	9
	.word	hand05_04_rle
	.byte	9
	.word	hand01_01_rle
	.byte	9
	.word	hand01_02_rle
	.byte	9
	.word	hand01_03_rle
	.byte	9
	.word	hand04_02_rle
	.byte	9
	.word	hand01_02_rle
	.byte	9
	.word	hand01_03_rle
	.byte	9
	.word	hand04_02_rle
	.byte	9
	.word	hand09_01_rle
	.byte	9
	.word	hand09_02_rle
	.byte	9
	.word	hand09_03_rle
	.byte	9
	.word	hand09_04_rle
	.byte	9
	.word	hand09_05_rle
	.byte	9
	.word	hand03_01_rle
	.byte	9
	.word	hand03_02_rle
	.byte	9
	.word	hand03_03_rle
	.byte	9
	.word	hand03_04_rle
	.byte	9
	.word	hand02_01_rle
	.byte	9
	.word	hand02_02_rle
	.byte	9
	.word	hand02_03_rle
	.byte	9
	.word	hand02_04_rle
	.byte	9
	.word	hand02_05_rle
	.byte	12
	.word	hand02_05_rle
	.byte	0


; Door opening sequence

opening_sequence:
	.byte	15
	.word	opening01_rle
	.byte	15
	.word	opening02_rle
	.byte	15
	.word	opening03_rle
	.byte	15
	.word	opening04_rle
	.byte	15
	.word	opening05_rle
	.byte	15
	.word	opening06_rle
	.byte	15
	.word	opening07_rle
	.byte	15
	.word	opening08_rle
	.byte	15
	.word	opening09_rle
	.byte	15
	.word	opening10_rle
	.byte	15
	.word	opening11_rle
	.byte	15
	.word	opening12_rle
	.byte	15
	.word	blank_rle
	.byte	100
	.word	blank_rle
	.byte	0

; Scanning sequence

scanning_sequence:
	.byte	15
	.word	scan01_rle
	.byte	15
	.word	scan02_rle
	.byte	15
	.word	scan03_rle
	.byte	15
	.word	scan04_rle
	.byte	15
	.word	scan05_rle
	.byte	15
	.word	scan06_rle
	.byte	15
	.word	scan07_rle
	.byte	15
	.word	scan08_rle
	.byte	15
	.word	scan09_rle
	.byte	15
	.word	scan10_rle
	.byte	20
	.word	scan11_rle
	.byte	20
	.word	scan12_rle
	.byte	20
	.word	scan13_rle
	.byte	20
	.word	scan14_rle
	.byte	20
	.word	scan15_rle
	.byte	20
	.word	scan16_rle
	.byte	40
	.word	scan17_rle
	.byte	40
	.word	scan18_rle
	.byte	40
	.word	scan19_rle
	.byte	40
	.word	scan19_rle
	.byte	0



; AI sequence

ai_sequence:
	.byte	50
	.word	ai01_rle
	.byte	50
	.word	ai02_rle
	.byte	50
	.word	ai03_rle
	.byte	50
	.word	ai04_rle
	.byte	50
	.word	ai05_rle
	.byte	50
	.word	ai05_rle
	.byte	0

static_pattern:
	.word	blank_rle	; 0
	.word	static01_rle	; 2
	.word	static03_rle	; 4
	.word	static02_rle	; 6
	.word	static01_rle	; 8

; Power-up sequence

powerup_sequence:
	.byte	30
	.word	powerup01_rle
	.byte	20
	.word	powerup02_rle
	.byte	20
	.word	powerup03_rle
	.byte	80
	.word	powerup03_rle
	.byte	0


; Cursor sequence

cursor_sequence:
	.byte	60
	.word	cursor01_rle
	.byte	20
	.word	cursor02_rle
	.byte	20
	.word	cursor03_rle
	.byte	20
	.word	cursor04_rle
	.byte	20
	.word	cursor05_rle
	.byte	20
	.word	cursor06_rle
	.byte	20
	.word	cursor07_rle
	.byte	20
	.word	cursor08_rle
	.byte	60
	.word	cursor08_rle
	.byte	0


peanut:
	.byte 0,2,"COPYRIGHT (C) 1977 PEANUT COMPUTER, INC.",0
	.byte 0,3,"ALL RIGHTS RESERVED.",0
	.byte 0,5,"CDOS VERSION 5.01",0
	.byte 0,18,"> ",0
	.byte 255

accelerator:
	.byte 0,0,  "MODIFICATION OF PARAMETERS",0
	.byte 0,1,  "RELATING TO PARTICLE",0
	.byte 0,2,  "ACCELERATOR (SYNCHOTRON).",0
	.byte 0,3,  " ___________",0
	.byte 0,4,  ":ROOM 3   ",('+'|$80),":\  E: 23%",0
	.byte 0,5,  ":          : : G: .005",0
	.byte 0,6,  ":          : : RK: 77.2L",0
	.byte 0,7,  ":          : :",0
	.byte 0,8,  ":          : : OPT: G+",0
	.byte 0,9,  ":          : :",0
	.byte 0,10, ":__________:_:  SHIELD:",0
	.byte 0,11, ":ROOM 1   ",('+'|$80),": : 1: OFF",0
	.byte 0,12, ":          : : 2: ON",0
	.byte 0,13, ":          : : 3: ON",0
	.byte 0,14, ":          : :",0
	.byte 0,15, ":          : : P^: 1",0
	.byte 0,16, ":          : :",0
	.byte 0,17, ": _________:_:",0
	.byte 0,18, ":/_________:/",0
	.byte 255


; Power-up sequence

soda_sequence:
	.byte	20
	.word	soda01_rle
	.byte	20
	.word	soda02_rle
	.byte	20
	.word	soda03_rle
	.byte	20
	.word	soda04_rle
	.byte	20
	.word	soda05_rle
	.byte	20
	.word	soda06_rle
	.byte	20
	.word	soda07_rle
	.byte	20
	.word	soda08_rle
	.byte	20
	.word	soda09_rle
	.byte	20
	.word	soda09_rle
	.byte	0
