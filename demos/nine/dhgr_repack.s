; take an unpacked dhgr graphic and repack it to DRAW_PAGE
; split in two so that we can do it with only an 8k buffer

	;=====================================
	;=====================================
	; repack raw graphic
	;=====================================
	;=====================================
	; starts loading from page in A

; repack_src = $a000
; REPACK_TEMP = $D0	; $D0..$D7
; also uses OUTL

dhgr_repack_top:

	ldx	#0
	stx	CURRENT_ROW

	ldx	#96
	bne	dhgr_repack_common		; bra

dhgr_repack_bottom:
	ldx	#96
	stx	CURRENT_ROW
	ldx	#192

dhgr_repack_common:
	stx	repack_end_smc+1


set_source:
	; set source

	sta	load_loop_smc+2
	lda	#0
	sta	load_loop_smc+1

	; load 7 bytes (2 colors each), convert to the 8 bytes DHGR expects



new_row:
	ldx	CURRENT_ROW
	lda	hposn_low,X
	sta	OUTL
	lda	hposn_high,X
	clc
	adc	DRAW_PAGE
	sta	OUTH

	ldx	#0
	stx	CURRENT_COL

next_col:

	;===========================
	; load next 14 colors

	ldx	#7
load_loop:

load_loop_smc:
	lda	repack_src,X
	sta	REPACK_TMP,X
	dex
	bpl	load_loop

	lda	load_loop_smc+1
	clc
	adc	#7
	sta	load_loop_smc+1
	bcc	noflo
	lda	load_loop_smc+2
	adc	#0
	sta	load_loop_smc+2
noflo:

	; $F0 already has AUX0

	lda	REPACK_TMP		; $F0
	rol
	rol	REPACK_TMP+1		; $F1
	rol	REPACK_TMP+2		; $F2
	rol	REPACK_TMP+3		; $F3
	rol	REPACK_TMP+4		; $F4
	rol	REPACK_TMP+5		; $F5
	rol	REPACK_TMP+6		; $F6
	rol	REPACK_TMP+7		; $F7

	; F1 now has MAIN0

	lda	REPACK_TMP+1
	rol
	rol	REPACK_TMP+2
	rol	REPACK_TMP+3
	rol	REPACK_TMP+4
	rol	REPACK_TMP+5
	rol	REPACK_TMP+6
	rol	REPACK_TMP+7

	; F2 now has AUX1

	lda	REPACK_TMP+2
	rol
	rol	REPACK_TMP+3
	rol	REPACK_TMP+4
	rol	REPACK_TMP+5
	rol	REPACK_TMP+6
	rol	REPACK_TMP+7

	; F3 now has MAIN1

	lda	REPACK_TMP+3
	rol
	rol	REPACK_TMP+4
	rol	REPACK_TMP+5
	rol	REPACK_TMP+6
	rol	REPACK_TMP+7

	; F4 now has AUX2

	lda	REPACK_TMP+4
	rol
	rol	REPACK_TMP+5
	rol	REPACK_TMP+6
	rol	REPACK_TMP+7

	; F5 now has MAIN2

	lda	REPACK_TMP+5
	rol
	rol	REPACK_TMP+6
	rol	REPACK_TMP+7

	; F6 now has AUX3

	lda	REPACK_TMP+6
	rol
	rol	REPACK_TMP+7

	; F7 now has MAIN3

	;=======================
	; write out AUX

	sta	$C005	; write AUX

	ldy	#0

	lda	REPACK_TMP
	sta	(OUTL),Y
	iny
	lda	REPACK_TMP+2
	sta	(OUTL),Y
	iny
	lda	REPACK_TMP+4
	sta	(OUTL),Y
	iny
	lda	REPACK_TMP+6
	sta	(OUTL),Y

	;========================
        ; write out MAIN
	sta	$C004	; write MAIN

	ldy	#0

	lda	REPACK_TMP+1
	sta	(OUTL),Y
	iny

	lda	REPACK_TMP+3
	sta	(OUTL),Y
	iny

	lda	REPACK_TMP+5
	sta	(OUTL),Y
	iny

	lda	REPACK_TMP+7
	sta	(OUTL),Y

	clc
	lda	#4
	adc	OUTL
	sta	OUTL

	inc	CURRENT_COL
	ldx	CURRENT_COL
	cpx	#10
	beq	done_col

	jmp	next_col
done_col:

	inc	CURRENT_ROW
	ldx	CURRENT_ROW
repack_end_smc:
	cpx	#96
	beq	done_pack
	jmp	new_row

done_pack:

	rts



; NNNNMMMM LLLLKKKK JJJJIIII HHHHGGGG FFFFEEEE DDDDCCCC BBBBAAAA --- save/rol7
; NNNMMMML LLLKKKKJ JJJIIIIH HHHGGGGF FFFEEEED DDDCCCCB -- save/rol6
; NNMMMMLL LLKKKKJJ JJIIIIHH HHGGGGFF FFEEEEDD -- save/rol5
; NMMMMLLL LKKKKJJJ JIIIIHHH HGGGGFFF --- save/rol4
; MMMMLLLL KKKKJJJJ IIIIHHHH --- save/rol3





