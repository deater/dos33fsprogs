.align $100


peasant_song:
; register init

track0:

; A: 24
; A: 31
; B: 24
	.byte $04 ; frame=2 A=0 L=2
; A: 36
; B: 31
	.byte $08 ; frame=4 A=1 L=0
	.byte $05 ; frame=4 B=0 L=2
; A: 43
; B: 36
	.byte $10 ; frame=6 A=2 L=0
	.byte $0D ; frame=6 B=1 L=2
; A: 46
; B: 43
	.byte $18 ; frame=8 A=3 L=0
	.byte $15 ; frame=8 B=2 L=2
; A: 48
; B: 46
	.byte $20 ; frame=10 A=4 L=0
	.byte $1D ; frame=10 B=3 L=2
; A: 43
; B: 48
	.byte $28 ; frame=12 A=5 L=0
	.byte $25 ; frame=12 B=4 L=2
; A: 41
; B: 43
	.byte $18 ; frame=14 A=3 L=0
	.byte $2D ; frame=14 B=5 L=2
; A: 24
; B: 41
	.byte $30 ; frame=16 A=6 L=0
	.byte $1D ; frame=16 B=3 L=2
; A: 31
; B: 24
	.byte $00 ; frame=18 A=0 L=0
	.byte $35 ; frame=18 B=6 L=2
; A: 36
; B: 31
	.byte $08 ; frame=20 A=1 L=0
	.byte $05 ; frame=20 B=0 L=2
; A: 43
; B: 36
	.byte $10 ; frame=22 A=2 L=0
	.byte $0D ; frame=22 B=1 L=2
; A: 46
; B: 43
	.byte $18 ; frame=24 A=3 L=0
	.byte $15 ; frame=24 B=2 L=2
; A: 48
; B: 46
	.byte $20 ; frame=26 A=4 L=0
	.byte $1D ; frame=26 B=3 L=2
; A: 43
; B: 48
	.byte $28 ; frame=28 A=5 L=0
	.byte $25 ; frame=28 B=4 L=2
; A: 41
; B: 43
	.byte $18 ; frame=30 A=3 L=0
	.byte $2D ; frame=30 B=5 L=2
; A: 24
; B: 41
	.byte $30 ; frame=32 A=6 L=0
	.byte $1D ; frame=32 B=3 L=2
; A: 31
; B: 24
	.byte $00 ; frame=34 A=0 L=0
	.byte $35 ; frame=34 B=6 L=2
; A: 36
; B: 31
	.byte $08 ; frame=36 A=1 L=0
	.byte $05 ; frame=36 B=0 L=2
; A: 43
; B: 36
	.byte $10 ; frame=38 A=2 L=0
	.byte $0D ; frame=38 B=1 L=2
; A: 46
; B: 43
	.byte $18 ; frame=40 A=3 L=0
	.byte $15 ; frame=40 B=2 L=2
; A: 48
; B: 46
	.byte $20 ; frame=42 A=4 L=0
	.byte $1D ; frame=42 B=3 L=2
; A: 43
; B: 48
	.byte $28 ; frame=44 A=5 L=0
	.byte $25 ; frame=44 B=4 L=2
; A: 41
; B: 43
	.byte $18 ; frame=46 A=3 L=0
	.byte $2D ; frame=46 B=5 L=2
; A: 24
; B: 41
	.byte $30 ; frame=48 A=6 L=0
	.byte $1D ; frame=48 B=3 L=2
; A: 31
; B: 24
	.byte $00 ; frame=50 A=0 L=0
	.byte $35 ; frame=50 B=6 L=2
; A: 36
; B: 31
	.byte $08 ; frame=52 A=1 L=0
	.byte $05 ; frame=52 B=0 L=2
; A: 43
; B: 36
	.byte $10 ; frame=54 A=2 L=0
	.byte $0D ; frame=54 B=1 L=2
; A: 51
; B: 43
	.byte $18 ; frame=56 A=3 L=0
	.byte $15 ; frame=56 B=2 L=2
; A: 50
; B: 51
	.byte $38 ; frame=58 A=7 L=0
	.byte $1D ; frame=58 B=3 L=2
; A: 46
; B: 50
	.byte $40 ; frame=60 A=8 L=0
	.byte $3D ; frame=60 B=7 L=2
; A: 43
; B: 46
	.byte $20 ; frame=62 A=4 L=0
	.byte $45 ; frame=62 B=8 L=2
; last: a=3 b=4 len=2
	.byte $18 ; frame=64 A=3 L=0
	.byte $25 ; frame=64 B=4 L=2
.byte $ff
track1:

; A: 24
; B: 12
; A: 31
; B: 24
	.byte $00 ; frame=2 A=0 L=0
	.byte $4D ; frame=2 B=9 L=2
; A: 36
	.byte $08 ; frame=4 A=1 L=0
	.byte $05 ; frame=4 B=0 L=2
; A: 43
	.byte $14 ; frame=6 A=2 L=2
; A: 46
; B: 53
	.byte $1C ; frame=8 A=3 L=2
; A: 48
; B: 51
	.byte $20 ; frame=10 A=4 L=0
	.byte $55 ; frame=10 B=10 L=2
; A: 43
; B: 19
	.byte $28 ; frame=12 A=5 L=0
	.byte $3D ; frame=12 B=7 L=2
; A: 41
; B: 15
	.byte $18 ; frame=14 A=3 L=0
	.byte $5D ; frame=14 B=11 L=2
; A: 24
; B: 12
	.byte $30 ; frame=16 A=6 L=0
	.byte $65 ; frame=16 B=12 L=2
; A: 31
; B: 24
	.byte $00 ; frame=18 A=0 L=0
	.byte $4D ; frame=18 B=9 L=2
; A: 36
	.byte $08 ; frame=20 A=1 L=0
	.byte $05 ; frame=20 B=0 L=2
; A: 43
	.byte $14 ; frame=22 A=2 L=2
; A: 46
; B: 50
	.byte $1C ; frame=24 A=3 L=2
; A: 48
; B: 51
	.byte $20 ; frame=26 A=4 L=0
	.byte $45 ; frame=26 B=8 L=2
; A: 43
; B: 19
	.byte $28 ; frame=28 A=5 L=0
	.byte $3D ; frame=28 B=7 L=2
; A: 41
; B: 15
	.byte $18 ; frame=30 A=3 L=0
	.byte $5D ; frame=30 B=11 L=2
; A: 24
; B: 12
	.byte $30 ; frame=32 A=6 L=0
	.byte $65 ; frame=32 B=12 L=2
; A: 31
; B: 24
	.byte $00 ; frame=34 A=0 L=0
	.byte $4D ; frame=34 B=9 L=2
; A: 36
	.byte $08 ; frame=36 A=1 L=0
	.byte $05 ; frame=36 B=0 L=2
; A: 43
	.byte $14 ; frame=38 A=2 L=2
; A: 46
; B: 53
	.byte $1C ; frame=40 A=3 L=2
; A: 48
; B: 51
	.byte $20 ; frame=42 A=4 L=0
	.byte $55 ; frame=42 B=10 L=2
; A: 43
; B: 19
	.byte $28 ; frame=44 A=5 L=0
	.byte $3D ; frame=44 B=7 L=2
; A: 41
; B: 15
	.byte $18 ; frame=46 A=3 L=0
	.byte $5D ; frame=46 B=11 L=2
; A: 24
; B: 12
	.byte $30 ; frame=48 A=6 L=0
	.byte $65 ; frame=48 B=12 L=2
; A: 31
; B: 24
	.byte $00 ; frame=50 A=0 L=0
	.byte $4D ; frame=50 B=9 L=2
; A: 36
	.byte $08 ; frame=52 A=1 L=0
	.byte $05 ; frame=52 B=0 L=2
; A: 43
	.byte $14 ; frame=54 A=2 L=2
; A: 51
; B: 55
	.byte $1C ; frame=56 A=3 L=2
; A: 50
; B: 53
	.byte $38 ; frame=58 A=7 L=0
	.byte $6D ; frame=58 B=13 L=2
; A: 46
; B: 26
	.byte $40 ; frame=60 A=8 L=0
	.byte $55 ; frame=60 B=10 L=2
; A: 43
; B: 50
	.byte $20 ; frame=62 A=4 L=0
	.byte $75 ; frame=62 B=14 L=2
; last: a=3 b=8 len=2
	.byte $18 ; frame=64 A=3 L=0
	.byte $45 ; frame=64 B=8 L=2
.byte $ff
track2:

; A: 24
; B: 12
; A: 31
; B: 24
	.byte $00 ; frame=2 A=0 L=0
	.byte $4D ; frame=2 B=9 L=2
; A: 36
; B: 60
	.byte $08 ; frame=4 A=1 L=0
	.byte $05 ; frame=4 B=0 L=2
; A: 43
; B: 58
	.byte $10 ; frame=6 A=2 L=0
	.byte $7D ; frame=6 B=15 L=2
; A: 46
; B: 53
	.byte $18 ; frame=8 A=3 L=0
	.byte $85 ; frame=8 B=16 L=2
; A: 48
; B: 55
	.byte $20 ; frame=10 A=4 L=0
	.byte $55 ; frame=10 B=10 L=2
; A: 43
; B: 19
	.byte $28 ; frame=12 A=5 L=0
	.byte $6D ; frame=12 B=13 L=2
; A: 41
; B: 15
	.byte $18 ; frame=14 A=3 L=0
	.byte $5D ; frame=14 B=11 L=2
; A: 24
; B: 12
	.byte $30 ; frame=16 A=6 L=0
	.byte $65 ; frame=16 B=12 L=2
; A: 31
; B: 24
	.byte $00 ; frame=18 A=0 L=0
	.byte $4D ; frame=18 B=9 L=2
; A: 36
; B: 53
	.byte $08 ; frame=20 A=1 L=0
	.byte $05 ; frame=20 B=0 L=2
; A: 43
; B: 55
	.byte $10 ; frame=22 A=2 L=0
	.byte $55 ; frame=22 B=10 L=2
; A: 46
; B: 50
	.byte $18 ; frame=24 A=3 L=0
	.byte $6D ; frame=24 B=13 L=2
; A: 48
; B: 51
	.byte $20 ; frame=26 A=4 L=0
	.byte $45 ; frame=26 B=8 L=2
; A: 43
; B: 19
	.byte $28 ; frame=28 A=5 L=0
	.byte $3D ; frame=28 B=7 L=2
; A: 41
; B: 15
	.byte $18 ; frame=30 A=3 L=0
	.byte $5D ; frame=30 B=11 L=2
; A: 24
; B: 12
	.byte $30 ; frame=32 A=6 L=0
	.byte $65 ; frame=32 B=12 L=2
; A: 31
; B: 24
	.byte $00 ; frame=34 A=0 L=0
	.byte $4D ; frame=34 B=9 L=2
; A: 36
; B: 60
	.byte $08 ; frame=36 A=1 L=0
	.byte $05 ; frame=36 B=0 L=2
; A: 43
; B: 62
	.byte $10 ; frame=38 A=2 L=0
	.byte $7D ; frame=38 B=15 L=2
; A: 46
; B: 53
	.byte $18 ; frame=40 A=3 L=0
	.byte $8D ; frame=40 B=17 L=2
; A: 48
; B: 51
	.byte $20 ; frame=42 A=4 L=0
	.byte $55 ; frame=42 B=10 L=2
; A: 43
; B: 19
	.byte $28 ; frame=44 A=5 L=0
	.byte $3D ; frame=44 B=7 L=2
; A: 41
; B: 15
	.byte $18 ; frame=46 A=3 L=0
	.byte $5D ; frame=46 B=11 L=2
; A: 24
; B: 12
	.byte $30 ; frame=48 A=6 L=0
	.byte $65 ; frame=48 B=12 L=2
; A: 31
; B: 24
	.byte $00 ; frame=50 A=0 L=0
	.byte $4D ; frame=50 B=9 L=2
; A: 36
; B: 53
	.byte $08 ; frame=52 A=1 L=0
	.byte $05 ; frame=52 B=0 L=2
; A: 43
; B: 55
	.byte $10 ; frame=54 A=2 L=0
	.byte $55 ; frame=54 B=10 L=2
; A: 51
; B: 58
	.byte $18 ; frame=56 A=3 L=0
	.byte $6D ; frame=56 B=13 L=2
; A: 50
; B: 55
	.byte $38 ; frame=58 A=7 L=0
	.byte $85 ; frame=58 B=16 L=2
; A: 46
; B: 53
	.byte $40 ; frame=60 A=8 L=0
	.byte $6D ; frame=60 B=13 L=2
; A: 43
; B: 50
	.byte $20 ; frame=62 A=4 L=0
	.byte $55 ; frame=62 B=10 L=2
; last: a=3 b=8 len=2
	.byte $18 ; frame=64 A=3 L=0
	.byte $45 ; frame=64 B=8 L=2
.byte $ff
track3:

; A: 24
; B: 12
; A: 31
; B: 24
	.byte $00 ; frame=2 A=0 L=0
	.byte $4D ; frame=2 B=9 L=2
; A: 36
; B: 51
	.byte $08 ; frame=4 A=1 L=0
	.byte $05 ; frame=4 B=0 L=2
; A: 43
; B: 50
	.byte $10 ; frame=6 A=2 L=0
	.byte $3D ; frame=6 B=7 L=2
; A: 46
; B: 53
	.byte $18 ; frame=8 A=3 L=0
	.byte $45 ; frame=8 B=8 L=2
; A: 48
; B: 51
	.byte $20 ; frame=10 A=4 L=0
	.byte $55 ; frame=10 B=10 L=2
; A: 43
; B: 19
	.byte $28 ; frame=12 A=5 L=0
	.byte $3D ; frame=12 B=7 L=2
; A: 41
; B: 15
	.byte $18 ; frame=14 A=3 L=0
	.byte $5D ; frame=14 B=11 L=2
; A: 24
; B: 12
	.byte $30 ; frame=16 A=6 L=0
	.byte $65 ; frame=16 B=12 L=2
; A: 31
; B: 24
	.byte $00 ; frame=18 A=0 L=0
	.byte $4D ; frame=18 B=9 L=2
; A: 36
; B: 55
	.byte $08 ; frame=20 A=1 L=0
	.byte $05 ; frame=20 B=0 L=2
; A: 43
; B: 53
	.byte $10 ; frame=22 A=2 L=0
	.byte $6D ; frame=22 B=13 L=2
; A: 46
; B: 50
	.byte $18 ; frame=24 A=3 L=0
	.byte $55 ; frame=24 B=10 L=2
; A: 48
; B: 51
	.byte $20 ; frame=26 A=4 L=0
	.byte $45 ; frame=26 B=8 L=2
; A: 43
; B: 19
	.byte $28 ; frame=28 A=5 L=0
	.byte $3D ; frame=28 B=7 L=2
; A: 41
; B: 15
	.byte $18 ; frame=30 A=3 L=0
	.byte $5D ; frame=30 B=11 L=2
; A: 24
; B: 12
	.byte $30 ; frame=32 A=6 L=0
	.byte $65 ; frame=32 B=12 L=2
; A: 31
; B: 24
	.byte $00 ; frame=34 A=0 L=0
	.byte $4D ; frame=34 B=9 L=2
; A: 36
; B: 50
	.byte $08 ; frame=36 A=1 L=0
	.byte $05 ; frame=36 B=0 L=2
; A: 43
; B: 51
	.byte $10 ; frame=38 A=2 L=0
	.byte $45 ; frame=38 B=8 L=2
; A: 46
; B: 53
	.byte $18 ; frame=40 A=3 L=0
	.byte $3D ; frame=40 B=7 L=2
; A: 48
; B: 51
	.byte $20 ; frame=42 A=4 L=0
	.byte $55 ; frame=42 B=10 L=2
; A: 43
; B: 19
	.byte $28 ; frame=44 A=5 L=0
	.byte $3D ; frame=44 B=7 L=2
; A: 41
; B: 15
	.byte $18 ; frame=46 A=3 L=0
	.byte $5D ; frame=46 B=11 L=2
; A: 24
; B: 12
	.byte $30 ; frame=48 A=6 L=0
	.byte $65 ; frame=48 B=12 L=2
; A: 31
; B: 24
	.byte $00 ; frame=50 A=0 L=0
	.byte $4D ; frame=50 B=9 L=2
; A: 36
; B: 55
	.byte $08 ; frame=52 A=1 L=0
	.byte $05 ; frame=52 B=0 L=2
; A: 43
; B: 58
	.byte $10 ; frame=54 A=2 L=0
	.byte $6D ; frame=54 B=13 L=2
; A: 51
; B: 55
	.byte $18 ; frame=56 A=3 L=0
	.byte $85 ; frame=56 B=16 L=2
; A: 50
; B: 53
	.byte $38 ; frame=58 A=7 L=0
	.byte $6D ; frame=58 B=13 L=2
; A: 46
; B: 26
	.byte $40 ; frame=60 A=8 L=0
	.byte $55 ; frame=60 B=10 L=2
; A: 43
; B: 50
	.byte $20 ; frame=62 A=4 L=0
	.byte $75 ; frame=62 B=14 L=2
; last: a=3 b=8 len=2
	.byte $18 ; frame=64 A=3 L=0
	.byte $45 ; frame=64 B=8 L=2
	.byte $FF ; end
; Octave 0 : 0 0 0 0 0 0 0 0 0 0 0 0 
; Octave 1 : 12 0 0 9 0 0 0 9 0 0 0 0 
; Octave 2 : 32 0 2 0 0 0 0 20 0 0 0 0 
; Octave 3 : 20 0 0 0 0 15 0 39 0 0 20 0 
; Octave 4 : 15 0 13 15 0 12 0 8 0 0 3 0 
; Octave 5 : 2 0 1 0 0 0 0 0 0 0 0 0 
; 18 notes allocated
;.byte 24,31,36,43,46,48,41,51,50,12,53,19,15,55,26,60,58,62,
frequencies_low:
.byte $E8,$46,$F4,$A3,$89,$7A,$B7,$66,$6C,$D1,$5B,$8C,$36,$51,$B3,$3D,$44,$36
frequencies_high:
.byte $01,$01,$00,$00,$00,$00,$00,$00,$00,$03,$00,$02,$03,$00,$01,$00,$00,$00
; total len=37

channel_a_volume:
        .byte 15,15,15,15,9,9,9,9

channel_b_volume:
        .byte 9,9,9,9,5,5,5,5

        lengths:
        .byte 0*4,1*4,2*4,4*4

        tracks_l:
                .byte <track0,<track0,<track1,<track1,<track3,<track2

; assume all on same page
;       tracks_h:
;               .byte >track4,>track0 ;,>track1,>track2,>track3
