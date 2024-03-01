div7_table	= $6800
mod7_table	= $6900
hposn_high	= $6a00
hposn_low	= $6b00


hgr_make_tables:

	;=====================
	; make /7 %7 tables
	;=====================

hgr_make_7_tables:

	lda	#0		; load lots of zeros
	tax
	tay
div7_loop:
	sta	div7_table,Y
mod7_smc:
	stx	mod7_table

	inx
	cpx	#7
	bne	div7_not7

	clc
	adc	#1
	ldx	#0
div7_not7:
	inc	mod7_smc+1	; assume starts on page boundary
	iny
	bne	div7_loop


;	ldy	#0
;	lda	#0
;mod7_loop:
;	sta	mod7_table,Y
;	clc
;	adc	#1
;	cmp	#7
;	bne	mod7_not7
;	lda	#0
;mod7_not7:
;	iny
;	bne	mod7_loop


	; Hposn table

; hposn_low, hposn_high will each be filled with $C0 bytes
; based on routine by John Brooks
; posted on comp.sys.apple2 on 2018-07-11
; https://groups.google.com/d/msg/comp.sys.apple2/v2HOfHOmeNQ/zD76fJg_BAAJ
; clobbers A,X
; preserves Y

; vmw note: version I was using based on applesoft HPOSN was ~64 bytes
;	this one is 37 bytes

build_hposn_tables:
	ldx	#0
btmi:
	txa
	and	#$F8
	bpl	btpl1
	ora	#5
btpl1:
	asl
	bpl	btpl2
	ora	#5
btpl2:
	asl
	asl
	sta	hposn_low, X
	txa
	and	#7
	rol
	asl	hposn_low, X
	rol
;	ora	#$20
	sta	hposn_high, X
	inx
	cpx	#$C0
	bne	btmi

; go 16 beyond, which allows our text scrolling routine

;	ldx	#16
;extra_table_loop:
;	lda	hposn_low,X
;	sta	hposn_low+192,X
;	lda	hposn_high,X
;	eor	#$60
;	sta	hposn_high+192,X
;	dex
;	bpl	extra_table_loop

	rts
