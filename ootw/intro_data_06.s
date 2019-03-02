; background graphics

.include "intro_graphics/06_console/intro_desktop.inc"
.include "intro_graphics/06_console/intro_cursor.inc"
.include "intro_graphics/06_console/intro_collider.inc"


; Power-up sequence

powerup_sequence:
	.byte	20
	.word	powerup01_rle
	.byte	128+60	;	.word	powerup02_rle
	.byte	128+20	;	.word	powerup03_rle
	.byte	20
	.word	powerup03_rle
	.byte	0


; Cursor sequence

cursor_sequence:
	.byte	60
	.word	cursor01_rle
	.byte	128+40	;	.word	cursor02_rle
	.byte	128+20	;	.word	cursor03_rle
	.byte	128+20	;	.word	cursor04_rle
	.byte	128+20	;	.word	cursor05_rle
	.byte	128+20	;	.word	cursor06_rle
	.byte	128+20	;	.word	cursor07_rle
	.byte	128+20	;	.word	cursor08_rle
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

