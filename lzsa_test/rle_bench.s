
.include "zp.inc"
.include "hardware.inc"

	lda	#0
	sta	DRAW_PAGE

	bit	SET_GR
	bit	PAGE0

	bit	KEYRESET
pause_loop:
	lda	KEYPRESS
	bpl	pause_loop

	lda	#<graphic_start
	sta	GBASL
	lda	#>graphic_start
	sta	GBASH

before:
	lda	#$c
	jsr	load_rle_gr

after:

	jsr	gr_copy_to_current


blah:
	jmp	blah


	.include "gr_unrle.s"
	.include "gr_copy.s"
	.include "gr_offsets.s"

graphic_start:
spaceship_far_n_rle:	.byte $28 ; ysize=48
	.byte $A0,$FF,$FF, $AF,$FF, $A7,$5F, $A3,$F5, $A0,$1B,$FF, $5F, $05,$05
	.byte $A4,$00, $0F,$0F, $A0,$1C,$FF, $50, $5F, $05, $A5,$00
	.byte $F0, $A0,$11,$FF, $0F, $9F,$9F, $AB,$99, $55, $0A
	.byte $90,$90, $A3,$00, $F0, $AE,$FF, $0F, $9F, $D9
	.byte $00, $A6,$DD, $A4,$88, $A3,$DD, $88, $55, $D9
	.byte $00, $A3,$D9, $D0, $9F, $A8,$FF, $A5,$0F, $00,$00
	.byte $8D,$8D, $00, $A6,$8D, $A4,$88, $A4,$8D, $55, $8D
	.byte $00, $A7,$8D, $AB,$FF, $F0, $00, $88,$88, $00
	.byte $AB,$88, $08,$08, $88, $55, $88, $00, $A6,$88
	.byte $F8, $AE,$FF, $F8, $F0, $A6,$08, $A5,$88, $99,$99
	.byte $88, $55, $08, $A7,$00, $0F,$0F, $A0,$13,$FF, $A7,$50
	.byte $59,$59, $58, $55, $5F, $A0,$01,$AF, $A3,$FF, $A9,$F0
	.byte $FF, $AC,$7F, $4F, $45,$45, $AA,$75, $55, $05
	.byte $0A, $AC,$7F, $AC,$77, $A3,$44, $00,$00, $44, $54
	.byte $A3,$55, $A3,$44, $A3,$00, $A0,$18,$77, $44, $FF, $44
	.byte $00,$00, $44, $A4,$55, $A3,$44, $00, $FF, $00
	.byte $A0,$18,$77, $A3,$44, $00,$00, $44, $A4,$55, $A3,$44, $A3,$00
	.byte $A0,$18,$77, $A3,$44, $00,$00, $A6,$55, $44,$44, $A3,$00, $A0,$18,$77
	.byte $A3,$44, $00,$00, $A6,$55, $54, $44, $A3,$00, $A4,$77
	.byte $07, $A3,$77, $A3,$07, $AD,$77, $A3,$44, $00, $A8,$55
	.byte $44, $A3,$00, $A3,$77, $07, $00, $88,$88, $07
	.byte $A3,$00, $07, $AC,$77, $A3,$44, $00, $A9,$55, $A3,$00
	.byte $A3,$77, $A3,$00, $A6,$88, $AC,$77, $A3,$44, $AA,$55, $A3,$00
	.byte $77,$77, $57, $A3,$00, $A6,$88
	.byte $A1
; cycles=7669
