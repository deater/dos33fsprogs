.include "zp.inc"


HGR_SHAPE	EQU	$1A
HGR_SHAPEH	EQU	$1B
HGR_BITS	EQU	$1C
HGR_COUNT	EQU	$1D
HGR_DX		EQU	$D0
HGR_DY		EQU	$D2
HGR_QUADRANT	EQU	$D3
HGR_E		EQU	$D4
HGR_EH		EQU	$D5
HGR_X		EQU	$E0
HGR_Y		EQU	$E2
HGR_COLOR	EQU	$E4
HGR_HORIZ	EQU	$E5
HGR_PAGE	EQU	$E6
HGR_SCALE	EQU	$E7
HGR_COLLISIONS	EQU	$EA
HGR_ROTATION	EQU	$F9

HCLR		EQU	$F3F2
HPOSN		EQU	$F411
HPLOT0		EQU	$F457
HGLIN		EQU	$F53A
XDRAW1		EQU	$F661
COLORTBL	EQU	$F6F6

	;==========================
	; Setup Graphics
	;==========================

	bit	SET_GR			; graphics mode
	bit	HIRES			; hires mode
        bit	TEXTGR			; mixed text/graphics
        bit	PAGE0			; first graphics page
	jsr	HOME

	lda	#$20
	sta	HGR_PAGE

	jsr	HCLR



;	lda	#0
;	sta	HGR_ROTATION
;	lda	#1
;	sta	HGR_SCALE


;	jsr	hgr_clear

;	lda	#<chell_right
;	sta	HGR_SHAPE
;	lda	#>chell_right
;	sta	HGR_SHAPE+1

	; HFNS	puts X-coord in Y,X, Y-coord in A
	; HPOSN sets up GBASL/GBASH

;	ldy	#0
;	lda	#100
;	tax
;	jsr	HPOSN

;	lda	HGR_ROTATION		; rotation

;	jsr	XDRAW1


	; HCOLOR=3
	ldx	#3
	lda	COLORTBL,X		; get color pattern from table
	sta	HGR_COLOR

	; HPLOT 100,100 to 150,150
	; X= (y,x), Y=a
	ldy	#0
	lda	#100
	ldx	#100
	jsr	HPLOT0

	; X=(x,a), y=Y
	lda	#150
	ldx	#0
	ldy	#150
	jsr	HGLIN



infinite_loop:
	jmp	infinite_loop


;.include "../asm_routines/hgr_offsets.s"
;.include "../asm_routines/hgr_putsprite.s"
.include "../asm_routines/hgr_slowclear.s"


; Shape Table
.include "objects_shape.inc"

; Graphics Background
.incbin	"GLADOS.HGR"
