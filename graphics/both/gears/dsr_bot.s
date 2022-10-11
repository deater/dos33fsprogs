; dsr rotate lores

; by deater (Vince Weaver) <vince@deater.net>

; 147 bytes -- original attempt
; 145 bytes -- hires address tables in zero page
; 143 bytes -- optimize table init some more
; 138 bytes -- swap X and Y in lores code
; 136 bytes -- remove unnecessary compare
; 135 bytes -- realize with shift, hclr is unneccesary
; 134 bytes -- optimize Y usage in inner loop
; 132 bytes -- don't need to init rotate?
; 135 bytes -- bot jump

; Zero Page
GBASL           = $26
GBASH           = $27
COLOR		= $30

HGR_X           = $E0
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_HORIZ       = $E5
HGR_PAGE        = $E6
HGR_SCALE	= $E7
ROTATION	= $FA
COUNT		= $FC
YY		= $FD
BB		= $FE
XX		= $FF

; Soft Switches

SET_GR          =       $C050
SET_TEXT        =       $C051
FULLGR          =       $C052
TEXTGR          =       $C053

PAGE1   = $C054 ; Page1
PAGE2   = $C055 ; Page2
LORES	= $C056   ; Enable LORES graphics
HIRES	= $C057   ; Enable HIRES graphics


; ROM routines

HGR     = $F3E2
HGR2    = $F3D8
HCLR    = $F3F2
HPLOT0  = $F457		; plot at (Y,X), (A)
WAIT    = $FCA8		; delay 1/2(26+27A+5A^2) us
HPOSN	= $F411		; (Y,X),(A)  (valued stores in HGRX,XH,Y)
PLOT    = $F800                 ;; PLOT AT Y,A
SETCOL  = $F864                 ;; COLOR=A
XDRAW0          =       $F65D


hgr_lookup_h    =       $40		; $40-$70
hgr_lookup_l    =       $70		; $70-$A0

;hgr_lookup_h    =       $1000
;hgr_lookup_l    =       $1100


dsr_rotate:

	;===================
	; init screen

	jsr	HGR			; clear PAGE1
					; A,Y are 0?
	bit	FULLGR

	;===================
	; init vars

;	sta	ROTATION		; start at 0
					; not needed if don't care start?

	ldx	#4
	stx	HGR_SCALE

	;===================
        ; int tables

	ldx	#47
init_loop:
        txa
        jsr	HPOSN			; important part is A=ycoord
	ldx	HGR_Y			; A value stored in HGR_Y
	lda	GBASL
	sta     hgr_lookup_l,X
	lda	GBASH
	sta	hgr_lookup_h,X
	dex
	bpl	init_loop


	bit	LORES


big_loop:

;=====================================
; draw dsr
draw_dsr:

	ldy	#0		; Y 0 here from HCLR
	ldx	#15
	lda	#20
	jsr     HPOSN           ; set screen position to X= (y,x) Y=(a)
                                ; saves X,Y,A to zero page
                                ; after Y= orig X/7
                                ; A and X are ??

	ldx	#<shape_dsr	; point to bottom byte of shape address
	ldy	#>shape_dsr	; point to top byte of shape address

        ; ROT in A
        lda     ROTATION	; ROT=0
        jsr	XDRAW0		; XDRAW 1 AT X,Y
                                ; Both A and X are 0 at exit
                                ; Z flag set on exit

;===============================
; copy to lores
; X654 3210 X654 3210



	ldy	#47
	sty	YY			; set y-coord to 47
lsier_outer:
	ldx	YY			; a bit of a wash
	lda	hgr_lookup_l,X
	sta	hgr_scrn_smc+1
	lda	hgr_lookup_h,X
	sta	hgr_scrn_smc+2

	ldx	#0
	ldy	#0			; COUNT

lsier_inner:

	lda	#6
	sta	BB

lsier_inner_inner:

hgr_scrn_smc:
	lsr	$2000,X			; note this also clears screen
	lda	#0
	bcs	no_color

	lda	YY			; get Y-coord into A
no_color:
	jsr	SETCOL

	lda	YY			; y-coord in A
					; x-coord already in Y

	jsr	PLOT			; plot at Y,A

	iny				; increment count
	cpy	#40			; if hit 40, done
	beq	done_line

	dec	BB			; decrement byte count
	bpl	lsier_inner_inner	; if <7 then keep shifting

	inx				; increment hires-x value
	bne	lsier_inner		; bra

done_line:
	dec	YY			; decrement y-coord
	bpl	lsier_outer		; until less than 0

end:
	inc	ROTATION
	inc	ROTATION
	jmp	big_loop

shape_dsr:
.byte   $2d,$36,$ff,$3f
.byte   $24,$ad,$22,$24,$94,$21,$2c,$4d
.byte   $91,$3f,$36,$00



	; $3F5 - 130 = $373
for_bot:
	jmp	dsr_rotate
