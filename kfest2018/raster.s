; Kansasfest HackFest Entry

; Zero Page
DRAW_PAGE	= $EE

; Soft Switches

SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
LORES	= $C056	; Enable LORES graphics


; ROM routines

TEXT	= $FB36				;; Set text mode
HOME	= $FC58				;; Clear the text screen



	;===================
	; init screen

	jsr	TEXT
	jsr	HOME

	lda	#0
	sta	DRAW_PAGE

	; GR part
	bit	LORES
	bit	SET_GR
	bit	FULLGR

	; Clear Page0

	lda	#$00
	ldy	#46
clear_page0_loop:
	jsr	hline
	dey
	dey
	bpl	clear_page0_loop

	; Clear Page1




	lda	#$55
	ldy	#38
	jsr	hline




loop_forever:
	jmp	loop_forever


	;==================================
	; HLINE
	;==================================

	; Color in A
	; X has which line
hline:
	ldx	gr_offsets,y					; 4+
	stx	hline_loop+1					; 4
	ldx	gr_offsets+1,y					; 4+
	stx	hline_loop+2					; 4
	ldx	#39						; 2
hline_loop:
	sta	$5d0,X		; 38				; 5
	dex							; 2
	bpl	hline_loop					; 2nt/3
	rts							; 6




;	H		E		L		L	O
.byte	$D1,$00,$D1,$00, $D1,$01,$00, $D1,$00,$00, $D1,$00,$00, $D0,$01,$D0,$00
.byte	$24,$04,$24,$00, $24,$20,$00, $24,$20,$00, $24,$20,$00, $04,$20,$04,$00
.byte	$C9,$C0,$C9,$00, $C9,$C0,$00, $C9,$00,$00, $C9,$00,$00, $C9,$00,$C0,$00
.byte	$06,$00,$06,$00, $06,$00,$00, $06,$00,$00, $06,$00,$00, $06,$00,$06,$00
	; move these to zero page for slight speed increase?

gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0
