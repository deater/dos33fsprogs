; Kansasfest HackFest Entry

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

	; GR part
	bit	LORES
	bit	SET_GR
	bit	FULLGR

	lda     #$55
	ldx	#39
border_loop:
	sta	$5d0,X		; 38

	dex
	bpl	border_loop


loop_forever:
	jmp	loop_forever


;	H		E		L		L	O
.byte	$D1,$00,$D1,$00, $D1,$01,$00, $D1,$00,$00, $D1,$00,$00, $D0,$01,$D0,$00
.byte	$24,$04,$24,$00, $24,$20,$00, $24,$20,$00, $24,$20,$00, $04,$20,$04,$00
.byte	$C9,$C0,$C9,$00, $C9,$C0,$00, $C9,$00,$00, $C9,$00,$00, $C9,$00,$C0,$00
.byte	$06,$00,$06,$00, $06,$00,$00, $06,$00,$00, $06,$00,$00, $06,$00,$06,$00
