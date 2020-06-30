

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




; viewer

; position 1
; [talking in another language]

viewer1_text:
.byte "[WORDS IN ANOTHER LANGUAGE]"

; position 2
; [scary talking in another language]
viewer2_text:
.byte "[OMINIOUS WORDS IN ANOTHER LANGUAGE]"

; position 3
; [ more talking in another language]

viewer3_text:
.byte "[MORE OMINIOUS WORDS IN ANOTHER LANGUAGE]"

; position 4
; Sirrus: I hope I pushed the right button
; my dear brother.what an interesting device you have here
; I'm not erasing anything important am I? haha
; remember he is preparing.  take only 1 page my dear
; brother

viewer4_text:
;                1         2         3
;      0123456789012345678901234567890123456789
.byte "I HOPE I PUSHED THE RIGHT BUTTON."
.byte "WHAT AN INTERESTING DEVICE YOU HAVE HERE"
.byte "NOT ERASING ANYTHING IMPORTANT, AM I?"
.byte "TAKE ONLY ONE PAGE MY DEAR BROTHER."
