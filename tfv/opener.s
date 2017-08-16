	;=============================
	; show VMW splash screen
	;=============================
opening:
	lda	#100
	sta	MATCH
	jsr	draw_logo
	jsr	page_flip

	; Draw the shining band

	lda	#0
	sta	MATCH
shine_loop:

	jsr	draw_logo
	jsr	page_flip

	inc	MATCH
	lda	MATCH
	cmp	#30
	bne	shine_loop

	lda	#8
	sta	CH		; HTAB 9

	lda	#20
	jsr	TABV		; VTAB 21


	lda     #>(vmwsw_string)
        sta     OUTH
	lda     #<(vmwsw_string)
        sta     OUTL

	jsr	print_string		; print("A VMW SOFTWARE PRODUCTION");


	jsr	wait_until_keypressed


	;=================
	; display part of logo
	;=================
	;
draw_segment:
	lda	#0
	sta	LOOP

segment_loop:
	lda	YADD
	clc
	adc	YY
	sta	YY	; yy=yy+yadd

	lda	COLOR1
	sta	COLOR		; color=COLOR1

	lda	MATCH		; if (ram[XX]==ram[MATCH])
	cmp	XX
	bne	nocolmatch1

	lda	COLOR		; color_equals(ram[COLOR1]*3);
	clc
	adc	COLOR1
	adc	COLOR1
	sta	COLOR

nocolmatch1:
	lda	YY
	sta	V2
	lda	XX
	clc
	adc	#9
	tay
	lda	#10
	tax

	jsr	vlin	; X,V2 at Y	vlin(10,ram[YY],9+ram[XX]);

	lda	COLOR2
	sta	COLOR		; color=COLOR2

	lda	MATCH		; if (ram[XX]==ram[MATCH])
	cmp	XX
	bne	nocolmatch2

	lda	COLOR		; color_equals(ram[COLOR2]*3);
	clc
	adc	COLOR2
	adc	COLOR2
	sta	COLOR

nocolmatch2:
	lda	#34
	sta	V2
	lda	XX
	clc
	adc	#9
	tay
	lda	YY
	tax
	cmp	#34
	beq	skip_bottom		   ; if (ram[YY]==34) skip
	jsr	vlin	; X,V2 at Y	vlin(ram[YY],34,9+ram[XX]);

skip_bottom:


	inc	XX		; ram[XX]++;

	inc	LOOP
	lda	LOOP
	cmp	#4
	bne	segment_loop

	lda	YADD		; ram[YADD]=-ram[YADD];
	eor	#$ff
	clc
	adc	#1
	sta	YADD

	rts

	;=================
	; display VMW logo
	;=================
	;
draw_logo:
	lda	#0
	sta	XX		; start of logo
	lda	#10
	sta	YY		; draw at Y=10
	lda	#6
	sta	YADD		; step of 6

	lda	#$00
	sta	COLOR2
	lda	#$11
	sta	COLOR1		; first colors are red/black
	jsr	draw_segment
	lda	#$44
	sta	COLOR2		; now red/green
	jsr	draw_segment
	lda	#$22
	sta	COLOR1		; now green/blue
	jsr	draw_segment
	jsr	draw_segment
	jsr	draw_segment
	lda	#$00
	sta	COLOR2		; now blue/black
	jsr	draw_segment

	rts

