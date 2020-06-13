	;=============================
	; channel_link_book
	;=============================
channel_link_book:

	; clear screen
	lda	#0
	sta	clear_all_color+1

	jsr	clear_all
	jsr	page_flip

	jsr	clear_all
	jsr	page_flip

	;====================================
	; load linking audio (12k) to $9000

;	lda	#<linking_filename
;	sta	OUTL
;	lda	#>linking_filename
;	sta	OUTH

;	jsr	opendir_filename


	; play sound effect?

;	lda	#<linking_noise
;	sta	BTC_L
;	lda	#>linking_noise
;	sta	BTC_H
;	ldx	#LINKING_NOISE_LENGTH		; 45 pages long???
;	jsr	play_audio

	lda	#CHANNEL_ARRIVAL
	sta	LOCATION
	lda	#DIRECTION_S
	sta	DIRECTION

	jsr	change_location
	rts


channel_movie:
	.word channel_sprite0,channel_sprite1,channel_sprite2
	.word channel_sprite3,channel_sprite4,channel_sprite5
	.word channel_sprite6,channel_sprite7,channel_sprite8
	.word channel_sprite9,channel_sprite10

channel_sprite0:
	.byte 9,6
	.byte $77,$77,$77,$7f,$77,$55,$77,$7f,$77
	.byte $77,$77,$77,$77,$57,$55,$57,$75,$77
	.byte $77,$ff,$55,$f7,$5f,$55,$ff,$ff,$57
	.byte $57,$ff,$55,$ff,$ff,$55,$55,$ff,$55
	.byte $55,$7f,$75,$77,$77,$55,$77,$77,$55
	.byte $55,$77,$77,$57,$57,$55,$77,$77,$75

channel_sprite1:
	.byte 9,6
	.byte $77,$78,$88,$87,$88,$87,$78,$77,$77
	.byte $77,$77,$77,$78,$88,$87,$88,$78,$77
	.byte $55,$87,$88,$f8,$88,$88,$8f,$55,$ff
	.byte $55,$f8,$58,$ff,$88,$88,$f8,$58,$ff
	.byte $55,$7f,$55,$88,$55,$88,$7f,$55,$7f
	.byte $55,$77,$77,$88,$55,$78,$77,$77,$77

channel_sprite2:
	.byte 9,6
	.byte $87,$88,$87,$87,$87,$87,$87,$87,$87
	.byte $88,$88,$77,$78,$78,$88,$88,$78,$77
	.byte $8f,$88,$88,$8f,$ff,$55,$ff,$55,$ff
	.byte $58,$88,$ff,$58,$88,$85,$ff,$55,$ff
	.byte $55,$88,$8f,$55,$78,$88,$8f,$55,$7f
	.byte $55,$88,$88,$55,$77,$78,$78,$55,$77

channel_sprite3:
	.byte 9,6
	.byte $87,$77,$77,$77,$77,$77,$77,$55,$55
	.byte $88,$88,$88,$87,$87,$77,$77,$55,$55
	.byte $ff,$58,$88,$88,$88,$88,$8f,$85,$ff
	.byte $ff,$55,$ff,$58,$88,$88,$88,$88,$f8
	.byte $88,$55,$77,$55,$77,$78,$78,$55,$77
	.byte $88,$85,$77,$55,$77,$77,$77,$55,$77

channel_sprite4:
	.byte 9,6
	.byte $78,$78,$78,$78,$78,$88,$88,$88,$88
	.byte $78,$58,$78,$58,$78,$58,$78,$58,$58
	.byte $ff,$55,$ff,$55,$ff,$55,$ff,$ff,$55
	.byte $ff,$55,$f5,$55,$ff,$55,$ff,$ff,$55
	.byte $7f,$55,$7f,$55,$7f,$55,$7f,$7f,$55
	.byte $77,$55,$77,$55,$77,$55,$77,$77,$55

channel_sprite5:
	.byte 9,6
	.byte $55,$55,$00,$00,$05,$50,$55,$00,$00
	.byte $05,$05,$05,$00,$50,$05,$55,$00,$70
	.byte $50,$00,$55,$00,$55,$ff,$55,$00,$ff
	.byte $55,$00,$55,$00,$55,$ff,$55,$00,$ff
	.byte $55,$00,$55,$00,$55,$77,$55,$00,$77
	.byte $55,$00,$55,$00,$55,$77,$55,$00,$77

channel_sprite6:
	.byte 9,6
	.byte $00,$00,$00,$50,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$05,$00,$55,$00,$00,$00
	.byte $50,$00,$00,$00,$00,$f5,$55,$00,$00
	.byte $55,$ff,$55,$f0,$00,$ff,$55,$ff,$00
	.byte $55,$7f,$55,$7f,$00,$7f,$55,$ff,$00
	.byte $55,$77,$55,$77,$00,$77,$55,$77,$00

channel_sprite7:
	.byte 9,6
	.byte $55,$75,$00,$50,$00,$00,$55,$00,$00
	.byte $88,$87,$00,$55,$77,$57,$55,$00,$87
	.byte $88,$88,$00,$75,$77,$57,$55,$00,$88
	.byte $08,$58,$00,$78,$57,$87,$85,$80,$58
	.byte $77,$50,$00,$70,$55,$77,$55,$00,$88
	.byte $77,$55,$00,$77,$55,$77,$55,$00,$88

channel_sprite8:
	.byte 9,6
	.byte $88,$8f,$8f,$8f,$ff,$00,$00,$ff,$ff
	.byte $88,$88,$ff,$55,$0f,$00,$00,$00,$ff
	.byte $88,$88,$5f,$55,$5f,$00,$ff,$f0,$f0
	.byte $88,$88,$ff,$55,$ff,$00,$ff,$55,$ff
	.byte $88,$88,$7f,$55,$7f,$00,$7f,$55,$ff
	.byte $88,$88,$87,$85,$77,$00,$77,$55,$77

channel_sprite9:
	.byte 9,6
	.byte $00,$05,$55,$00,$05,$00,$55,$00,$00
	.byte $00,$55,$55,$ff,$55,$00,$55,$55,$00
	.byte $00,$f0,$00,$ff,$55,$00,$55,$55,$00
	.byte $00,$05,$00,$05,$55,$00,$f5,$f5,$00
	.byte $00,$7f,$00,$ff,$55,$00,$ff,$ff,$00
	.byte $00,$77,$00,$77,$55,$00,$77,$77,$00

channel_sprite10:
	.byte 9,6
	.byte $88,$55,$88,$55,$00,$88,$77,$77,$77
	.byte $88,$55,$88,$55,$00,$88,$77,$77,$77
	.byte $88,$55,$88,$55,$00,$88,$77,$77,$77
	.byte $68,$66,$88,$26,$00,$88,$66,$66,$66
	.byte $26,$62,$68,$66,$00,$68,$66,$66,$66
	.byte $66,$62,$26,$26,$00,$66,$66,$66,$66




linking_filename:
	.byte "LINK_NOISE.BTC",0
