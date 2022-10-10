; Parallax Sierpinski/xor boxes HGR

; by deater (Vince Weaver) <vince@deater.net>


; Zero Page
GBASL           = $26
GBASH           = $27

HGR_X           = $E0
HGR_Y           = $E2
HGR_COLOR       = $E4
HGR_HORIZ       = $E5
HGR_PAGE        = $E6
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


hgr_lookup_h    =       $1000
hgr_lookup_l    =       $1100
div4_lookup	=	$90

parallax:

	;===================
	; init screen

	jsr	HGR			; clear PAGE1
	bit	FULLGR

	;===================
        ; int tables

        ldx     #191
init_loop:
        txa
        pha
        jsr     HPOSN
        pla
        tax
        lda     GBASL
        sta     hgr_lookup_l,X
        lda     GBASH
;	and	#$1F				; 20 30    001X 40 50  010X
        sta     hgr_lookup_h,X

	dex
	cpx	#$ff
	bne	init_loop

draw_sier:

	ldx	#47
sier_outer:
	lda	hgr_lookup_l,X
	sta	GBASL
	lda	hgr_lookup_h,X
	sta	GBASH

	stx	XX
	ldy	#39
sier_inner:

	tya
	and	XX
	beq	not_zero

	lda	#00
	beq	zero
not_zero:
	lda	#$7f
zero:
	sta	(GBASL),Y

	dey
	bpl	sier_inner

	dex
	cpx	#$ff
	bne	sier_outer

;===============================
; copy to lores

	bit	LORES


	ldx	#47
lsier_outer:
	lda	hgr_lookup_l,X
	sta	hgr_scrn_smc+1
	lda	hgr_lookup_h,X
	sta	hgr_scrn_smc+2

	stx	XX
	ldy	#39
lsier_inner:

hgr_scrn_smc:
	lda	$2000,Y
	jsr	SETCOL		; color is A

	tya
	pha

	txa

	jsr	PLOT		; plot at Y,A

	pla
	tay

	dey
	bpl	lsier_inner

	dex
	cpx	#$ff
	bne	lsier_outer



end:
	jmp	end
