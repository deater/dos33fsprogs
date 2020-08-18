draw_gate_animation_s:
	rts

draw_gate_animation_n:
	rts

close_rts:
	rts

draw_projection:
	lda	DIRECTION
	cmp	#DIRECTION_S
	bne	close_rts

	lda	ANIMATE_FRAME
	beq	close_rts

	cmp	#2	; blt
	bcc	projection_inc_frame	; start with nothing
	beq	setup_background
	bne	projector_animation

	; setup light background with text
setup_background:
	ldy	#LOCATION_SOUTH_BG
	lda	#<shack_entrance_playing_s_lzsa
	sta	location28,Y			; NIBEL_SHACK_ENTRANCE
	lda	#>shack_entrance_playing_s_lzsa
	sta	location28+1,Y			; NIBEL_SHACK_ENTRANCE

	lda	#DIRECTION_S|DIRECTION_SPLIT
	jsr	change_direction
	bit	TEXTGR

	lda	DRAW_PAGE
	pha

	lda	#8
	sta	DRAW_PAGE

	lda	NIBEL_PROJECTOR
	asl
	tay
	lda	viewer_text,Y
	sta	OUTL
	lda	viewer_text+1,Y
	sta	OUTH

	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	pla
	sta	DRAW_PAGE

	inc	ANIMATE_FRAME

projector_animation:
	lda	ANIMATE_FRAME
	asl
	tay
	lda	achenar_projection_sprites,Y
	sta	INL
	lda	achenar_projection_sprites+1,Y
	sta	INH
	lda	#11
	sta	XPOS
	lda	#10
	sta	YPOS


	jsr	put_sprite_crop


	; increment animation
projection_inc_frame:
	lda	FRAMEL
	and	#$3f
	bne	done_projection
	inc	ANIMATE_FRAME
	lda	ANIMATE_FRAME
	cmp	#20
	bne	done_projection


	; reset
	lda	#0
	sta	ANIMATE_FRAME

	ldy	#LOCATION_SOUTH_BG
	lda	#<shack_entrance_s_lzsa
	sta	location28,Y			; NIBEL_SHACK_ENTRANCE
	lda	#>shack_entrance_s_lzsa
	sta	location28+1,Y			; NIBEL_SHACK_ENTRANCE

	lda	#DIRECTION_S
	jsr	change_location

done_projection:

	rts



achenar_projection_sprites:
	.word	achenar_sprite0		; 0	skipped
	.word	achenar_sprite0		; 1	skipped
	.word	achenar_sprite0		; 2	only bg
	.word	achenar_sprite0		; 3
	.word	achenar_sprite1		; 4
	.word	achenar_sprite2		; 5
	.word	achenar_sprite1		; 6
	.word	achenar_sprite2		; 7
	.word	achenar_sprite1		; 8
	.word	achenar_sprite2		; 9
	.word	achenar_sprite1		; 10
	.word	achenar_sprite3		; 11
	.word	achenar_sprite1		; 12
	.word	achenar_sprite2		; 13
	.word	achenar_sprite1		; 14
	.word	achenar_sprite3		; 15
	.word	achenar_sprite1		; 16
	.word	achenar_sprite2		; 17
	.word	achenar_sprite0		; 18
	.word	empty_sprite		; 19





empty_sprite:
	.byte 1,1
	.byte $AA

achenar_sprite0:
	.byte	7,8
	.byte	$AA,$EA,$A0,$0A,$A0,$0A,$AA
	.byte	$A5,$EA,$AE,$6A,$A6,$6A,$A0
	.byte	$AE,$0A,$AE,$FA,$A6,$0A,$A0
	.byte	$AE,$EA,$A0,$FA,$A0,$6A,$A0
	.byte	$AE,$EA,$AE,$EA,$A6,$6A,$A0
	.byte	$AE,$EA,$A0,$0A,$A6,$0A,$A0
	.byte	$A0,$0A,$A6,$5A,$A0,$0A,$A0
	.byte	$A6,$0A,$A0,$0A,$A0,$AA,$AA

achenar_sprite1:
	.byte	7,8
	.byte	$AA,$E0,$E0,$00,$00,$0A,$AA
	.byte	$55,$EE,$EE,$66,$66,$66,$00
	.byte	$EE,$0E,$0E,$F6,$06,$06,$00
	.byte	$EE,$EE,$E0,$FF,$60,$66,$00
	.byte	$EE,$EE,$5E,$EF,$66,$66,$00
	.byte	$0E,$EE,$00,$00,$06,$00,$00
	.byte	$00,$00,$56,$56,$00,$00,$00
	.byte	$A6,$00,$00,$00,$00,$A0,$AA

achenar_sprite2:
	.byte	7,8
	.byte	$AA,$E0,$E0,$00,$00,$0A,$AA
	.byte	$55,$EE,$EE,$66,$66,$66,$00
	.byte	$EE,$EE,$EE,$F6,$66,$66,$00
	.byte	$EE,$E0,$E0,$FF,$60,$60,$00
	.byte	$EE,$EE,$0E,$EF,$66,$66,$00
	.byte	$0E,$0E,$F0,$F0,$06,$00,$00
	.byte	$00,$00,$E6,$E6,$00,$00,$00
	.byte	$A6,$00,$00,$00,$00,$A0,$AA

achenar_sprite3:
	.byte	7,8
	.byte	$AA,$E0,$E0,$00,$00,$0A,$AA
	.byte	$55,$EE,$EE,$66,$66,$66,$00
	.byte	$EE,$E0,$00,$F6,$00,$60,$00
	.byte	$EE,$EE,$E0,$FF,$60,$66,$00
	.byte	$EE,$EE,$0E,$0F,$66,$66,$00
	.byte	$0E,$00,$2F,$2F,$00,$00,$00
	.byte	$00,$00,$22,$22,$00,$00,$00
	.byte	$A6,$00,$00,$00,$00,$A0,$AA




goto_shack_outside:
	lda	#NIBEL_SHACK_OUTSIDE
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION

	jmp	change_location

goto_wall:
	lda	#NIBEL_BLUE_PATH_2P75
	sta	LOCATION

	lda	#DIRECTION_N
	sta	DIRECTION

	jmp	change_location


scary_entrance:
	lda	#NIBEL_SHACK_ENTRANCE
	sta	LOCATION

	lda	#DIRECTION_S
	sta	DIRECTION

	jsr	change_location

	lda	#$1
	sta	ANIMATE_FRAME
	lda	#$f
	sta	FRAMEL

	rts

handle_shack_door:

	lda	CURSOR_X
	cmp	#17
	bcc	face_door	; blt
	cmp	#26
	bcc	go_straight	; blt

	; swing gate (26,27,28,29)

	lda	#1
	sta	ANIMATE_FRAME

	rts

go_straight:
	lda	#NIBEL_BLUE_PATH_2P5
	sta	LOCATION
	jmp	change_location

face_door:
	lda	#DIRECTION_E
	sta	DIRECTION
	jmp	change_direction




;=============================
;=============================
; elevator2 handle pulled
;=============================
;=============================

; FIXME: animate
elevator2_handle:

	; click speaker
	bit	SPEAKER

	; check for water power?
	; in theory can't get here unless there is water power
	; so assume it is still active

	lda	#ARBOR_INSIDE_ELEV2_CLOSED
	sta	LOCATION

	lda	#LOAD_ARBOR
	sta	WHICH_LOAD

	lda	#$ff
	sta	LEVEL_OVER

	rts


;=========================
;=========================
; close elevator2 door
;=========================
;=========================

elevator2_close_door:

	lda	#NIBEL_IN_ELEV2_TOP_CLOSED
	sta	LOCATION
	jmp	change_location


nibel_take_red_page:
	lda	#CHANNEL_PAGE
	jmp	take_red_page

nibel_take_blue_page:
	lda	#CHANNEL_PAGE
	jmp	take_blue_page


draw_blue_page:
	lda	DIRECTION
	cmp	#DIRECTION_E
	bne	no_draw_page

	lda	BLUE_PAGES_TAKEN
	and	#CHANNEL_PAGE
	bne	no_draw_page

	lda	#6
	sta	XPOS
	lda	#42
	sta	YPOS

	lda	#<blue_page_sprite
	sta	INL
	lda	#>blue_page_sprite
	sta	INH

	jmp	put_sprite_crop		; tail call

no_draw_page:
	rts



draw_red_page:
	lda	DIRECTION
	cmp	#DIRECTION_S
	bne	no_draw_page

	lda	RED_PAGES_TAKEN
	and	#CHANNEL_PAGE
	bne	no_draw_page

	lda	#13
	sta	XPOS
	lda	#36
	sta	YPOS

	lda	#<red_page_sprite
	sta	INL
	lda	#>red_page_sprite
	sta	INH

	jmp	put_sprite_crop		; tail call


projector_button:

	lda	DRAW_PAGE
	pha

	; mixed text and graphics
	bit	TEXTGR

;	lda	DIRECTION
;	ora	#DIRECTION_SPLIT
;	sta	DIRECTION

	lda	#$8
	sta	DRAW_PAGE

	jsr	clear_bottom

	; reset button colors
	lda	#$44
	sta	$D50+16
	sta	$D50+18
	sta	$D50+20
	sta	$D50+22

	lda	#$cc

	ldy	CURSOR_X
	cpy	#19
	bcs	button3
	cpy	#17
	bcs	button2
	cpy	#15
	bcs	button1
button0:

	sta	$D50+16

	lda	#<button0_and_2_animation
	sta	current_button_animation
	lda	#>button0_and_2_animation
	sta	current_button_animation+1

	lda	#0
	sta	NIBEL_PROJECTOR

	lda	#<viewer1_text
	sta	OUTL
	lda	#>viewer1_text
	sta	OUTH

	jmp	done_buttons

button1:

	sta	$D50+18

	lda	#<button1_animation
	sta	current_button_animation
	lda	#>button1_animation
	sta	current_button_animation+1

	lda	#1
	sta	NIBEL_PROJECTOR

	lda	#<viewer2_text
	sta	OUTL
	lda	#>viewer2_text
	sta	OUTH

	jmp	done_buttons

button2:
	sta	$D50+20

	lda	#<button0_and_2_animation
	sta	current_button_animation
	lda	#>button0_and_2_animation
	sta	current_button_animation+1

	lda	#2
	sta	NIBEL_PROJECTOR

	lda	#<viewer3_text
	sta	OUTL
	lda	#>viewer3_text
	sta	OUTH

	jmp	done_buttons

button3:
	sta	$D50+22

	lda	#<button3_animation
	sta	current_button_animation
	lda	#>button3_animation
	sta	current_button_animation+1

	lda	#3
	sta	NIBEL_PROJECTOR

	lda	#<viewer4_text
	sta	OUTL
	lda	#>viewer4_text
	sta	OUTH
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print


done_buttons:
	jsr	move_and_print
	pla
	sta	DRAW_PAGE

	lda	#1
	sta	ANIMATE_FRAME

	rts


nibel_view_torn_page:

	lda	#NIBEL_HALF_LETTER
	sta	LOCATION

	jsr	change_location

	bit	SET_TEXT		; set text mode

	rts

	;=============================
	; open the elevator door
	;=============================
nibel_open_elevator:

	lda	#NIBEL_OUTSIDE_ELEV2_OPEN
	sta	LOCATION

	jmp	change_location

	;=============================
	; get into the elevator
	;=============================
nibel_getin_elevator:

	lda	#NIBEL_IN_ELEV2_TOP_OPEN
	sta	LOCATION

	lda	#DIRECTION_E
	sta	DIRECTION

	jmp	change_location



	;=============================
	; open the drawer in red room
	;=============================
nibel_open_drawer:

	lda	#NIBEL_RED_TABLE_OPEN
	sta	LOCATION

	jmp	change_location



; viewer
viewer_text:
	.word viewer1_text
	.word viewer2_text
	.word viewer3_text
	.word viewer4_text


; position 1
; [talking in another language]

viewer1_text:
.byte 5,22,"[ WORDS IN ANOTHER LANGUAGE ]",0
.byte 0,23,0
.byte 0,23,0
.byte 0,23,0

; position 2
; [scary talking in another language]
viewer2_text:
.byte 1,22,"[ OMINOUS WORDS IN ANOTHER LANGUAGE ]",0
.byte 0,23,0
.byte 0,23,0
.byte 0,23,0

; position 3
; [ more talking in another language]

viewer3_text:
.byte 9,22,"[ MORE OMINOUS WORDS ]",0
.byte 0,23,0
.byte 0,23,0
.byte 0,23,0

; position 4
; Sirrus: I hope I pushed the right button
; my dear brother.what an interesting device you have here
; I'm not erasing anything important am I? haha
; remember he is preparing.  take only 1 page my dear
; brother

viewer4_text:
;                     1         2         3
;           0123456789012345678901234567890123456789
.byte 4,20,"I HOPE I PUSHED THE RIGHT BUTTON.",0
.byte 0,21,"WHAT AN INTERESTING DEVICE YOU HAVE HERE",0
.byte 1,22,"NOT ERASING ANYTHING IMPORTANT, AM I?",0
.byte 3,23,"TAKE ONLY ONE PAGE MY DEAR BROTHER.",0

current_button_animation:
	.word button0_and_2_animation

button0_and_2_animation:
	.word viewer_static1_sprite
	.word viewer_static2_sprite
	.word viewer_static1_sprite
	.word viewer_static2_sprite
	.word viewer_ach_sprite

button1_animation:
	.word viewer_static1_sprite
	.word viewer_static2_sprite
	.word viewer_static1_sprite
	.word viewer_static2_sprite
	.word viewer_ach_zoom_sprite

button3_animation:
	.word viewer_static1_sprite
	.word viewer_static2_sprite
	.word viewer_static1_sprite
	.word viewer_static2_sprite
	.word viewer_sir_sprite



viewer_static1_sprite:
.byte 12,8
.byte $55,$fd,$2f,$62,$26,$65,$f0,$6f,$26,$65,$5d,$ff
.byte $ff,$65,$56,$62,$26,$ff,$55,$52,$26,$62,$ff,$65
.byte $26,$62,$26,$55,$2f,$62,$26,$65,$f6,$6f,$26,$62
.byte $26,$62,$f6,$6f,$55,$62,$26,$ff,$26,$55,$26,$62
.byte $26,$ff,$26,$62,$26,$f5,$5f,$62,$26,$62,$55,$52
.byte $2f,$62,$26,$62,$f6,$6f,$25,$52,$26,$62,$26,$65
.byte $dd,$62,$26,$f2,$2f,$62,$26,$65,$56,$62,$26,$d2
.byte $dd,$d2,$f6,$6f,$26,$02,$26,$62,$26,$55,$dd,$dd

viewer_static2_sprite:
.byte 12,8
.byte $55,$fd,$6f,$26,$62,$25,$f0,$2f,$62,$25,$5d,$ff
.byte $ff,$25,$52,$26,$62,$ff,$55,$62,$62,$26,$ff,$25
.byte $02,$06,$02,$55,$0f,$06,$02,$05,$f2,$0f,$02,$06
.byte $00,$00,$f0,$0f,$55,$00,$00,$ff,$00,$55,$00,$00
.byte $60,$ff,$60,$20,$60,$f5,$5f,$20,$60,$20,$55,$50
.byte $6f,$26,$62,$26,$f2,$2f,$65,$56,$62,$26,$62,$25
.byte $dd,$26,$62,$f6,$6f,$26,$62,$25,$52,$26,$62,$d6
.byte $dd,$d6,$f2,$2f,$62,$06,$62,$26,$62,$55,$dd,$dd

viewer_ach_sprite:
.byte 12,8
.byte $55,$fd,$0f,$00,$00,$05,$f0,$0f,$00,$05,$5d,$ff
.byte $ff,$05,$50,$20,$62,$ff,$55,$50,$00,$00,$ff,$05
.byte $00,$00,$00,$55,$2f,$66,$26,$25,$f0,$0f,$00,$00
.byte $00,$00,$f0,$6f,$55,$66,$62,$ff,$00,$55,$00,$00
.byte $00,$ff,$00,$66,$66,$f5,$5f,$66,$00,$00,$55,$50
.byte $0f,$00,$e0,$26,$f2,$2f,$25,$56,$00,$00,$00,$05
.byte $dd,$0e,$e6,$f2,$6f,$62,$62,$05,$50,$00,$00,$d0
.byte $dd,$d0,$f0,$0f,$02,$06,$02,$00,$00,$55,$dd,$dd

viewer_ach_zoom_sprite:
.byte 12,8
.byte $55,$fd,$6f,$66,$66,$05,$f0,$0f,$00,$65,$5d,$ff
.byte $ff,$e5,$5e,$66,$66,$ff,$55,$56,$66,$66,$ff,$05
.byte $66,$e6,$6e,$55,$0f,$06,$06,$05,$f6,$6f,$66,$00
.byte $66,$e6,$f6,$0f,$55,$00,$00,$ff,$00,$55,$66,$00
.byte $66,$ff,$66,$68,$86,$f5,$5f,$68,$66,$6e,$55,$50
.byte $6f,$e6,$6e,$66,$f6,$6f,$65,$56,$68,$86,$66,$05
.byte $dd,$e6,$6e,$f6,$6f,$00,$00,$05,$50,$00,$00,$d0
.byte $dd,$d6,$f6,$0f,$06,$00,$00,$00,$00,$55,$dd,$dd

viewer_sir_sprite:
.byte 12,8
.byte $55,$fd,$0f,$00,$00,$e5,$fe,$ef,$c0,$05,$5d,$ff
.byte $ff,$05,$50,$00,$ee,$ff,$55,$54,$ee,$44,$ff,$05
.byte $00,$00,$00,$55,$4f,$ee,$44,$45,$fe,$4f,$00,$00
.byte $00,$00,$f0,$0f,$55,$ce,$44,$ff,$ee,$55,$00,$00
.byte $00,$ff,$00,$00,$4c,$f5,$5f,$44,$ee,$44,$55,$50
.byte $2f,$32,$23,$00,$fe,$4f,$c5,$5e,$cc,$32,$23,$35
.byte $dd,$32,$23,$f2,$2f,$34,$c4,$85,$5c,$32,$23,$d2
.byte $dd,$d2,$f3,$3f,$23,$02,$2e,$8c,$c8,$55,$dd,$dd






