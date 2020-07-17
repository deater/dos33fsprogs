	;=============================
	; mist_link_book
	;=============================
mist_link_book:

	; turn off music
	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	skip_turn_off_music

	sei
	jsr	clear_ay_both
skip_turn_off_music:

	; clear screen

	lda	#0
	sta	clear_all_color+1

	jsr	clear_all
	jsr	page_flip

	jsr	clear_all
	jsr	page_flip

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

; water1
dock_animate_sprite1:
	.byte	9,6
	.byte	$22,$22,$22,$22,$22,$66,$66,$22,$22
	.byte	$26,$62,$26,$62,$26,$62,$66,$26,$62
	.byte	$26,$62,$26,$62,$26,$62,$66,$26,$62
	.byte	$26,$62,$26,$62,$26,$62,$66,$26,$62
	.byte	$26,$62,$26,$62,$26,$62,$66,$26,$62
	.byte	$26,$62,$26,$62,$26,$62,$66,$26,$22

; water2
dock_animate_sprite2:
	.byte	9,6
	.byte	$22,$22,$22,$22,$22,$66,$66,$22,$22
	.byte	$62,$26,$62,$26,$62,$26,$66,$62,$26
	.byte	$62,$26,$62,$26,$62,$26,$66,$62,$26
	.byte	$62,$26,$62,$26,$62,$26,$66,$62,$26
	.byte	$62,$26,$62,$26,$62,$26,$66,$62,$26
	.byte	$62,$26,$62,$26,$62,$26,$66,$22,$22

; water tilt
dock_animate_sprite3:
	.byte	9,6
	.byte	$77,$77,$77,$77,$77,$77,$77,$77,$77
	.byte	$77,$77,$77,$77,$77,$77,$77,$77,$77
	.byte	$22,$22,$22,$27,$27,$77,$77,$77,$77
	.byte	$22,$22,$22,$22,$22,$22,$22,$22,$22
	.byte	$22,$22,$22,$22,$22,$22,$22,$22,$22
	.byte	$22,$22,$22,$22,$22,$22,$22,$22,$22

; water tilt_island
dock_animate_sprite4:
	.byte	9,6
	.byte	$77,$77,$77,$77,$77,$77,$77,$77,$77
	.byte	$77,$77,$77,$77,$77,$77,$77,$77,$77
	.byte	$77,$77,$57,$55,$77,$77,$77,$77,$27
	.byte	$77,$57,$55,$55,$25,$2f,$22,$22,$22
	.byte	$77,$25,$22,$22,$22,$22,$22,$22,$22
	.byte	$22,$22,$22,$22,$22,$22,$22,$22,$22

; island1
dock_animate_sprite5:
	.byte	9,6
	.byte	$66,$66,$66,$66,$44,$66,$66,$66,$66
	.byte	$66,$66,$46,$66,$44,$46,$55,$66,$56
	.byte	$66,$44,$44,$44,$44,$44,$75,$77,$99
	.byte	$44,$44,$44,$44,$44,$44,$d7,$2d,$29
	.byte	$54,$44,$55,$55,$55,$55,$55,$22,$22
	.byte	$25,$22,$22,$22,$25,$25,$22,$22,$22

; island2
dock_animate_sprite6:
	.byte	9,6
	.byte	$44,$66,$44,$66,$44,$99,$99,$66,$66
	.byte	$44,$44,$54,$55,$44,$5e,$89,$56,$56
	.byte	$44,$44,$44,$55,$44,$55,$58,$85,$88
	.byte	$54,$45,$44,$44,$44,$54,$55,$88,$88
	.byte	$44,$44,$44,$44,$44,$45,$dd,$28,$88
	.byte	$44,$44,$44,$44,$44,$22,$22,$22,$22

; island3
dock_animate_sprite7:
	.byte	9,6
	.byte	$22,$42,$42,$72,$55,$77,$99,$66,$66
	.byte	$22,$44,$44,$d7,$77,$e9,$99,$86,$55
	.byte	$44,$44,$5d,$44,$77,$7e,$77,$58,$55
	.byte	$44,$d4,$45,$44,$88,$57,$45,$85,$88
	.byte	$dd,$44,$44,$44,$55,$45,$dd,$22,$28
	.byte	$44,$dd,$d4,$44,$88,$2d,$82,$22,$22

; island4
dock_animate_sprite8:
	.byte	9,6
	.byte	$55,$88,$e8,$66,$56,$55,$56,$66,$66
	.byte	$55,$77,$5e,$77,$d8,$8d,$88,$22,$26
	.byte	$cc,$77,$55,$77,$dd,$88,$88,$22,$22
	.byte	$44,$45,$c7,$55,$d5,$22,$22,$22,$22
	.byte	$44,$44,$4c,$55,$dd,$22,$22,$22,$22
	.byte	$44,$44,$44,$55,$dd,$22,$28,$22,$22








