
; spaceship and a cube

NumObjects = 2

;NumObjects:	.byte 2		; number of objects
;		.byte 35	; number of points (unused)
;		.byte 41	; number of lines (unused)
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

;
; For shape N, the index of the first point.
;
; Shape #0 uses points $00-1A, shape #1 uses points $1B-22.  (Data at offsets 2-
; 15 is junk.)
FirstPointIndex:
	.byte $00,$1b

; For shape N, the index of the last point + 1.
LastPointIndex:
	.byte $1b,$23

;
; For shape N, the index of the first line.
;
; Shape #0 uses lines $00-1C, shape #1 uses lines $1D-28.  (Data at offsets 2-15
; is junk.)

FirstLineIndex:
	.byte $00,$1d

; For shape N, the index of the last point + 1.
LastLineIndex:
	.byte $1d,$29



