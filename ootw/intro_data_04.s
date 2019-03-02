;=================================
;=================================
; Intro Segment 01 Data (Building)
;=================================
;=================================

.include "intro_graphics/04_keypad/intro_scanner_door.inc"
.include "intro_graphics/04_keypad/intro_approach.inc"
.include "intro_graphics/04_keypad/intro_keypad_bg.inc"
.include "intro_graphics/04_keypad/intro_hands.inc"
.include "intro_graphics/04_keypad/intro_opening.inc"

.include "intro_graphics/08_lightning/nothing.inc"

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
