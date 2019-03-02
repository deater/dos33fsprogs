; background graphics

.if 1
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
.if HACK
.include "intro_graphics/10_gone/intro_gone.inc"
.endif

.else

.include "intro_graphics/01_building/intro_building_lz4.inc"
.include "intro_graphics/01_building/intro_building_car_lz4.inc"
.include "intro_graphics/01_building/intro_car_lz4.inc"

.include "intro_graphics/02_outer_door/outer_door_lz4.inc"
.include "intro_graphics/02_outer_door/feet_lz4.inc"

.include "intro_graphics/03_elevator/intro_elevator_lz4.inc"
.include "intro_graphics/03_elevator/intro_off_elevator_lz4.inc"
.include "intro_graphics/03_elevator/intro_walking_lz4.inc"

.include "intro_graphics/04_keypad/intro_scanner_door_lz4.inc"
.include "intro_graphics/04_keypad/intro_approach_lz4.inc"
.include "intro_graphics/04_keypad/intro_keypad_bg_lz4.inc"
.include "intro_graphics/04_keypad/intro_hands_lz4.inc"
.include "intro_graphics/04_keypad/intro_opening_lz4.inc"

.include "intro_graphics/05_scanner/intro_scanner_lz4.inc"
.include "intro_graphics/05_scanner/intro_scanning_lz4.inc"
.include "intro_graphics/05_scanner/intro_ai_bg_lz4.inc"
.include "intro_graphics/05_scanner/intro_ai_lz4.inc"

.include "intro_graphics/06_console/intro_desktop_lz4.inc"
.include "intro_graphics/06_console/intro_cursor_lz4.inc"
.include "intro_graphics/06_console/intro_collider_lz4.inc"

.include "intro_graphics/07_soda/intro_open_soda_lz4.inc"
.include "intro_graphics/07_soda/intro_drinking_lz4.inc"

.include "intro_graphics/08_lightning/lightning_lz4.inc"

.include "intro_graphics/09_tunnel/intro_tunnel1_lz4.inc"
.include "intro_graphics/09_tunnel/intro_tunnel2_lz4.inc"

.include "intro_graphics/10_gone/intro_zappo_lz4.inc"
.if HACK
.include "intro_graphics/10_gone/intro_gone_lz4.inc"
.endif

.endif


;========================
; Car driving up sequence

building_sequence:
	.byte	127
	.word	intro_car1
	.byte	128+2	;	.word	intro_car2
	.byte	128+2	;	.word	intro_car3
	.byte	128+2	;	.word	intro_car4
	.byte	128+2	;	.word	intro_car5
	.byte	128+2	;	.word	intro_car6
	.byte	128+2	;	.word	intro_car7
	.byte	128+2	;	.word	intro_car8
	.byte	128+2	;	.word	intro_car9
	.byte	128+126	;	.word	intro_car10
	.byte	0

;========================
; Getting out of car sequence

outtacar_sequence:
	.byte	100
	.word	intro_car12
	.byte	128+50	;	.word	intro_car13
	.byte	128+125	;	.word	intro_car14
	.byte	125
	.word	intro_car14
	.byte	0


; Getting out of car sequence

feet_sequence:
	.byte	100
	.word	feet01_rle
	.byte	128+10	;	.word	feet02_rle
	.byte	128+10	;	.word	feet03_rle
	.byte	128+10	;	.word	feet04_rle
	.byte	128+10	;	.word	feet05_rle
	.byte	128+10	;	.word	feet06_rle
	.byte	128+10	;	.word	feet07_rle
	.byte	128+10	;	.word	feet08_rle
	.byte	128+30	;	.word	feet09_rle
	.byte	128+10	;	.word	feet10_rle
	.byte	128+10	;	.word	feet11_rle
	.byte	128+10	;	.word	feet12_rle
	.byte	128+10	;	.word	feet13_rle
	.byte	128+10	;	.word	feet14_rle
	.byte	128+10	;	.word	feet15_rle
	.byte	10
	.word	nothing_rle
	.byte	100
	.word	nothing_rle
	.byte	0

; Walking off elevator sequence

walking_sequence:
	.byte	20
	.word	walking01_rle
	.byte	128+20	;	.word	walking02_rle
	.byte	128+20	;	.word	walking03_rle
	.byte	128+20	;	.word	walking04_rle
	.byte	128+20	;	.word	walking05_rle
	.byte	128+20	;	.word	walking06_rle
	.byte	128+20	;	.word	walking07_rle
	.byte	128+20	;	.word	walking08_rle
	.byte	20
	.word	walking08_rle
	.byte	0

; Approaching keypad sequence

approach_sequence:
	.byte	20
	.word	approach01_rle
	.byte	128+20	;	.word	approach02_rle
	.byte	128+20	;	.word	approach03_rle
	.byte	128+20	;	.word	approach04_rle
	.byte	128+20	;	.word	approach05_rle
	.byte	128+20	;	.word	approach06_rle
	.byte	128+20	;	.word	approach07_rle
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
	.byte	128+15	;	.word	opening02_rle
	.byte	128+15	;	.word	opening03_rle
	.byte	128+15	;	.word	opening04_rle
	.byte	128+15	;	.word	opening05_rle
	.byte	128+15	;	.word	opening06_rle
	.byte	128+15	;	.word	opening07_rle
	.byte	128+15	;	.word	opening08_rle
	.byte	128+15	;	.word	opening09_rle
	.byte	128+15	;	.word	opening10_rle
	.byte	128+15	;	.word	opening11_rle
	.byte	128+15	;	.word	opening12_rle
	.byte	15
	.word	nothing_rle
	.byte	100
	.word	nothing_rle
	.byte	0

; Scanning sequence

scanning_sequence:
	.byte	15
	.word	scan01_rle
	.byte	128+15	;	.word	scan02_rle
	.byte	128+15	;	.word	scan03_rle
	.byte	128+15	;	.word	scan04_rle
	.byte	128+15	;	.word	scan05_rle
	.byte	128+15	;	.word	scan06_rle
	.byte	128+15	;	.word	scan07_rle
	.byte	128+15	;	.word	scan08_rle
	.byte	128+15	;	.word	scan09_rle
	.byte	128+15	;	.word	scan10_rle
	.byte	128+20	;	.word	scan11_rle
	.byte	128+20	;	.word	scan12_rle
	.byte	128+20	;	.word	scan13_rle
	.byte	128+20	;	.word	scan14_rle
	.byte	128+20	;	.word	scan15_rle
	.byte	128+20	;	.word	scan16_rle
	.byte	128+40	;	.word	scan17_rle
	.byte	128+40	;	.word	scan18_rle
	.byte	128+40	;	.word	scan19_rle
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
	.word	nothing_rle	; 0
	.word	nothing_rle	; 2
	.word	static01_rle	; 4
	.word	static03_rle	; 6
	.word	static02_rle	; 8
	.word	static01_rle	; 10

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

; Power-up sequence

soda_sequence:
	.byte	1
	.word	soda01_rle
	.byte	128+30	;	.word	soda02_rle
	.byte	128+15	;	.word	soda03_rle
	.byte	128+15	;	.word	soda04_rle
	.byte	128+15	;	.word	soda05_rle
	.byte	128+15	;	.word	soda06_rle
	.byte	128+15	;	.word	soda07_rle
	.byte	128+15	;	.word	soda08_rle
	.byte	128+15	;	.word	soda09_rle
	.byte	20
	.word	soda09_rle
	.byte	0



	; Scanning text

good_evening:
	.byte 2,21,"GOOD EVENING PROFESSOR.",0
ferrari:
	.byte 2,21,"I SEE YOU HAVE DRIVEN HERE IN YOUR",0
	.byte 2,22,"FERRARI.",0


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
	.byte 128+30	;	.word drinking03_rle
	.byte 128+30	;	.word drinking04_rle
	.byte 128+30	;	.word drinking05_rle
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
;	.word nothing_rle

	;==============
	; split, as was > 256

bolt_sequence:
	.byte 80
	;=======================
	; 147 bolt right
	;=======================
	;	13,14,15
	.word storm13_rle
	.byte 128+5	;	.word storm14_rle
	.byte 128+5	;	.word storm15_rle
	.byte 5
	; 	screen goes white
	;	*all white
	.word white_rle
	.byte 8
	;	lightning animation
	;	* bolt1, 2,3,4,5,6,7
	.word bolt1_rle
	.byte 128+5	;	.word bolt2_rle
	.byte 128+5	;	.word bolt3_rle
	.byte 128+5	;	.word bolt4_rle
	.byte 128+5	;	.word bolt5_rle
	.byte 128+5	;	.word bolt6_rle
	.byte 128+5	;	.word bolt7_rle
	.byte 5
	;	* all white (a while)
	.word white_rle
	; 	* all black (a while)
	.word 128+30,black_rle
	.byte 30
	; 148.3 big bolt behind car
	;	29 .. 38, 40.. 42 (38 twice as long?)
	.word storm29_rle
	.byte 128+5	;	.word storm30_rle
	.byte 128+5	;	.word storm31_rle
	.byte 128+5	;	.word storm32_rle
	.byte 128+5	;	.word storm33_rle
	.byte 128+5	;	.word storm34_rle
	.byte 128+5	;	.word storm35_rle
	.byte 128+5	;	.word storm36_rle
	.byte 128+5	;	.word storm37_rle
	.byte 128+5	;	.word storm38_rle
	.byte 128+5	;	.word storm40_rle
	.byte 128+5	;	.word storm41_rle
	.byte 128+5	;	.word storm42_rle
	.byte 5
	; by 150 faded out and on to tunnel
	.word nothing_rle
	.byte 0
;	.word nothing_rle

	;=======================
	; Tunnel1 Sequence
	;=======================
tunnel1_sequence:
	.byte 10
	.word nothing_rle
	.byte 50
	; red blob
	.word tunnel1_01_rle
	.byte 128+2	;	.word tunnel1_02_rle
	.byte 128+2	;	.word tunnel1_03_rle
	.byte 128+2	;	.word tunnel1_04_rle
	.byte 128+2	;	.word tunnel1_05_rle
	.byte 2

	; lightning blob
	.word nothing_rle
	.byte 50
	.word tunnel1_06_rle
	.byte 128+2	;	.word tunnel1_07_rle
	.byte 2
	.word white_rle
	.byte 2
	.word tunnel1_08_rle
	.byte 128+2	;	.word tunnel1_09_rle
	.byte 128+2	;	.word tunnel1_10_rle
	.byte 128+2	;	.word tunnel1_11_rle
	.byte 128+2	;	.word tunnel1_12_rle
	.byte 128+2	;	.word tunnel1_13_rle
	.byte 128+2	;	.word tunnel1_14_rle
	.byte 128+2	;	.word tunnel1_15_rle
	.byte 128+2	;	.word tunnel1_16_rle
	.byte 128+2	;	.word tunnel1_17_rle
	.byte 128+2	;	.word tunnel1_18_rle
	.byte 128+2	;	.word tunnel1_19_rle
	.byte 2
	.word nothing_rle
	.byte 0


	;=======================
	; Tunnel2 Sequence
	;=======================
tunnel2_sequence:
	.byte 10
	.word nothing_rle
	.byte 50
	; red blob
	.word tunnel2_01_rle
	.byte 128+2	;	.word tunnel2_02_rle
	.byte 128+2	;	.word tunnel2_03_rle
	.byte 128+2	;	.word tunnel2_04_rle
	.byte 128+2	;	.word tunnel2_05_rle
	.byte 128+2	;	.word tunnel2_06_rle
	.byte 128+2	;	.word tunnel2_07_rle
	.byte 128+2	;	.word tunnel2_08_rle
	.byte 128+2	;	.word tunnel2_09_rle
	.byte 2
	.word nothing_rle
	.byte 50

	; lightning blob
	.word tunnel2_10_rle
	.byte 128+2	;	.word tunnel2_11_rle
	.byte 128+2	;	.word tunnel2_12_rle
	.byte 128+2	;	.word tunnel2_13_rle
	.byte 128+2	;	.word tunnel2_14_rle
	.byte 128+2	;	.word tunnel2_15_rle
	.byte 128+2	;	.word tunnel2_16_rle
	.byte 128+2	;	.word tunnel2_17_rle
	.byte 2
	.word nothing_rle
	.byte 0




	;=======================
	; Zappo Sequence
	;=======================
zappo_sequence:

	.byte 50
	.word white_rle

	.byte 2
	.word zappo01_rle				; B

	.byte 128+2	;	.word zappo02_rle	; B
	.byte 128+2	;	.word zappo03_rle	; A
	.byte 128+2	;	.word zappo04_rle	; B
	.byte 128+2	;	.word zappo05_rle	; B

	.byte 255
	.word zappo03_rle	; load A
	.byte 2
	.word zappo06_rle	; A

	.byte 255
	.word blue_zappo_rle	; load b
	.byte 2
	.word zappo07_rle	; B

	.byte 2
	.word zappo08_rle	; B

	.byte 255
	.word zappo03_rle	; load A
	.byte 2
	.word zappo09_rle	; A

	.byte 255
	.word blue_zappo_rle	; load b
	.byte 2
	.word zappo10_rle	; B

	.byte 255
	.word zappo03_rle	; load A
	.byte 2
	.word zappo11_rle	; A

	.byte 255
	.word blue_zappo_rle	; load b
	.byte 2
	.word zappo12_rle	; B
	.byte 128+2	;	.word zappo13_rle	; B
	.byte 128+2	;	.word zappo14_rle	; B

	.byte 255
	.word zappo03_rle	; load A
	.byte 2
	.word zappo15_rle	; A

	.byte 255
	.word blue_zappo_rle	; load b
	.byte 2
	.word zappo16_rle	; B
	.byte 128+2	;	.word zappo17_rle	; B
	.byte 2
	.word white_rle
	.byte 128+5	;	.word black_rle
	.byte 5
	.word white_rle
	.byte 128+5	;	.word black_rle
;	.byte 5
;	.word white_rle
;	.byte 1
;	.word black_rle
;	.byte 1
;	.word white_rle
;	.byte 1
;	.word black_rle
;	.byte 1
;	.word white_rle
;	.byte 1
;	.word black_rle
	.byte 0
	.word nothing_rle


.if HACK
	;=======================
	; Gone Sequence
	;=======================
gone_sequence:

	.byte 50
	.word white_rle

	.byte 7
	.word gone01_rle				; B

	.byte 128+7	;	.word gone02_rle	; B
	.byte 128+7	;	.word gone03_rle	; B
	.byte 128+7	;	.word gone04_rle	; B
	.byte 128+7	;	.word gone05_rle	; B
	.byte 128+7	;	.word gone06_rle	; B
	.byte 128+7	;	.word gone07_rle	; B
	.byte 128+7	;	.word gone08_rle	; B
	.byte 128+7	;	.word gone09_rle	; LB
	.byte 128+7	;	.word gone10_rle	; CY

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone11_rle	; LB

	.byte 255
	.word gone_rle		; B back into $c00
	.byte 7
	.word gone02_rle	; B (12 is dupe of 2)

	.byte 7
	.word gone13_rle	; B

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone14_rle	; LB

	.byte 255
	.word gone_rle		; B back into $c00 + plain
	.byte 7
	.word nothing_rle

	.byte 7
	.word gone16_rle	; B

	.byte 7
	.word nothing_rle	; B (plain?)

	.byte 7
	.word gone18_rle	; B
	.byte 128+7	;	.word gone19_rle	; B
	.byte 128+7	;	.word gone20_rle	; B
	.byte 128+7	;	.word gone21_rle	; B

	.byte 7
	.word nothing_rle	; B (plain?)

	.byte 7
	.word gone23_rle	; B
	.byte 128+7	;	.word gone24_rle	; B
	.byte 128+7	;	.word gone25_rle	; B
	.byte 128+7	;	.word gone26_rle	; B
	.byte 128+7	;	.word gone27_rle	; B

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone28_rle	; LB

;	.byte 255
;	.word gone10_rle	; CY into $c00
	.byte 7
	.word gone10_rle	; CY (same as 10)

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone28_rle	; LB (30 same as 28)

	.byte 255
	.word gone_rle		; B back into $c00 + plain
	.byte 7
	.word gone31_rle	; B

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone32_rle	; LB

	.byte 255
	.word gone_rle		; B back into $c00 + plain
	.byte 7
	.word nothing_rle	; B (plain?)

	.byte 7
	.word gone34_rle	; B

	.byte 128+7	;	.word gone35_rle	; B
	.byte 128+7	;	.word gone36_rle	; B
	.byte 128+7	;	.word gone37_rle	; B
	.byte 128+7	;	.word gone38_rle	; B

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone39_rle	; LB

	.byte 255
	.word gone10_rle	; CY into $c00
	.byte 7
	.word gone40_rle	; CY

	.byte 7
	.word gone10_rle	; CY (same as 10)

	.byte 255
	.word gone09_rle	; LB into $c00
	.byte 7
	.word gone42_rle	; LB

	.byte 255
	.word gone_rle		; B back into $c00 + plain
	.byte 7
	.word gone43_rle	; B

	.byte 7
	.word nothing_rle
	.byte 0

.endif
