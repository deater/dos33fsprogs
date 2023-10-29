; do a (hopefully fast) plasma type demo

; 151 -- original
; 137 -- optimize generation
; 136 -- align lookup table so we can index it easier
; 130 -- optimize indexing of lookup
; 126 -- run loops backaward
; 124 -- notice X already 0 before plot
; 131 -- use GBASCALC.  much faster, but 7 bytes larger
; 129 -- run loop backwards
; 128 -- set color ourselves
; 127 -- overlap color lookup with sine table
; 119 -- forgot to comment out unused
; 121 -- make it use full screen (40x48)

; 149 -- add page flipping
; 144 -- optimize a bit
; 141 -- smc DRAW_PAGE

; 144 -- for bot, backwards jump
; 142 -- from qkumba, remove php/plp
; 141 -- from qkumba, remove SAVEX

; goal=135

.include "zp.inc"
.include "hardware.inc"

CTEMP	= $FC
;SAVEOFF	= $FD
;SAVEX	= $FE
;SAVEY	= $FF

	;================================
	; Clear screen and setup graphics
	;================================
plasma:

	jsr	SETGR		; set lo-res 40x40 mode
	bit	FULLGR		; make it 40x48



;	color = ( 8.0 + 8*sin(x) + 8.0 + 8*sin(y) )/2
;		becomes
;	color = ( 16 + (sintable[xx&0xf]) + (sintable[yy&0xf])) / 2;

	; we only create a 16x16 texture, which we pattern across 40x48 screen

create_lookup:
	ldy	#15
create_yloop:
	ldx	#15
create_xloop:
	clc
	lda	#15		; 8+8 (but 15 works better)
	adc	sinetable,X
	adc	sinetable,Y
	lsr
lookup_smc:
	sta	lookup		; always starts at $d00

	inc	lookup_smc+1

	dex
	bpl	create_xloop

	dey
	bpl	create_yloop

	; X and Y both $FF

create_lookup_done:

forever_loop:

cycle_colors:
	; cycle colors

	; can't do palette rotate on Apple II so faking it here
	; just incrementing every entry in texture by 1

	; X if $FF when arriving here
;	ldx	#0
	inx	; make X 0
cycle_loop:
	inc	lookup,X
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
	ldy	PAGE1,X		; set display page to PAGE1 or PAGE2

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

	txa			; get Y in accumulator
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

;	stx	SAVEX		; SAVE YY

	tya			; get x&0xf
	and	#$f
	ora 	CTEMP 		; combine with val from earlier
				; get ((y&0xf)*16)+x

	tax

plot_lookup:

;	sta	plot_lookup_smc+1

plot_lookup_smc:
	lda	lookup,X	; load lookup, (y*16)+x
;	lda	lookup	; load lookup, (y*16)+x

	and	#$f
	lsr			; we actually only have 8 colors

	tax
	lda	colorlookup,X	; lookup color
	sta	COLOR		; each nibble should be same

	jsr	PLOT1		; plot at GBASL,Y (x co-ord goes in Y)

;	ldx	SAVEX		; restore YY


	dey
	bpl	plot_xloop

	pla
	tax

	dex
	bpl	plot_yloop
	bmi	forever_loop

colorlookup:
bw_color_lookup:

; blue
;.byte $55,$22,$66,$77,$ff,$77,$55	; ,$00 shared w sin table

; pink
.byte $55,$11,$33,$bb,$ff,$bb,$55

; this is actually 8*sin(x)
sinetable:
.byte $00,$03,$05,$07,$08,$07,$05,$03
.byte $00,$FD,$FB,$F9,$F8,$F9,$FB,$FD

;colorlookup:
;.byte $00,$00,$05,$05,$07,$07,$0f,$0f
;.byte $07,$07,$06,$06,$02,$02,$05,$05
;.byte $00,$55,$77,$ff,$77,$66,$22,$55

	; want this to be at 3f5
	; Length is 141 so start at $3f4 - 
	;			1013 - 141 + 3 = 875 = $36B

	jmp	plasma

; make lookup happen at page boundary

.org	$d00
lookup:
