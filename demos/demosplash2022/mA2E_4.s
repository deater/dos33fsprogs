; Octave 0 : 0 0 0 3 0 3 0 3 3 0 16 0
; Octave 1 : 45 0 0 19 0 23 0 0 0 0 5 0
; Octave 2 : 14 0 2 6 0 8 0 0 0 0 0 0
; Octave 3 : 0 0 0 1 0 1 0 2 0 0 2 0
; Octave 4 : 4 0 1 5 2 5 0 7 0 2 4 0
; Octave 5 : 3 0 4 1 5 2 0 0 0 0 0 0
; 30 notes allocated
;.byte 12,55,24,64,10,62,60,15,17,58,22,57,8,7,5,3,53,52,29,27,26,65,63,51,50,48,46,39,41,43,

frequencies_low:
.byte $D1,$51,$E8,$30,$49,$36,$3D,$36
.byte $DC,$44,$24,$48,$CF,$18,$B8,$6C
.byte $5B,$60,$6E,$9B,$B3,$2D,$33,$66
.byte $6C,$7A,$89,$CD,$B7,$A3

frequencies_high:
.byte $03,$00,$01,$00,$04,$00,$00,$03,$02,$00,$02,$00,$04,$05,$05,$06,$00,$00,$01,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00
; total len=61

; pattern 0
; 0 -> F
; 48-> C
; 50-> A
; 52-> 9
; 54-> 8
; 56-> 7
; 58-> 6
; 60-> 5
; 62-> 4
bamps0:
;         0  15  30  45  48  50  52  54  56  58  60  62
.byte	$FF,$FF,$FF,$3F,$2C,$2A,$29,$28,$27,$26,$25,$24

; pattern 1
; 0 -> F
; 9 -> C
;10 -> F
;20 -> C
;22 -> F
;29 -> C
;30 -> F
;31 -> C
;32 -> F
;40 -> C
; 48-> A
; 50-> 9
; 52-> 8
; 54-> 7
; 56-> 6
; 58-> 5
; 60-> 4
; 62-> 3
bamps1:
;       0   9  10  20  22  29  30  31  32  40  48  50  52 54   56  58  60  62
.byte $9F,$1C,$AF,$2C,$7F,$1C,$1F,$1C,$8F,$8C,$2A,$29,$28,$27,$26,$25,$24,$23

; pattern 2
; 0 ->F
; 13->C
; 14->F
; 15->C
; 16->F
; 24->C
; 26->9
; 28->8
; 30->7
; 32->F
; 45->C
; 46->F
; 47->C
; 48->F
; 56->C
; 58->9
; 60->7
; 62->6
bamps2:
;       0  13  14  15  16  24  26  28  30  32  45  46  47  48  56  58  60  62
.byte $DF,$1C,$1F,$1C,$8F,$2C,$29,$28,$27,$DF,$1C,$1F,$1C,$8F,$2C,$29,$27,$26

; pattern3
; 0->F
; 24->C
; 26->9
; 28->8
; 30->7
; 32->F
; 45->C
; 46->F
; 47->C
; 48->F
; 56->C
; 58->9
; 60->7
; 62->6
bamps3:
;       0  15  24  26  28  30  32  45  46  47  48  56  58  60  62
.byte $FF,$9F,$2C,$29,$28,$27,$DF,$1C,$1F,$1C,$8F,$2C,$29,$27,$26

; pattern4
;  0->0
; 60->F
; 61->C
; 62->F
; 63->C

bamps4:
;       0  15  30  45  60  61  62  63
.byte $F0,$F0,$F0,$F0,$1F,$1C,$1F,$1C


.align $100

channel_a_volume:
        .byte 14,14,14,14,11,11,10,10

        lengths:
        .byte 0*8,1*8,2*8,4*8

        tracks_l:
                .byte <track4,<track0,<track1,<track2,<track3

; assume all on same page
;       tracks_h:
;               .byte >track4,>track0,>track1,>track2,>track3

        bamps_l:
                .byte <bamps4,<bamps0,<bamps1,<bamps2,<bamps3
;        bamps_h:
;                .byte >bamps4,>bamps0,>bamps1,>bamps2,>bamps3



track0:

; A: 12
; B: 55
; A: 12
	.byte $00 ; frame=2 A=0 L=0
	.byte $0D ; frame=2 B=1 L=2
; A: 24
; B: 64
	.byte $04 ; frame=4 A=0 L=2
; A: 12
	.byte $10 ; frame=6 A=2 L=0
	.byte $1D ; frame=6 B=3 L=2
; A: 10
; B: 62
	.byte $04 ; frame=8 A=0 L=2
; A: 12
; B: 60
	.byte $20 ; frame=10 A=4 L=0
	.byte $2D ; frame=10 B=5 L=2
; A: 15
	.byte $00 ; frame=12 A=0 L=0
	.byte $35 ; frame=12 B=6 L=2
; A: 17
; B: 58
	.byte $3C ; frame=14 A=7 L=2
; A: 10
	.byte $40 ; frame=16 A=8 L=0
	.byte $4D ; frame=16 B=9 L=2
; A: 10
	.byte $24 ; frame=18 A=4 L=2
; A: 22
	.byte $24 ; frame=20 A=4 L=2
; A: 10
; B: 57
	.byte $54 ; frame=22 A=10 L=2
; A: 8
; B: 58
	.byte $20 ; frame=24 A=4 L=0
	.byte $5D ; frame=24 B=11 L=2
; A: 7
; B: 57
	.byte $60 ; frame=26 A=12 L=0
	.byte $4D ; frame=26 B=9 L=2
; A: 5
; B: 55
	.byte $68 ; frame=28 A=13 L=0
	.byte $5D ; frame=28 B=11 L=2
; A: 3
; B: 53
	.byte $70 ; frame=30 A=14 L=0
	.byte $0D ; frame=30 B=1 L=2
; A: 12
; B: 52
	.byte $78 ; frame=32 A=15 L=0
	.byte $85 ; frame=32 B=16 L=2
; A: 12
	.byte $00 ; frame=34 A=0 L=0
	.byte $8D ; frame=34 B=17 L=2
; A: 24
	.byte $04 ; frame=36 A=0 L=2
; A: 12
; B: 55
	.byte $14 ; frame=38 A=2 L=2
; A: 10
	.byte $00 ; frame=40 A=0 L=0
	.byte $0D ; frame=40 B=1 L=2
; A: 12
	.byte $24 ; frame=42 A=4 L=2
; A: 15
	.byte $04 ; frame=44 A=0 L=2
; A: 17
	.byte $3C ; frame=46 A=7 L=2
; A: 17
	.byte $44 ; frame=48 A=8 L=2
; A: 17
	.byte $44 ; frame=50 A=8 L=2
; A: 29
	.byte $44 ; frame=52 A=8 L=2
; A: 29
	.byte $94 ; frame=54 A=18 L=2
; A: 27
	.byte $94 ; frame=56 A=18 L=2
; A: 26
	.byte $9C ; frame=58 A=19 L=2
; A: 24
	.byte $A4 ; frame=60 A=20 L=2
; A: 22
	.byte $14 ; frame=62 A=2 L=2
; last: a=10 b=-1 len=2
	.byte $54 ; frame=64 A=10 L=2
.byte $ff
track1:

; A: 12
; B: 55
; A: 12
	.byte $00 ; frame=2 A=0 L=0
	.byte $0D ; frame=2 B=1 L=2
; A: 24
; B: 64
	.byte $04 ; frame=4 A=0 L=2
; A: 12
	.byte $10 ; frame=6 A=2 L=0
	.byte $1D ; frame=6 B=3 L=2
; A: 10
; B: 62
	.byte $04 ; frame=8 A=0 L=2
; A: 12
; B: 64
	.byte $20 ; frame=10 A=4 L=0
	.byte $2D ; frame=10 B=5 L=2
; A: 15
	.byte $00 ; frame=12 A=0 L=0
	.byte $1D ; frame=12 B=3 L=2
; A: 17
; B: 65
	.byte $3C ; frame=14 A=7 L=2
; A: 10
	.byte $40 ; frame=16 A=8 L=0
	.byte $AD ; frame=16 B=21 L=2
; A: 10
	.byte $24 ; frame=18 A=4 L=2
; A: 22
	.byte $24 ; frame=20 A=4 L=2
; A: 10
; B: 64
	.byte $54 ; frame=22 A=10 L=2
; A: 8
; B: 65
	.byte $20 ; frame=24 A=4 L=0
	.byte $1D ; frame=24 B=3 L=2
; A: 7
; B: 64
	.byte $60 ; frame=26 A=12 L=0
	.byte $AD ; frame=26 B=21 L=2
; A: 5
; B: 62
	.byte $68 ; frame=28 A=13 L=0
	.byte $1D ; frame=28 B=3 L=2
; A: 3
; B: 60
	.byte $70 ; frame=30 A=14 L=0
	.byte $2D ; frame=30 B=5 L=2
; A: 12
; B: 52
	.byte $78 ; frame=32 A=15 L=0
	.byte $35 ; frame=32 B=6 L=2
; A: 12
	.byte $00 ; frame=34 A=0 L=0
	.byte $8D ; frame=34 B=17 L=2
; A: 24
	.byte $04 ; frame=36 A=0 L=2
; A: 12
	.byte $14 ; frame=38 A=2 L=2
; A: 10
	.byte $04 ; frame=40 A=0 L=2
; A: 12
	.byte $24 ; frame=42 A=4 L=2
; A: 15
	.byte $04 ; frame=44 A=0 L=2
; A: 17
	.byte $3C ; frame=46 A=7 L=2
; A: 17
	.byte $44 ; frame=48 A=8 L=2
; A: 17
	.byte $44 ; frame=50 A=8 L=2
; A: 29
	.byte $44 ; frame=52 A=8 L=2
; A: 29
	.byte $94 ; frame=54 A=18 L=2
; A: 27
	.byte $94 ; frame=56 A=18 L=2
; A: 26
	.byte $9C ; frame=58 A=19 L=2
; A: 24
	.byte $A4 ; frame=60 A=20 L=2
; A: 22
	.byte $14 ; frame=62 A=2 L=2
; last: a=10 b=-1 len=2
	.byte $54 ; frame=64 A=10 L=2
.byte $ff
track2:

; A: 15
; B: 63
; A: 15
	.byte $38 ; frame=2 A=7 L=0
	.byte $B5 ; frame=2 B=22 L=2
; A: 27
	.byte $3C ; frame=4 A=7 L=2
; A: 15
	.byte $9C ; frame=6 A=19 L=2
; A: 17
; B: 62
	.byte $3C ; frame=8 A=7 L=2
; A: 17
; B: 60
	.byte $40 ; frame=10 A=8 L=0
	.byte $2D ; frame=10 B=5 L=2
; A: 29
; B: 58
	.byte $40 ; frame=12 A=8 L=0
	.byte $35 ; frame=12 B=6 L=2
; A: 17
; B: 53
	.byte $90 ; frame=14 A=18 L=0
	.byte $4D ; frame=14 B=9 L=2
; A: 12
; B: 55
	.byte $40 ; frame=16 A=8 L=0
	.byte $85 ; frame=16 B=16 L=2
; A: 12
	.byte $00 ; frame=18 A=0 L=0
	.byte $0D ; frame=18 B=1 L=2
; A: 24
	.byte $04 ; frame=20 A=0 L=2
; A: 12
	.byte $14 ; frame=22 A=2 L=2
; A: 12
	.byte $04 ; frame=24 A=0 L=2
; A: 12
	.byte $04 ; frame=26 A=0 L=2
; A: 24
	.byte $04 ; frame=28 A=0 L=2
; A: 12
	.byte $14 ; frame=30 A=2 L=2
; A: 15
; B: 51
	.byte $04 ; frame=32 A=0 L=2
; A: 15
	.byte $38 ; frame=34 A=7 L=0
	.byte $BD ; frame=34 B=23 L=2
; A: 27
	.byte $3C ; frame=36 A=7 L=2
; A: 15
	.byte $9C ; frame=38 A=19 L=2
; A: 17
; B: 55
	.byte $3C ; frame=40 A=7 L=2
; A: 17
; B: 53
	.byte $40 ; frame=42 A=8 L=0
	.byte $0D ; frame=42 B=1 L=2
; A: 29
; B: 51
	.byte $40 ; frame=44 A=8 L=0
	.byte $85 ; frame=44 B=16 L=2
; B: 50
	.byte $90 ; frame=45 A=18 L=0
	.byte $BB ; frame=45 B=23 L=1
; A: 17
; B: 48
	.byte $C3 ; frame=46 B=24 L=1
; B: 46
	.byte $40 ; frame=47 A=8 L=0
	.byte $CB ; frame=47 B=25 L=1
; A: 12
; B: 48
	.byte $D3 ; frame=48 B=26 L=1
; A: 10
	.byte $00 ; frame=52 A=0 L=0
	.byte $CF ; frame=52 B=25 L=3
; A: 12
	.byte $26 ; frame=56 A=4 L=3
; last: a=0 b=-1 len=8
	.byte $10 ; frame=64 A=0 L=8
.byte $ff
track3:

; A: 15
; B: 39
; A: 15
	.byte $38 ; frame=2 A=7 L=0
	.byte $DD ; frame=2 B=27 L=2
; A: 27
	.byte $3C ; frame=4 A=7 L=2
; A: 15
	.byte $9C ; frame=6 A=19 L=2
; A: 17
; B: 41
	.byte $3C ; frame=8 A=7 L=2
; A: 17
; B: 43
	.byte $40 ; frame=10 A=8 L=0
	.byte $E5 ; frame=10 B=28 L=2
; A: 29
; B: 46
	.byte $40 ; frame=12 A=8 L=0
	.byte $ED ; frame=12 B=29 L=2
; A: 17
; B: 48
	.byte $90 ; frame=14 A=18 L=0
	.byte $D5 ; frame=14 B=26 L=2
; A: 12
; B: 43
	.byte $40 ; frame=16 A=8 L=0
	.byte $CD ; frame=16 B=25 L=2
; A: 12
	.byte $00 ; frame=18 A=0 L=0
	.byte $ED ; frame=18 B=29 L=2
; A: 24
	.byte $04 ; frame=20 A=0 L=2
; A: 12
	.byte $14 ; frame=22 A=2 L=2
; A: 12
	.byte $04 ; frame=24 A=0 L=2
; A: 12
	.byte $04 ; frame=26 A=0 L=2
; A: 24
	.byte $04 ; frame=28 A=0 L=2
; A: 12
	.byte $14 ; frame=30 A=2 L=2
; A: 15
; B: 51
	.byte $04 ; frame=32 A=0 L=2
; A: 15
	.byte $38 ; frame=34 A=7 L=0
	.byte $BD ; frame=34 B=23 L=2
; A: 27
	.byte $3C ; frame=36 A=7 L=2
; A: 15
	.byte $9C ; frame=38 A=19 L=2
; A: 17
; B: 48
	.byte $3C ; frame=40 A=7 L=2
; A: 17
; B: 51
	.byte $40 ; frame=42 A=8 L=0
	.byte $CD ; frame=42 B=25 L=2
; A: 29
; B: 53
	.byte $40 ; frame=44 A=8 L=0
	.byte $BD ; frame=44 B=23 L=2
; A: 17
; B: 58
	.byte $90 ; frame=46 A=18 L=0
	.byte $85 ; frame=46 B=16 L=2
; A: 12
; B: 55
	.byte $40 ; frame=48 A=8 L=0
	.byte $4D ; frame=48 B=9 L=2
; A: 12
	.byte $00 ; frame=50 A=0 L=0
	.byte $0D ; frame=50 B=1 L=2
; A: 24
	.byte $04 ; frame=52 A=0 L=2
; A: 12
	.byte $14 ; frame=54 A=2 L=2
; A: 12
	.byte $04 ; frame=56 A=0 L=2
; A: 12
	.byte $04 ; frame=58 A=0 L=2
; A: 24
	.byte $04 ; frame=60 A=0 L=2
; A: 12
	.byte $14 ; frame=62 A=2 L=2
; last: a=0 b=-1 len=2
	.byte $04 ; frame=64 A=0 L=2
.byte $ff
track4:

; A: 12
; A: 12
	.byte $04 ; frame=2 A=0 L=2
; A: 24
	.byte $04 ; frame=4 A=0 L=2
; A: 12
	.byte $14 ; frame=6 A=2 L=2
; A: 10
	.byte $04 ; frame=8 A=0 L=2
; A: 12
	.byte $24 ; frame=10 A=4 L=2
; A: 15
	.byte $04 ; frame=12 A=0 L=2
; A: 17
	.byte $3C ; frame=14 A=7 L=2
; A: 10
	.byte $44 ; frame=16 A=8 L=2
; A: 10
	.byte $24 ; frame=18 A=4 L=2
; A: 22
	.byte $24 ; frame=20 A=4 L=2
; A: 10
	.byte $54 ; frame=22 A=10 L=2
; A: 8
	.byte $24 ; frame=24 A=4 L=2
; A: 7
	.byte $64 ; frame=26 A=12 L=2
; A: 5
	.byte $6C ; frame=28 A=13 L=2
; A: 3
	.byte $74 ; frame=30 A=14 L=2
; A: 12
	.byte $7C ; frame=32 A=15 L=2
; A: 12
	.byte $04 ; frame=34 A=0 L=2
; A: 24
	.byte $04 ; frame=36 A=0 L=2
; A: 12
	.byte $14 ; frame=38 A=2 L=2
; A: 10
	.byte $04 ; frame=40 A=0 L=2
; A: 12
	.byte $24 ; frame=42 A=4 L=2
; A: 15
	.byte $04 ; frame=44 A=0 L=2
; A: 17
	.byte $3C ; frame=46 A=7 L=2
; A: 17
	.byte $44 ; frame=48 A=8 L=2
; A: 15
	.byte $46 ; frame=52 A=8 L=3
; A: 12
	.byte $3E ; frame=56 A=7 L=3
; B: 51
	.byte $06 ; frame=60 A=0 L=3
; B: 53
	.byte $BD ; frame=62 B=23 L=2
; last: a=-1 b=16 len=2
	.byte $85 ; frame=64 B=16 L=2
	.byte $FF ; end


