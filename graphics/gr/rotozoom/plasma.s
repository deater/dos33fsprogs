
texture = $d00
high_lookup = $e00
low_lookup = $f00

;col = ( 8.0 + (sintable[xx&0xf])
;           + 8.0 + (sintable[yy&0xf])
;            ) / 2;

init_plasma_texture:

	ldy	#15
create_yloop:
	ldx	#15
create_xloop:
	clc
	lda	#15
	adc	sinetable,X
	adc	sinetable,Y
	lsr
lookup_smc:
	sta	texture		; always starts at $d00

	inc	lookup_smc+1

	dex
	bpl	create_xloop

	dey
	bpl	create_yloop

	rts


	;==============================
	; update plasma

update_plasma:

cycle_colors:
	; cycle colors

	ldx	#0
cycle_texture_loop:
	inc	texture,X

	lda	texture,X	; slow here but faster than doing it
	and	#$f		; in the draw routine
	sta	texture,X

	inx
	bne	cycle_texture_loop

	; make lookup

	ldx	#0
cycle_lookup_loop:
	lda	texture,X
	lsr
	tay
color_lookup_smc:
	lda	green_lookup,Y
	pha
	and	#$f0
	sta	high_lookup,X
	pla
	and	#$0f
	sta	low_lookup,X

	inx
	bne	cycle_lookup_loop

	rts

.if 0
plot_frame:

	; plot frame

	ldx	#47		; YY=0

plot_yloop:

	txa			; get (y&0xf)<<4
	pha			; save YY
	asl
	asl
	asl
	asl
	sta	CTEMP

	txa
	lsr

	ldy	#$0f		; setup mask
	bcc	plot_mask
	ldy	#$f0

plot_mask:
	sty	MASK



	jsr	GBASCALC	; point GBASL/H to address in A
				; after, A trashed, C is clear

	;==========

	ldy	#39		; XX = 39 (countdown)

plot_xloop:

	tya			; get x&0xf
	and	#$f
	ora 	CTEMP 		; get ((y&0xf)*16)+x

	tax

plot_lookup:

;	sta	plot_lookup_smc+1

plot_lookup_smc:
	lda	lookup,X	; load lookup, (y*16)+x
;	lda	lookup	; load lookup, (y*16)+x

	and	#$f
	lsr
	tax
	lda	colorlookup,X
	sta	COLOR

	jsr	PLOT1	; plot at GBASL,Y (x co-ord in Y)

	dey
	bpl	plot_xloop

	pla
	tax			; restore YY

	dex
	bpl	plot_yloop
	bmi	forever_loop

.endif

which_color:	.byte $0

colorlookup:
.word	green_lookup,yellow_lookup,blue_lookup,red_lookup



; blue
blue_lookup:
.byte $55,$22,$66,$77,$ff,$77,$55,$00

; red
red_lookup:
.byte $55,$11,$33,$bb,$ff,$bb,$55,$00

; green
green_lookup:
.byte $55,$44,$cc,$ee,$ff,$ee,$55,$00

; yellow
yellow_lookup:
.byte $55,$88,$99,$dd,$ff,$dd,$55,$00

sinetable:
.byte $00,$03,$05,$07,$08,$07,$05,$03
.byte $00,$FD,$FB,$F9,$F8,$F9,$FB,$FD
