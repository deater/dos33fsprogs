; Kansasfest HackFest Entry

; Zero Page
DRAW_PAGE	= $EE
CURRENT_OFFSET	= $EF
OFFSET_GOVERNOR = $F0

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
	sta	OFFSET_GOVERNOR

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
	lda	#$44
	jsr	clear_gr

	; draw border line

	lda	#$55
	ldy	#38
	jsr	hline


	;==================
	; Draw Temp Rasters
	;==================
	lda	#$0
	sta	DRAW_PAGE
	lda	#$b1
	ldy	#10
	jsr	hline
	lda	#$3f
	ldy	#12
	jsr	hline

	lda	#$4
	sta	DRAW_PAGE
	lda	#$f3
	ldy	#10
	jsr	hline
	lda	#$1b
	ldy	#12
	jsr	hline




	; temporarily draw HELLO

	ldy	CURRENT_OFFSET
	ldx	#0
data_loop2:
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
	bne	data_loop2




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
        ; so we want roughly 10 lines * 4 = 40*65 = 2600+4550-65
	; +4550 - 65 (for the scanline we missed) = 7085 - 12 = 7073


	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4


        ; want 7073
	; Try X=26 Y=52 cycles=7073

        lda     #0                                                      ; 2
        lda     #0                                                      ; 2

        ldy     #52                                                     ; 2
loopA:
        ldx     #26                                                     ; 2
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


	; 2 + 48*(  (4+2+25*(2+3)) + (4+2+23*(2+3)+4+5)) + 9)
	;     48*[(6+125)-1] + [(6+115+10)-1]

display_loop:

	ldy	#48						; 2

outer_loop:

	bit	PAGE0						; 4
	ldx	#25		; 130 cycles with PAGE0		; 2
page0_loop:			; delay 126+bit
	dex							; 2
	bne	page0_loop					; 2/3


	bit	PAGE1						; 4
	ldx	#23		; 130 cycles with PAGE1		; 2
page1_loop:			; delay 115+(7 loop)+4 (bit)+4(extra)
	dex							; 2
	bne	page1_loop					; 2/3

	nop							; 2
	lda	DRAW_PAGE					; 3

	dey							; 2
	bne	outer_loop					; 2/3



	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================

	; delay 2717 (4550 +1 from falltrough, -2 for loadup, -1832 for scroll)

	; Try X=8 Y=59 cycles=2715

	; waste 2 cycles
	;lda	DRAW_PAGE						; 3
	;lda	DRAW_PAGE						; 3
	nop								; 2

	ldy	#59							; 2
loop5:
	ldx	#8							; 2
loop6:
	dex								; 2
	bne	loop6							; 2nt/3

	dey								; 2
	bne	loop5							; 2nt/3



;	jmp	display_loop					; 3


	;================================
	; SCROLL THE TEXT
	;================================
	; 5+ 40*(36 + 9)+5+3 -1 + 20
	; 12+40*(45) + 19 = 1832

	ldy	CURRENT_OFFSET				; 3
	ldx	#0					; 2
data_loop:
	lda	words,Y					; 4+
	sta	$6d0,X					; 5

	lda	words2,Y				; 4+
	sta	$750,X					; 5

	lda	words3,Y				; 4+
	sta	$ad0,X					; 5

	lda	words4,Y				; 4+
	sta	$b50,X					; 5

	iny						; 2
	inx						; 2
	cpx	#40					; 2
	bne	data_loop				; 2nt/3

	inc	OFFSET_GOVERNOR				; 5

	lda	OFFSET_GOVERNOR				; 3
	cmp	#6					; 2
	bne	not_yet					; 2

	inc	CURRENT_OFFSET				; 5
	lda	#0					; 2
	sta	OFFSET_GOVERNOR				; 3
	jmp	all_done				; 3
not_yet:
							; 1
	lda	OFFSET_GOVERNOR				; 3
	lda	OFFSET_GOVERNOR				; 3
	lda	OFFSET_GOVERNOR				; 3
	lda	OFFSET_GOVERNOR				; 3

all_done:



	jmp	display_loop				; 3


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
.byte	$D1,$00,$D1,$00, $D1,$01,$00, $D1,$00,$00, $D1,$00,$00, $D0,$01,$D0,$00, $00, $00
;       K                F            E            S	        T
.byte	$D1,$00,$D1,$00, $D1,$01,$00, $D1,$01,$00, $D1,$D1,$00, $01,$D1,$01,$00
;       1             8               .   .   .
.byte	$00,$D1,$00, $D0,$01,$D0,$00, $00,$00,$00, $00,$00,$00, $00,$00,$00, $00,$00
;	H                A                V                E
.byte	$D1,$00,$D1,$00, $D0,$01,$D0,$00, $D1,$00,$D1,$00, $D1,$01,$00, $00,$00
;	Y                O                U
.byte	$D1,$00,$D1,$00, $D0,$01,$D0,$00, $D1,$00,$D1,$00, $00,$00
;       E            V                E            R
.byte	$D1,$01,$00, $D1,$00,$D1,$00, $D1,$01,$00, $D1,$01,$D1,$00, $00,$00
;       S            E            E            N
.byte	$D1,$D1,$00, $D1,$01,$00, $D1,$01,$00, $D1,$00,$D0,$D1,$00, $00,$00
;       4                0                x
.byte	$D1,$00,$D1,$00, $D0,$01,$D0,$00, $D0,$00,$D0,$00
;       9                6
.byte	$D1,$01,$D1,$00, $D1,$01,$01,$00, $00,$00
;       L            O                R                E            S
.byte	$D1,$00,$00, $D0,$01,$D0,$00, $D1,$01,$D1,$00, $D1,$01,$00, $D1,$D1,$00
; Apple
.byte	$00,$00,$C0,$C0,$CC,$C0,$00,$00
; VMW Logo
.byte	$0,$0,$11,$11,$11,$11,$11,$44, $22,$22,$22,$22,$22,$44, $22,$22,$22,$22,$22,$00
; Apple
.byte	$0,$0,$00,$C0,$C0,$CC,$C0,$0


.repeat 64
.byte $0
.endrep
words2:
.byte	$24,$04,$24,$00, $24,$20,$00, $24,$20,$00, $24,$20,$00, $04,$20,$04,$00, $00,$00
.byte	$24,$04,$20,$00, $24,$00,$00, $24,$20,$00, $20,$24,$00, $00,$24,$00,$00
.byte	$00,$24,$00, $04,$20,$04,$00, $20,$20,$00, $20,$20,$00, $20,$20,$00, $00,$00
.byte	$24,$04,$24,$00, $24,$00,$24,$00, $04,$20,$04,$00, $24,$20,$00, $00,$00
.byte	$00,$24,$00,$00, $04,$20,$04,$00, $24,$20,$24,$00, $00,$00
.byte	$24,$20,$00, $04,$20,$04,$00, $24,$20,$00, $24,$04,$20,$00, $00,$00
.byte	$20,$24,$00, $24,$20,$00, $24,$20,$00, $24,$00,$00,$24,$00, $00,$00
.byte	$00,$00,$24,$00, $04,$20,$04,$00, $00,$04,$00,$00
.byte	$00,$00,$24,$00, $24,$20,$24,$00, $00,$00
.byte	$24,$20,$00, $04,$20,$04,$00, $24,$04,$20,$00, $24,$20,$00, $20,$24,$00
.byte	$00,$29,$29,$29,$29,$20,$00,$00
.byte	$0,$0,$00,$01,$11,$41,$44,$44, $44,$42,$22,$42,$44,$44, $44,$42,$22,$02,$00,$00
.byte	$0,$0,$29,$29,$29,$29,$20,$0

.repeat 64
.byte $0
.endrep
words3:
.byte	$C9,$C0,$C9,$00, $C9,$C0,$00, $C9,$00,$00, $C9,$00,$00, $C9,$00,$C9,$00, $00,$00
.byte	$C9,$C0,$09,$00, $C9,$C0,$00, $C9,$C0,$00, $C9,$C0,$00, $00,$C9,$00,$00
.byte	$09,$C9,$00, $09,$C0,$09,$00, $00,$00,$00, $00,$00,$00, $00,$00,$00, $00,$00
.byte	$C9,$C0,$C9,$00, $C9,$C0,$C9,$00, $C9,$00,$C9,$00, $C9,$C0,$00, $00,$00
.byte	$09,$C0,$09,$00, $c9,$00,$c9,$00, $C9,$00,$C9,$00, $00,$00
.byte	$C9,$C0,$00, $C9,$00,$C9,$00, $C9,$C0,$00, $C9,$C0,$C9,$00, $00,$00
.byte	$C9,$C0,$00, $C9,$C0,$00, $C9,$C0,$00, $C9,$09,$00,$C9,$00, $00,$00
.byte	$C9,$C0,$C9,$00, $C9,$00,$C9,$00, $00,$C0,$00,$00
.byte	$C9,$C0,$C9,$00, $C9,$C0,$C0,$00, $00,$00
.byte	$C9,$00,$00, $C9,$00,$C9,$00, $C9,$C0,$C9,$00, $C9,$C0,$00, $C9,$C0,$00
.byte	$00,$D0,$D0,$DC,$D0,$00,$00,$00
.byte	$0,$0,$01,$11,$11,$11,$41,$44, $42,$22,$22,$22,$42,$44, $42,$22,$22,$22,$02,$00
.byte	$0,$0,$D0,$D0,$DC,$D0,$00,$0

.repeat 64
.byte $0
.endrep
words4:
.byte	$06,$00,$06,$00, $06,$00,$00, $06,$00,$00, $06,$00,$00, $06,$00,$06,$00, $00,$00
.byte	$06,$00,$06,$00, $06,$00,$00, $06,$00,$00, $00,$06,$00, $00,$06,$00,$00
.byte	$00,$06,$00, $06,$00,$06,$00, $06,$06,$00, $06,$06,$00, $06,$06,$00, $00,$00
.byte	$06,$00,$06,$00, $06,$00,$06,$00, $00,$06,$00,$00, $06,$00,$00, $00,$00
.byte	$00,$06,$00,$00, $06,$00,$06,$00, $06,$00,$06,$00, $00,$00
.byte	$06,$00,$00, $00,$06,$00,$00, $06,$00,$00, $06,$00,$06,$00, $00,$00
.byte	$00,$06,$00, $06,$00,$00, $06,$00,$00, $06,$00,$00,$06,$00, $00,$00
.byte	$00,$00,$06,$00, $06,$00,$06,$00, $06,$00,$06,$00
.byte	$00,$00,$06,$00, $06,$00,$06,$00, $00,$00
.byte	$06,$00,$00, $06,$00,$06,$00, $06,$00,$06,$00, $06,$00,$00, $00,$04,$00
.byte	$00,$01,$61,$61,$61,$01,$00,$00
.byte	$0,$0,$00,$01,$11,$41,$44,$44, $44,$42,$22,$42,$44,$44, $44,$42,$22,$02,$00,$00
.byte	$0,$0,$01,$61,$61,$61,$01,$0

.repeat 64
.byte $0
.endrep


; ?


; Apple
;.byte	$0,$0,$00,$C0,$C0,$CC,$C0,$0
;.byte	$0,$0,$29,$29,$29,$29,$20,$0
;.byte	$0,$0,$D0,$D0,$DC,$D0,$00,$0
;.byte	$0,$0,$01,$61,$61,$61,$01,$0

; VMW Logo
;.byte	$0,$0,$11,$11,$11,$11,$11,$44, $22,$22,$22,$22,$22,$44, $22,$22,$22,$22,$22,$00
;.byte	$0,$0,$00,$01,$11,$41,$44,$44, $44,$42,$22,$42,$44,$44, $44,$42,$22,$02,$00,$00
;.byte	$0,$0,$01,$11,$11,$11,$41,$44, $42,$22,$22,$22,$42,$44, $42,$22,$22,$22,$02,$00
;.byte	$0,$0,$00,$01,$11,$41,$44,$44, $44,$42,$22,$42,$44,$44, $44,$42,$22,$02,$00,$00


gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0
