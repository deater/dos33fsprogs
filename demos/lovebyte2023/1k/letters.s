
do_letters:

	;=========================================
	; SETUP
	;=========================================

	jsr	HGR2			; set/clear HGR page2 to black
					; Hi-res graphics, no text at bottom
					; Y=0, A=$60 after this call

	;==============================
	; print deater

	lda	#28			; y position
	sta	YPOS

;	lda	#$ff			; start on right hand side
;	sta	start_smc+1		; default

;	lda	#$fc			; movement size to add
;	sta	add_smc+1		;

;	lda	#<desire_ends+1		; default
;	sta	type_smc+1

;	lda	#<deater_offsets	; default
;	sta	offsets_smc+1

	jsr	slide_in


	;==============================
	; print maze

	lda	#28			; start on left hand side
	sta	start_smc+1

	lda	#4			; movement size to add
	sta	add_smc+1

	lda	#128			; Y location
	sta	YPOS

	lda	#<ma2e_ends		; point to the end table
	sta	type_smc+1

	lda	#<ma2e_offsets		; point to the shape offset
	sta	offsets_smc+1

	jsr	slide_in		; slide it

;	jsr	zoom_in			; just fall through

	; A is $FF here

	;=========================
	; zoom in
	;=========================

zoom_in:

	lda	#0			; reset rotate and pointer
	sta	ROTATE
	sta	WHICH

outer_zoom_loop:

	lda	WHICH
	tax				; update offset

	lda	desire_offsets,X	; get offsets in place
	sta	xdraw_offset_smc+1	; setup xdraw

	bmi	done2			; if negative, done

	lda	#36			; start big
	sta	HGR_SCALE

	lda	desire_ends,X		; X Position
	sta	XPOS

	lda	#76			; Y position
	sta	YPOS

inner_zoom_loop:

	jsr	draw_wait_erase

	dec	HGR_SCALE		; zoom in
	dec	HGR_SCALE

	lda	HGR_SCALE

	cmp	#10			; stop if big enough
	bcs	inner_zoom_loop

	jsr	xdraw			; leave it on screen

	inc	WHICH			; move to next letter

	bpl	outer_zoom_loop		; bra

done2:
;	rts
;
;.include "letters_routines.s"
