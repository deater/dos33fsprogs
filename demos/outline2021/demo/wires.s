; wires



;CTEMP	= $FC


	;================================
	; Clear screen and setup graphics
	;================================
wires:

;	jsr	SETGR		; set lo-res 40x40 mode
	bit	SET_GR
	bit	LORES
	bit	FULLGR		; make it 40x48

	lda	#0
	sta	FRAME

	jsr	wires_create_lookup



wires_forever_loop:

	jsr	wires_cycle_colors

	; set/flip pages
	; we want to flip pages and then draw to the offscreen one

wire_flip_pages:

;	ldx	#0		; x already 0

	lda	wires_draw_page_smc+1	; DRAW_PAGE
	beq	wire_done_page
	inx
wire_done_page:
	ldy	PAGE0,X		; set display page to PAGE1 or PAGE2

	eor	#$4		; flip draw page between $400/$800
	sta	wires_draw_page_smc+1 ; DRAW_PAGE


	; plot current frame
	; scan whole 40x48 screen and plot each point based on
	; lookup table colors
wire_plot_frame:

	ldx	#47		; YY=47 (count backwards)

wires_plot_yloop:

	txa			; get (y&0xf)<<4
	pha			; save YY / SAVEX

	asl
	asl
	asl
	asl
	sta	CTEMP		; save for later

	txa			; get YY in accumulator
	lsr			; call actually wants Ycoord/2


	ldy	#$0f		; setup mask for odd/even line
	bcc	plot_mask
	ldy	#$f0
plot_mask:
	sty	MASK

	jsr	GBASCALC	; point GBASL/H to address in (A is ycoord/2)
				; after, A is GBASL, C is clear

	lda	GBASH		; adjust to be PAGE1/PAGE2 ($400 or $800)
wires_draw_page_smc:
	adc	#0
	sta	GBASH

	;==========

	ldy	#39		; XX = 39 (countdown)

wires_plot_xloop:

	tya			; get x&0xf
	and	#$f
	ora 	CTEMP 		; combine with val from earlier
				; get ((y&0xf)*16)+x

	tax

wires_plot_lookup:

wires_plot_lookup_smc:
	lda	wires_lookup,X	; load lookup, (y*16)+x
	cmp	#11
	bcs	color_notblue	; if < 11, blue

color_blue:
	lda	#$11	; blue offset

color_notblue:
	tax
	lda	wires_colorlookup-11,X	; lookup color

color_notblack:

	sta	COLOR		; each nibble should be same

	jsr	PLOT1		; plot at GBASL,Y (x co-ord goes in Y)

	dey
	bpl	wires_plot_xloop

	pla
	tax

	dex
	bpl	wires_plot_yloop

	inc	FRAME
	lda	FRAME
	cmp	#$40
	bne	wires_forever_loop

	rts

wires_colorlookup:

;.byte	$22,$22,$22,$22,$22,$22,$22,$22
;.byte	$22,$22,$22,
.byte	$66,$77,$ff,$77,$66,$00,$22

; make lookup happen at page boundary

;.align	$100
;.org	$d00
;wires_lookup:

wires_lookup	= $1000


	;===============================
	; wires create lookup
	;===============================
	;
	; we only create a 16x16 texture, which we pattern across 40x48 screen

wires_create_lookup:
	ldy	#15
wires_create_yloop:
	ldx	#15
wires_create_xloop:

	; vertical
	txa
	and	#$7
	bne	horiz

xnot:
	tya
	bne	wires_lookup_smc

horiz:
	; horizontal
	tya
	and	#$7
	beq	ynot

	lda	#$10
	bne	wires_lookup_smc

ynot:
	txa
wires_lookup_smc:
	sta	wires_lookup		; always starts at $d00

	inc	wires_lookup_smc+1

	dex
	bpl	wires_create_xloop

	dey
	bpl	wires_create_yloop

	; X and Y both $FF

wires_create_lookup_done:
	rts


	;===============================
	; wires cycle colors
	;===============================

wires_cycle_colors:
	; cycle colors

	; can't do palette rotate on Apple II so faking it here
	; just incrementing every entry in texture by 1

	; X is $FF when arriving here
;	ldx	#0
	inx	; make X 0
cycle_loop:
	ldy	wires_lookup,X
	cpy	#$10
	beq	skip_zero
	iny
	tya
	and	#$f
	sta	wires_lookup,X
skip_zero:
	inx
	bne	cycle_loop

	rts
