;==============================
; OOTW -- Intro -- The Console
;==============================

intro_06_console_part1:

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


	rts




intro_06_console_part2:



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



;=================================
;=================================
; Intro Segment 06 Data (Console)
;=================================
;=================================

.include "graphics/06_console/intro_desktop.inc"
.include "graphics/06_console/intro_cursor.inc"
.include "graphics/06_console/intro_collider.inc"


; Power-up sequence

powerup_sequence:
	.byte	20
	.word	powerup01_lzsa
	.byte	128+60	;	.word	powerup02_lzsa
	.byte	128+20	;	.word	powerup03_lzsa
	.byte	20
	.word	powerup03_lzsa
	.byte	0


; Cursor sequence

cursor_sequence:
	.byte	60
	.word	cursor01_lzsa
	.byte	128+40	;	.word	cursor02_lzsa
	.byte	128+20	;	.word	cursor03_lzsa
	.byte	128+20	;	.word	cursor04_lzsa
	.byte	128+20	;	.word	cursor05_lzsa
	.byte	128+20	;	.word	cursor06_lzsa
	.byte	128+20	;	.word	cursor07_lzsa
	.byte	128+20	;	.word	cursor08_lzsa
	.byte	60
	.word	cursor08_lzsa
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


shield_sequence:
	.byte 30
	.word collider_p200_lzsa
	.byte 30
	.word collider_p201_lzsa
	.byte 30
	.word collider_p202_lzsa
	.byte 30
	.word collider_p203_lzsa
	.byte 30
	.word collider_p200_lzsa
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
