;=================================
;=================================
; Intro Segment 02 Data (Door)
;=================================
;=================================

; background graphics

.include "graphics/02_outer_door/outer_door.inc"
.include "graphics/02_outer_door/feet.inc"
;.include "graphics/08_lightning/nothing.inc"

;=============================
; Feet going in door sequence

feet_sequence:
	.byte	255
	.word	outer_door_lzsa
	.byte	1
	.word	outer_door_lzsa
	.byte	128+100	;	.word	feet01_lzsa
	.byte	128+10	;	.word	feet02_lzsa
	.byte	128+10	;	.word	feet03_lzsa
	.byte	128+10	;	.word	feet04_lzsa
	.byte	128+10	;	.word	feet05_lzsa
	.byte	128+10	;	.word	feet06_lzsa
	.byte	128+10	;	.word	feet07_lzsa
	.byte	128+10	;	.word	feet08_lzsa
	.byte	128+30	;	.word	feet09_lzsa
	.byte	128+10	;	.word	feet10_lzsa
	.byte	128+10	;	.word	feet11_lzsa
	.byte	128+10	;	.word	feet12_lzsa
	.byte	128+10	;	.word	feet13_lzsa
	.byte	128+10	;	.word	feet14_lzsa
	.byte	128+10	;	.word	feet15_lzsa
	.byte	10
	.word	nothing_lzsa
	.byte	100
	.word	nothing_lzsa
	.byte	0


;=================================
;=================================
; Intro Segment 03 Data (Elevator)
;=================================
;=================================

.include "graphics/03_elevator/intro_elevator.inc"
.include "graphics/03_elevator/intro_off_elevator.inc"
.include "graphics/03_elevator/intro_walking.inc"


	; Elevator light co-ordinates
	; we load them backwards
indicators:
	.byte 	18,4	; 4
	.byte	16,3	; 3
	.byte 	14,2	; 2
	.byte	18,2	; 1
	.byte	16,1	; 0

; Walking off elevator sequence

; FIXME: why do we skip walking00????

walking_sequence:
	.byte	20
	.word	walking01_lzsa
	.byte	128+20	;	.word	walking02_lzsa
	.byte	128+20	;	.word	walking03_lzsa
	.byte	128+20	;	.word	walking04_lzsa
	.byte	128+20	;	.word	walking05_lzsa
	.byte	128+20	;	.word	walking06_lzsa
	.byte	128+20	;	.word	walking07_lzsa
	.byte	128+20	;	.word	walking08_lzsa
	.byte	20
	.word	walking08_lzsa
	.byte	0
