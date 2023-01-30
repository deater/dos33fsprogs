; letter test

; zero page locations
HGR_SHAPE	=	$1A
SEEDL		=	$4E
FRAME		=	$A4
OUR_ROT		=	$A5
RND_EXP		=	$C9
HGR_PAGE	=	$E6
HGR_SCALE	=	$E7
HGR_ROTATION	=	$F9
WHICH		=	$FB
SCALE		=	$FC
ROTATE		=	$FD
XPOS		=	$FE
YPOS		=	$FF

; Soft Switches
KEYPRESS	=	$C000
KEYRESET	=	$C010
SPEAKER		=	$C030
PAGE0           =       $C054
PAGE1           =       $C055

; ROM calls
RND		=	$EFAE

HGR2		=	$F3D8
HGR		=	$F3E2
HCLR		=	$F3F2
HCLR_COLOR	=	$F3F4
HPOSN		=	$F411
XDRAW0		=	$F65D
TEXT		=	$FB36	; Set text mode
WAIT		=	$FCA8	; delay 1/2(26+27A+5A^2) us


letter_test:

	;=========================================
	; SETUP
	;=========================================


	jsr	HGR
	jsr	HGR2			; set/clear HGR page2 to black
					; Hi-res graphics, no text at bottom
					; Y=0, A=$60 after this call

	lda	#5
	sta	HGR_SCALE

	lda	#0
	sta	ROTATE
	sta	WHICH

	;=========================
	; slide in
	;=========================

outer_slide_loop:
	lda	#255
	sta	XPOS
	lda	#100
	sta	YPOS

slide_loop:
	jsr	xdraw

	lda	#100
	jsr	WAIT
	jsr	xdraw

	dec	XPOS
	dec	XPOS

	lda	XPOS
	lsr
	and	#$f
	tax
	lda	rotate_pattern,X
	sta	ROTATE

	lda	XPOS
ends_smc:
	cmp	#65
	bcs	slide_loop

	jsr	xdraw

	inc	WHICH
	lda	WHICH
	tax
	lda	deater_ends,X
	sta	ends_smc+1
	lda	deater_offsets,X
	sta	xdraw_offset_smc+1
	bpl	outer_slide_loop

end:
	jmp	end


	;=======================
	; xdraw
	;=======================

xdraw:
	ldy	#0
	ldx	XPOS
	lda	YPOS
	jsr	HPOSN		; X= (y,x) Y=(a)



	clc
	lda	#<shape_table_d
xdraw_offset_smc:
	adc	#0
	tax
	ldy	#>shape_table_d

	lda	ROTATE

	jmp	XDRAW0

.if 0
	;=======================
	; flip page
	;=======================

flip_page:
	lda	HGR_PAGE
	eor	#$60
	sta	HGR_PAGE

	clc
	rol
	rol
	tax
	lda	PAGE1,X

	rts
.endif

;	ldy	#3		; 2
;init_loop:
;	tya			; 1
;	asl
;	asl
;	sta	rotate_pattern,Y; 3
;	dey			; 1
;	bne	init_loop	; 2

rotate_pattern:
	.byte 0,3,6,9, 9,6,3,0, 0,$FD,$FA,$F7, $F7,$FA,$FD, 0


deater_offsets:
	.byte 0		; D
	.byte 8		; E
	.byte 15	; A
	.byte 23	; T
	.byte 8		; E
	.byte 30	; R
	.byte $FF	; end

deater_ends:
	.byte	65,90,115,140,165,190

shape_table:

shape_table_d:
	.byte	$23,$2c,$2e,$36, $37,$27,$04,$00
shape_table_e:
	.byte	$27,$2c,$95,$12, $3f,$24,$00
shape_table_a:
	.byte	$23,$2c,$35,$96, $24,$3f,$36,$00
shape_table_t:
	.byte	$12,$24,$e4,$2b, $2d,$05,$00
shape_table_r:
	.byte	$97,$24,$24,$2d, $36,$37,$35,$06,$00
