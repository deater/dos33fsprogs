; test the 4am fonts

;  for another project

.include "zp.inc"
.include "hardware.inc"


font_test:
	;===================
	; set graphics mode
	;===================
	jsr	HOME

	jsr	HGR

;	bit	HIRES
;	bit	FULLGR
;	bit	SET_GR
;	bit	PAGE1



	jsr	build_tables

	; test 1

	lda	#<test1
	ldy	#>test1

	ldx	#1
	stx	VTAB

	ldx	#0

	jsr	DrawCondensedString

	; test 2

	lda	#<test2
	ldy	#>test2

	ldx	#3
	stx	VTAB

	ldx	#0

	jsr	DrawCondensedString

	; test 3

	lda	#<test3
	ldy	#>test3

	ldx	#5
	stx	VTAB

	ldx	#0

	jsr	DrawCondensedString

	; test 4

	lda	#<test4
	ldy	#>test4

	ldx	#7
	stx	VTAB
	ldx	#0

	jsr	DrawCondensedString

	; test 5

	lda	#<test5
	ldy	#>test5

	ldx	#9
	stx	VTAB
	ldx	#0

	jsr	DrawCondensedString



end:
	jmp	end


test1:
	;         0123456789012345678901234567890123456789
	.byte 39,"PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS!"
test2:
	.byte 39,"pack my box with five dozen liquor jugs?"
test3:
	.byte 24,"This is a HGR font test."
test4:
	.byte 38,"0123456789)(*&^%$#@!`~<>,./';:[]{}\|_+="
test5:
	.byte 17,"@/\/\/\/\______ |"

	.include "font_condensed.s"
	.include "font_condensed_data.s"


; .hgrlo, .hgr1hi will each be filled with $C0 bytes
; based on routine by John Brooks
; posted on comp.sys.apple2 on 2018-07-11
; https://groups.google.com/d/msg/comp.sys.apple2/v2HOfHOmeNQ/zD76fJg_BAAJ
; clobbers A,X
; preserves Y


build_tables:
         ldx   #0
btmi:
        txa
         and   #$F8
         bpl   btpl1
         ora   #5
btpl1:
         asl
         bpl   btpl2
         ora   #5
btpl2:
         asl
         asl
         sta   HGRLO, X
         txa
         and   #7
         rol
         asl   HGRLO, X
         rol
         ora   #$20
         sta   HGRHI, X
         inx
         cpx   #$C0
         bne   btmi

	rts

