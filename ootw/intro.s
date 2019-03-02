.define HACK 1


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

;	jmp	tunnel1

;===============================
;===============================
; Opening scene with car
;===============================
;===============================


	;==================================
	; draw the car driving up
	;==================================
	; draw getting out of the car

	lda	#<building_sequence
	sta	INTRO_LOOPL
	lda	#>building_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence


;===============================
;===============================
; Walk into door
;===============================
;===============================

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
	lda	#$10			; load also to off-screen $1000
	jsr	load_rle_gr


	jsr	gr_copy_to_current

	lda	#$66
	sta	COLOR

	; elevator outer door

	ldx	#39
	stx	V2
	ldx	#4
	ldy	#14
	jsr	vlin	; VLIN 4,39 AT 14 (X, V2 at Y)

	ldx	#35
	stx	V2
	ldx	#7
	ldy	#18
	jsr	vlin	; VLIN 7,35 AT 18 (X, V2 at Y)

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
	cmp	#37
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
	; Load elevator background

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
	; draw keypad sequence

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

	;=========================
	; zappo

	lda	#>(blue_zappo_rle)
	sta	GBASH
	lda	#<(blue_zappo_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<zappo_sequence
	sta	INTRO_LOOPL
	lda	#>zappo_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	;======================
	; gone
.if HACK
	lda	#>(gone_rle)
	sta	GBASH
	lda	#<(gone_rle)
	sta	GBASL
	lda	#$c			; load to off-screen $c00
	jsr	load_rle_gr

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<gone_sequence
	sta	INTRO_LOOPL
	lda	#>gone_sequence
	sta	INTRO_LOOPH


	jsr	run_sequence
.endif

gone_loop:
	lda	KEYPRESS
	bpl	gone_loop
	bit	KEYRESET


	rts


.include "gr_pageflip.s"
.include "gr_unrle.s"
;.include "lz4_decode.s"
;load_rle_gr:
.include "gr_copy.s"
.include "gr_offsets.s"
.include "gr_overlay.s"
.include "gr_vlin.s"
.include "gr_plot.s"
.include "gr_fast_clear.s"
.include "gr_putsprite.s"
.include "text_print.s"

.include "intro_data.s"



	;=================================
	; Display a sequence of images

	; pattern is TIME, PTR
	; if time==0, then done
	; if time==255, reload $C00 with PTR
	; if time==0..127 wait TIME, then overlay PTR over $C00
	; if time==128..254, wait TIME-128, then overlay GBASL over $C00

run_sequence:
	ldy	#0

run_sequence_loop:
	lda	(INTRO_LOOPL),Y		; get time
	beq	run_sequence_done	; if zero, then done

	cmp	#$ff			; if $ff, then load image to $c00
	bne	not_reload

reload_image:
	iny
	lda	(INTRO_LOOPL),Y
	sta	GBASL
	iny
	lda	(INTRO_LOOPL),Y
	sta	GBASH
	iny
	sty	INTRO_LOOPER		; save for later
	lda	#$0c			; load to $c00
	jsr	load_rle_gr
	jmp	seq_stuff

not_reload:
	tax
	cmp	#$80			;if negative, no need to load pointer
	bcs	no_set_image_ptr	; bge (branch if greater equal)


get_image_ptr:
	iny
	lda	(INTRO_LOOPL),Y
	sta	GBASL
	iny
	lda	(INTRO_LOOPL),Y
	sta	GBASH

no_set_image_ptr:
	txa
	and	#$7f
	tax
	cpx	#1
	beq	seq_no_wait

	jsr	long_wait
seq_no_wait:

	iny
	sty	INTRO_LOOPER		; save for later
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip
seq_stuff:
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



	;======================
	; Plot particle
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





