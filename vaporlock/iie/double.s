; Test mid-screen mode switch on Apple IIe double modes

; TODO: detect iic/iigs and vblank properly there

; by Vince `deater` Weaver

; zero page
GBASL	= $26
GBASH	= $27
V2	= $2D

HGRPAGE = $E6

YPOS	= $FE
TCOLOR	= $FF

; soft-switches
; yes, I know these aren't necessary the "official" names

EIGHTYSTORE	=	$C001
CLR80COL	=	$C00C
SET80COL	=	$C00D

SET_GR	= $C050
SET_TEXT= $C051
FULLGR	= $C052
TEXTGR	= $C053
PAGE1	= $C054
PAGE2	= $C055
LORES	= $C056
HIRES	= $C057
CLRAN3	= $C05E
SETAN3	= $C05F
VBLANK	= $C019		; *not* RDVBL (VBL signal low)

; ROM routines
SETCOL  = $F864		; COLOR=A*17
SETGR	= $FB40
VLINE	= $F828		; VLINE A,$2D at Y
HGR	= $F3E2
HPOSN	= $F411
HPLOT0  = $F457		; plot at (Y,X), (A)
HGLIN	= $F53A		; line to (X,A),(Y)

	;================================
	; Clear screen and setup graphics
	;================================
double:

	jsr	SETGR		; set lo-res 40x40 mode


	; set 80-store mode

	sta	EIGHTYSTORE	; PAGE2 selects AUX memory
	bit	PAGE1

	;===================
	; draw lo-res lines

	ldx	#39
draw_lores_lines:
	txa
	tay
	jsr	SETCOL

	lda	#47
	sta	V2
	lda	#0
	jsr	VLINE	; VLINE A,$2D at Y

	dex
	bpl	draw_lores_lines

	; copy to 800 temporarily
	; yes this is a bit of a hack

	ldy	#0
cp_loop:
	lda	$400,Y
	sta	$800,Y

	lda	$500,Y
	sta	$900,Y

	lda	$600,Y
	sta	$A00,Y

	lda	$700,Y
	sta	$B00,Y

	iny
	bne	cp_loop

	bit	PAGE1

	; copy to $400 in AUX

	bit	PAGE2	; $400 now maps to AUX:$400

	ldy	#0
cp2_loop:
	lda	$800,Y
	eor	#$FF
	sta	$400,Y

	lda	$900,Y
	eor	#$FF
	sta	$500,Y

	lda	$A00,Y
	eor	#$FF
	sta	$600,Y

	lda	$B00,Y
	eor	#$FF
	sta	$700,Y

	iny
	bne	cp2_loop

	bit	PAGE1


	;===================
	; draw hi-res lines

	jsr	HGR
	bit	FULLGR		; make it 40x48

	lda	#$FF
	sta	$E4		; HCOLOR

	ldx	#0
	ldy	#0
	lda	#96
	jsr	HPLOT0		; plot at (Y,X), (A)

	ldx	#0
	lda	#140
	ldy	#191
	jsr	HGLIN		; line to (X,A),(Y)

	ldx	#1
	lda	#23
	ldy	#96
	jsr	HGLIN		; line to (X,A),(Y)

; draw double-hires lines



	lda	#$20		; draw to page0 (MAIN?)
	sta	HGRPAGE

	lda	#150		; start at 150
	sta	YPOS
color_loop:
	lda	YPOS
	and	#$f
	sta	TCOLOR
	asl
	asl
	asl
	asl
	ora	TCOLOR
	sta	TCOLOR		; update color

	lda	YPOS
	jsr	draw_line_color

	inc	YPOS
	lda	YPOS
	cmp	#192
	bne	color_loop


	; wait for vblank on IIe
	; positive? during vblank

wait_vblank_iie:
	lda	VBLANK
	bmi	wait_vblank_iie		; wait for positive (in vblank)
wait_vblank_done_iie:
	lda	VBLANK			; wait for negative (vlank done)
	bpl	wait_vblank_done_iie

	;
double_loop:
	;===========================
	; text mode first 6*4 (24) lines
	;	each line 65 cycles (25 hblank+40 bytes)


; 3 LINES 80-COL AN3

	sta	SET80COL	; 4
	bit	SET_TEXT	; 4

	; wait 6*4=24 lines
	; (24*65)-8 = 1560-8 = 1552

	jsr	delay_1552

; 3 LINES 40-COL AN3

	sta	CLR80COL	; 4
	bit	SET_TEXT	; 4
	jsr	delay_1552

; 3 LINES 40-col LORES AN3

	lda	LORES		; 4
	bit	SET_GR		; 4
	jsr	delay_1552

; 3 LINES 80-col DLORES AN3

	sta	SET80COL	; 4
	sta	CLRAN3		; 4
	jsr	delay_1552

; 3 lines 40-col LORES

	sta	CLR80COL	; 4
	sta	SETAN3		; 4	; doublehiresoff
	jsr	delay_1552

; 3 lines HIRES
	sta	HIRES		; 4
	sta	CLRAN3		; 4
	jsr	delay_1552

; 3 lines HIRES
	sta	HIRES		; 4
	sta	SETAN3		; 4
	jsr	delay_1552

; 3 line Double-HIRES

	sta	SET80COL	; 4
	sta	CLRAN3		; 4

	jsr	delay_1552



	;==================================
	; vblank = 4550 cycles

	; Try X=226 Y=4 cycles=4545
skip_vblank:
	nop

	ldy	#4							; 2
loop3:	ldx	#226							; 2
loop4:	dex								; 2
	bne	loop4							; 2nt/3
	dey								; 2
	bne	loop3							; 2nt/3

	jmp	double_loop	; 3

;=======================================================
; need to align because if we straddle a page boundary
;	the time counts end up off

.align $100

	; actually want 1552-12 (6 each for jsr/rts)
	; 1540
	; Try X=15 Y=19 cycles=1540
delay_1552:

        ldy     #19							; 2
loop5:  ldx     #15							; 2
loop6:  dex								; 2
        bne     loop6							; 2nt/3
        dey								; 2
        bne     loop5							; 2nt/3

	rts


	;==========================
	; draw horizontal DHGR line
	;==========================
	; color is in TCOLOR
	; Y position is in A
	;=========================
draw_line_color:
	ldx	#0
	ldy	#0
	jsr	HPOSN		; setup GBASL/GBASH with Y position

	ldy	#0
line_loop_it:
	; set page2
	sta	PAGE2
	lda	TCOLOR
	sta	(GBASL),Y
	cmp	#$80
	rol	TCOLOR

	; set page1
	sta	PAGE1
	lda	TCOLOR
	sta	(GBASL),Y
	cmp	#$80
	rol	TCOLOR
	iny

	cpy	#40
	bne	line_loop_it

	rts
