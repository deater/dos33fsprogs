;
; Divide-by-7 table.  Used to divide the X coordinate (0-255) by 7, yielding a
; byte offset for the hi-res screen column.
;
Div7Tab: ; 1400
	.byte $00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$02,$02
	.byte $02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$03,$04,$04,$04,$04
	.byte $04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$06,$06,$06,$06,$06,$06
	.byte $06,$07,$07,$07,$07,$07,$07,$07,$08,$08,$08,$08,$08,$08,$08,$09
	.byte $09,$09,$09,$09,$09,$09,$0a,$0a,$0a,$0a,$0a,$0a,$0a,$0b,$0b,$0b
	.byte $0b,$0b,$0b,$0b,$0c,$0c,$0c,$0c,$0c,$0c,$0c,$0d,$0d,$0d,$0d,$0d
	.byte $0d,$0d,$0e,$0e,$0e,$0e,$0e,$0e,$0e,$0f,$0f,$0f,$0f,$0f,$0f,$0f
	.byte $10,$10,$10,$10,$10,$10,$10,$11,$11,$11,$11,$11,$11,$11,$12,$12
	.byte $12,$12,$12,$12,$12,$13,$13,$13,$13,$13,$13,$13,$14,$14,$14,$14
	.byte $14,$14,$14,$15,$15,$15,$15,$15,$15,$15,$16,$16,$16,$16,$16,$16
	.byte $16,$17,$17,$17,$17,$17,$17,$17,$18,$18,$18,$18,$18,$18,$18,$19
	.byte $19,$19,$19,$19,$19,$19,$1a,$1a,$1a,$1a,$1a,$1a,$1a,$1b,$1b,$1b
	.byte $1b,$1b,$1b,$1b,$1c,$1c,$1c,$1c,$1c,$1c,$1c,$1d,$1d,$1d,$1d,$1d
	.byte $1d,$1d,$1e,$1e,$1e,$1e,$1e,$1e,$1e,$1f,$1f,$1f,$1f,$1f,$1f,$1f
	.byte $20,$20,$20,$20,$20,$20,$20,$21,$21,$21,$21,$21,$21,$21,$22,$22
	.byte $22,$22,$22,$22,$22,$23,$23,$23,$23,$23,$23,$23,$24,$24,$24,$24

;
; Hi-res bit table.  Converts the X coordinate (0-255) into a bit position
; within a byte.  (Essentially 2 to the power of the remainder of the coordinate
; divided by 7.)
;

HiResBitTab: ; 1500
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08,$10,$20,$40,$01,$02,$04,$08,$10,$20,$40
	.byte $01,$02,$04,$08

;
; Hi-res Y-coordinate lookup table, low byte.  Values 0-191 are meaningful, 192-
; 255 are junk.
;

YTableLo: ; 1600
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$80,$80,$80,$80,$80,$80,$80,$80,$00,$00,$00,$00,$00,$00,$00,$00,$80,$80,$80,$80,$80,$80,$80,$80
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$80,$80,$80,$80,$80,$80,$80,$80,$00,$00,$00,$00,$00,$00,$00,$00,$80,$80,$80,$80,$80,$80,$80,$80
	.byte $28,$28,$28,$28,$28,$28,$28,$28,$a8,$a8,$a8,$a8,$a8,$a8,$a8,$a8,$28,$28,$28,$28,$28,$28,$28,$28,$a8,$a8,$a8,$a8,$a8,$a8,$a8,$a8
	.byte $28,$28,$28,$28,$28,$28,$28,$28,$a8,$a8,$a8,$a8,$a8,$a8,$a8,$a8,$28,$28,$28,$28,$28,$28,$28,$28,$a8,$a8,$a8,$a8,$a8,$a8,$a8,$a8
	.byte $50,$50,$50,$50,$50,$50,$50,$50,$d0,$d0,$d0,$d0,$d0,$d0,$d0,$d0,$50,$50,$50,$50,$50,$50,$50,$50,$d0,$d0,$d0,$d0,$d0,$d0,$d0,$d0
	.byte $50,$50,$50,$50,$50,$50,$50,$50,$d0,$d0,$d0,$d0,$d0,$d0,$d0,$d0,$50,$50,$50,$50,$50,$50,$50,$50,$d0,$d0,$d0,$d0,$d0,$d0,$d0,$d0


.align  $0100 ; (64 bytes)

;==============================================
; Hi-res Y-coordinate lookup table, high byte.
;==============================================

YTableHi:
	.byte $00,$04,$08,$0c,$10,$14,$18,$1c
	.byte $00,$04,$08,$0c,$10,$14,$18,$1c
	.byte $01,$05,$09,$0d,$11,$15,$19,$1d
	.byte $01,$05,$09,$0d,$11,$15,$19,$1d

	.byte $02,$06,$0a,$0e,$12,$16,$1a,$1e
	.byte $02,$06,$0a,$0e,$12,$16,$1a,$1e
	.byte $03,$07,$0b,$0f,$13,$17,$1b,$1f
	.byte $03,$07,$0b,$0f,$13,$17,$1b,$1f

	.byte $00,$04,$08,$0c,$10,$14,$18,$1c
	.byte $00,$04,$08,$0c,$10,$14,$18,$1c
	.byte $01,$05,$09,$0d,$11,$15,$19,$1d
	.byte $01,$05,$09,$0d,$11,$15,$19,$1d

	.byte $02,$06,$0a,$0e,$12,$16,$1a,$1e
	.byte $02,$06,$0a,$0e,$12,$16,$1a,$1e
	.byte $03,$07,$0b,$0f,$13,$17,$1b,$1f
	.byte $03,$07,$0b,$0f,$13,$17,$1b,$1f

	.byte $00,$04,$08,$0c,$10,$14,$18,$1c
	.byte $00,$04,$08,$0c,$10,$14,$18,$1c
	.byte $01,$05,$09,$0d,$11,$15,$19,$1d
	.byte $01,$05,$09,$0d,$11,$15,$19,$1d

	.byte $02,$06,$0a,$0e,$12,$16,$1a,$1e
	.byte $02,$06,$0a,$0e,$12,$16,$1a,$1e
	.byte $03,$07,$0b,$0f,$13,$17,$1b,$1f
	.byte $03,$07,$0b,$0f,$13,$17,$1b,$1f

.align  $0100 ; (64 bytes)

