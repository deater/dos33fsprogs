; same, but try to do it with only an 8k buffer
;	(instead of 13k/16k)


.include "zp.inc"
.include "hardware.inc"

hposn_low = $c00
hposn_high = $d00


	;=============================
	; Better DHGR image load
	;=============================
	; assumes ZX02 compressed "better" format
	;	which is not-interleaved and 2-colors-per-byte packed

better_dhgr:

	bit	KEYRESET	; just to be safe

	jsr	hgr_make_tables

	;=================================
	; init graphics
	;=================================

	; We are first to run, so init double-hires

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
	sta	AN3		; set double hires
	sta	EIGHTYCOLON	; 80 column
	sta	CLR80COL
;	sta	SET80COL	; (allow page1/2 flip main/aux)

	bit	PAGE1		; display page1
	lda	#$0
	sta	DRAW_PAGE	; draw to page1


	;===============================
	; load raw top graphic to $A000

	lda	#<monster1_top
	sta	zx_src_l+1
	lda	#>monster1_top
	sta	zx_src_h+1

	lda	#$A0			; load to MAIN DHGR PAGE0

	jsr	zx02_full_decomp

	lda	#$A0

	jsr	repack_top

	;===============================
	; load raw bottom graphic to $A000

	lda	#<monster1_bottom
	sta	zx_src_l+1
	lda	#>monster1_bottom
	sta	zx_src_h+1

	lda	#$A0			; load to MAIN DHGR PAGE0

	jsr	zx02_full_decomp

	lda	#$A0

	jsr	repack_bottom

stay_forever:
	jmp	stay_forever



	;=====================================
	;=====================================
	; repack raw graphic
	;=====================================
	;=====================================
	; starts loading from page in A
repack_top:

	ldx	#0
	stx	CURRENT_ROW

	ldx	#96
	bne	repack_common		; bra

repack_bottom:
	ldx	#96
	stx	CURRENT_ROW
	ldx	#192

repack_common:
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




.include "zx02_optim.s"
;.include "aux_memcopy.s"
.include "hgr_table.s"

monster1_top:
	.incbin "graphics/monster_pumpkin.raw_top.zx02"

monster1_bottom:
	.incbin "graphics/monster_pumpkin.raw_bottom.zx02"

