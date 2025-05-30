	;============================
	; do the pan

do_scroll:

pan_loop:

	lda	#0
	sta	SCROLL_SUBSCROLL
	sta	SCROLL_OFFSET

	; set up first char
	jsr	draw_font_char

pan_outer_outer_loop:

					; 168->184
	ldx	#183			; work backwards, 184->168
pan_outer_loop:

	; setup the high bytes in the SMC

	; $2000					; 0010 -> 0100 0011 -> 0101
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	pil_smc2+2	; lda
	sta	pil_smc12+2	; lda
	sta	pil_smc22+2	; lda
	sta	pil_smc6+2	; lda
	eor	#$60
	sta	pil_smc1+2	; sta
	sta	pil_smc3+2	; sta
	sta	pil_smc13+2	; sta
	sta	pil_smc23+2	; sta


	; $6000

	; this is always $60 when compact
	; in theory don't even need to self modify

;	lda	#$60

;	sta	pil_smc5+2	; lda
;	sta	pil_smc7+2	; sta
;	sta	pil_smc8+2	; sta
;	sta	pil_smc9+2	; sta

	; setup the low address bytes in the SMC

	; $2000
	lda	hposn_low,X
	sta	pil_smc1+1
	sta	pil_smc2+1
	sta	pil_smc12+1
	sta	pil_smc22+1
	sta	pil_smc6+1

	; $2000+1
	clc
	adc	#1
	sta	pil_smc3+1
	sta	pil_smc13+1
	sta	pil_smc23+1

	; $6000 even
;	pha
;	txa
	lda	compact_even-168,X
	sta	pil_smc5+1
	sta	pil_smc8+1
;	pla

	; $6000+1
	lda	compact_odd-168,X
	sta	pil_smc7+1
	sta	pil_smc9+1

	stx	XSAVE

	; inner loop

	; original: 6+(30*39)-1 = 1175
	; new	    6+(24*39)-1 = 941
	; unroll by 3	6+((19+19+19+5)*13)-1 = 811

	ldy	#0			; start col0			; 2
pil_smc1:
	ldx	$2000,Y			; even col			; 4+

	;===================================
	; loop1

; palette bit never changes
; ideally we'd bump it along when we scroll

; FF -> 9F
; 1111 1111  -> 1001 1111	00 20 40 60 00 20 40 60
; 7F -> 1F
; 0111 111   -> 0001 1111

; copy over high bit when do next copy

pan_inner_loop:

	; X from previous loop
llm1_smc:
	lda	left_lookup_keep_main,X	; lookup next			; 4+

pil_smc3:
	ldx	$2000+1,Y		; odd col			; 4+
lln1_smc:
	ora	left_lookup_keep_next,X					; 4+

pil_smc2:
	sta	$2000,Y			; update			; 5

	iny								; 2

	;===================================
	; loop2

;pan_inner_loop:

	; X from previous loop

llm2_smc:
	lda	left_lookup_keep_main,X	; lookup next			; 4+

pil_smc13:
	ldx	$2000+1,Y		; odd col			; 4+
lln2_smc:
	ora	left_lookup_keep_next,X					; 4+

pil_smc12:
	sta	$2000,Y			; update			; 5

	iny								; 2

	;===================================
	; loop3

;pan_inner_loop:

	; X from previous loop

llm3_smc:
	lda	left_lookup_keep_main,X	; lookup next			; 4+

pil_smc23:
	ldx	$2000+1,Y		; odd col			; 4+
lln3_smc:
	ora	left_lookup_keep_next,X					; 4+

pil_smc22:
	sta	$2000,Y			; update			; 5

	iny								; 2
	cpy	#39							; 2
	bne	pan_inner_loop						; 2/3

	;==================================
	; leftover
	;==================================

	; X has $2000,39
llm4_smc:
	lda	left_lookup_keep_main,X			; 4+

pil_smc5:
	ldx	$6000					; 4+
lln4_smc:
	ora	left_lookup_keep_next,X			; 4+

pil_smc6:
	sta	$2000,Y					; 5

	;=================
	; shift font
		; X has $6000
llm5_smc:
	lda	left_lookup_keep_main,X			; 4+

pil_smc7:
	ldx	$6000+1					; 4+
lln5_smc:
	ora	left_lookup_keep_next,X			; 4+

pil_smc8:
	sta	$6000					; 5

llm6_smc:
	lda	left_lookup_keep_main,X			; 4+
pil_smc9:
	sta	$6000+1					; 5


	;   $2038    $2039    $4000    $4001
	;0 XDCCBBAA XGGFFEED XKJJIIHH  XNNMMLLK
	;1 XEDDCCBB XHHGGFFE XLKKJJII  X~~NNMML
	;2 XFEEDDCC XIIHHGGF XMLLKKJJ  X~~~~NNM
	;3 XGFFEEDD XJJIIHHG XNMMLLKK  X~~~~~~N
	;4 XHGGFFEE XKKJJIIH X~NNMMLL  X~~~~~~~
	;5 XIHHGGFF XLLKKJJI X~~~NNMM  X~~~~~~~
	;6 XJIIHHGG XMMLLKKJ X~~~~~NN  X~~~~~~~
	;7 XKJJIIHH XNNMMLLK X~~~~~~~  X~~~~~~~
	;8                    RQQPPOO  UUTTSSR

	; every 7 clicks need to copy over two more columns

	ldx	XSAVE

	dex
	cpx	#167				; check to see if done
						; copying rows
	beq	done_pan_outer_loop
	jmp	pan_outer_loop
done_pan_outer_loop:

	lda	KEYPRESS			; if keypress early exit
	bmi	done_pan

	lda	SCROLL_SUBSCROLL
	cmp	#6
	beq	yes_pal_shift
	cmp	#2
	beq	yes_pal_shift

no_pal_shift:
	ldx	#>left_lookup_keep_main
	ldy	#>left_lookup_keep_next
	jmp	pal_shift
yes_pal_shift:
	ldx	#>left_lookup_swap_main
	ldy	#>left_lookup_swap_next

pal_shift:
	stx	llm1_smc+2
	stx	llm2_smc+2
	stx	llm3_smc+2
	stx	llm4_smc+2
	stx	llm5_smc+2
	stx	llm6_smc+2

	sty	lln1_smc+2
	sty	lln2_smc+2
	sty	lln3_smc+2
	sty	lln4_smc+2
	sty	lln5_smc+2

	; wrap subscroll counter
	; TODO: use mod 7 table here
	inc	SCROLL_SUBSCROLL
	lda	SCROLL_SUBSCROLL
	cmp	#7
	bne	no_ticker


	;=================================
	; did 7 shifts, time for new letter
	; also copy over palette bits?
next_letter:
	lda	#0
	sta	SCROLL_SUBSCROLL

	jsr	draw_font_char


no_ticker:

	jsr	wait_vblank
	jsr	hgr_page_flip

	lda	SCROLL_OFFSET
	cmp	#142
	beq	done_pan

	jmp	pan_outer_outer_loop

done_pan:
	bit	KEYRESET

	lda	#0
	sta	SCROLL_OFFSET

	rts






draw_font_char:


;do_scroll:
;	lda	#0
;	sta	SCROLL_START
;	sta	SCROLL_ODD


do_scroll_loop:
	ldx	SCROLL_OFFSET	; load offset into string
	lda	scroll_text,X	; get the character
	sec
	sbc	#'@'		; convert from ASCII
	asl
	tax

draw_text_page3:
	; row1
	lda	large_font_row0,X
	sta	$6000
	lda	large_font_row0+1,X
	sta	$6001

	; row2
	lda	large_font_row1,X
	sta	$6002
	lda	large_font_row1+1,X
	sta	$6003

	; row3
	lda	large_font_row2,X
	sta	$6004
	lda	large_font_row2+1,X
	sta	$6005

	; row4
	lda	large_font_row3,X
	sta	$6006
	lda	large_font_row3+1,X
	sta	$6007

	; row5
	lda	large_font_row4,X
	sta	$6008
	lda	large_font_row4+1,X
	sta	$6009

	; row6
	lda	large_font_row5,X
	sta	$600A
	lda	large_font_row5+1,X
	sta	$600B

	; row7
	lda	large_font_row6,X
	sta	$600C
	lda	large_font_row6+1,X
	sta	$600D

	; row8
	lda	large_font_row7,X
	sta	$600E
	lda	large_font_row7+1,X
	sta	$600F

	; row9
	lda	large_font_row8,X
	sta	$6010
	lda	large_font_row8+1,X
	sta	$6011

	; row10
	lda	large_font_row9,X
	sta	$6012
	lda	large_font_row9+1,X
	sta	$6013

	; row11
	lda	large_font_row10,X
	sta	$6014
	lda	large_font_row10+1,X
	sta	$6015

	; row12
	lda	large_font_row11,X
	sta	$6016
	lda	large_font_row11+1,X
	sta	$6017

	; row13
	lda	large_font_row12,X
	sta	$6018
	lda	large_font_row12+1,X
	sta	$6019

	; row14
	lda	large_font_row13,X
	sta	$601A
	lda	large_font_row13+1,X
	sta	$601B

	; row15
	lda	large_font_row14,X
	sta	$601c
	lda	large_font_row14+1,X
	sta	$601d

	; row16
	lda	large_font_row15,X
	sta	$601E
	lda	large_font_row15+1,X
	sta	$601F

	inc	SCROLL_OFFSET		; point to next char

	rts

scroll_text:
; ]^_
; note _ is space with pal bit set
; \ is christmas tree
; ]^ is a lobster
	      ;0123456789012345678901234567890123456789
	.byte "@\@\@MERRY@CHRISTMAS@FROM@MAINE@]^_"
	.byte "@]^_@FROM@THE@GUINEA@PIG@GANG@"		; 63
	.byte "]^_@\@]^_@\@BEST@WISHES@FOR@A@GREAT@WINTER@\@\@" ; 111
	.byte "]^_@\@]^_@@@@@@@@@@@@@@@@@@@@"		; 140




; offscreen text draw

;	original		compact
; 1	62D0,62D1		6000,6001
; 2	66D0,66D1		6002,6003
; 3	6AD0,6AD1		6004,6005
; 4	6AE0,6AE1		6006,6007
; 5	72D0,72D1		6008,6009
; 6	76D0,76D1		600A,600B
; 7	7AD0,7AD1		600C,600D

compact_even:
	.byte $00,$02,$04,$06,$08,$0A,$0c,$0e
	.byte $10,$12,$14,$16,$18,$1A,$1c,$1e

compact_odd:
	.byte $01,$03,$05,$07,$09,$0B,$0D,$0F
	.byte $11,$13,$15,$17,$19,$1B,$1D,$1F



.align	$100
.include "scroll_tables.s"
