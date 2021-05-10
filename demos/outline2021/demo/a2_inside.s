; Apple II self portrait using Boxes

	;================================
	; Clear screen and setup graphics
	;================================
a2_inside:

	jsr	SETGR		; set lo-res 40x40 mode
	bit	PAGE0
	bit	LORES
	bit	FULLGR		; make it 40x48


	;=============================
	; init wires

	jsr	wires_create_lookup

	;=============================
	; draw the computer

draw_box_loop:

	; get color/Y0
	jsr	load_byte
	tax			; Y0 is in X

	tya			; check for end

	bmi	done_computer


	jsr	load_byte	; Y1
	sta	Y1

	jsr	load_byte	; X0
	sta	X0

	tya
	lsr
	lsr
	sta	COLOR


	jsr	load_byte	; X1
	sta	H2

	tya
	and	#$C0
	ora	COLOR

	lsr
	lsr
	lsr
	lsr

	jsr	SETCOL


inner_loop:

	;; HLINE Y,H2 at A
	;; X left alone, carry set on exit
	;; H2 left alone
	;; Y and A trashed

	ldy	X0
	txa
	jsr	HLINE

	cpx	Y1
	inx
	bcc	inner_loop
	bcs	draw_box_loop

done_computer:

	;====================================
	; draw the demo, sierpinski at first
	;====================================
	; screen is from (11,6) - (20,23)
	; so size is 9,17?


	lda	#200
	sta	FRAME


	; pause a bit at beginning
	jsr	WAIT

sier_loop:

	lda	#100		; Wait a bit, we're too fast
	jsr	WAIT

	inc	FRAME		; increment frame

	ldx	#17		; YY

sier_yloop:

	lda	#9		; XX
	sta	XX

sier_xloop:

	txa			; get YY
	clc
	adc	FRAME		; and add in FRAME

	and	XX		; and it with XX

	bne	black
	lda	FRAME		; color is based on frame
	lsr			; only update every 16 lines?
	lsr
	lsr
	lsr
	bne	not_zero	; but no color 0 (would be all black)
	lda	#3		; how about purple instead

not_zero:

	.byte	$2C	; bit trick
black:
	lda	#$00

	jsr	SETCOL		; set top/bottom nibble same color

	lda	XX		; offset XX to tiny screen
	clc
	adc	#11
	tay			; put into Y

	txa			; offset YY to tiny screen
	clc
	adc	#6		; put into A

	jsr	PLOT		; PLOT AT Y,A

	dec	XX
	bpl	sier_xloop

	dex
	bpl	sier_yloop

	lda	FRAME
	bne	sier_loop
;	rts



	;====================================
	; draw the demo, wires
	;====================================
	; screen is from (11,6) - (20,23)
	; so size is 9,17?


	lda	#200
	sta	FRAME


	; pause a bit at beginning
	jsr	WAIT

a2_wire_loop:

	jsr	wires_cycle_colors

	lda	#100		; Wait a bit, we're too fast
	jsr	WAIT

	inc	FRAME		; increment frame

	ldx	#17		; YY

a2_wire_yloop:

	lda	#9		; XX
	sta	XX

a2_wire_xloop:

	txa
	and	#$f

	asl
	asl
	asl
	asl
	ora	XX
	tay

        lda     wires_lookup,Y          ; load from array               ; 4

        cmp     #11
        bcs     acolor_notblue   ; if < 11, blue

acolor_blue:
        lda     #$11    ; blue offset

acolor_notblue:
        tay
        lda     wires_colorlookup-11,Y  ; lookup color

acolor_notblack:




	jsr	SETCOL		; set top/bottom nibble same color

	lda	XX		; offset XX to tiny screen
	clc
	adc	#11
	tay			; put into Y

	txa			; offset YY to tiny screen
	clc
	adc	#6		; put into A

	jsr	PLOT		; PLOT AT Y,A

	dec	XX
	bpl	a2_wire_xloop

	dex
	bpl	a2_wire_yloop

	lda	FRAME
	bne	a2_wire_loop



	;=======================================
	; copy to $c00
	;=======================================

	lda	#0
	sta	DRAW_PAGE
	jsr	gr_copy_from_current

	lda	#4
	sta	DISP_PAGE

	;============================
	; rotozoom
	;============================

	; do a (hopefully fast) roto-zoom

;	jsr	clear_screens
;	jsr	init_multiply_tables

	jsr	gr_copy_to_current
	jsr	page_flip
	jsr	gr_copy_to_current

	;=================================
	; main loop

	lda	#0
	sta	ANGLE
	sta	SCALE_F
	sta	FRAME

	lda	#1
	sta	direction
	lda	#$10
	sta	scaleaddl
	lda	#$00
	sta	scaleaddh

	lda	#1
	sta	SCALE_I

rz_main_loop:

	jsr	rotozoom_c00

	jsr	page_flip

;wait_for_keypress:
;	lda	KEYPRESS
;	bpl	wait_for_keypress
;	bit	KEYRESET


	clc
	lda	FRAME
	adc	direction
	sta	FRAME

	cmp	#$f8
	beq	rback_at_zero
	cmp	#33
	beq	rat_far_end
	bne	rdone_reverse

rback_at_zero:
;	inc	which_image
;	lda	which_image
;	cmp	#3
;	bne	refresh_image
;	lda	#0
;	sta	which_image
;refresh_image:
;	jsr	load_background

rat_far_end:

	rts

	; change bg color
;	lda	roto_color_even_smc+1
;	clc
;	adc	#$01
;	and	#$0f
;	sta	roto_color_even_smc+1

;	lda	roto_color_odd_smc+1
;	clc
;	adc	#$10
;	and	#$f0
;	sta	roto_color_odd_smc+1



	; reverse direction
;;	lda	direction
;	eor	#$ff
;	clc
;	adc	#1
;	sta	direction

;	lda	scaleaddl
;	eor	#$ff
;	clc
;	adc	#1
;	sta	scaleaddl

;	lda	scaleaddh
;	eor	#$ff
;	adc	#0
;	sta	scaleaddh

rdone_reverse:
	clc
	lda	ANGLE
	adc	direction
	and	#$1f
	sta	ANGLE

	clc
	lda	SCALE_F
	adc	scaleaddl
	sta	SCALE_F
	lda	SCALE_I
	adc	scaleaddh
	sta	SCALE_I

	jmp	rz_main_loop


;direction:	.byte	$01
;scaleaddl:	.byte	$10
;scaleaddh:	.byte	$00



	rts




	;=========================
	; load byte routine
	;=========================

load_byte:
	inc	load_byte_smc+1
	bne	load_byte_nowrap
	inc	load_byte_smc+2

load_byte_nowrap:
				; so no need to wrap
load_byte_smc:
	lda	box_data-1
	tay
	and	#$3f
	rts


	; 4 6 6 6 6
box_data:
	.byte $00,$2F,$C0,$E7
	.byte $01,$2B,$0A,$9B
	.byte $28,$29,$43,$D4
	.byte $24,$27,$43,$D6
	.byte $20,$23,$45,$D7
	.byte $1C,$1F,$48,$D8
	.byte $23,$26,$07,$8E
	.byte $24,$27,$08,$92
	.byte $1F,$1F,$0D,$92
	.byte $2A,$2B,$43,$54
	.byte $2C,$2D,$46,$53
	.byte $2C,$2D,$14,$97
	.byte $08,$16,$1C,$9C
	.byte $02,$1A,$49,$D8
	.byte $04,$18,$0A,$95
	.byte $06,$17,$0B,$14
	.byte $15,$29,$22,$A2
	.byte $13,$28,$22,$A4
	.byte $13,$14,$5C,$63
	.byte $15,$16,$5B,$61
	.byte $17,$2B,$59,$E1
	.byte $18,$20,$1A,$20
	.byte $22,$2A,$1A,$20
	.byte $1C,$1C,$5B,$60
	.byte $26,$26,$5B,$60
	.byte $1F,$20,$DF,$1F
	.byte $29,$2A,$DF,$1F
	.byte $19,$1E,$5D,$5E
	.byte $23,$28,$5D,$5E
	.byte $02,$03,$17,$D7
	.byte $FF
