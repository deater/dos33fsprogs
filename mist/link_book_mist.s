	;======================================
	; mist link book to the octogon temple
	;======================================
mist_link_book:

	; clear screen
	lda	#0
	sta	clear_all_color+1

	jsr	clear_all
	jsr	page_flip

	jsr	clear_all
	jsr	page_flip

	; play sound effect

	jsr	play_link_noise


	lda	#OCTAGON_CEILING
	sta	LOCATION
	lda	#DIRECTION_N
	sta	DIRECTION

	lda	#LOAD_OCTAGON		; return to OCTAGON on MIST
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts


mist_movie:
	.word ceiling_sprite0,ceiling_sprite1,ceiling_sprite2
	.word ceiling_sprite3,ceiling_sprite4,ceiling_sprite5
	; probably should have 6 more

ceiling_sprite0:
	.byte 9,6
	.byte $88,$88,$22,$75,$75,$75,$22,$88,$88
	.byte $88,$22,$27,$02,$f2,$02,$27,$22,$88
	.byte $28,$22,$0f,$02,$00,$0f,$02,$55,$22
	.byte $22,$ff,$22,$02,$20,$02,$22,$55,$22
	.byte $88,$22,$2f,$f2,$f2,$f2,$52,$22,$88
	.byte $88,$88,$22,$2f,$2f,$22,$25,$88,$88

ceiling_sprite1:
	.byte 9,6
	.byte $88,$88,$52,$22,$75,$75,$25,$88,$88
	.byte $88,$25,$22,$f2,$00,$f2,$27,$72,$88
	.byte $28,$ff,$20,$02,$00,$0f,$f0,$27,$22
	.byte $22,$ff,$20,$22,$00,$ff,$20,$52,$22
	.byte $88,$22,$2f,$ff,$f0,$22,$52,$55,$88
	.byte $88,$88,$22,$52,$52,$52,$25,$88,$88

ceiling_sprite2:
	.byte 9,6
	.byte $88,$88,$22,$25,$25,$22,$22,$88,$88
	.byte $88,$22,$ff,$02,$2f,$02,$27,$72,$88
	.byte $28,$22,$0f,$02,$00,$0f,$0f,$77,$22
	.byte $22,$22,$ff,$02,$20,$0f,$2f,$77,$22
	.byte $88,$52,$22,$2f,$22,$22,$27,$22,$88
	.byte $88,$88,$25,$22,$55,$55,$25,$88,$88

ceiling_sprite3:
	.byte 9,6
	.byte $88,$88,$22,$ff,$22,$22,$25,$88,$88
	.byte $88,$22,$ff,$2f,$00,$ff,$22,$22,$88
	.byte $28,$22,$f0,$02,$00,$02,$f0,$77,$22
	.byte $55,$22,$f0,$0f,$00,$ff,$20,$77,$22
	.byte $88,$55,$22,$22,$20,$22,$75,$57,$88
	.byte $88,$88,$25,$52,$52,$52,$22,$88,$88

ceiling_sprite4:
	.byte 9,6
	.byte $88,$88,$22,$f2,$2f,$22,$22,$88,$88
	.byte $88,$22,$ff,$02,$22,$02,$22,$22,$88
	.byte $58,$f5,$0f,$02,$00,$02,$0f,$72,$22
	.byte $55,$22,$22,$02,$f0,$02,$2f,$77,$22
	.byte $88,$52,$22,$22,$2f,$22,$77,$22,$88
	.byte $88,$88,$55,$52,$52,$27,$22,$88,$88

ceiling_sprite5:
	.byte 9,6
	.byte $88,$88,$72,$27,$f2,$d2,$22,$88,$88
	.byte $88,$55,$f2,$2f,$00,$22,$2f,$22,$88
	.byte $28,$f2,$20,$02,$00,$02,$f0,$55,$22
	.byte $55,$22,$20,$f2,$00,$f2,$20,$25,$22
	.byte $88,$55,$22,$2f,$20,$72,$27,$22,$88
	.byte $88,$88,$55,$27,$27,$52,$52,$88,$88
