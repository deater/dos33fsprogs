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
	pha
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
	pla
	clc
	adc	#$40
	sta	pil_smc5+2	; lda
	sta	pil_smc7+2	; sta
	sta	pil_smc8+2	; sta
	sta	pil_smc9+2	; sta

	; setup the low address bytes in the SMC

	; $2000
	lda	hposn_low,X
	sta	pil_smc1+1
	sta	pil_smc2+1
	sta	pil_smc12+1
	sta	pil_smc22+1
	sta	pil_smc6+1
	sta	pil_smc5+1
	sta	pil_smc8+1

	; $2000+1
	clc
	adc	#1
	sta	pil_smc3+1
	sta	pil_smc13+1
	sta	pil_smc23+1
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

pan_inner_loop:

	; X from previous loop

	lda	left_lookup_main,X	; lookup next			; 4+

pil_smc3:
	ldx	$2000+1,Y		; odd col			; 4+
	ora	left_lookup_next,X					; 4+

pil_smc2:
	sta	$2000,Y			; update			; 5

	iny								; 2

	;===================================
	; loop2

;pan_inner_loop:

	; X from previous loop

	lda	left_lookup_main,X	; lookup next			; 4+

pil_smc13:
	ldx	$2000+1,Y		; odd col			; 4+
	ora	left_lookup_next,X					; 4+

pil_smc12:
	sta	$2000,Y			; update			; 5

	iny								; 2

	;===================================
	; loop3

;pan_inner_loop:

	; X from previous loop

	lda	left_lookup_main,X	; lookup next			; 4+

pil_smc23:
	ldx	$2000+1,Y		; odd col			; 4+
	ora	left_lookup_next,X					; 4+

pil_smc22:
	sta	$2000,Y			; update			; 5

	iny								; 2
	cpy	#39							; 2
	bne	pan_inner_loop						; 2/3

	;==================================
	; leftover
	;==================================

	; X has $2000,39
	lda	left_lookup_main,X			; 4+

pil_smc5:
	ldx	$6000					; 4+
	ora	left_lookup_next,X			; 4+

pil_smc6:
	sta	$2000,Y					; 5

	;=================
	; shift font
		; X has $6000
	lda	left_lookup_main,X			; 4+

pil_smc7:
	ldx	$6000+1					; 4+
	ora	left_lookup_next,X			; 4+

pil_smc8:
	sta	$6000					; 5

	lda	left_lookup_main,X			; 4+
pil_smc9:
	sta	$6000+1					; 5


	;   $2038  $2039   $4000    $4001
	;0 DCCBBAA GGFFEED KJJIIHH  NNMMLLK
	;1 EDDCCBB HHGGFFE LKKJJII  ~~NNMML
	;2 FEEDDCC IIHHGGF MLLKKJJ  ~~~~NNM
	;3 GFFEEDD JJIIHHG NMMLLKK  ~~~~~~N
	;4 HGGFFEE KKJJIIH ~NNMMLL  ~~~~~~~
	;5 IHHGGFF LLKKJJI ~~~NNMM  ~~~~~~~
	;6 JIIHHGG MMLLKKJ ~~~~~NN  ~~~~~~~
	;7 KJJIIHH NNMMLLK ~~~~~~~  ~~~~~~~
	;8                 RQQPPOO  UUTTSSR

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

	; wrap subscroll counter
	; TODO: use mod 7 table here
	inc	SCROLL_SUBSCROLL
	lda	SCROLL_SUBSCROLL
	cmp	#7
	bne	no_ticker

next_letter:
	lda	#0
	sta	SCROLL_SUBSCROLL

	jsr	draw_font_char


no_ticker:

	jsr	wait_vblank
	jsr	hgr_page_flip

	lda	SCROLL_OFFSET
	cmp	#164
	beq	done_pan

	jmp	pan_outer_outer_loop

done_pan:
	bit	KEYRESET

	rts

.include "scroll_tables.s"




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
	sta	$62D0
	lda	large_font_row0+1,X
	sta	$62D1

	; row2
	lda	large_font_row1,X
	sta	$66D0
	lda	large_font_row1+1,X
	sta	$66D1

	; row3
	lda	large_font_row2,X
	sta	$6AD0
	lda	large_font_row2+1,X
	sta	$6AD1

	; row4
	lda	large_font_row3,X
	sta	$6ED0
	lda	large_font_row3+1,X
	sta	$6ED1

	; row5
	lda	large_font_row4,X
	sta	$72D0
	lda	large_font_row4+1,X
	sta	$72D1

	; row6
	lda	large_font_row5,X
	sta	$76D0
	lda	large_font_row5+1,X
	sta	$76D1

	; row7
	lda	large_font_row6,X
	sta	$7AD0
	lda	large_font_row6+1,X
	sta	$7AD1

	; row8
	lda	large_font_row7,X
	sta	$7ED0
	lda	large_font_row7+1,X
	sta	$7ED1

	; row9
	lda	large_font_row8,X
	sta	$6350
	lda	large_font_row8+1,X
	sta	$6351

	; row10
	lda	large_font_row9,X
	sta	$6750
	lda	large_font_row9+1,X
	sta	$6751

	; row11
	lda	large_font_row10,X
	sta	$6B50
	lda	large_font_row10+1,X
	sta	$6B51

	; row12
	lda	large_font_row11,X
	sta	$6F50
	lda	large_font_row11+1,X
	sta	$6F51

	; row13
	lda	large_font_row12,X
	sta	$7350
	lda	large_font_row12+1,X
	sta	$7351

	; row14
	lda	large_font_row13,X
	sta	$7750
	lda	large_font_row13+1,X
	sta	$7751

	; row15
	lda	large_font_row14,X
	sta	$7B50
	lda	large_font_row14+1,X
	sta	$7B51

	; row16
	lda	large_font_row15,X
	sta	$7F50
	lda	large_font_row15+1,X
	sta	$7F51

	inc	SCROLL_OFFSET		; point to next char

	rts

scroll_text:
	      ;0123456789012345678901234567890123456789
;	.byte "@@@@@@@@@@@@@@@@@@@@"
	.byte "@\]^_@I@HAVE@FOUND@A@W"
	.byte "AY@TO@GET@YOU@HOME[@YOU@MUST@TRAVEL@TO@R"
	.byte "IVENQ@FREE@THE@PEOPLEQ@SAVE@MY@WIFEQ@AND"
	.byte "@TRAP@MY@DAD[@OH@ALSO@RIVEN@IS@IMPLODING"
	.byte "[@@@@@@@@@@@@@@@@@@@@"
;	.byte "[@SIGNAL@ME@WHEN@YOU@ARE@DONE[@@@@@@@@@@"
;	.byte "@@@@@@@@@@@@@@"
