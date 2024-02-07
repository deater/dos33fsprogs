; Made with version 1.0 (2024 Lovebyte)
peasant_song:
; register init

track0:

; A: 'A 5' 57
; B: 'A 5' 57
	.byte $04 ; frame=2 A=0 L=2
; A: 'C 6' 60
	.byte $05 ; frame=4 B=0 L=2
; B: 'C 6' 60
	.byte $14 ; frame=6 A=1 L=2
; A: 'F 5' 53
	.byte $15 ; frame=8 B=1 L=2
; B: 'F 5' 53
	.byte $24 ; frame=10 A=2 L=2
; A: 'G 5' 55
	.byte $2D ; frame=16 B=2 L=6
; B: 'G 5' 55
	.byte $34 ; frame=18 A=3 L=2
; A: 'E 5' 52
	.byte $35 ; frame=20 B=3 L=2
; A: 'E 5' 50
; B: 'E 5' 52
	.byte $44 ; frame=22 A=4 L=2
; A: 'D 5' 57
; B: 'D 5' 50
	.byte $50 ; frame=24 A=5 L=0
	.byte $45 ; frame=24 B=4 L=2
; B: 'A 5' 57
	.byte $00 ; frame=26 A=0 L=0
	.byte $55 ; frame=26 B=5 L=2
; A: 'E 5' 52
	.byte $05 ; frame=28 B=0 L=2
; B: 'E 5' 52
	.byte $44 ; frame=30 A=4 L=2
; A: 'A 5' 57
	.byte $45 ; frame=32 B=4 L=2
; B: 'A 5' 57
	.byte $04 ; frame=34 A=0 L=2
; A: 'C 6' 60
	.byte $05 ; frame=36 B=0 L=2
; B: 'C 6' 60
	.byte $14 ; frame=38 A=1 L=2
; A: 'F 5' 53
	.byte $15 ; frame=40 B=1 L=2
; B: 'F 5' 53
	.byte $24 ; frame=42 A=2 L=2
; A: 'G 5' 55
	.byte $2D ; frame=48 B=2 L=6
; B: 'G 5' 55
	.byte $34 ; frame=50 A=3 L=2
; A: 'E 5' 52
	.byte $35 ; frame=52 B=3 L=2
; A: 'E 5' 50
; B: 'E 5' 52
	.byte $44 ; frame=54 A=4 L=2
; A: 'D 5' 45
; B: 'D 5' 50
	.byte $50 ; frame=56 A=5 L=0
	.byte $45 ; frame=56 B=4 L=2
; B: 'A 4' 45
	.byte $60 ; frame=58 A=6 L=0
	.byte $55 ; frame=58 B=5 L=2
; A: 'E 4' 40
	.byte $65 ; frame=60 B=6 L=2
; B: 'E 4' 40
	.byte $74 ; frame=62 A=7 L=2
; last: a=-1 b=7 len=2
	.byte $75 ; frame=64 B=7 L=2
.byte $ff
track1:

; A: 'A 4' 57
; B: 'A 4' 45
; A: 'A 4' 60
; B: 'A 4' 45
	.byte $00 ; frame=4 A=0 L=0
	.byte $69 ; frame=4 B=6 L=4
; B: 'B 4' 47
	.byte $10 ; frame=6 A=1 L=0
	.byte $65 ; frame=6 B=6 L=2
; A: 'C 5' 53
; B: 'C 5' 48
	.byte $85 ; frame=8 B=8 L=2
; B: 'A 4' 45
	.byte $20 ; frame=10 A=2 L=0
	.byte $95 ; frame=10 B=9 L=2
; B: 'D 5' 50
	.byte $69 ; frame=14 B=6 L=4
; A: 'G 5' 55
	.byte $55 ; frame=16 B=5 L=2
; B: 'D 5' 50
	.byte $34 ; frame=18 A=3 L=2
; A: 'C 5' 52
; B: 'C 5' 48
	.byte $55 ; frame=20 B=5 L=2
; A: 'B 4' 50
; B: 'B 4' 47
	.byte $40 ; frame=22 A=4 L=0
	.byte $95 ; frame=22 B=9 L=2
; A: 'C 5' 57
; B: 'C 5' 48
	.byte $50 ; frame=24 A=5 L=0
	.byte $85 ; frame=24 B=8 L=2
; B: 'A 4' 45
	.byte $00 ; frame=26 A=0 L=0
	.byte $95 ; frame=26 B=9 L=2
; A: 'E 5' 52
	.byte $65 ; frame=28 B=6 L=2
; A: 'A 4' 57
; B: 'A 4' 45
	.byte $48 ; frame=32 A=4 L=4
; A: 'A 4' 60
; B: 'A 4' 45
	.byte $00 ; frame=36 A=0 L=0
	.byte $69 ; frame=36 B=6 L=4
; B: 'B 4' 47
	.byte $10 ; frame=38 A=1 L=0
	.byte $65 ; frame=38 B=6 L=2
; A: 'C 5' 53
; B: 'C 5' 48
	.byte $85 ; frame=40 B=8 L=2
; B: 'A 4' 45
	.byte $20 ; frame=42 A=2 L=0
	.byte $95 ; frame=42 B=9 L=2
; B: 'A 4' 45
	.byte $69 ; frame=46 B=6 L=4
; B: 'B 4' 47
	.byte $63 ; frame=47 B=6 L=1
; A: 'D 5' 55
; B: 'D 5' 50
	.byte $83 ; frame=48 B=8 L=1
; B: 'D 5' 50
	.byte $30 ; frame=50 A=3 L=0
	.byte $55 ; frame=50 B=5 L=2
; A: 'C 5' 52
; B: 'C 5' 48
	.byte $55 ; frame=52 B=5 L=2
; A: 'B 4' 50
; B: 'B 4' 47
	.byte $40 ; frame=54 A=4 L=0
	.byte $95 ; frame=54 B=9 L=2
; A: 'A 4' 45
; B: 'A 4' 45
	.byte $50 ; frame=56 A=5 L=0
	.byte $85 ; frame=56 B=8 L=2
; A: 'E 4' 40
	.byte $60 ; frame=60 A=6 L=0
	.byte $69 ; frame=60 B=6 L=4
; last: a=7 b=-1 len=4
	.byte $78 ; frame=64 A=7 L=4
	.byte $FF ; end
; Octave 0 : 0 0 0 0 0 0 0 0 0 0 0 0 
; Octave 1 : 0 0 0 0 0 0 0 0 0 0 0 0 
; Octave 2 : 0 0 0 0 0 0 0 0 0 0 0 0 
; Octave 3 : 0 0 0 0 3 0 0 0 0 12 0 5 
; Octave 4 : 5 0 10 0 9 6 0 6 0 9 0 0 
; Octave 5 : 6 0 0 0 0 0 0 0 0 0 0 0 
; 10 notes allocated
;.byte 57,60,53,55,52,50,45,40,47,48,
frequencies_low:
.byte $48,$3D,$5B,$51,$60,$6C,$91,$C1,$81,$7A
;frequencies_high:
;.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
; total len=21
