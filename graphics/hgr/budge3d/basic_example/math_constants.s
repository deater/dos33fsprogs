;
; Math constants for rotation.
;
; To compute X * cos(theta), start by converting theta (0-27) into a table base
; address (using the 28-byte tables RotIndexLo_cos / RotIndexHi_cos).  Split the
; X coordinate into nibbles, use the low 4 bits to index into the adjusted
; RotTabLo pointer, and the high 4 bits to index into the adjusted RotTabHi
; pointer.  Add the values at those locations together.
;
; This is similar to the way the scale table works.  See ScaleTableLo, below,
; for a longer explanation of how the nibbles are used.
;
; As an example, suppose we have a point at (36,56), and we want to rotate it 90
; degrees (rot=7).  We use the RotIndex tables to get the table base addresses:
; sin=$00/$00 ($1200/$1300), cos=$70/$07 ($1270/$1307).  We split the
; coordinates into nibbles without shifting ($24,$38 --> $20 $04, $30 $08), and
; use the nibbles as indexes into the tables:
;
;  X * cos(theta) = ($1274)+($1327) = $00+$00 = 0
;  Y * sin(theta) = ($1208)+($1330) = $08+$30 = 56
;  X * sin(theta) = ($1204)+($1320) = $04+$20 = 36
;  Y * cos(theta) = ($1278)+($1337) = $00+$00 = 0
;
;  XC = X*cos(theta) - Y*sin(theta) = -56
;  YC = X*sin(theta) + Y*cos(theta) = 36
;
; which is exactly what we expected (counter-clockwise).
;
; The largest value from the index table is $EE, so that last 17 bytes in each
; table are unused.
;

RotTabLo: ; 1200
	.byte $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f
	.byte $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e,$0f
	.byte $00,$01,$02,$03,$04,$05,$05,$06,$07,$08,$09,$0a,$0b,$0c,$0d,$0e
	.byte $00,$01,$02,$02,$03,$04,$05,$05,$06,$07,$08,$09,$09,$0a,$0b,$0c
	.byte $00,$01,$01,$02,$02,$03,$04,$04,$05,$06,$06,$07,$07,$08,$09,$09
	.byte $00,$00,$01,$01,$02,$02,$03,$03,$03,$04,$04,$05,$05,$06,$06,$07
	.byte $00,$00,$00,$01,$01,$01,$01,$02,$02,$02,$02,$02,$03,$03,$03,$03
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$ff,$ff,$ff,$ff,$fe,$fe,$fe,$fe,$fe,$fd,$fd,$fd,$fd
	.byte $00,$00,$ff,$ff,$fe,$fe,$fd,$fd,$fd,$fc,$fc,$fb,$fb,$fa,$fa,$f9
	.byte $00,$ff,$ff,$fe,$fe,$fd,$fc,$fc,$fb,$fa,$fa,$f9,$f9,$f8,$f7,$f7
	.byte $00,$ff,$fe,$fe,$fd,$fc,$fb,$fb,$fa,$f9,$f8,$f7,$f7,$f6,$f5,$f4
	.byte $00,$ff,$fe,$fd,$fc,$fb,$fb,$fa,$f9,$f8,$f7,$f6,$f5,$f4,$f3,$f2
	.byte $00,$ff,$fe,$fd,$fc,$fb,$fb,$fa,$f8,$f7,$f6,$f5,$f4,$f3,$f2,$f1
	.byte $00,$ff,$fe,$fd,$fc,$fb,$fa,$f9,$f8,$f7,$f6,$f5,$f4,$f3,$f2,$f1
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

RotTabHi: ; 1300
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	.byte $10,$10,$0e,$0d,$0a,$07,$04,$00,$fc,$f9,$f6,$f3,$f2,$f0,$f0,$00
	.byte $20,$1f,$1d,$19,$14,$0e,$07,$00,$f9,$f2,$ec,$e7,$e3,$e1,$e0,$00
	.byte $30,$2f,$2b,$26,$1e,$15,$0b,$00,$f5,$eb,$e2,$da,$d5,$d1,$d0,$00
	.byte $40,$3e,$3a,$32,$28,$1c,$0e,$00,$f2,$e4,$d8,$ce,$c6,$c2,$c0,$00
	.byte $50,$4e,$48,$3f,$32,$23,$12,$00,$ee,$dd,$ce,$c1,$b8,$b2,$b0,$00
	.byte $60,$5e,$56,$4b,$3c,$2a,$15,$00,$eb,$d6,$c4,$b5,$aa,$a2,$a0,$00
	.byte $70,$6d,$65,$58,$46,$31,$19,$00,$e7,$cf,$ba,$a8,$9b,$93,$90,$00
	.byte $80,$83,$8d,$9c,$b0,$c8,$e4,$00,$1c,$38,$50,$64,$73,$7d,$80,$00
	.byte $90,$93,$9b,$a8,$ba,$cf,$e7,$00,$19,$31,$46,$58,$65,$6d,$70,$00
	.byte $a0,$a2,$aa,$b5,$c4,$d6,$eb,$00,$15,$2a,$3c,$4b,$56,$5e,$60,$00
	.byte $b0,$b2,$b8,$c1,$ce,$dd,$ee,$00,$12,$23,$32,$3f,$48,$4e,$50,$00
	.byte $c0,$c2,$c6,$ce,$d8,$e4,$f2,$00,$0e,$1c,$28,$32,$3a,$3e,$40,$00
	.byte $d0,$d1,$d5,$da,$e2,$eb,$f5,$00,$0b,$15,$1e,$26,$2b,$2f,$30,$00
	.byte $e0,$e1,$e3,$e7,$ec,$f2,$f9,$00,$07,$0e,$14,$19,$1d,$1f,$20,$00
	.byte $f0,$f0,$f2,$f3,$f6,$f9,$fc,$00,$04,$07,$0a,$0d,$0e,$10,$10,$00

