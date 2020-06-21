;=======================
; scenery

plant_wind:
	.word	plant1
	.word	plant2
	.word	plant3
	.word	plant4

plant1:
	.byte	$4,$5
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$00
	.byte	$aa,$00,$aa,$00

plant2:
	.byte	$4,$5
	.byte	$a0,$0a,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$00
	.byte	$aa,$00,$aa,$00

plant3:
	.byte	$4,$5
	.byte	$00,$aa,$aa,$aa
	.byte	$a0,$0a,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$00
	.byte	$aa,$00,$aa,$00

plant4:
	.byte	$4,$5
	.byte	$00,$aa,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$00,$aa,$00
	.byte	$aa,$00,$aa,$00


pool_ripples:
	.word	ripple1
	.word	ripple2
	.word	ripple3
	.word	ripple4


ripple1:
	.byte	$3,$1
	.byte	$5a,$5a,$aa

ripple2:
	.byte	$3,$1
	.byte	$aa,$5a,$aa

ripple3:
	.byte	$3,$1
	.byte	$aa,$aa,$aa

ripple4:
	.byte	$3,$1
	.byte	$aa,$aa,$aa


foreground_spikes:
	.byte	$4,$5
	.byte	$00,$aa,$aa,$00
	.byte	$00,$aa,$0a,$00
	.byte	$00,$aa,$00,$00
	.byte	$00,$aa,$00,$00
	.byte	$00,$aa,$aa,$00


;=======================
; Tentacle


tentacle_progression:
	.word	tentacle0	; 0
	.word	tentacle1	; 1
	.word	tentacle2	; 2
	.word	tentacle3	; 3
	.word	tentacle4	; 4
	.word	tentacle5	; 5
	.word	tentacle5	; 6
	.word	tentacle5	; 7
	.word	tentacle4	; 8
	.word	tentacle3	; 9
	.word	tentacle2	; 10
	.word	tentacle1	; 11
	.word	tentacle0	; 12





tentacle0:
	.byte	$2,$5
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$5a

tentacle1:
	.byte	$2,$5
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$00

tentacle2:
	.byte	$2,$5
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$00,$aa
	.byte	$aa,$00

tentacle3:
	.byte	$2,$5
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$aa,$00
	.byte	$00,$aa
	.byte	$aa,$00

tentacle4:
	.byte	$2,$5
	.byte	$aa,$aa
	.byte	$00,$aa
	.byte	$aa,$00
	.byte	$00,$aa
	.byte	$aa,$00

tentacle5:
	.byte	$2,$5
	.byte	$aa,$00
	.byte	$00,$aa
	.byte	$aa,$00
	.byte	$00,$aa
	.byte	$aa,$00

caught_progression:
	.word	caught0
	.word	caught1
	.word	caught2
	.word	caught3
	.word	caught4
	.word	caught5
	.word	caught6
	.word	caught7
	.word	caught8
	.word	ripple4
	.word	ripple4
	.word	ripple4	; 12



caught0:
	.byte	$5,$8
	.byte	$aa,$aa,$aa,$9a,$9a
	.byte	$aa,$00,$00,$99,$bb
	.byte	$aa,$00,$aa,$0b,$aa
	.byte	$00,$aa,$aa,$bb,$aa
	.byte	$aa,$00,$aa,$bb,$aa
	.byte	$aa,$aa,$aa,$44,$aa
	.byte	$aa,$aa,$aa,$44,$aa
	.byte	$aa,$aa,$aa,$f4,$fa

caught1:
	.byte	$6,$8
	.byte	$aa,$aa,$aa,$9a,$9a,$aa
	.byte	$aa,$aa,$aa,$99,$bb,$aa
	.byte	$aa,$00,$00,$0b,$00,$aa
	.byte	$00,$aa,$aa,$bb,$00,$0a
	.byte	$aa,$00,$aa,$bb,$aa,$aa
	.byte	$aa,$aa,$aa,$44,$aa,$aa
	.byte	$aa,$aa,$aa,$44,$aa,$aa
	.byte	$aa,$aa,$aa,$f4,$fa,$aa

caught2:
	.byte	$7,$8
	.byte	$aa,$aa,$aa,$9a,$9a,$aa,$aa
	.byte	$aa,$bb,$aa,$bb,$bb,$aa,$bb
	.byte	$aa,$aa,$bb,$0b,$0b,$bb,$aa
	.byte	$aa,$0a,$0a,$00,$00,$0a,$aa
	.byte	$aa,$00,$aa,$00,$00,$a0,$aa
	.byte	$aa,$aa,$aa,$44,$44,$aa,$aa
	.byte	$aa,$aa,$aa,$44,$44,$aa,$aa
	.byte	$aa,$aa,$aa,$f4,$f4,$aa,$aa

caught3:
	.byte	$6,$7
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$b9,$b9,$aa
	.byte	$aa,$aa,$bb,$0b,$0b,$bb
	.byte	$aa,$0a,$0a,$00,$00,$0a
	.byte	$aa,$00,$aa,$00,$00,$a0
	.byte	$aa,$aa,$aa,$44,$44,$aa
	.byte	$aa,$aa,$aa,$af,$af,$aa


caught4:
	.byte	$6,$6
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$9a,$aa,$aa
	.byte	$aa,$aa,$aa,$bb,$aa,$aa
	.byte	$aa,$aa,$0a,$0b,$aa,$aa
	.byte	$aa,$aa,$00,$40,$0a,$a0
	.byte	$aa,$aa,$aa,$af,$aa,$aa

caught5:
	.byte	$5,$5
	.byte	$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$9a,$aa
	.byte	$aa,$ae,$0a,$b0,$ae

caught6:
	.byte	$6,$5
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$ea,$aa,$aa,$aa,$ea
	.byte	$aa,$aa,$5a,$0e,$5a,$aa


caught7:
	.byte	$6,$5
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$ea,$aa,$aa
	.byte	$aa,$ae,$5a,$5a,$5a,$ae

caught8:
	.byte	$4,$5
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$5e

	;============================
	; Falling boulder

boulder:
	.byte	$3,$2
	.byte	$22,$22,$2a
	.byte	$22,$22,$22



