

;=============================
;=============================
; elevator2 handle pulled
;=============================
;=============================


; FIXME: check for water power
; FIXME: animate
elevator2_handle:

	; click speaker
	bit	SPEAKER

	; check for water power

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

; position 1
; [talking in another language]

viewer1_text:
.byte 5,22,"[ WORDS IN ANOTHER LANGUAGE ]",0

; position 2
; [scary talking in another language]
viewer2_text:
.byte 1,22,"[ OMINOUS WORDS IN ANOTHER LANGUAGE ]",0

; position 3
; [ more talking in another language]

viewer3_text:
.byte 9,22,"[ MORE OMINOUS WORDS ]",0

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






