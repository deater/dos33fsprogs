peasant_song:
; register init
	.byte   $00,$00,$00,$00,$00,$00         ; $00: A/B/C fine/coarse
	.byte   $00                             ; $06
	.byte   $38                             ; $07 mixer (ABC on)
	.byte   $0E,$0C,$0C                     ; $08 volume A/B/C
	.byte   $00,$00,$00,$00                 ; $09

	.byte $20 ; A = C 2
	.byte $4C ; B = R--3
	.byte $8C ; C = R--3
	.byte $CB ; L = 11

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $CB ; L = 11

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $CB ; L = 11

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $CB ; L = 11

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C4 ; L = 4

	.byte $25 ; A = F 2
	.byte $CB ; L = 11

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $25 ; A = F 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $25 ; A = F 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $25 ; A = F 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $25 ; A = F 2
	.byte $CB ; L = 11

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $25 ; A = F 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $25 ; A = F 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $25 ; A = F 2
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $CB ; L = 11

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $27 ; A = G 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $27 ; A = G 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $27 ; A = G 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $27 ; A = G 2
	.byte $CB ; L = 11

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $27 ; A = G 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $27 ; A = G 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $27 ; A = G 2
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $4C ; B = R--3
	.byte $C4 ; L = 4

	.byte $4C ; B = R--3
	.byte $C4 ; L = 4

	.byte $0C ; A = R--3
	.byte $4C ; B = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $4C ; B = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $4C ; B = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $4C ; B = R--3
	.byte $CB ; L = 11

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $C8 ; L = 8

	.byte $47 ; B = G 4
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $4C ; B = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $47 ; B = G 4
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $4C ; B = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $47 ; B = G 4
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $45 ; B = F 4
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $4C ; B = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $45 ; B = F 4
	.byte $C3 ; L = 3

	.byte $4C ; B = R--3
	.byte $C1 ; L = 1

	.byte $45 ; B = F 4
	.byte $C4 ; L = 4

	.byte $44 ; B = E 4
	.byte $C3 ; L = 3

	.byte $4C ; B = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $44 ; B = E 4
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $4C ; B = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $44 ; B = E 4
	.byte $C3 ; L = 3

	.byte $0C ; A = R--3
	.byte $C1 ; L = 1

	.byte $20 ; A = C 2
	.byte $45 ; B = F 4
	.byte $C4 ; L = 4

	.byte $25 ; A = F 2
	.byte $CC ; L = 12

	.byte $25 ; A = F 2
	.byte $C4 ; L = 4

	.byte $25 ; A = F 2
	.byte $C4 ; L = 4

	.byte $25 ; A = F 2
	.byte $C4 ; L = 4

	.byte $25 ; A = F 2
	.byte $CC ; L = 12

	.byte $25 ; A = F 2
	.byte $C4 ; L = 4

	.byte $25 ; A = F 2
	.byte $C4 ; L = 4

	.byte $25 ; A = F 2
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $C8 ; L = 8

	.byte $47 ; B = G 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $47 ; B = G 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $47 ; B = G 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $45 ; B = F 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $45 ; B = F 4
	.byte $C4 ; L = 4

	.byte $45 ; B = F 4
	.byte $C4 ; L = 4

	.byte $44 ; B = E 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $44 ; B = E 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $44 ; B = E 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $45 ; B = F 4
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $42 ; B = D 4
	.byte $C3 ; L = 3

	.byte $42 ; B = D 4
	.byte $C1 ; L = 1

	.byte $42 ; B = D 4
	.byte $C2 ; L = 2

	.byte $42 ; B = D 4
	.byte $C3 ; L = 3

	.byte $42 ; B = D 4
	.byte $C3 ; L = 3

	.byte $20 ; A = C 2
	.byte $4A ; B = A#4
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $4A ; B = A#4
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $4A ; B = A#4
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $42 ; B = D 4
	.byte $C3 ; L = 3

	.byte $42 ; B = D 4
	.byte $C1 ; L = 1

	.byte $42 ; B = D 4
	.byte $C2 ; L = 2

	.byte $42 ; B = D 4
	.byte $C4 ; L = 4

	.byte $42 ; B = D 4
	.byte $C2 ; L = 2

	.byte $20 ; A = C 2
	.byte $47 ; B = G 4
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $47 ; B = G 4
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $47 ; B = G 4
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $42 ; B = D 4
	.byte $C3 ; L = 3

	.byte $42 ; B = D 4
	.byte $C1 ; L = 1

	.byte $42 ; B = D 4
	.byte $C2 ; L = 2

	.byte $42 ; B = D 4
	.byte $C2 ; L = 2

	.byte $42 ; B = D 4
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $4A ; B = A#4
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $4A ; B = A#4
	.byte $C2 ; L = 2

	.byte $42 ; B = D 4
	.byte $C2 ; L = 2

	.byte $20 ; A = C 2
	.byte $C2 ; L = 2

	.byte $42 ; B = D 4
	.byte $C2 ; L = 2

	.byte $20 ; A = C 2
	.byte $47 ; B = G 4
	.byte $C4 ; L = 4

	.byte $47 ; B = G 4
	.byte $C2 ; L = 2

	.byte $42 ; B = D 4
	.byte $C4 ; L = 4

	.byte $42 ; B = D 4
	.byte $C2 ; L = 2

	.byte $20 ; A = C 2
	.byte $45 ; B = F 4
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $45 ; B = F 4
	.byte $C2 ; L = 2

	.byte $47 ; B = G 4
	.byte $C2 ; L = 2

	.byte $20 ; A = C 2
	.byte $C2 ; L = 2

	.byte $47 ; B = G 4
	.byte $C2 ; L = 2

	.byte $25 ; A = F 2
	.byte $CC ; L = 12

	.byte $25 ; A = F 2
	.byte $C4 ; L = 4

	.byte $25 ; A = F 2
	.byte $C4 ; L = 4

	.byte $25 ; A = F 2
	.byte $C4 ; L = 4

	.byte $25 ; A = F 2
	.byte $CC ; L = 12

	.byte $25 ; A = F 2
	.byte $C4 ; L = 4

	.byte $25 ; A = F 2
	.byte $C4 ; L = 4

	.byte $25 ; A = F 2
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $C8 ; L = 8

	.byte $47 ; B = G 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $47 ; B = G 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $47 ; B = G 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $45 ; B = F 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $45 ; B = F 4
	.byte $C4 ; L = 4

	.byte $45 ; B = F 4
	.byte $C4 ; L = 4

	.byte $44 ; B = E 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $44 ; B = E 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $44 ; B = E 4
	.byte $C4 ; L = 4

	.byte $27 ; A = G 2
	.byte $45 ; B = F 4
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $47 ; B = G 4
	.byte $C4 ; L = 4

	.byte $47 ; B = G 4
	.byte $C4 ; L = 4

	.byte $47 ; B = G 4
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $CC ; L = 12

	.byte $20 ; A = C 2
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $C4 ; L = 4

	.byte $20 ; A = C 2
	.byte $FF
