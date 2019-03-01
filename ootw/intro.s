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

	jmp	tunnel1

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

scanner2:

	lda	#>(ai_bg_rle)
	sta	GBASH
	lda	#<(ai_bg_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	clear_bottom
	bit	TEXTGR			; split graphics/text

	jsr	gr_copy_to_current_40x40
	jsr	page_flip

	jsr	clear_bottom

	;=============================
	; Identification (nothing)
	;=============================

	lda	#0
	sta	DNA_OUT
	sta	DNA_PROGRESS

	lda	#<ai_sequence
	sta	INTRO_LOOPL
	lda	#>ai_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence_static

	; slices        / | - / nothing (pause)
	; more slices   / | - / nothing (pause)
	; small circle  / | - / nothing (pause)
	; big circle    / | - / nothing (pause)

;	jsr	gr_copy_to_current_40x40
;	jsr	draw_dna
;	jsr	page_flip

	; approx one rotation until "Good evening"
	; two rotation, then switch to key + Ferrari
	; three rotations, then done

	;                   -   !!! DNA START 1 line
	;                     /   !!! DNA start 1 line
	;                         !!! DNA 2 lines
	; DNA 5 lines
	; Good evening professor.
	; DNA all lines

	; Triggers:
	; + DNA starts midway through big circle
	; + Good evening printed at DNA_OUT=5
	; + Switch to key, print ferrari


	; Key             |
	; I see you have driven here in your \ Ferrari.
	; Key                - / nothing (pause)


	ldx	#35
spin_on_key:
	txa
	pha

	jsr	draw_dna
	jsr	page_flip

	pla
	tax

	lda	#250
	jsr	WAIT

	dex
	bne	spin_on_key

;uz_loop:
;	lda	KEYPRESS
;	bpl	uz_loop
;	bit	KEYRESET

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

	ldx	#80		; pause a bit
	jsr	long_wait

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

	ldx	#40		; pause a bit
	jsr	long_wait


;===============================
; Peanut OS
;===============================

peanutos:

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

	; wait 1s

	ldx	#60
	jsr	long_wait

	lda	#1
	sta	CURSOR_COUNT

project_23_loop:
	; RUN PROJECT 23# (typed)
	; #

	lda	#$a0
	jsr	clear_top_a
	jsr	clear_bottom

	lda	#<peanut
	sta	OUTL
	lda	#>peanut
	sta	OUTH

	jsr	move_and_print_list

	; $550

	lda	#$5
	clc
	adc	DRAW_PAGE
	sta	OUTH
	lda	#$52
	sta	OUTL

	ldy	#0
print_project23_loop:

	lda	project_23,Y
	eor	#$80
	sta	(OUTL),Y

	iny
	cpy	CURSOR_COUNT
	bne	print_project23_loop

	lda	#' '
	sta	(OUTL),Y

	jsr	page_flip

	ldx	#10
	jsr	long_wait

	inc	CURSOR_COUNT
	lda	CURSOR_COUNT
	cmp	#15
	bne	project_23_loop

	ldx	#20			; brief pasue at end of line
	jsr	long_wait

	lda	#(' '|$80)		; clear out last cursor
	sta	(OUTL),Y

	lda	#' '			; put cursor on next line
	sta	$5d2			; both pages
	sta	$9d2


	; wait 1s

	ldx	#100
	jsr	long_wait



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

	; the actual intro draws background 3-d stuff first, gradually
	; then writes text


	lda	#$a0
	jsr	clear_top_a
	jsr	clear_bottom

	lda	#<accelerator
	sta	OUTL
	lda	#>accelerator
	sta	OUTH

	jsr	move_and_print_list

	jsr	page_flip

	ldx	#50
	jsr	long_wait

	; Cusrsor starts at E
	; Down to .005 (pauses)
	; End of RK
	; End of g+ (pauses)
	; erase +
	; change to - (pauses)
	; down to 1 (pauses)
	; down to 2
	; down to 3
	; down to P (pause)

	ldy	#0
	lda	#<accel_paramaters
	sta	INL
	lda	#>accel_paramaters
	sta	INH
accel_input_loop:
	lda	(INL),Y		; get X
	cmp	#$ff
	beq	done_accel_input
	sta	accel_smc+1
	sta	accel_smc+4
	iny
	lda	(INL),Y		; get Y
	sta	accel_smc+2
	clc
	adc	#$4
	sta	accel_smc+5
	iny
	lda	(INL),Y		; get char
	iny
accel_smc:
	sta	$400
	sta	$800

	lda	(INL),Y		; get time
	tax
	jsr	long_wait
	iny
	jmp	accel_input_loop
done_accel_input:


	; FLASH: RUN EXPERIMENT ? (pause)
	;				Y
	lda	#2
	sta	CURSOR_COUNT
flash_loop:

	lda	#<run_experiment
	sta	OUTL
	lda	#>run_experiment
	sta	OUTH
	jsr	print_both_pages

	ldx	#75
	jsr	long_wait

	lda	#<run_blank
	sta	OUTL
	lda	#>run_blank
	sta	OUTH
	jsr	print_both_pages

	ldx	#75
	jsr	long_wait

	lda	CURSOR_COUNT
	cmp	#1
	bne	not_yes

	lda	#'Y'|$80
	sta	$670
	sta	$A70

not_yes:
	dec	CURSOR_COUNT
	bpl	flash_loop


;======================
; Accelerate
;======================
	bit	SET_GR

	lda	#>(collider_rle)
	sta	GBASH
	lda	#<(collider_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip

	bit	TEXTGR
	jsr	clear_bottoms

	; --- Theoretical Study ---
	; make this inverse?

	lda	#<theoretical_study
	sta	OUTL
	lda	#>theoretical_study
	sta	OUTH

	jsr	print_both_pages

	;==========================
	; - Phase 0:
	; INJECTION of particles
	; into synchrotron

	lda	#0
	sta	PARTICLE_COUNT

	lda	#<phase0
	sta	OUTL
	lda	#>phase0
	sta	OUTH

	jsr	move_and_print_list_both_pages

	jsr	gr_copy_to_current_40x40
	jsr	plot_particle
	jsr	page_flip
	ldx	#40
	jsr	long_wait

	jsr	gr_copy_to_current_40x40
	jsr	plot_particle
	jsr	page_flip
	ldx	#40
	jsr	long_wait


	;===========================
	; - Phase 1:
	; Particle ACCELERATION.


	; Note: goes around at least 4 times

	jsr	clear_bottoms

	; --- Theoretical Study ---
	lda	#<theoretical_study
	sta	OUTL
	lda	#>theoretical_study
	sta	OUTH

	jsr	print_both_pages

	lda	#<phase1
	sta	OUTL
	lda	#>phase1
	sta	OUTH

	jsr	move_and_print_list_both_pages

	; 5 times around? (total = 39)

particle_loop:
	jsr	gr_copy_to_current_40x40
	jsr	plot_particle
	jsr	page_flip
	ldx	#20
	jsr	long_wait

	lda	PARTICLE_COUNT
	cmp	#38
	bne	particle_loop

	;=====================================
	; - Phase 2:
	; EJECTION of particles
	; on the shield.

	; Note: goes around once more, then does shield animation

	jsr	clear_bottoms

	; --- Theoretical Study ---
	lda	#<theoretical_study
	sta	OUTL
	lda	#>theoretical_study
	sta	OUTH

	jsr	print_both_pages

	lda	#<phase2
	sta	OUTL
	lda	#>phase2
	sta	OUTH

	jsr	move_and_print_list_both_pages


	jsr	gr_copy_to_current_40x40
	jsr	plot_particle
	jsr	page_flip
	ldx	#20
	jsr	long_wait

	lda	#<shield_sequence
	sta	INTRO_LOOPL
	lda	#>shield_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence_40x40

	ldx	#30
	jsr	long_wait

	;=============================
	; A  N  A  L  Y  S  I  S

	jsr	clear_bottoms

	; --- Theoretical Study ---
	lda	#<theoretical_study
	sta	OUTL
	lda	#>theoretical_study
	sta	OUTH

	jsr	print_both_pages

	lda	#<analysis
	sta	OUTL
	lda	#>analysis
	sta	OUTH

	jsr	print_both_pages

	ldx	#200
	jsr	long_wait

	;=============================
	; - RESULT:
	; Probability of creating:
	; ANTIMATTER: 91.V %
	; NEUTRINO 27:  0.04 %
	; NEUTRINO 424: 18 %

	jsr	clear_bottoms

	lda	#<result
	sta	OUTL
	lda	#>result
	sta	OUTH

	jsr	move_and_print_list_both_pages

	ldx	#200
	jsr	long_wait


	;================================
	; Practical verification Y/N ?"

	jsr	clear_bottoms

	lda	#<practical_verification
	sta	OUTL
	lda	#>practical_verification
	sta	OUTH

	jsr	print_both_pages

	ldx	#200
	jsr	long_wait

	;==========================================
	; THE EXPERIMENT WILL BEGIN IN 20 SECONDS
	; 19, 18, 17

	jsr	gr_copy_to_current_40x40
	jsr	page_flip

	jsr	clear_bottoms

	lda	#<experiment
	sta	OUTL
	lda	#>experiment
	sta	OUTH

	; 20
	jsr	print_both_pages
	ldx	#100
	jsr	long_wait

	; 19
	jsr	print_both_pages
	ldx	#100
	jsr	long_wait

	; 18
	jsr	print_both_pages
	ldx	#100
	jsr	long_wait

	; 17
	jsr	print_both_pages
	ldx	#100
	jsr	long_wait


;===============================
;===============================
; Opening Soda
;===============================
;===============================
soda:
	lda	#>(soda_bg_rle)
	sta	GBASH
	lda	#<(soda_bg_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	bit	FULLGR

	lda	#<soda_sequence
	sta	INTRO_LOOPL
	lda	#>soda_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


;	ldx	#30
;	jsr	long_wait

;open_soda_loop:
;	lda	KEYPRESS
;	bpl	open_soda_loop
;	bit	KEYRESET

;===============================
;===============================
; Drinking Soda
;===============================
;===============================

	lda	#>(drinking02_rle)
	sta	GBASH
	lda	#<(drinking02_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	lda	#<drinking_sequence
	sta	INTRO_LOOPL
	lda	#>drinking_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	ldx	#200
	jsr	long_wait

;drinking_loop:
;	lda	KEYPRESS
;	bpl	drinking_loop
;	bit	KEYRESET

;===============================
;===============================
; More crazy screen
;===============================
;===============================

	lda	#>(collider_rle)
	sta	GBASH
	lda	#<(collider_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	bit	TEXTGR
	jsr	clear_bottoms

	; THE EXPERIMENT WILL BEGIN IN 5  SECONDS
	jsr	gr_copy_to_current_40x40
	jsr	page_flip

	lda	#<experiment
	sta	OUTL
	lda	#>experiment
	sta	OUTH
	jsr	print_both_pages

	lda	#<five
	sta	OUTL
	lda	#>five
	sta	OUTH
	jsr	print_both_pages

	lda	#0
	sta	MESSAGE_COUNT
	sta	MESSAGE_CURRENT
	sta	TIME_COUNT
message_loop:

	; Shield 9A.5F Ok
	; Flux % 5.0177 Ok
	; CDI Vector ok
	; %%%ddd ok
	; Race-Track ok
	;    -----REPEAT	; 10

	ldx	MESSAGE_CURRENT
	lda	message_list,X
	sta	OUTL
	lda	message_list+1,X
	sta	OUTH
	jsr	print_both_pages

	inc	MESSAGE_CURRENT
	inc	MESSAGE_CURRENT
	lda	MESSAGE_CURRENT
	cmp	#10
	bne	not_ten
	lda	#0
	sta	MESSAGE_CURRENT
not_ten:

	; 4  SECONDS
	; Shield "
	;    -----REPEAT	; 10

	; 3 SECONDS
	; Sheild "
	;    -----REPEAT	; 10

	; 2 SECONDS		; 10

	; 1 SECONDS (at CDI Vector)	; 10
	; 0 SECONDS (at %%%)	; 10

	ldx	#10
	jsr	long_wait

	inc	CURSOR_COUNT

	lda	CURSOR_COUNT
	and	#$07
	bne	not_time_oflo

	inc	TIME_COUNT
	inc	TIME_COUNT

	; update seconds

	ldx	TIME_COUNT
	lda	times,X
	sta	OUTL
	lda	times+1,X
	sta	OUTH
	jsr	print_both_pages

not_time_oflo:

	lda	CURSOR_COUNT
	cmp	#42
	bne	not_time_gone

	; clear out when near end
	jsr	clear_bottoms

not_time_gone:

	lda	CURSOR_COUNT
	cmp	#48
	bne	message_loop

	;=============================
	; EXPERIMENT LINES GOES AWAY
	; Stop printing at race track
	; dark blue going around track

	; Note: goes around at least 4 times

	jsr	clear_bottoms

	ldx	#30
	jsr	long_wait

;collider_ui_loop:
;	lda	KEYPRESS
;	bpl	collider_ui_loop
;	bit	KEYRESET



	; 1 times around? (total = 8)

	lda	#0
	sta	PARTICLE_COUNT

particle_loop2:
	jsr	gr_copy_to_current_40x40
	jsr	plot_particle
	jsr	page_flip
	ldx	#20
	jsr	long_wait

	lda	PARTICLE_COUNT
	cmp	#10
	bne	particle_loop2


;collider_ui_loop:
;	lda	KEYPRESS
;	bpl	collider_ui_loop
;	bit	KEYRESET


;===============================
;===============================
; Thunderstorm Outside
;===============================
;===============================

thunderstorm:
	lda	#>(building_car_rle)
	sta	GBASH
	lda	#<(building_car_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip
	bit	FULLGR

	lda	#<lightning_sequence
	sta	INTRO_LOOPL
	lda	#>lightning_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	lda	#<bolt_sequence
	sta	INTRO_LOOPL
	lda	#>bolt_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

;outside_loop:
;	lda	KEYPRESS
;	bpl	outside_loop
;	bit	KEYRESET


;===============================
;===============================
; Tunnel 1
;===============================
;===============================

tunnel1:
	lda	#>(tunnel1_rle)
	sta	GBASH
	lda	#<(tunnel1_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<tunnel1_sequence
	sta	INTRO_LOOPL
	lda	#>tunnel1_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


;tunnel1_loop:
;	lda	KEYPRESS
;	bpl	tunnel1_loop
;	bit	KEYRESET



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

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<tunnel2_sequence
	sta	INTRO_LOOPL
	lda	#>tunnel2_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


;tunnel2_loop:
;	lda	KEYPRESS
;	bpl	tunnel2_loop
;	bit	KEYRESET


;===============================
;===============================
; Zappo / Gone
;===============================
;===============================

	lda	#>(blue_zappo_rle)
	sta	GBASH
	lda	#<(blue_zappo_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	lda	#<zappo_sequence
	sta	INTRO_LOOPL
	lda	#>zappo_sequence
	sta	INTRO_LOOPH


	lda	#>(gone_rle)
	sta	GBASH
	lda	#<(gone_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

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
.include "gr_putsprite.s"
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
.include "intro_graphics/06_console/intro_collider.inc"

.include "intro_graphics/07_soda/intro_open_soda.inc"
.include "intro_graphics/07_soda/intro_drinking.inc"

.include "intro_graphics/08_lightning/lightning.inc"

.include "intro_graphics/09_tunnel/intro_tunnel1.inc"
.include "intro_graphics/09_tunnel/intro_tunnel2.inc"

.include "intro_graphics/10_gone/intro_zappo.inc"
.include "intro_graphics/10_gone/intro_gone.inc"

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



	;====================================
	; Display a sequence of images 40x40

run_sequence_40x40:
	ldy	#0

run_sequence_40x40_loop:
	lda	(INTRO_LOOPL),Y		; get time
	beq	run_sequence_40x40_done
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

	jsr	gr_overlay_40x40
	jsr	page_flip
	ldy	INTRO_LOOPER

	jmp	run_sequence_40x40_loop
run_sequence_40x40_done:
	rts



	;=================================
	; Display a sequence of images
	; with /-|/ static overlay

run_sequence_static:
	ldy	#0				; init

run_sequence_static_loop:

	lda	(INTRO_LOOPL),Y			; draw DNA
	sta	DNA_OUT
	iny

	lda	(INTRO_LOOPL),Y			; pause for time
	beq	run_sequence_static_done
	tax

	lda	DNA_OUT
	bne	pause_draw_dna

	jsr	long_wait
	jmp	done_pause_dna
pause_draw_dna:
	txa
	pha

	tya
	pha

	jsr	draw_dna
	jsr	page_flip

	pla
	tay

	pla
	tax

	lda	#250
	jsr	WAIT

	dex
	bne	pause_draw_dna

done_pause_dna:

	iny					; point to overlay

	lda	#10				; set up static loop
	sta	STATIC_LOOPER

	sty	INTRO_LOOPER			; save for later

static_loop:

	lda	(INTRO_LOOPL),Y
	sta	GBASL
	iny
	lda	(INTRO_LOOPL),Y
	sta	GBASH

	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay_40x40

	ldy	STATIC_LOOPER
	lda	static_pattern,Y
	sta	GBASL
	lda	static_pattern+1,Y
	sta	GBASH

	lda	#$10			; load to $1000
	jsr	load_rle_gr


	; force 40x40 overlay

	jsr	gr_overlay_40x40_noload

	lda	DNA_OUT
	beq	no_dna

	jsr	draw_dna

no_dna:
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
	.byte	0,50		; pause at start, no dna
	.word	ai01_rle	; slices

	.byte	0,50		; pause at start, no dna
	.word	ai02_rle	; slices_zoom

	.byte	0,50		; pasue as start, no dna
	.word	ai03_rle	; little circle

	.byte	0,50		; pause at start, no dna
	.word	ai04_rle	; big circle

	.byte	1,20		; pause longer, yes dna
	.word	ai05_rle	; key

	.byte	0,0
;	.word	ai05_rle	; key
;	.byte	0

static_pattern:
	.word	blank_rle	; 0
	.word	blank_rle	; 2
	.word	static01_rle	; 4
	.word	static03_rle	; 6
	.word	static02_rle	; 8
	.word	static01_rle	; 10

; Power-up sequence

powerup_sequence:
	.byte	20
	.word	powerup01_rle
	.byte	60
	.word	powerup02_rle
	.byte	20
	.word	powerup03_rle
	.byte	20
	.word	powerup03_rle
	.byte	0


; Cursor sequence

cursor_sequence:
	.byte	60
	.word	cursor01_rle
	.byte	40
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
	.byte 0,18,"> ",(' '|$80),0
	.byte 255
project_23:
	.byte "RUN PROJECT 23",0

accelerator:
	.byte 0,0,  "MODIFICATION OF PARAMETERS",0
	.byte 0,1,  "RELATING TO PARTICLE",0
	.byte 0,2,  "ACCELERATOR (SYNCHOTRON).",0
	.byte 0,3,  " ___________",0
	.byte 0,4,  ":ROOM 3   ",('+'|$80),":\  E: 23%",0
	.byte 0,5,  ":          : : G: .005",0
	.byte 0,6,  ": :        : : RK: 77.2L",0
	.byte 0,7,  ":          : :",0
	.byte 0,8,  ":          : : OPT: G+",0
	.byte 0,9,  ": :        : :",0
	.byte 0,10, ":__________:_:  SHIELD:",0
	.byte 0,11, ":ROOM 1   ",('+'|$80),": : 1: OFF",0
	.byte 0,12, ": :        : : 2: ON",0
	.byte 0,13, ":          : : 3: ON",0
	.byte 0,14, ": :        : :",0
	.byte 0,15, ":          : : P^: 1",0
	.byte 0,16, ": :        : :",0
	.byte 0,17, ": _________:_:",0
	.byte 0,18, ":/_________:/",0
	.byte 255


; Power-up sequence

soda_sequence:
	.byte	1
	.word	soda01_rle
	.byte	30
	.word	soda02_rle
	.byte	15
	.word	soda03_rle
	.byte	15
	.word	soda04_rle
	.byte	15
	.word	soda05_rle
	.byte	15
	.word	soda06_rle
	.byte	15
	.word	soda07_rle
	.byte	15
	.word	soda08_rle
	.byte	15
	.word	soda09_rle
	.byte	20
	.word	soda09_rle
	.byte	0



	; Scanning text

good_evening:
	.byte 2,21,"GOOD EVENING PROFESSOR.",0
ferrari:
	.byte 2,21,"I SEE YOU HAVE DRIVEN HERE IN YOUR",0
	.byte 2,22,"FERRARI.",0




	;====================================
	; Draw DNA
	;====================================
draw_dna:

	lda	#0	; count
	sta	DNA_COUNT

draw_dna_loop:
	clc
	lda	DNA_COUNT
	adc	#10
	sta	YPOS

	lda     #26
        sta     XPOS

	lda	DNA_COUNT		; 0, 4, 8, 12, 16....
	lsr
	clc
	adc	DNA_PROGRESS		; 0,2,4,6,8,...

	and	#$e
	tax

	lda	dna_list,X
	sta	INL
	lda     dna_list+1,X
	sta	INH

	jsr	put_sprite

	lda	DNA_COUNT
	clc
	adc	#4
	sta	DNA_COUNT

	; for DNA_PROGRESS 0,2,4,6,8,10,12 we only want to print
	; first X lines (gradually fade in)
	; after that, draw the whole thing

	lda	DNA_PROGRESS
	cmp	#14
	bpl	dna_full

	asl
	cmp	DNA_COUNT
	bpl	draw_dna_loop
	bmi	dna_full_done

dna_full:
	lda	DNA_COUNT
	cmp	#28
	bne	draw_dna_loop

dna_full_done:

	inc	DNA_PROGRESS
	inc	DNA_PROGRESS

	; see if printing message
	lda	DNA_PROGRESS
	cmp	#10
	bne	no_good_message

	lda	#<good_evening
	sta	OUTL
	lda	#>good_evening
	sta	OUTH
	jsr	print_both_pages
	jmp	no_ferrari_message

no_good_message:
	cmp	#$30
	bne	no_ferrari_message

	lda	#<ferrari
	sta	OUTL
	lda	#>ferrari
	sta	OUTH
	jsr	print_both_pages
	jsr	print_both_pages


no_ferrari_message:
	rts

dna_list:
	.word dna0_sprite
	.word dna1_sprite
	.word dna2_sprite
	.word dna3_sprite
	.word dna4_sprite
	.word dna5_sprite
	.word dna6_sprite
	.word dna7_sprite

dna0_sprite:
	.byte   $7,$2
	.byte   $66,$40,$40,$40,$40,$40,$cc
	.byte   $06,$00,$00,$00,$00,$00,$0c

dna1_sprite:
	.byte   $7,$2
	.byte   $00,$66,$40,$40,$40,$cc,$00
	.byte   $00,$06,$00,$00,$00,$0c,$00

dna2_sprite:
	.byte   $7,$2
	.byte   $00,$00,$66,$40,$cc,$00,$00
	.byte   $00,$00,$06,$00,$0c,$00,$00

dna3_sprite:
	.byte   $7,$2
	.byte   $00,$00,$00,$66,$00,$00,$00
	.byte   $00,$00,$00,$06,$00,$00,$00

dna4_sprite:
	.byte   $7,$2
	.byte   $00,$00,$CC,$40,$66,$00,$00
	.byte   $00,$00,$0C,$00,$06,$00,$00

dna5_sprite:
	.byte   $7,$2
	.byte   $00,$CC,$40,$40,$40,$66,$00
	.byte   $00,$0C,$00,$00,$00,$06,$00

dna6_sprite:
	.byte   $7,$2
	.byte   $CC,$40,$40,$40,$40,$40,$66
	.byte   $0C,$00,$00,$00,$00,$00,$06

dna7_sprite:
	.byte   $7,$2
	.byte   $66,$40,$40,$40,$40,$40,$cc
	.byte   $06,$00,$00,$00,$00,$00,$0c



accel_paramaters:
	.byte	$15,$6,' ',20		; 21,4 = $615 Cursor starts at E
	.byte	$15,$6,' '|$80,1	;             Cusrsor off at E
	.byte	$96,$6,' ',100		; 22,5 = $696 Down to .005 (pauses)
	.byte	$96,$6,' '|$80,1	;             off
	.byte	$18,$7,' ',20		; 24,6 = $718 End of RK
	.byte	$18,$7,' '|$80,1	;             off
	.byte	$3E,$4,' ',100		; 22,8 = $43E End of g+ (pauses)
	.byte	$3E,$4,' '|$80,1	;             off
	.byte	$3D,$4,' ',20		; 21,8 = $43D erase +
	.byte	$3D,$4,'-'|$80,1	;             change to - (pauses)
	.byte	$3E,$4,' ',100		; 22,8 = $43e change to - (pauses)
	.byte	$3E,$4,' '|$80,1	;             off
	.byte	$BD,$5,' ',100		; 22,11= $5bd down to 1 (pauses)
	.byte	$BD,$5,' '|$80,1	;             off
	.byte	$3C,$6,' ',20		; 21,12= $63c down to 2
	.byte	$3C,$6,' '|$80,1	;             off
	.byte	$BC,$6,' ',20		; 21,13= $6bc down to 3
	.byte	$BC,$6,' '|$80,1	;             off
	.byte	$BC,$7,' ',20		; 21,15= $7bc down to P (pause)
	.byte	$BC,$7,' '|$80,1	;             off
	.byte	$ff


	; FLASH: RUN EXPERIMENT ? (pause)
run_experiment:
	.byte 10,20,"RUN EXPERIMENT ?",0
run_blank:
	.byte 10,20,"                ",0

;'R'|$80,'U'|$80,'N'|$80,' '|$80
;	.byte 10,20,'R'|$80,'U'|$80,'N'|$80,' '|$80
;	.byte 'E'|$80,'X'|$80,'P'|$80,'E'|$80,'R'|$80,'I'|$80
;	.byte 'M'|$80,'E'|$80,'N'|$80,'T'|$80,' '|$80,'?'|$80,0




	; --- Theoretical Study ---
	; make this inverse?
theoretical_study:
	.byte 7,20,"--- THEORETICAL STUDY ---",0

	; - Phase 0:
	; INJECTION of particles
	; into synchrotron
phase0:
	.byte 0,21,"- PHASE 0:",0
	.byte 0,22,"INJECTION OF PARTICLES",0
	.byte 0,23,"INTO SYNCHROTRON",0
	.byte $ff

	; - Phase 1:
	; Particle ACCELERATION.
phase1:
	.byte 0,21,"- PHASE 1:",0
	.byte 0,22,"PARTICLE ACCELERATION.",0
	.byte $ff

	; - Phase 2:
	; EJECTION of particles
	; on the shield.
phase2:
	.byte 0,21,"- PHASE 2:",0
	.byte 0,22,"EJECTION OF PARTICLES",0
	.byte 0,23,"ON THE SHIELD.",0
	.byte $ff

	; A  N  A  L  Y  S  I  S
analysis:
	.byte 8,22,"A  N  A  L  Y  S  I  S",0

	; - RESULT:
	; Probability of creating:
	; ANTIMATTER: 91.V %
	; NEUTRINO 27:  0.04 %
	; NEUTRINO 424: 18 %
result:
	.byte 0,20,"- RESULT, PROBABILITY OF CREATING:",0
	.byte 10,21,"ANTIMATTER: 91.V %",0
	.byte 10,22,"NEUTRINO 27:  0.04 %",0
	.byte 10,23,"NEUTRINO 424: 18 %",0
	.byte $ff

	; Practical verification Y/N ?"
practical_verification:
	.byte 6,21,"PRACTICAL VERIFICATION Y/N ?",0

	; THE EXPERIMENT WILL BEGIN IN 20 SECONDS
experiment:
	.byte 0,20,"THE EXPERIMENT WILL BEGIN IN 20 SECONDS",0
	.byte 29,20,"19",0
	.byte 29,20,"18",0
	.byte 29,20,"17",0


	; Particle co-ordinates
particles:
	.byte	21,23	; 0
	.byte	21,15	; 1
	.byte 	22,7	; 2
	.byte	27,2	; 3
	.byte 	32,6	; 4
	.byte	34,13	; 5
	.byte 	31,26	; 6
	.byte 	27,28	; 7

	;======================
	; plot particle
	;======================
plot_particle:
	; Xcoord in X
        ; Ycoord in A
        ; color in COLOR

	lda	#$22
	sta	COLOR

	lda	PARTICLE_COUNT
	and	#7
	asl
	tay
	ldx	particles,Y
	lda	particles+1,Y

	jsr	plot

	inc	PARTICLE_COUNT

	rts



shield_sequence:
	.byte 30
	.word collider_p200_rle
	.byte 30
	.word collider_p201_rle
	.byte 30
	.word collider_p202_rle
	.byte 30
	.word collider_p203_rle
	.byte 30
	.word collider_p200_rle
	.byte 0


message0:
	.byte	8,22,"SHIELD 9A.5F OK ",0
message1:
	.byte	8,22,"FLUX % 5.0177 OK",0
message2:
	.byte	8,22,"CDI VECTOR OK   ",0
message3:
	.byte	8,22,"%%%DDD OK       ",0
message4:
	.byte	8,22,"RACE-TRACK OK   ",0

message_list:
	.word	message0
	.word	message1
	.word	message2
	.word	message3
	.word	message4


five:
	.byte 29,20,"5 ",0
four:
	.byte 29,20,"4 ",0
three:
	.byte 29,20,"3 ",0
two:
	.byte 29,20,"2 ",0
one:
	.byte 29,20,"1 ",0
zero:
	.byte 29,20,"0 ",0

times:
	; note, the second zero is there because we get a TIME_COUNT
	; of 6 even though it is printed then erased (but never displayed)
	.word five,four,three,two,one,zero,zero



drinking_sequence:
	.byte 30
	.word drinking02_rle
	.byte 30
	.word drinking03_rle
	.byte 30
	.word drinking04_rle
	.byte 30
	.word drinking05_rle
	.byte 0




	; Lightning sequence
lightning_sequence:
	; 125 start
	; 126, small central lightning 1,2,3,4
	;
	.byte 100
	.word storm01_rle
	.byte 7
	.word storm02_rle
	.byte 7
	.word storm03_rle
	.byte 7
	.word storm04_rle
	.byte 7
	; 128.2 center glow in cloud 5,6,5
	;
	.word nothing_rle
	.byte 100
	.word storm05_rle
	.byte 7
	.word storm06_rle
	.byte 7
	.word storm05_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 128.7 inverse flash
	;
	.word flash_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 129.6 center left glow in cloud 8
	;
	.word storm08_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 130.1 glow in cloud, right 9
	;
	.word storm09_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 130.4 glow in cloud, right 10
	;
	.word storm10_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 131.7 small glow, center right 11,12
	;
	.word storm11_rle
	.byte 7
	.word storm12_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 133.5 lightning bolt right 13,14,15,16
	;
	.word storm13_rle
	.byte 7
	.word storm14_rle
	.byte 7
	.word storm15_rle
	.byte 7
	.word storm16_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 134.7 glow center left 8
	;
	.word storm08_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 135.2 small glow center 5,6,5
	;
	.word storm05_rle
	.byte 7
	.word storm06_rle
	.byte 7
	.word storm05_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 135.4 inverse flash
	;
	.word flash_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 135.8 another inverse flash
	;
	.word flash_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 135.5 glow right 9
	;
	.word storm09_rle
	.byte 7
	.word nothing_rle
	.byte 40
	; 136 small glow right 0
	;
	.word storm10_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 138.6 cloud glow 12,11,12
	;
	.word storm12_rle
	.byte 7
	.word storm11_rle
	.byte 7
	.word storm12_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 139.6 small bolt center 1,2,3,4
	;
	.word storm01_rle
	.byte 7
	.word storm02_rle
	.byte 7
	.word storm03_rle
	.byte 7
	.word storm04_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 141.4 right glow in cloud 10
	;
	.word storm10_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 143 glow in center 5,6,5
	;
	.word storm05_rle
	.byte 7
	.word storm06_rle
	.byte 7
	.word storm05_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 144.8 glow left 8
	;
	.word storm08_rle
	.byte 7
	.word nothing_rle
	.byte 80
	; 145.7 center glow cloud 11,12
	;
	.word storm11_rle
	.byte 7
	.word storm12_rle
	.byte 7
	.word nothing_rle
	.byte 0
	.word nothing_rle

	;==============
	; split, as was > 256

bolt_sequence:
	.byte 80
	;=======================
	; 147 bolt right
	;=======================
	;	13,14,15
	.word storm13_rle
	.byte 5
	.word storm14_rle
	.byte 5
	.word storm15_rle
	.byte 5
	; 	screen goes white
	;	*all white
	.word white_rle
	.byte 8
	;	lightning animation
	;	* bolt1, 2,3,4,5,6,7
	.word bolt1_rle
	.byte 5
	.word bolt2_rle
	.byte 5
	.word bolt3_rle
	.byte 5
	.word bolt4_rle
	.byte 5
	.word bolt5_rle
	.byte 5
	.word bolt6_rle
	.byte 5
	.word bolt7_rle
	.byte 5
	;	* all white (a while)
	.word white_rle
	.byte 30
	; 	* all black (a while)
	.word black_rle
	.byte 30
	; 148.3 big bolt behind car
	;	29 .. 38, 40.. 42 (38 twice as long?)
	.word storm29_rle
	.byte 5
	.word storm30_rle
	.byte 5
	.word storm31_rle
	.byte 5
	.word storm32_rle
	.byte 5
	.word storm33_rle
	.byte 5
	.word storm34_rle
	.byte 5
	.word storm35_rle
	.byte 5
	.word storm36_rle
	.byte 5
	.word storm37_rle
	.byte 5
	.word storm38_rle
	.byte 5
	.word storm40_rle
	.byte 5
	.word storm41_rle
	.byte 5
	.word storm42_rle
	.byte 5
	; by 150 faded out and on to tunnel
	.word nothing_rle
	.byte 0
	.word nothing_rle


	;=======================
	; Tunnel1 Sequence
	;=======================
tunnel1_sequence:
	.byte 10
	.word nothing_rle
	.byte 50
	; red blob
	.word tunnel1_01_rle
	.byte 2
	.word tunnel1_02_rle
	.byte 2
	.word tunnel1_03_rle
	.byte 2
	.word tunnel1_04_rle
	.byte 2
	.word tunnel1_05_rle
	.byte 2

	; lightning blob
	.word nothing_rle
	.byte 50
	.word tunnel1_06_rle
	.byte 2
	.word tunnel1_07_rle
	.byte 2
	.word white_rle
	.byte 2
	.word tunnel1_08_rle
	.byte 2
	.word tunnel1_09_rle
	.byte 2
	.word tunnel1_10_rle
	.byte 2
	.word tunnel1_11_rle
	.byte 2
	.word tunnel1_12_rle
	.byte 2
	.word tunnel1_13_rle
	.byte 2
	.word tunnel1_14_rle
	.byte 2
	.word tunnel1_15_rle
	.byte 2
	.word tunnel1_16_rle
	.byte 2
	.word tunnel1_17_rle
	.byte 2
	.word tunnel1_18_rle
	.byte 2
	.word tunnel1_19_rle
	.byte 2
	.word nothing_rle
	.byte 0
	.word nothing_rle


	;=======================
	; Tunnel2 Sequence
	;=======================
tunnel2_sequence:
	.byte 10
	.word nothing_rle
	.byte 50
	; red blob
	.word tunnel2_01_rle
	.byte 2
	.word tunnel2_02_rle
	.byte 2
	.word tunnel2_03_rle
	.byte 2
	.word tunnel2_04_rle
	.byte 2
	.word tunnel2_05_rle
	.byte 2
	.word tunnel2_06_rle
	.byte 2
	.word tunnel2_07_rle
	.byte 2
	.word tunnel2_08_rle
	.byte 2
	.word tunnel2_09_rle
	.byte 2
	.word nothing_rle
	.byte 50

	; lightning blob
	.word tunnel2_10_rle
	.byte 2
	.word tunnel2_11_rle
	.byte 2
	.word tunnel2_12_rle
	.byte 2
	.word tunnel2_13_rle
	.byte 2
	.word tunnel2_14_rle
	.byte 2
	.word tunnel2_15_rle
	.byte 2
	.word tunnel2_16_rle
	.byte 2
	.word tunnel2_17_rle
	.byte 2
	.word nothing_rle
	.byte 0
	.word nothing_rle

	;=======================
	; Zappo Sequence
	;=======================
zappo_sequence:

	.byte 50
	.word white_rle
	.byte 20
	.word zappo01_rle	; B
	.byte 20
	.word zappo02_rle	; B
	.byte 20
	.word zappo03_rle	; A
	.byte 20
	.word zappo04_rle	; B
	.byte 20
	.word zappo05_rle	; B
	.byte 20
	.word zappo06_rle	; A
	.byte 20
	.word zappo07_rle	; B
	.byte 20
	.word zappo08_rle	; B
	.byte 20
	.word zappo09_rle	; A
	.byte 20
	.word zappo10_rle	; B
	.byte 20
	.word zappo11_rle	; A
	.byte 20
	.word zappo12_rle	; B
	.byte 20
	.word zappo13_rle	; B
	.byte 20
	.word zappo14_rle	; B
	.byte 20
	.word zappo15_rle	; A
	.byte 20
	.word zappo16_rle	; B
	.byte 20
	.word zappo17_rle	; B
	.byte 20
	.word white_rle
	.byte 20
	.word black_rle
	.byte 20
	.word white_rle
	.byte 20
	.word black_rle
	.byte 20
	.word white_rle
	.byte 20
	.word black_rle
	.byte 20
	.word white_rle
	.byte 20
	.word black_rle
	.byte 20
	.word white_rle
	.byte 20
	.word black_rle
	.byte 0
	.word nothing_rle
