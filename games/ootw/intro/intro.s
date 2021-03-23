;==========================
; OOTW -- The Famous Intro
;==========================

.include "../zp.inc"
.include "../hardware.inc"

intro:
	lda	#0
	sta	INTRO_REPEAT		; by default, don't repeat
	bit	KEYRESET		; clear keyboard buffer

repeat_intro:
	;===========================
	; Enable graphics

	bit	LORES			; 40x40 lo-res
	bit	SET_GR
	bit	FULLGR			; full screen

	;===========================
	; Setup pages

	lda	#4			; page to draw
	sta	DRAW_PAGE
	lda	#0			; page to display
	sta	DISP_PAGE

;	jmp	tunnel1			; debug, skip ahead

	;===============================
	; Opening scene with car

	jsr	intro_01_building

	;===============================
	; Walking to door

	jsr	intro_02_outer_door

	;===============================
	; Elevator

	jsr	intro_03_elevator

	;===============================
	; Keypad

	jsr	intro_04_keypad



;===============================
;===============================
; Scanner
;===============================
;===============================

scanner:
	lda	#<(intro_scanner_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(intro_scanner_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

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
	lda	#<(ai_bg_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(ai_bg_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

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



;===============================
; Sitting at Desk
;===============================

	;======================
	; load bg

	lda	#<(desktop_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(desktop_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

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

	lda	#<(desktop_bg_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(desktop_bg_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

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

	lda	#<(collider_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(collider_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

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
	lda	#<(soda_bg_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(soda_bg_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

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

	lda	#<(drinking02_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(drinking02_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

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

	lda	#<(collider_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(collider_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

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

	lda	#<(intro_building_car_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(intro_building_car_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

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

	lda	#<(tunnel1_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(tunnel1_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

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

	lda	#<(tunnel2_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(tunnel2_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

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

	lda	#<(blue_zappo_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(blue_zappo_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<zappo_sequence
	sta	INTRO_LOOPL
	lda	#>zappo_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

	;======================
	; gone

	lda	#<(gone_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(gone_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<gone_sequence
	sta	INTRO_LOOPL
	lda	#>gone_sequence
	sta	INTRO_LOOPH


	jsr	run_sequence

	;======================
	; Pause a bit

	ldx	#180
	jsr	long_wait

;gone_loop:
;	lda	KEYPRESS
;	bpl	gone_loop
;	bit	KEYRESET

	; see if R pressed, if so, repeat
	; otherwise, return and indicate we want to start the game

	lda	KEYPRESS
	bpl	check_repeat	; if no keypress, jump ahead

	and	#$7f		; clear high bit

	cmp	#'R'
	bne	check_repeat

	lda	INTRO_REPEAT
	eor	#$1
	sta	INTRO_REPEAT


check_repeat:
	bit	KEYRESET	; reset keyboard strobe
	lda	INTRO_REPEAT
	beq	done_intro

	jmp	repeat_intro

done_intro:
	lda	#1		; start game
	sta	WHICH_LOAD

	rts


.include "../gr_pageflip.s"
;.include "../gr_unrle.s"
;.include "../lz4_decode.s"
.include "../decompress_fast_v2.s"
.include "../gr_copy.s"
.include "../gr_offsets.s"
.include "../gr_overlay.s"
.include "../gr_vlin.s"
.include "../gr_plot.s"
.include "../gr_fast_clear.s"
.include "../gr_putsprite.s"
.include "../text_print.s"
.include "gr_run_sequence.s"


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
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	iny
	lda	(INTRO_LOOPL),Y
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$10			; load to $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay_40x40

	ldy	STATIC_LOOPER
	lda	static_pattern,Y
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	static_pattern+1,Y
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$10			; load to $1000
	jsr	decompress_lzsa2_fast


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




DATA_LOCATION	=	$9000


; intro4,intro5

.if 0
opening_sequence  =	(DATA_LOCATION+$204E)
keypad_sequence   =	(DATA_LOCATION+$1FF3)
keypad_lzsa        =	(DATA_LOCATION+$0496)
approach_sequence =	(DATA_LOCATION+$1FE6)
scanner_door_lzsa  =	(DATA_LOCATION+$0000)

ferrari		  =	(DATA_LOCATION+$2D47)
good_evening	  =	(DATA_LOCATION+$2D2D)
dna_list	  =	(DATA_LOCATION+$2D77)
static_pattern	  =	(DATA_LOCATION+$2D21)
ai_sequence	  =	(DATA_LOCATION+$2D0B)
ai_bg_lzsa	  =	(DATA_LOCATION+$2744)
scanning_sequence =	(DATA_LOCATION+$2CF2)
scanner_lzsa       =	(DATA_LOCATION+$2063)
.endif
intro4_data_lzsa:
;	.incbin "intro_data_04.lzsa"
	.include "intro_data_04.s"

; intro6,intro7

.if 0
experiment		= (DATA_LOCATION+$0D2C)
practical_verification	= (DATA_LOCATION+$0D0D)
result			= (DATA_LOCATION+$0CA6)
analysis		= (DATA_LOCATION+$0C8D)
shield_sequence		= (DATA_LOCATION+$0D75)
phase2			= (DATA_LOCATION+$0C56)
phase1			= (DATA_LOCATION+$0C2F)
phase0			= (DATA_LOCATION+$0BF5)
particles		= (DATA_LOCATION+$0D65)
theoretical_study	= (DATA_LOCATION+$0BD9)
collider_lzsa		= (DATA_LOCATION+$06D8)
run_blank		= (DATA_LOCATION+$0BC6)
run_experiment		= (DATA_LOCATION+$0BB3)
accel_paramaters	= (DATA_LOCATION+$0B62)
accelerator		= (DATA_LOCATION+$09C1)
project_23		= (DATA_LOCATION+$09B2)
peanut			= (DATA_LOCATION+$0955)
cursor_sequence		= (DATA_LOCATION+$0947)
desktop_bg_lzsa		= (DATA_LOCATION+$0242)
powerup_sequence	= (DATA_LOCATION+$093E)
desktop_lzsa		= (DATA_LOCATION+$0000)

times			= (DATA_LOCATION+$0E0C)
message_list		= (DATA_LOCATION+$0DE4)
five			= (DATA_LOCATION+$0DEE)
drinking_sequence	= (DATA_LOCATION+$1C29)
drinking02_lzsa		= (DATA_LOCATION+$1705)
soda_sequence		= (DATA_LOCATION+$1C1A)
soda_bg_lzsa		= (DATA_LOCATION+$0E1A)
.endif

intro6_data_lzsa:
;	.incbin "intro_data_06.lzsa"
	.include "intro_data_06.s"

; intro8
.if 0
bolt_sequence		= (DATA_LOCATION+$1484)
lightning_sequence	= (DATA_LOCATION+$13D2)
building_car_lzsa	= (DATA_LOCATION+$1259)
.endif
intro8_data_lzsa:
;	.incbin "intro_data_08.lzsa"
	.include "intro_data_08.s"

; intro9, intro10
.if 0
gone_sequence		= (DATA_LOCATION+$2C66)
gone_lzsa		= (DATA_LOCATION+$2039)
zappo_sequence		= (DATA_LOCATION+$2C1B)
blue_zappo_lzsa		= (DATA_LOCATION+$1737)
tunnel2_sequence	= (DATA_LOCATION+$1718)
tunnel2_lzsa		= (DATA_LOCATION+$0B0F)
tunnel1_sequence	= (DATA_LOCATION+$16F2)
tunnel1_lzsa		= (DATA_LOCATION+$0000)
.endif
intro9_data_lzsa:
;	.incbin "intro_data_09.lzsa"
	.include "intro_data_09.s"



	;========================
	; load all the sub-parts
	;========================

	.include "intro_01_building.s"
	.include "intro_02_outer_door.s"
	.include "intro_03_elevator.s"
	.include "intro_04_keypad.s"
