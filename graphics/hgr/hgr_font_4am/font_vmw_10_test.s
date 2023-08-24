; test 4am x10 fonts but with our calling convention

.include "zp.inc"
.include "hardware.inc"


vmw_10_test:
	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	jsr	HGR

	jsr	build_tables


	; test 1

	lda	#<test1
	ldy	#>test1
	jsr	DrawCondensedString

	; test 2

	lda	#<test2
	ldy	#>test2
	jsr	DrawCondensedString

	; test 3

	lda	#<test3
	ldy	#>test3
	jsr	DrawCondensedString

	; test 4

	lda	#<test4
	ldy	#>test4
	jsr	DrawCondensedString

	; test 5

	lda	#<test5
	ldy	#>test5
	jsr	DrawCondensedString



end:
	jmp	end


test1:
	;         0123456789012345678901234567890123456789
	.byte 0,10,"PACK MY BOX WITH FIVE DOZEN LIQUOR JUGS!",0
test2:
	.byte 0,30,"pack my box with five dozen liquor jugs?",0
test3:
	.byte 9,50,"This is a HGR font test.",0
test4:
	.byte 0,100,"0123456789)(*&^%$#@!`~<>,./';:[]{}\|_+=",0
test5:
	.byte 0,120,"@/\/\/\/\______ |",0

	.include "font_vmw_condensed.s"
	.include "font_vmw_condensed_data.s"


hposn_low	= $1713	; 0xC0 bytes (lifetime, used by DrawLargeCharacter)
hposn_high	= $1800	; 0xC0 bytes (lifetime, used by DrawLargeCharacter)

	.include "hgr_table.s"


