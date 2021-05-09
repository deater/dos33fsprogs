; A 123-byte Apple II Lo-res Fake Palette Rotation Demo
;	The Apple II has no Palette rotation hardware, so we fake it

; For Lovebyte 2021

; by Vince `deater` Weaver (vince@deater.net) / dSr
; with some help from qkumba

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
; 139 -- from qkumba, remove php/plp
; 138 -- from qkumba, remove SAVEX
; 133 -- run from zero page
; 132 -- make lookup 8*sin+7
; 131 -- re-arrange sine table
; 128 -- call into PLOT for MASK seting

; urgh lovebyte wants 124 byte (counts header)

; 127 -- base YY<<16 by adding smc, not by shifting
; 125 -- realize that the top byte wraps so no need to and
; 124 -- re-arrange code to make an CLC unnecessary
; 123 -- qkumba noticed we can use the $FF offset directly in page flip


; zero page
;GBASL	= $26
;GBASH	= $27
;MASK	= $2E
;COLOR	= $30
;CTEMP	= $68
YY	= $69

; soft-switches
;FULLGR	= $C052
;PAGE1	= $C054

; ROM routines
;PLOT1	= $F80E		;; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
GBASCALC= $F847		;; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)
;SETCOL  = $F864		;; COLOR=A*17
;SETGR	= $FB40


;.zeropage
;.globalzp	colorlookup,plot_lookup_smc,draw_page_smc,frame_smc,sinetable


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


	; I've tried re-optimizing this about 10 different ways
	; and it never ends up shorter

create_lookup:
	ldx	#15
create_yloop:
	ldy	#15
create_xloop:
	sec
	lda	sinetable,X
	adc	sinetable,Y	; 15+sin(x)+sin(y)
	lsr
lookup_smc:
	sta	lookup		; always starts at $d00
	inc	lookup_smc+1

	dey
	bpl	create_xloop

	dex
	bpl	create_yloop

	; X and Y both $FF

create_lookup_done:

forever_loop:

cycle_colors:

	; cycle colors
	; instead of advancing entire frame, do slightly slower route
	; instead now and just incrememnting the frame and doing the
	; adjustment at plot time.

	; increment frame

	inc	frame_smc+1

	; set/flip pages
	; we want to flip pages and then draw to the offscreen one

flip_pages:

;	ldy	#0

;	iny			; y is $FF, make it 0

	lda	draw_page_smc+1	; DRAW_PAGE
	bne	done_page
	dey
done_page:
;	ldx	PAGE1,Y		; set display page to PAGE1 or PAGE2

	ldx	$BF56,Y		; PAGE1 - $FF

	eor	#$4		; flip draw page between $400/$800
	sta	draw_page_smc+1 ; DRAW_PAGE


	; plot current frame
	; scan whole 40x48 screen and plot each point based on
	; lookup table colors
plot_frame:

	ldx	#47		; YY=47 (count backwards)
plot_yloop:

	txa			; get YY into A
	pha			; save X for later
	lsr			; call actually wants Ycoord/2

	php			; save C flag for mask handling

	; ugh can't use PLOT trick as it always will draw something
	; to PAGE1 even if we don't want to

	jsr	GBASCALC	; point GBASL/H to address in (A is ycoord/2)
				; after, A is GBASL, C is clear

	lda	GBASH		; adjust to be PAGE1/PAGE2 ($400 or $800)
draw_page_smc:
	adc	#0
	sta	GBASH

	; increment YY in top nibble of lookup for (yy<<16)+xx
	; clc	from above, C always 0
	lda	plot_lookup_smc+1
	adc	#$10		; no need to mask as it will oflo and be ignored
	sta	plot_lookup_smc+1

	;==========

	ldy	#39		; XX = 39 (countdown)

	; sets MASK by calling into middle of PLOT routine
	; by Y being 39 draw in a spot that gets over-written

	plp
	jsr	$f806

plot_xloop:

	tya			; get XX & 0x0f
	and	#$f
	tax

plot_lookup_smc:
	lda	lookup,X	; load lookup, (YY*16)+XX

	clc
frame_smc:
	adc	#$00		; add in frame

	and	#$f
	lsr			; we actually only have 8 colors

	tax

	lda	colorlookup,X	; lookup color


	sta	COLOR		; each nibble should be same

	jsr	PLOT1		; plot at GBASL,Y (x co-ord goes in Y)

	dey
	bpl	plot_xloop

	pla			; restore YY
	tax
	dex
	bpl	plot_yloop
	bmi	forever_loop

colorlookup:

; blue
.byte $55,$22,$66,$77,$ff,$77,$55	; ,$00 shared w sin table


sinetable:
; this is actually (8*sin(x))+7
; re-arranged so starts with $00 for colorlookup overlap
.byte $00,$FF
HACK:			; use the $0200 here for (HACK),Y addressing?
			; in the end no way to get Y set properly
.byte $00,$02,$04
.byte $07,$0A,$0C,$0E,$0F,$0E,$0C,$0A
.byte $07,$04,$02


; make lookup happen at page boundary

lookup = $200

;.org	$200
;lookup:
