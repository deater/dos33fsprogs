; wires

; 159 -- initial
; 158 -- jmp to branch
; 152 -- special case dark blue
; 151 -- another jmp to branch
; 148 -- use $10 instead of $ff for black color
; 147 -- optimize color code
; 143 -- use 15x15 grid instead of 7x7

; goal=141

.include "zp.inc"
.include "hardware.inc"

CTEMP	= $FC


	;================================
	; Clear screen and setup graphics
	;================================
plasma:

;	jsr	SETGR		; set lo-res 40x40 mode
;	bit	SET_GR
;	bit	FULLGR		; make it 40x48

	jsr	$F3D8		; HGR2
	bit	LORES

;	lda	#$20
;	sta	HGRPAGE
	lda	#$10
;	lsr
	sta	HGRBITS
	jsr	$F3F6		; BKGND

	; we only create a 16x16 texture, which we pattern across 40x48 screen


; need to beat 30 bytes

	ldx	#15	; store at 15,x and x,15
			; 240+x, (x*16),15

write_loop:

	txa
	sta	lookup+240,X
	sta	lookup+112,X

	asl
	asl
	asl
	asl

;	clc

	tay
	txa
	sta	lookup,Y

	dex
	bpl	write_loop


;create_lookup:
;	ldy	#15
;create_yloop:
;	ldx	#15
;create_xloop:

;	; vertical
;	txa
;;	and	#$7
;	bne	horiz
;
;xnot:
;	tya
;	bne	lookup_smc
;
;horiz:
;	; horizontal
;	tya
;;	and	#$7
;	beq	ynot
;
;	lda	#$10
;	bne	lookup_smc

;ynot:
;	txa
;lookup_smc:
;	sta	lookup		; always starts at $d00

;	inc	lookup_smc+1

;	dex
;	bpl	create_xloop

;	dey
;	bpl	create_yloop

	; X and Y both $FF

create_lookup_done:

forever_loop:

cycle_colors:
	; cycle colors

	; can't do palette rotate on Apple II so faking it here
	; just incrementing every entry in texture by 1

	; X is $FF when arriving here
;	ldx	#0
	inx	; make X 0
cycle_loop:
	ldy	lookup,X
	cpy	#$10
	beq	skip_zero
	iny
	tya
	and	#$f
	sta	lookup,X
skip_zero:
	inx
	bne	cycle_loop




	; set/flip pages
	; we want to flip pages and then draw to the offscreen one

flip_pages:

;	ldx	#0		; x already 0

	lda	draw_page_smc+1	; DRAW_PAGE
	beq	done_page
	inx
done_page:
	ldy	PAGE0,X		; set display page to PAGE1 or PAGE2

	eor	#$4		; flip draw page between $400/$800
	sta	draw_page_smc+1 ; DRAW_PAGE


	; plot current frame
	; scan whole 40x48 screen and plot each point based on
	; lookup table colors
plot_frame:

	ldx	#47		; YY=47 (count backwards)

plot_yloop:

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
draw_page_smc:
	adc	#0
	sta	GBASH

	;==========

	ldy	#39		; XX = 39 (countdown)

plot_xloop:

	tya			; get x&0xf
	and	#$f
	ora 	CTEMP 		; combine with val from earlier
				; get ((y&0xf)*16)+x

	tax

plot_lookup:

plot_lookup_smc:
	lda	lookup,X	; load lookup, (y*16)+x
	cmp	#11
	bcs	color_notblue	; if < 11, blue

color_blue:
	lda	#$11	; blue offset

color_notblue:
	tax
	lda	colorlookup-11,X	; lookup color

color_notblack:

	sta	COLOR		; each nibble should be same

	jsr	PLOT1		; plot at GBASL,Y (x co-ord goes in Y)

	dey
	bpl	plot_xloop

	pla
	tax

	dex
	bpl	plot_yloop
	bmi	forever_loop

colorlookup:

;.byte	$22,$22,$22,$22,$22,$22,$22,$22
;.byte	$22,$22,$22,
.byte	$66,$77,$ff,$77,$66,$00,$22


	; want this to be at 3f5
	; Length is 141 so start at $3f4 - 
	;			1013 - 141 + 3 = 875 = $36B

	jmp	plasma

; make lookup happen at page boundary

.org	$4000
lookup:
