; wires

; 159 -- initial
; 158 -- jmp to branch
; 152 -- special case dark blue
; 151 -- another jmp to branch
; 148 -- use $10 instead of $ff for black color
; 147 -- optimize color code
; 143 -- use 15x15 grid instead of 7x7
; 138 -- re-wrote clear screen code
; 144 -- back to original layout
; 142 -- jump to earlier BGND entry point
; 141 -- start at $FF even though it misses upper left
;	 this makes noticable glitches though

; goal=141

.include "zp.inc"
.include "hardware.inc"

CTEMP	= $FC


	;================================
	; Clear screen and setup graphics
	;================================
plasma:

	jsr	$F3D8		; HGR2 (and full screen), set HGRPAGE to $40
				; after, A is #$60
	lda	#$10		; write $10 to the 8k starting at $4000
	jsr	$F3F4		; does the store, is this allowed?
				;    stores to HGR.BITS and then runs BKGND

	bit	LORES		; switch to lo-res


	;================================
	; create texture
	;================================
	; we create a 16x16 texture, which we pattern across 40x48 screen

	ldx	#15

	; store at 15,x 8,x and x,15 x,8
	;	240+x, (x*16),15

write_loop:

	txa			; write 0123456789ABCDEF pattern horizontally
	sta	lookup+64,X	; line at Y=4
	sta	lookup+192,X	; line at Y=12

	asl			; draw vertical line
	asl
	asl
	asl

	tay
	txa
	sta	lookup+4,Y	; line at X=4
	sta	lookup+12,Y	; line at X=12

	dex
	bpl	write_loop

create_lookup_done:

	; X is $FF
	; Y is $00?

	;=========================
	; cycle colors
	;=========================

cycle_colors:

	; can't do palette rotate on Apple II so faking it here
	; just incrementing every entry in texture by 1

	; for this one we wrap at $f
	; and we don't touch color $10 which maps to zero (black)

	; X is $FF when arriving here
	; both from init and from end loop

	; we should start at 0, starting at FF means we never
	; cycle pixel 0.  We worked around this by arranging the texture
	; so pixel 0 is always black

;	ldx	#0
;	inx	; make X 0

;cycle_loop:
;	ldy	lookup,X
;	cpy	#$10		; $10 is black background, don't rotate it
;	beq	skip_zero
;	dey
;	tya
;	and	#$f
;	sta	lookup,X
;skip_zero:
;	dex
;	bne	cycle_loop

cycle_loop:
	lda	lookup,X
	cmp	#$10		; $10 is black background, don't rotate it
	; carry set if >=10
	bcs	skip_zero
	sbc	#0
	and	#$f
	sta	lookup,X
skip_zero:
	dex
	bne	cycle_loop


	;=========================
	; set/flip pages
	;=========================
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


	;===================================
	; plot current frame
	;===================================
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
	bcc	plot_mask	; set by the lsr
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
	lda	lookup,X	; load lookup, (y*16)+x

	cmp	#11
	bcc	color_blue	; if < 11, blue

color_notblue:
	tax
	lda	colorlookup-11,X	; lookup color

	.byte	$2C		; BIT trick
color_blue:
	lda	#$22		; load color blue (skipped if bit trick)

	sta	COLOR		; each nibble should be same

	jsr	PLOT1		; plot at GBASL,Y (x co-ord goes in Y)

	dey			; XX--
	bpl	plot_xloop	; loop if >=0

	pla			; restore YY
	tax
	dex			; YY--
	bpl	plot_yloop	; loop if >=0

	bmi	cycle_colors	; move to next frame

colorlookup:
.byte	$66,$77,$ff,$77,$66,$00


	; want this to be at 3f5
	; Length is 141 so start at $3f4 - 
	;			1013 - 141 + 3 = 875 = $36B

	jmp	plasma

; make lookup happen at page boundary

.org	$4000
lookup:
