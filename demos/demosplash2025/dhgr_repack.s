; take an unpacked dhgr graphic and repack it to DRAW_PAGE
; split in two so that we can do it with only an 8k buffer

	;=====================================
	;=====================================
	; repack raw graphic
	;=====================================
	;=====================================
	; starts loading from page in A

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
	lda	$A000,X
	sta	$F0,X
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

	lda	$F0
	rol
	rol	$F1
	rol	$F2
	rol	$F3
	rol	$F4
	rol	$F5
	rol	$F6
	rol	$F7

	; F1 now has MAIN0

	lda	$F1
	rol
	rol	$F2
	rol	$F3
	rol	$F4
	rol	$F5
	rol	$F6
	rol	$F7

	; F2 now has AUX1

	lda	$F2
	rol
	rol	$F3
	rol	$F4
	rol	$F5
	rol	$F6
	rol	$F7

	; F3 now has MAIN1

	lda	$F3
	rol
	rol	$F4
	rol	$F5
	rol	$F6
	rol	$F7

	; F4 now has AUX2

	lda	$F4
	rol
	rol	$F5
	rol	$F6
	rol	$F7

	; F5 now has MAIN2

	lda	$F5
	rol
	rol	$F6
	rol	$F7

	; F6 now has AUX3

	lda	$F6
	rol
	rol	$F7

	; F7 now has MAIN3

	;=======================
	; write out AUX

	sta	$C005	; write AUX

	ldy	#0

	lda	$F0
	sta	(OUTL),Y
	iny
	lda	$F2
	sta	(OUTL),Y
	iny
	lda	$F4
	sta	(OUTL),Y
	iny
	lda	$F6
	sta	(OUTL),Y

	;========================
        ; write out MAIN
	sta	$C004	; write MAIN

	ldy	#0

	lda	$F1
	sta	(OUTL),Y
	iny

	lda	$F3
	sta	(OUTL),Y
	iny

	lda	$F5
	sta	(OUTL),Y
	iny

	lda	$F7
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





