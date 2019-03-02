; background graphics

.include "intro_graphics/05_scanner/intro_scanner.inc"
.include "intro_graphics/05_scanner/intro_scanning.inc"
.include "intro_graphics/05_scanner/intro_ai_bg.inc"
.include "intro_graphics/05_scanner/intro_ai.inc"


; Scanning sequence

scanning_sequence:
	.byte	15
	.word	scan01_rle
	.byte	128+15	;	.word	scan02_rle
	.byte	128+15	;	.word	scan03_rle
	.byte	128+15	;	.word	scan04_rle
	.byte	128+15	;	.word	scan05_rle
	.byte	128+15	;	.word	scan06_rle
	.byte	128+15	;	.word	scan07_rle
	.byte	128+15	;	.word	scan08_rle
	.byte	128+15	;	.word	scan09_rle
	.byte	128+15	;	.word	scan10_rle
	.byte	128+20	;	.word	scan11_rle
	.byte	128+20	;	.word	scan12_rle
	.byte	128+20	;	.word	scan13_rle
	.byte	128+20	;	.word	scan14_rle
	.byte	128+20	;	.word	scan15_rle
	.byte	128+20	;	.word	scan16_rle
	.byte	128+40	;	.word	scan17_rle
	.byte	128+40	;	.word	scan18_rle
	.byte	128+40	;	.word	scan19_rle
	.byte	40
	.word	scan19_rle
	.byte	0


; AI sequence

ai_sequence:
	.byte	0,50		; pause at start, no dna
	.word	ai01_rle	; slices

	.byte	0,50		; pause at start, no dna
	.word	ai02_rle	; slices_zoom

	.byte	0,50		; pasue as start, no dna
	.word	ai03_rle	; little circle

	.byte	0,50		; pause at start, no dna
	.word	ai04_rle	; big circle

	.byte	1,20		; pause longer, yes dna
	.word	ai05_rle	; key

	.byte	0,0
;	.word	ai05_rle	; key
;	.byte	0

static_pattern:
	.word	nothing_rle	; 0
	.word	nothing_rle	; 2
	.word	static01_rle	; 4
	.word	static03_rle	; 6
	.word	static02_rle	; 8
	.word	static01_rle	; 10

	; Scanning text

good_evening:
	.byte 2,21,"GOOD EVENING PROFESSOR.",0
ferrari:
	.byte 2,21,"I SEE YOU HAVE DRIVEN HERE IN YOUR",0
	.byte 2,22,"FERRARI.",0


dna_list:
	.word dna0_sprite
	.word dna1_sprite
	.word dna2_sprite
	.word dna3_sprite
	.word dna4_sprite
	.word dna5_sprite
	.word dna6_sprite
	.word dna7_sprite

dna0_sprite:
	.byte   $7,$2
	.byte   $66,$40,$40,$40,$40,$40,$cc
	.byte   $06,$00,$00,$00,$00,$00,$0c

dna1_sprite:
	.byte   $7,$2
	.byte   $00,$66,$40,$40,$40,$cc,$00
	.byte   $00,$06,$00,$00,$00,$0c,$00

dna2_sprite:
	.byte   $7,$2
	.byte   $00,$00,$66,$40,$cc,$00,$00
	.byte   $00,$00,$06,$00,$0c,$00,$00

dna3_sprite:
	.byte   $7,$2
	.byte   $00,$00,$00,$66,$00,$00,$00
	.byte   $00,$00,$00,$06,$00,$00,$00

dna4_sprite:
	.byte   $7,$2
	.byte   $00,$00,$CC,$40,$66,$00,$00
	.byte   $00,$00,$0C,$00,$06,$00,$00

dna5_sprite:
	.byte   $7,$2
	.byte   $00,$CC,$40,$40,$40,$66,$00
	.byte   $00,$0C,$00,$00,$00,$06,$00

dna6_sprite:
	.byte   $7,$2
	.byte   $CC,$40,$40,$40,$40,$40,$66
	.byte   $0C,$00,$00,$00,$00,$00,$06

dna7_sprite:
	.byte   $7,$2
	.byte   $66,$40,$40,$40,$40,$40,$cc
	.byte   $06,$00,$00,$00,$00,$00,$0c

