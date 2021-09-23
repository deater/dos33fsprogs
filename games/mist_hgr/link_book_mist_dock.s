	;=============================
	; mist_link_book
	;=============================
mist_link_book:

	; turn off music
	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	skip_turn_off_music

	; disable interrupts
	jsr	mockingboard_disable_interrupt

	jsr	clear_ay_both

skip_turn_off_music:

	; load link noise if IIc
	; we have to load it late due to IIc needing ROM copy in AUX
	; until done playing music
	; this makes an awkward pause but seems best compromise

	lda	APPLEII_MODEL
	cmp	#'C'
	bne	link_noise_already_loaded

	jsr	load_linking_noise
link_noise_already_loaded:


	; clear screen

        ; clear to black
	lda	#$80
	jsr	BKGND0

	lda	#0
	sta	clear_all_color+1

	jsr	clear_all
;	jsr	page_flip

;	jsr	clear_all
;	jsr	page_flip

	; play sound effect

	jsr	play_link_noise

	lda	#MIST_ARRIVAL_DOCK
	sta	LOCATION

	lda	#LOAD_MIST			; start at Mist
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts


dock_animation_sprites:
	.word dock_animate_sprite3			; 26
	.word dock_animate_sprite4			; 27
	.word dock_animate_sprite5			; 28
	.word dock_animate_sprite6			; 29
	.word dock_animate_sprite7			; 30
	.word dock_animate_sprite8			; 31
	.word dock_animate_sprite9			; 32
	.word dock_animate_sprite10			; 33
	.word dock_animate_sprite11			; 34
	.word dock_animate_sprite12			; 35
	.word dock_animate_sprite13			; 36


; water1
dock_animate_sprite1:
.byte $00,$00,$00,$00,$00,$D5,$AA,$00,$00
.byte $00,$00,$00,$00,$00,$D5,$AA,$00,$00
.byte $AA,$00,$AA,$00,$AA,$00,$AA,$D5,$00
.byte $00,$D5,$00,$D5,$00,$D5,$AA,$00,$AA
.byte $AA,$00,$AA,$00,$AA,$00,$AA,$D5,$00
.byte $00,$D5,$00,$D5,$00,$D5,$AA,$00,$AA
.byte $AA,$00,$AA,$00,$AA,$00,$AA,$D5,$00
.byte $00,$D5,$00,$D5,$00,$D5,$AA,$00,$AA
.byte $AA,$00,$AA,$00,$AA,$00,$AA,$D5,$00
.byte $00,$D5,$00,$D5,$00,$D5,$AA,$00,$AA
.byte $AA,$00,$AA,$00,$AA,$00,$AA,$D5,$00
.byte $00,$D5,$00,$D5,$00,$D5,$AA,$00,$00

; water2
dock_animate_sprite2:
.byte $80,$80,$80,$80,$80,$D5,$AA,$80,$80
.byte $80,$80,$80,$80,$80,$D5,$AA,$80,$80
.byte $80,$D5,$80,$D5,$80,$D5,$AA,$80,$AA
.byte $AA,$80,$AA,$80,$AA,$80,$AA,$D5,$80
.byte $80,$D5,$80,$D5,$80,$D5,$AA,$80,$AA
.byte $AA,$80,$AA,$80,$AA,$80,$AA,$D5,$80
.byte $80,$D5,$80,$D5,$80,$D5,$AA,$80,$AA
.byte $AA,$80,$AA,$80,$AA,$80,$AA,$D5,$80
.byte $80,$D5,$80,$D5,$80,$D5,$AA,$80,$AA
.byte $AA,$80,$AA,$80,$AA,$80,$AA,$D5,$80
.byte $80,$D5,$80,$D5,$80,$D5,$AA,$80,$80
.byte $AA,$80,$AA,$80,$AA,$80,$AA,$80,$80


; water tilt_high
dock_animate_sprite3:
.byte $AA,$FD,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $AA,$D5,$AA,$D5,$FA,$FF,$FF,$FF,$FF
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$F5,$FF
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA

; water tilt_low
dock_animate_sprite4:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $AA,$FD,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $AA,$D5,$AA,$D5,$FA,$FF,$FF,$FF,$FF
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$F5,$FF
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA

; water level
dock_animate_sprite5:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA

; water tilt_island
dock_animate_sprite6:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$BF,$FC,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$F1,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$80,$80,$F8,$FF,$FF,$D5,$AA
.byte $FF,$80,$80,$80,$A0,$D5,$AA,$D5,$AA
.byte $9F,$80,$A8,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA

; island1
dock_animate_sprite7:
.byte $FF,$FF,$FF,$FF,$FD,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$75,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$55,$FF,$2A,$FF,$FF
.byte $FF,$FF,$5D,$FF,$55,$2A,$2A,$FF,$2A
.byte $FF,$2E,$55,$2E,$55,$2A,$2A,$80,$D5
.byte $FF,$2A,$55,$2A,$55,$2A,$80,$80,$D5
.byte $55,$2A,$55,$2A,$55,$2A,$80,$FF,$D5
.byte $55,$2A,$55,$2A,$55,$2A,$FF,$D5,$AA
.byte $55,$2A,$D5,$AA,$D5,$AA,$D5,$D5,$AA
.byte $D5,$2A,$D5,$AA,$D5,$AA,$D5,$D5,$AA
.byte $D5,$D5,$AA,$D5,$D5,$AA,$AA,$D5,$AA
.byte $AA,$D5,$AA,$D5,$AA,$D5,$AA,$D5,$AA

; island2
dock_animate_sprite8:
.byte $F7,$7F,$F7,$7F,$55,$AB,$FF,$7F,$7F
.byte $55,$7F,$55,$7F,$55,$AA,$F5,$7F,$7F
.byte $55,$3A,$55,$35,$55,$D5,$D5,$7F,$7F
.byte $55,$2A,$2A,$2D,$55,$5D,$C0,$7F,$2A
.byte $55,$2A,$55,$2D,$55,$7F,$80,$AA,$D5
.byte $55,$2A,$55,$2D,$55,$55,$2A,$7F,$D5
.byte $55,$AA,$55,$2A,$55,$2A,$2A,$AA,$D5
.byte $D5,$2A,$55,$2A,$55,$55,$2A,$AA,$D5
.byte $55,$2A,$55,$2A,$55,$55,$FF,$AA,$D5
.byte $55,$2A,$55,$2A,$55,$6A,$BF,$D5,$D2
.byte $55,$2A,$55,$2A,$55,$D5,$DA,$D5,$AA
.byte $55,$2A,$55,$2A,$55,$D5,$AA,$D5,$AA

; island3
dock_animate_sprite9:
.byte $FF,$FF,$FF,$FF,$03,$55,$D5,$7F,$7F
.byte $FF,$3A,$5D,$55,$00,$55,$D5,$7F,$7F
.byte $FF,$2A,$55,$55,$2A,$AA,$D5,$7F,$2A
.byte $DF,$2A,$55,$FF,$55,$D5,$D5,$AA,$00
.byte $55,$2A,$FF,$2A,$2A,$D5,$2A,$AA,$00
.byte $55,$2A,$2A,$2A,$0A,$11,$2A,$00,$00
.byte $55,$2A,$2A,$2A,$55,$55,$00,$00,$D5
.byte $55,$FF,$55,$2A,$55,$00,$55,$AA,$D5
.byte $FF,$2A,$55,$2A,$00,$00,$FF,$D5,$D5
.byte $55,$AA,$55,$2A,$00,$2A,$FF,$D5,$AA
.byte $D5,$2A,$55,$2A,$D5,$FF,$AA,$D5,$AA
.byte $55,$2A,$55,$2A,$D5,$D5,$D5,$D5,$AA


; island4
dock_animate_sprite10:
.byte $80,$AA,$D5,$7F,$7F,$55,$7F,$7F,$7F
.byte $F5,$AA,$AA,$7F,$2F,$55,$FA,$7F,$7F
.byte $80,$55,$AA,$55,$D5,$FF,$B5,$D5,$7F
.byte $8C,$15,$22,$54,$FD,$AA,$B5,$D5,$AA
.byte $55,$15,$22,$54,$FD,$AA,$D5,$D5,$AA
.byte $55,$55,$22,$55,$FD,$AA,$D5,$D5,$AA
.byte $55,$AA,$2A,$FE,$FF,$D5,$AA,$D5,$AA
.byte $D5,$2A,$55,$3E,$FF,$D5,$AA,$D5,$AA
.byte $55,$AA,$55,$3E,$FF,$D5,$AA,$D5,$AA
.byte $55,$2A,$F5,$EB,$BF,$D5,$AA,$D5,$AA
.byte $55,$2A,$75,$EB,$BF,$AD,$A5,$D5,$AA
.byte $55,$2A,$55,$6A,$BF,$D5,$AA,$D5,$AA

; island5
dock_animate_sprite11:
.byte $B5,$F5,$FF,$D7,$2F,$75,$FF,$FF,$FF
.byte $AA,$D5,$6A,$AA,$F5,$AB,$FF,$FF,$FF
.byte $2A,$55,$2A,$8A,$F5,$AB,$FD,$FF,$FF
.byte $22,$80,$22,$8A,$7F,$A2,$AD,$D5,$FD
.byte $22,$80,$22,$A2,$DF,$8A,$B5,$B5,$AA
.byte $2A,$80,$2A,$7F,$D7,$8A,$B5,$ED,$AA
.byte $2D,$55,$2A,$AF,$FF,$D5,$AA,$ED,$AA
.byte $55,$2A,$75,$AF,$FF,$D5,$AA,$D2,$AA
.byte $D5,$2A,$FD,$FB,$FF,$D5,$DA,$D5,$AA
.byte $D5,$FF,$FF,$FB,$FF,$D5,$DA,$D5,$AA
.byte $55,$FA,$FF,$7A,$FF,$B5,$D5,$D6,$AA
.byte $55,$2A,$DF,$7A,$FF,$D5,$AD,$D5,$AA

; island6
dock_animate_sprite12:
.byte $80,$80,$FF,$FF,$AF,$FF,$FF,$FF,$FF
.byte $A0,$84,$FF,$FA,$2A,$55,$FF,$FF,$FF
.byte $A0,$84,$DF,$AA,$F5,$A8,$F4,$FF,$FF
.byte $A0,$84,$D4,$FF,$FF,$AA,$F4,$FF,$FF
.byte $80,$D0,$94,$FA,$80,$AA,$A4,$D5,$AA
.byte $2A,$15,$F8,$FF,$D5,$88,$D5,$DA,$AA
.byte $80,$80,$F8,$FF,$D5,$88,$D5,$DA,$AA
.byte $55,$2A,$FF,$2A,$D7,$88,$D4,$D5,$AA
.byte $55,$FF,$57,$FA,$FF,$D5,$AA,$D5,$AA
.byte $75,$FF,$57,$FA,$D5,$A5,$AA,$D5,$AA
.byte $FD,$FF,$55,$AA,$D5,$A5,$D5,$D5,$D2
.byte $FF,$AF,$55,$AA,$D5,$D5,$AA,$D5,$AD

; island7
dock_animate_sprite13:
.byte $2A,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $2E,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $2A,$FF,$FF,$FF,$7A,$FF,$FF,$FF,$FF
.byte $80,$FC,$AF,$DF,$2A,$94,$FF,$FF,$FF
.byte $80,$E0,$97,$8A,$F0,$8A,$F1,$FF,$FF
.byte $80,$80,$97,$8F,$80,$8A,$F1,$FF,$FF
.byte $80,$80,$80,$FA,$C5,$AA,$94,$AA,$FF
.byte $FF,$2A,$55,$FF,$D7,$AA,$94,$8A,$AA
.byte $55,$2A,$55,$AA,$97,$88,$D4,$D5,$A8
.byte $55,$2A,$55,$FF,$FF,$BF,$A9,$AA,$85
.byte $55,$2A,$FD,$FF,$FF,$FF,$A9,$D5,$8A
.byte $55,$2A,$FF,$FF,$FF,$FF,$85,$D5,$AA

