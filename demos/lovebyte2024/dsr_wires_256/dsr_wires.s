; desire wires -- Apple II Hires

; by Vince `deater` Weaver / dSr

; Lovebyte 2024


; 247 bytes -- initial version
; 242 bytes -- optimize page flip
; 252 bytes -- add alternating logo/field
;           -- inlining draw_box saves no bytes

; D0+ used by HGR routines

HGR_X		= $E0
HGR_Y		= $E2
HGR_COLOR	= $E4
HGR_PAGE	= $E6

GBASL		= $26
GBASH		= $27

TEMPY		= $F0
TEMPX		= $F1
HGR_END2	= $FC
HGR_END		= $FD
COUNT		= $FE
FRAME		= $FF

; soft-switches

PAGE1   = $C054
PAGE2   = $C055

; ROM routines

HGR2		= $F3D8		; set hires page2 and clear $4000-$5fff
HGR		= $F3E2		; set hires page1 and clear $2000-$3FFF
HPOSN           = $F411
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us


hposn_low	= $8000
hposn_high	= $8100


wires:
	jsr	HGR
	sty	FRAME

	;==========================
	; make HGR lookup table

	; Y=0 from HGR
table_loop:
        tya				; XPOS=(Y,X) YPOS=A
        jsr     HPOSN
        ldy     HGR_Y                   ; HPOSN saves this
        lda     GBASL
        sta     hposn_low,Y
        lda     GBASH
	sec
	sbc	#$20			; adjust to take off HGR_PAGE
        sta     hposn_high,Y
        iny
        bne     table_loop		; seems harmless to run 192..255?


	jsr	HGR2		; clear screen PAGE2  A and Y 0 after

reset_x:

	; reset X
	ldx	#$0


switch_pages:

	;==========================
	; flip pages

	lda	HGR_PAGE	; flip draw page
	eor	#$60
	sta	HGR_PAGE

	asl
	asl
	asl
	rol
	tay
	lda	PAGE1,Y

outer_loop:

	;=====================================
	; pulse loop horizontal
	;=====================================
	; write out pattern to horizontal line
	; due to memory layout by going $4000-$43FF only draw every 8th line


	lda	#$00
	tay

	sta	GBASL

	lda	HGR_PAGE		; point GBASL to $4000
	sta	GBASH

	clc
	adc	#$4
	sta	HGR_END
	adc	#$1C
	sta	HGR_END2
horiz_loop:

	lda	even_lookup,X
	sta	(GBASL),Y
	iny

	lda	odd_lookup,X
	sta	(GBASL),Y
	iny

	bne	noflo2
	inc	GBASH
noflo2:

	lda	HGR_END
	cmp	GBASH
	bne	horiz_loop

	;========================================
	; vertical loop
	;========================================

	; A should already be $44 here
	; Y should be 0
	; X is position in pattern

	; to be honest I don't remember how this works

vert_loop:
	txa

	clc
	adc	#2		; $44 + 2?		= $46
	asl			;			= $8E
	asl			; shift left?		= $1C + carry
	adc	HGR_PAGE	; what?			= $5D
	sbc	GBASH		; huh	- $44		= $19

	cmp	#8		; WHAT IS GOING ON HERE?
	lda	#$81
	bcs	noeor
	ora	#$02
noeor:

	sta	(GBASL),Y	; store it out

	inc	GBASL		; skip two columns
	inc	GBASL
	bne	noflo
	inc	GBASH
noflo:
	lda	HGR_END2
	cmp	GBASH
	bne	vert_loop

	stx	TEMPX

	inc	FRAME
	lda	FRAME
	and	#$10
	beq	no_boxes

	;====================
	; draw box masks


	ldx     #11
draw_loop:
        jsr     draw_box
        dex
        bpl     draw_loop

	;=====================
	; done drawing boxes

no_boxes:


	ldx	TEMPX

	inx			; wrap at 7
	cpx	#7
	beq	reset_x

	bne	switch_pages	; bra

even_lookup:
.byte	$D7,$DD,$F5, $D5,$D5,$D5,$D5
odd_lookup:
.byte	$AA,$AA,$AA, $AB,$AE,$BA,$EA


box_x1:
        .byte     0,  0,  3,  5, 11, 13, 13, 18, 16, 26, 31, 37
box_y1:
        .byte   169,  0,  0,105,  0, 24, 88,105,137, 88,105, 88
box_x2:
        .byte    40,  3, 11, 11, 40, 40, 16, 26, 24, 29, 37, 40
box_y2:
        .byte   192,169, 88,152, 24, 88,169,120,152,170,170,170

	;==========================
	; draw box
	;==========================
	; which to draw in X
	;	X preserved?

draw_box:
	lda	box_y1,X                ; 3
draw_box_outer:
	sta	TEMPY                   ; 2
	tay                             ; 1
	lda	hposn_low,Y             ; 3
	sta	GBASL                   ; 2
	lda	hposn_high,Y            ; 3
	clc
	adc	HGR_PAGE		; 2
	sta	GBASH                   ; 2
	ldy	box_x1,X                ; 3
draw_box_inner:
;	tya                             ; 1
;	lsr                             ; 1
;	lda	box_color_odd,X         ; 3
;	bcc	draw_color_odd          ; 2     ; we might have these flipped
;draw_color_even:
;	lda	box_color_even,X        ; 3
;draw_color_odd:

	lda	#$80			;	always color black1 here

	sta	(GBASL),Y               ; 2
	iny                             ; 1
	tya                             ; 1
	cmp	box_x2,X                ; 3
	bne	draw_box_inner          ; 2

	inc	TEMPY                   ; 2
	lda	TEMPY                   ; 2
	cmp	box_y2,X                ; 3
	bne	draw_box_outer          ; 2

	rts                             ; 1
