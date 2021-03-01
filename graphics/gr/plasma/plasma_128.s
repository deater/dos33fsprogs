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
; 139 -- from qkumba, remove php/plp
; 138 -- from qkumba, remove SAVEX
; 133 -- run from zero page
; 132 -- make lookup 8*sin+7
; 131 -- re-arrange sine table
; 128 -- call into PLOT for MASK seting

; urgh lovebyte wants 124 byte (counts header)

; zero page
GBASL	= $26
GBASH	= $27
MASK	= $2E
COLOR	= $30
CTEMP	= $68

; soft-switches
FULLGR          =       $C052
PAGE0           =       $C054

; ROM routines
PLOT1	= $F80E		;; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
GBASCALC= $F847		;; take Y-coord/2 in A, put address in GBASL/H ( a trashed, C clear)
SETCOL  = $F864		;; COLOR=A*17
SETGR	= $FB40


.zeropage

.globalzp	sinetable,colorlookup,draw_page_smc

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
	sec
	lda	sinetable,X
	adc	sinetable,Y	; 15+sin(x)+sin(y)
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
	pha			; save YY
	asl
	asl
	asl
	asl
	sta	CTEMP		; save for later

	txa			; get Y in accumulator
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



	;==========

	ldy	#39		; XX = 39 (countdown)

	; sets MASK by calling into middle of PLOT routine
	; by Y being 39 draw in a spot that gets over-written

	plp
	jsr	$f806

plot_xloop:

	tya			; get x&0xf
	and	#$f
	ora 	CTEMP 		; combine with val from earlier
				; get ((y&0xf)*16)+x

	tax

plot_lookup:
plot_lookup_smc:
	lda	lookup,X	; load lookup, (y*16)+x

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
.byte $00,$FF,$00,$02,$04
.byte $07,$0A,$0C,$0E,$0F,$0E,$0C,$0A
.byte $07,$04,$02


; make lookup happen at page boundary

.org	$d00
lookup:
