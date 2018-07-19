; Kansasfest HackFest Entry

; Zero Page
DRAW_PAGE	= $EE
CURRENT_OFFSET	= $EF

; Soft Switches

SET_GR	= $C050 ; Enable graphics
FULLGR	= $C052	; Full screen, no text
PAGE0	= $C054 ; Page0
PAGE1	= $C055 ; Page1
LORES	= $C056	; Enable LORES graphics


; ROM routines

TEXT	= $FB36				;; Set text mode
HOME	= $FC58				;; Clear the text screen
WAIT	= $FCA8				;; delay 1/2(26+27A+5A^2) us


	;===================
	; init screen

	jsr	TEXT
	jsr	HOME

	lda	#0
	sta	DRAW_PAGE
	sta	CURRENT_OFFSET

	; Clear Page0
	lda	#$00
	sta	DRAW_PAGE
	jsr	clear_gr

	; draw border line

	lda	#$55
	ldy	#38
	jsr	hline

	; Clear Page1
	lda	#$4
	sta	DRAW_PAGE
	lda	#$00
	jsr	clear_gr

	; draw border line

	lda	#$55
	ldy	#38
	jsr	hline

	;=====================================================
	; attempt vapor lock
	;  by reading the "floating bus" we can see most recently
	;  written value of the display
	; we look for $55 (which is the grey line)
	;=====================================================
	; See:
	;	Have an Apple Split by Bob Bishop
        ;	Softalk, October 1982

	; Challenges: each scan line scans 40 bytes.
	; The blanking happens at the *beginning*
	; So 65 bytes are scanned, starting at adress of the line - 25

	; the scan takes 8 cycles, look for 4 repeats of the value
	; to avoid false positive found if the horiz blanking is mirroring
	; the line (max 3 repeats in that case)

vapor_lock_loop:		; first make sure we have all zeroes
	LDA #$00
zxloop:
	LDX #$04
wiloop:
	CMP $C051
	BNE zxloop
	DEX
	BNE wiloop

	LDA #$55		; now look for four all grey
zloop:
	LDX #$04
qloop:
	CMP $C051
	BNE zloop
	DEX
	BNE qloop

	; found first line of low-res grey, need to kill time
        ; until we can enter at top of screen
        ; so we want roughly 5200+4550 - 65 (for the scanline we missed)


	; GR part
	bit	LORES
	bit	SET_GR
	bit	FULLGR


        ; want 9685
        ; Try X=34 Y=55 cycles=9681

        lda     #0                                                      ; 2
        lda     #0                                                      ; 2

        ldy     #55                                                     ; 2
loopA:
        ldx     #34                                                     ; 2
loopB:
        dex                                                             ; 2
        bne     loopB                                                   ; 2nt/3

        dey                                                             ; 2
        bne     loopA                                                   ; 2nt/3

        jmp     display_loop
.align  $100


	;================================================
	; Display Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; We want to alternate between page1 and page2 every 65 cycles
        ;       vblank = 4550 cycles to do scrolling

display_loop:

	ldy	#96						; 2

outer_loop:

	ldx	#25		; 130 cycles with PAGE0		; 2
page0_loop:
	dex							; 2
	bne	page0_loop					; 2/3
	bit	PAGE0						; 4

	ldx	#25		; 130 cycles with PAGE1		; 2
page1_loop:
	dex							; 2
	bne	page1_loop					; 2/3
	bit	PAGE1						; 4

	dey							; 2
	bne	outer_loop					; 2/3

	jmp	display_loop					; 3

	; We have 4550 cycles in the vblank, use them wisely


	ldy	CURRENT_OFFSET
	ldx	#0
data_loop:
	lda	words,Y
	sta	$6d0,X

	lda	words2,Y
	sta	$750,X

	lda	words3,Y
	sta	$ad0,X

	lda	words4,Y
	sta	$b50,X

	iny
	inx
	cpx	#40
	bne	data_loop

	inc	CURRENT_OFFSET

	lda	#128
	jsr	WAIT

	jmp	display_loop


	;==================================
	; HLINE
	;==================================

	; Color in A
	; Y has which line
hline:
	pha							; 3
	ldx	gr_offsets,y					; 4+
	stx	hline_loop+1					; 4
	lda	gr_offsets+1,y					; 4+
	clc							; 2
	adc	DRAW_PAGE					; 3
	sta	hline_loop+2					; 4
	pla							; 4
	ldx	#39						; 2
hline_loop:
	sta	$5d0,X		; 38				; 5
	dex							; 2
	bpl	hline_loop					; 2nt/3
	rts							; 6

	;==========================
	; Clear gr screen
	;==========================
	; Color in A
clear_gr:
	ldy	#46
clear_page_loop:
	jsr	hline
	dey
	dey
	bpl	clear_page_loop
	rts

.align  $100
words:
;	H		E		L		L	O
.byte	$D1,$00,$D1,$00, $D1,$01,$00, $D1,$00,$00, $D1,$00,$00, $D0,$01,$D0,$00
.repeat 239
.byte $0
.endrep
words2:
.byte	$24,$04,$24,$00, $24,$20,$00, $24,$20,$00, $24,$20,$00, $04,$20,$04,$00
.repeat 239
.byte $0
.endrep
words3:
.byte	$C9,$C0,$C9,$00, $C9,$C0,$00, $C9,$00,$00, $C9,$00,$00, $C9,$00,$C0,$00
.repeat 239
.byte $0
.endrep
words4:
.byte	$06,$00,$06,$00, $06,$00,$00, $06,$00,$00, $06,$00,$00, $06,$00,$06,$00
.repeat 239
.byte $0
.endrep


gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0
