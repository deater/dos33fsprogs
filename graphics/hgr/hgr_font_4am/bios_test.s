; Fake BIOS screen
;  for another project

.include "zp.inc"
.include "hardware.inc"


bios_test:
	;===================
	; set graphics mode
	;===================
	jsr	HOME

	bit	HIRES
	bit	FULLGR
	bit	SET_GR
	bit	PAGE1

	jsr	build_tables

	;===================
	; Load graphics
	;===================

	lda	#<graphics_data
	sta	ZX0_src
	lda	#>graphics_data
	sta	ZX0_src+1

	lda	#$20			; temporarily load to $2000

	jsr	full_decomp

	; test 1

	lda	#<test1
	ldy	#>test1

	ldx	#1
	stx	CV

	ldx	#0

	; test 2

	lda	#<test2
	ldy	#>test2

	ldx	#3
	stx	CV

	ldx	#0

	; test 3

	lda	#<test3
	ldy	#>test3

	ldx	#5
	stx	CV

	ldx	#0

	jsr	DrawCondensedString

	; test 4

	lda	#<test4
	ldy	#>test4

	ldx	#7
	stx	CV
	ldx	#0

	jsr	DrawCondensedString

	; test 5

	lda	#<test5
	ldy	#>test5

	ldx	#9
	stx	CV
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

	.include "font_4am_condensed.s"
	.include "font_4am_condensed_data.s"

	.include "zx02_optim.s"

graphics_data:
	.incbin "graphics/a2_energy.hgr.zx02"

hposn_low	= $1713	; 0xC0 bytes (lifetime, used by DrawLargeCharacter)
hposn_high	= $1800	; 0xC0 bytes (lifetime, used by DrawLargeCharacter)

	.include "hgr_table.s"


