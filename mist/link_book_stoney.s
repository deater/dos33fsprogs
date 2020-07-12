	;=============================
	; stoney_link_book
	;=============================
stoney_link_book:

	; clear screen
	lda	#0
	sta	clear_all_color+1

	jsr	clear_all
	jsr	page_flip

	jsr	clear_all
	jsr	page_flip

	;====================================
	; load linking audio (12k) to $9000

.if 0
	lda	#<linking_filename
	sta	OUTL
	lda	#>linking_filename
	sta	OUTH

        jsr	opendir_filename


	; play sound effect?

	lda	#<linking_noise
	sta	BTC_L
	lda	#>linking_noise
	sta	BTC_H
	ldx	#LINKING_NOISE_LENGTH		; 45 pages long???
	jsr	play_audio
.endif

	lda	#STONEY_ARRIVAL
	sta	LOCATION

	lda	#LOAD_STONEY
	sta	WHICH_LOAD

	lda	#DIRECTION_N
	sta	DIRECTION

	lda	#$ff
	sta	LEVEL_OVER

;	jsr	change_location
	rts


stoney_movie:
	.word stoney_sprite0,stoney_sprite1,stoney_sprite2,stoney_sprite3
	.word stoney_sprite4,stoney_sprite5,stoney_sprite6,stoney_sprite7
	.word stoney_sprite8,stoney_sprite9,stoney_sprite10,stoney_sprite11
	.word stoney_sprite12,stoney_sprite13,stoney_sprite14,stoney_sprite15


stoney_sprite0:
	.byte 9,6
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $dd,$5d,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $58,$55,$5d,$7d,$dd,$7d,$dd,$5d,$77
	.byte $55,$80,$55,$57,$6d,$67,$6d,$55,$57
	.byte $66,$66,$66,$66,$66,$66,$66,$66,$66
	.byte $66,$66,$66,$66,$66,$66,$66,$66,$66

stoney_sprite1:
	.byte 9,6
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$0d
	.byte $dd,$7d,$dd,$dd,$dd,$7d,$5d,$77,$00
	.byte $dd,$77,$dd,$77,$6d,$55,$55,$67,$00
	.byte $68,$66,$66,$66,$66,$65,$65,$66,$00
	.byte $66,$66,$66,$66,$66,$66,$66,$66,$66

stoney_sprite2:
	.byte 9,6
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$0d,$dd
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$00,$dd
	.byte $dd,$dd,$7d,$dd,$7d,$7d,$00,$00,$0d
	.byte $5d,$dd,$77,$55,$77,$55,$00,$00,$00
	.byte $55,$66,$67,$55,$66,$66,$00,$00,$00
	.byte $66,$66,$66,$65,$66,$66,$60,$00,$00

stoney_sprite3:
	.byte 9,6
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$00
	.byte $dd,$dd,$5d,$dd,$dd,$dd,$5d,$dd,$00
	.byte $55,$dd,$55,$77,$dd,$dd,$55,$00,$00
	.byte $00,$00,$55,$77,$6d,$6d,$65,$00,$00
	.byte $00,$00,$55,$66,$66,$66,$66,$00,$00
	.byte $00,$00,$66,$66,$66,$66,$66,$00,$00

stoney_sprite4:
	.byte 9,6
	.byte $00,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $00,$00,$dd,$5d,$dd,$dd,$5d,$dd,$dd
	.byte $00,$00,$7d,$55,$dd,$dd,$55,$dd,$dd
	.byte $00,$00,$67,$65,$6d,$6d,$55,$6d,$6d
	.byte $00,$60,$66,$66,$66,$66,$66,$66,$66
	.byte $66,$66,$66,$66,$66,$66,$66,$66,$66

stoney_sprite5:
	.byte 9,6
	.byte $00,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $00,$dd,$dd,$dd,$5d,$dd,$dd,$dd,$dd
	.byte $00,$6d,$dd,$5d,$55,$dd,$dd,$dd,$55
	.byte $00,$66,$67,$55,$55,$dd,$dd,$55,$55
	.byte $00,$66,$66,$66,$66,$66,$66,$55,$55
	.byte $00,$66,$66,$66,$66,$66,$66,$55,$55

stoney_sprite6:
	.byte 9,6
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $dd,$dd,$55,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $6d,$55,$d5,$dd,$dd,$dd,$55,$dd,$dd
	.byte $66,$55,$6d,$6d,$dd,$77,$55,$dd,$dd
	.byte $66,$66,$66,$66,$77,$55,$55,$dd,$dd
	.byte $66,$66,$66,$66,$66,$65,$65,$66,$6d

stoney_sprite7:
	.byte 9,6
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $dd,$5d,$dd,$dd,$5d,$55,$dd,$dd,$dd
	.byte $57,$55,$dd,$dd,$55,$dd,$dd,$dd,$dd
	.byte $65,$65,$66,$5d,$55,$dd,$dd,$dd,$dd
	.byte $66,$66,$66,$65,$65,$66,$6d,$6d,$dd
	.byte $66,$66,$66,$66,$66,$66,$66,$66,$77

stoney_sprite8:
	.byte 9,6
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$55,$dd,$dd
	.byte $dd,$ed,$dd,$dd,$dd,$dd,$55,$dd,$dd
	.byte $dd,$87,$dd,$55,$77,$55,$55,$dd,$dd
	.byte $66,$68,$6d,$65,$66,$55,$55,$77,$66
	.byte $66,$66,$66,$66,$66,$65,$65,$67,$66
	.byte $66,$66,$66,$66,$66,$66,$66,$66,$66

stoney_sprite9:
	.byte 9,6
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$55
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$55
	.byte $dd,$dd,$dd,$7e,$dd,$55,$77,$dd,$55
	.byte $5d,$dd,$7d,$88,$5d,$55,$67,$6d,$55
	.byte $85,$68,$66,$66,$65,$65,$66,$66,$55
	.byte $66,$66,$66,$66,$66,$66,$66,$66,$65

stoney_sprite10:
	.byte 9,6
	.byte $dd,$dd,$dd,$dd,$dd,$5d,$dd,$dd,$dd
	.byte $dd,$dd,$dd,$ee,$dd,$55,$5d,$dd,$dd
	.byte $77,$7d,$dd,$87,$55,$55,$55,$5d,$dd
	.byte $68,$66,$56,$58,$55,$55,$55,$55,$55
	.byte $66,$66,$65,$55,$55,$55,$55,$55,$55
	.byte $66,$66,$66,$55,$55,$55,$55,$55,$55

stoney_sprite11:
	.byte 9,6
	.byte $dd,$ed,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $7e,$7e,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $55,$87,$dd,$7d,$5d,$dd,$7d,$5d,$dd
	.byte $55,$58,$6d,$67,$65,$6d,$67,$65,$6d
	.byte $55,$55,$66,$66,$66,$66,$66,$66,$66
	.byte $55,$55,$55,$66,$66,$66,$66,$66,$66

stoney_sprite12:
	.byte 9,6
	.byte $ed,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $ee,$ed,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $77,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $87,$6d,$6d,$77,$7d,$dd,$5d,$dd,$77
	.byte $58,$66,$66,$66,$66,$66,$55,$66,$67
	.byte $55,$66,$66,$66,$66,$66,$66,$66,$66

stoney_sprite13:
	.byte 9,6
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $ed,$5d,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $5d,$55,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $55,$55,$85,$6d,$6d,$77,$7d,$5d,$dd
	.byte $65,$68,$66,$66,$66,$66,$66,$55,$5d
	.byte $66,$66,$66,$66,$66,$66,$66,$66,$65

stoney_sprite14:
	.byte 9,6
	.byte $dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $dd,$5d,$55,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $5d,$55,$55,$57,$7d,$dd,$dd,$dd,$dd
	.byte $55,$85,$85,$75,$57,$66,$66,$67,$6d
	.byte $65,$68,$68,$65,$66,$66,$66,$66,$66
	.byte $66,$66,$66,$66,$66,$66,$66,$66,$66

stoney_sprite15:
	.byte 9,6
	.byte $55,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $55,$dd,$dd,$dd,$dd,$dd,$dd,$dd,$dd
	.byte $55,$87,$7d,$dd,$77,$dd,$dd,$dd,$dd
	.byte $55,$58,$77,$66,$77,$6d,$6d,$67,$6d
	.byte $75,$77,$57,$55,$66,$66,$66,$66,$66
	.byte $57,$55,$55,$55,$66,$66,$66,$66,$66


linking_filename:
	.byte "LINK_NOISE.BTC",0
