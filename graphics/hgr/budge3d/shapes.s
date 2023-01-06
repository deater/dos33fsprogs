;===========================================================
;
; If configured without the HRCG, the module starts here.  *
;
; Note that all tables are page-aligned for performance.   *
;
;===========================================================

NumObjects:	.byte 2		; number of objects
		.byte 35	; number of points (unused)
		.byte 41	; number of lines (unused)
;
; The next five tables represent the data as it was entered into the shape
; editor.  There are two shapes.  The first (space shuttle) starts at offset 0,
; has 27 points, and 29 lines.  The second (cube) starts immediately after the
; first, has 8 points, and 12 lines.
;

; 3D mesh X coordinates (-60, -57, ...)
ShapeXCoords:

	; spaceship

	.byte $c4,$c7,$c7,$c7,$c7,$d6,$d6,$d6	; $00
	.byte $d6,$f1,$f1,$00,$00,$15,$15,$1e	; $08
	.byte $1e,$1e,$1e,$24,$24,$24,$24,$09	; $10
	.byte $1b,$15,$1e			; $18

	; cube
	.byte $fb,$05,$05,$fb,$fb		; $1b
	.byte $05,$05,$fb			; $20

	; junk

	.byte $ec,$fc,$0c,$18,$28,$30,$44,$50,$74,$7c,$05,$fb,$00,$c4,$ca,$ca,$ca,$ca,$d6,$d6,$d6,$d6,$f1,$f1,$00,$00,$15,$15,$1e
	.byte $1e,$1e,$1e,$24,$24,$24,$24,$09,$1b,$15,$1e,$d8,$e8,$f8,$08,$18,$28,$9c,$c4,$ec,$14,$3c,$64,$c9,$37,$b5,$4b,$22,$de,$de,$f2,$0e
	.byte $22,$22,$de,$de,$f2,$0e,$22,$28,$39,$46,$d8,$c7,$ba,$00,$00,$00,$4d,$4d,$3f,$3f,$b3,$b3,$c1,$c1,$f9,$07,$07,$f9,$11,$ef,$ef,$11
	.byte $08,$f8,$0a,$f6,$19,$e7,$19,$e7,$00,$fa,$06,$00,$00,$fc,$04,$fc,$04,$fa,$06,$f6,$0a,$fc,$04,$f4,$0c,$fa,$06,$fa,$06,$f6,$0a,$f6
	.byte $0a,$f4,$0c,$f4,$0c,$d0,$30,$d0,$30,$d0,$30,$d0,$30,$d0,$30,$d0,$30,$d3,$06,$fc,$1a,$ba,$00,$da,$03,$16,$1a,$b0,$00,$ba,$02,$10
	.byte $34,$1a,$98,$19,$2b,$da,$03,$1b,$ab,$3b,$a0,$a0,$ab,$a4,$01,$df,$82,$d9,$0b,$f2,$0c,$d8,$06,$06,$2b,$7c,$10,$5b,$08,$3f,$19,$16
	.byte $0f,$01,$9c,$19,$23,$0f,$01,$97,$f2,$18,$24,$00,$0c,$c0,$f8,$06,$ed,$2b,$7c,$42,$1a,$ac,$00,$ba,$5c,$06,$f1,$1a,$03,$00,$da,$06

; 3D mesh Y coordinates (0, 3, ...)
ShapeYCoords:
	; spaceship
	.byte $00,$03,$03,$fd,$fd,$06,$09,$fa
	.byte $f7,$09,$f7,$0f,$f1,$24,$dc,$24
	.byte $dc,$09,$f7,$09,$f7,$06,$fa,$00
	.byte $00,$00,$00

	; cube
	.byte $fb,$fb,$05,$05,$fb
	.byte $fb,$05,$05

	; garbage
	.byte $d0,$e0,$bc,$b0,$c4,$d8,$d0,$e0,$e0,$d0,$0a,$0a,$22,$00,$05,$05,$fb,$fb,$06,$09,$fa,$f7,$09,$f7,$0f,$f1,$24,$dc,$24
	.byte $dc,$09,$f7,$09,$f7,$06,$fa,$00,$00,$00,$00,$20,$20,$20,$20,$20,$20,$e0,$e0,$e0,$e0,$e0,$e0,$10,$10,$fa,$fa,$f4,$f4,$0c,$20,$20
	.byte $0c,$f4,$f4,$0c,$20,$20,$0c,$00,$00,$00,$00,$00,$00,$28,$39,$46,$f9,$07,$07,$f9,$f9,$07,$07,$f9,$4d,$4d,$3f,$3f,$ef,$ef,$11,$11
	.byte $0e,$0e,$1b,$1b,$11,$11,$e7,$e7,$00,$06,$06,$fa,$0a,$0a,$0a,$0a,$0a,$06,$06,$06,$06,$fa,$fa,$06,$06,$06,$06,$fa,$fa,$04,$04,$fc
	.byte $fc,$04,$04,$fc,$fc,$0c,$0c,$f4,$f4,$0c,$0c,$f4,$f4,$0c,$0c,$f4,$f4,$06,$00,$4f,$0c,$d0,$d2,$a3,$02,$00,$2c,$0d,$c5,$e4,$e9,$f4
	.byte $04,$06,$00,$a2,$0d,$c1,$00,$00,$00,$20,$4d,$0a,$a9,$ff,$85,$31,$a0,$00,$a5,$24,$c9,$27,$d0,$09,$20,$8e,$fd,$85,$31,$a9,$06,$85
	.byte $24,$b1,$12,$c5,$30,$d0,$13,$e6,$31,$a4,$31,$c0,$10,$b0,$0b,$be,$f0,$00,$e4,$24,$90,$04,$86,$24,$90,$d6,$20,$ed,$fd,$e6,$12,$d0

; 3D mesh Z coordinates (0, 3, ...)
ShapeZCoords:
	; spaceship
	.byte $00,$03,$fd,$03,$fd,$09,$fa,$09
	.byte $fa,$fa,$fa,$fa,$fa,$fa,$fa,$fa
	.byte $fa,$fa,$fa,$fa,$fa,$09,$09,$09
	.byte $09,$1b,$1b

	; cube
	.byte $fb,$fb,$fb,$fb,$05
	.byte $05,$05,$05

	; garbage
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$05,$fb,$05,$fb,$09,$fa,$09,$fa,$fa,$fa,$fa,$fa,$fa,$fa,$fa
	.byte $fa,$fa,$fa,$fa,$fa,$09,$09,$09,$09,$1e,$1e,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$e2,$e2,$e0,$e0,$e0,$e0,$fd,$de,$c9,$fd,$de,$c9,$fb,$db,$c6,$c9,$c6,$c6,$c9,$c9,$c6,$c6,$c9,$c6,$c6,$c9,$c9,$28,$28,$2a,$2a
	.byte $16,$16,$03,$03,$20,$20,$1e,$1e,$5a,$1e,$1e,$1e,$24,$22,$22,$0c,$0c,$12,$12,$10,$10,$0c,$0c,$e8,$e8,$e2,$e2,$e8,$e8,$fa,$fa,$fa
	.byte $fa,$e8,$e8,$e8,$e8,$f4,$f4,$f4,$f4,$ee,$ee,$ee,$ee,$00,$00,$00,$00,$89,$f6,$01,$e2,$10,$27,$e8,$03,$64,$00,$0a,$00,$01,$00,$2b
	.byte $35,$25,$37,$00,$4c,$45,$08,$2b,$d7,$02,$58,$36,$01,$f5,$20,$89,$f6,$6c,$3b,$38,$08,$ed,$07,$02,$eb,$f8,$4c,$07,$03,$6c,$38,$ec
	.byte $28,$db,$02,$a5,$00,$20,$8e,$0a,$20,$89,$f6,$29,$d7,$03,$e2,$00,$60,$00,$20,$8e,$fd,$20,$ce,$0a,$20,$d5,$0e,$20,$c9,$09,$20,$89

; 3D mesh line definition: start points (0, 0, 0, ...)
LineStartPoint: ; b00
	; spaceship (29 lines)
	.byte $00,$00,$00,$00,$01,$02,$03,$04
	.byte $06,$08,$09,$0a,$0b,$0c,$0d,$0e
	.byte $0f,$10,$11,$12,$13,$05,$07,$13
	.byte $14,$15,$17,$19,$1a

	; cube (12 lines)
	.byte $1b,$1c,$1d
	.byte $1e,$1f,$20,$21,$22,$1b,$1c,$1d
	.byte $1e

	; junk
	.byte $26,$27,$28,$29,$2a,$2b,$2d,$2e,$30,$30,$30,$30,$31,$32,$33,$34,$36,$38,$39,$3a,$3b,$3c,$3d
	.byte $3e,$3f,$40,$41,$42,$43,$35,$37,$43,$44,$45,$47,$49,$48,$4b,$4c,$4d,$4e,$4f,$50,$4b,$57,$59,$51,$5d,$63,$5d,$5e,$5f,$65,$5f,$60
	.byte $5b,$60,$61,$66,$67,$5c,$5d,$62,$63,$6a,$5e,$5f,$64,$65,$6d,$70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7a,$7b,$7c,$7d,$7e,$7f,$80
	.byte $81,$7e,$7f,$7e,$7f,$84,$85,$84,$85,$86,$87,$88,$88,$88,$8c,$8c,$8d,$8e,$89,$8a,$91,$92,$93,$94,$93,$94,$8b,$8b,$97,$98,$99,$97
	.byte $98,$99,$9a,$9d,$a1,$a9,$9f,$a3,$ab,$9e,$a2,$aa,$a0,$a4,$ac,$39,$a3,$38,$01,$0a,$a5,$03,$4d,$d6,$03,$4a,$37,$38,$25,$39,$11,$3c
	.byte $00,$29,$71,$28,$71,$00,$20,$da,$0b,$4c,$45,$08,$20,$89,$f6,$e8,$11,$3c,$00,$32,$b0,$71,$e0,$71,$22,$00,$6c,$08,$00,$14,$cd,$fe
	.byte $00,$20,$ce,$0a,$20,$89,$f6,$29,$3a,$28,$3b,$eb,$00,$20,$8e,$0a,$20,$89,$f6,$29,$38,$2a,$39,$f8,$28,$b9,$f8,$00,$20,$cc,$0b,$20

; 3D mesh line definition: end points (1, 2, 3, ...)
LineEndPoint: ; c00

	; spaceship (29 lines)
	.byte $01,$02,$03,$04,$05,$06,$07,$08
	.byte $09,$0a,$0b,$0c,$0d,$0e,$0f,$10
	.byte $11,$12,$13,$14,$14,$15,$16,$15
	.byte $16,$16,$19,$1a,$18

	; cube (12 lines)
	.byte $1c,$1d,$1e
	.byte $1b,$20,$21,$22,$1f,$1f,$20,$21
	.byte $22

	; junk
	.byte $27,$28,$29,$2a,$2b,$2c,$2f,$2f,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3a,$3b,$3c,$3d,$3e,$3f
	.byte $40,$41,$42,$43,$44,$44,$45,$46,$45,$46,$46,$49,$4a,$4a,$51,$52,$53,$54,$55,$56,$50,$58,$5a,$56,$5e,$64,$63,$64,$60,$66,$65,$66
	.byte $67,$67,$68,$68,$69,$6a,$6a,$6b,$6b,$6c,$6d,$6d,$6e,$6e,$6f,$71,$72,$73,$70,$75,$76,$77,$74,$79,$7a,$7b,$78,$7d,$7e,$7f,$7c,$82
	.byte $83,$81,$80,$85,$84,$80,$81,$60,$5d,$84,$85,$89,$8a,$8b,$8d,$8e,$8f,$90,$91,$92,$93,$94,$95,$96,$97,$98,$9b,$9c,$99,$9a,$9a,$9b
	.byte $9c,$9b,$9c,$a5,$a9,$ad,$a7,$ab,$af,$a6,$aa,$ae,$a8,$ac,$b0,$10,$dd,$08,$3f,$19,$6b,$0f,$00,$20,$d0,$09,$20,$0c,$fd,$c9,$d3,$66
	.byte $33,$20,$ce,$0a,$a9,$ff,$85,$2f,$d0,$00,$20,$61,$0c,$20,$89,$f6,$11,$00,$02,$29,$d4,$06,$04,$49,$51,$01,$f8,$4a,$06,$03,$51,$01
	.byte $fa,$21,$3a,$f2,$42,$51,$d3,$07,$fb,$19,$00,$02,$11,$7c,$03,$24,$71,$2a,$71,$00,$20,$7b,$0d,$24,$33,$10,$0c,$20,$0c,$fd,$c9,$83

;
; For shape N, the index of the first point.
;
; Shape #0 uses points $00-1A, shape #1 uses points $1B-22.  (Data at offsets 2-
; 15 is junk.)
FirstPointIndex:
	.byte $00,$1b
	.byte $08,$0c,$0d,$1d,$2d,$30,$4b,$5b,$88,$7c,$03,$61,$39,$e9

; For shape N, the index of the last point + 1.
LastPointIndex:
	.byte $1b,$23
	.byte $0c,$0d,$1d,$2d,$30,$4b,$5b,$88,$b1,$2a,$1a,$00,$02,$ba

;
; For shape N, the index of the first line.
;
; Shape #0 uses lines $00-1C, shape #1 uses lines $1D-28.  (Data at offsets 2-15
; is junk.)

FirstLineIndex:
	.byte $00,$1d
	.byte $0c,$01,$12,$20,$2f,$31,$4e,$58,$8b,$01,$9c,$00,$a5,$16

; For shape N, the index of the last point + 1.
LastLineIndex:
	.byte $1d,$29
	.byte $12,$01,$20,$2f,$31,$4e,$58,$8b,$af,$fe,$4c,$45,$08,$20

;
; Indexes into the rotation tables.  One entry for each rotation value (0-27). 
; The "low" and "high" tables have the same value at each position, just shifted
; over 4 bits.
;
; Mathematically, cosine has the same shape as sine, but is shifted by PI/2 (one
; quarter period) ahead of it.  That's why there are two sets of tables, one of
; which is shifted by 7 bytes.
;
; See the comments above RotTabLo for more details.
;

RotIndexLo_sin:
	.byte $70,$60,$50,$40,$30,$20,$10,$00
	.byte $10,$20,$30,$40,$50,$60,$70,$80
	.byte $90,$a0,$b0,$c0,$d0,$e0,$d0,$c0
	.byte $b0,$a0,$90,$80

RotIndexHi_sin:
	.byte $07,$06,$05,$04,$03,$02,$01,$00
	.byte $01,$02,$03,$04,$05,$06,$07,$08
	.byte $09,$0a,$0b,$0c,$0d,$0e,$0d,$0c
	.byte $0b,$0a,$09,$08

RotIndexLo_cos:
	.byte $00,$10,$20,$30,$40,$50,$60,$70
	.byte $80,$90,$a0,$b0,$c0,$d0,$e0,$d0
	.byte $c0,$b0,$a0,$90,$80,$70,$60,$50
	.byte $40,$30,$20,$10

RotIndexHi_cos:
	.byte $00,$01,$02,$03,$04,$05,$06,$07
	.byte $08,$09,$0a,$0b,$0c,$0d,$0e,$0d
	.byte $0c,$0b,$0a,$09,$08,$07,$06,$05
	.byte $04,$03,$02,$01

;
; Indexes into the scale tables.  One entry for each scale value (0-15).  See
; the comments above ScaleTabLo for more details.
;
ScaleIndexLo:
	.byte $00,$10,$20,$30,$40,$50,$60,$70,$80,$90,$a0,$b0,$c0,$d0,$e0,$f0

ScaleIndexHi:
	.byte $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f

;
; Junk, pads to end of 256-byte page.
.align  $0100 ; (48 bytes)

