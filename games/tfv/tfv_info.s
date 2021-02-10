	;===========================
	; print inventory and stats
	;===========================
print_info:

	lda	#$a0
	jsr	clear_top_a

	bit	SET_TEXT

	jsr	normal_text

	; inverse space
	lda	#$20
	sta	COLOR


	; Draw boxes

	; HLIN Y, V2 AT A

	; hlin_double(0,0,39,0);
	ldy	#39
	sty	V2
	ldy	#0
	lda	#0
	jsr	hlin_double


	; hlin_double(0,0,39,4);
	ldy	#39
	sty	V2
	ldy	#0
	lda	#4
	jsr	hlin_double

	; hlin_double(0,0,39,8);
	ldy	#39
	sty	V2
	ldy	#0
	lda	#8
	jsr	hlin_double

	; hlin_double(0,0,39,46);
	ldy	#39
	sty	V2
	ldy	#0
	lda	#46
	jsr	hlin_double

	; X, V2 at Y

	; basic_vlin(0,47,0);
	ldy	#0
	ldx	#47
	stx	V2
	ldx	#0
	jsr	vlin

	; basic_vlin(0,47,20);
	ldy	#20
	ldx	#47
	stx	V2
	ldx	#0
	jsr	vlin

	; basic_vlin(0,47,39);
	ldy	#39
	ldx	#47
	stx	V2
	ldx	#0
	jsr	vlin

	jsr	normal_text
	lda	#<info_name_string
	sta	OUTL
	lda	#>info_name_string
	sta	OUTH

	jsr	move_and_print	; print name
	jsr	move_and_print	; print level
	jsr	move_and_print	; print inventory
	jsr	move_and_print	; print stats
	jsr	move_and_print	; print hp
	jsr	move_and_print	; print mp
	jsr	move_and_print	; print exp
	jsr	move_and_print	; print next
	jsr	move_and_print	; print money
	jsr	move_and_print	; print time

	;==================
	; print inventory
	;==================

	ldy	#10	; start at 5 (*2)

	;============
	; print item1

	lda	#$1
	sta	MASK
	ldx	#0
item1_loop:
	clc
	lda	gr_offsets,Y
	adc	#3	; indent
	sta	BASL

	lda	gr_offsets+1,Y
	adc	DRAW_PAGE
	sta	BASH

	lda	MASK
	and	HERO_INVENTORY1
	beq	item1_not_there

	lda	item1_name_addr,X
	sta	OUTL
	lda	item1_name_addr+1,X
	sta	OUTH

	sty	TEMPY
	jsr	print_string
	ldy	TEMPY

	iny
	iny

item1_not_there:

	asl	MASK
	inx
	inx
	cpx	#16
	bne	item1_loop

	;============
	; print item2


	lda	#$1
	sta	MASK
	ldx	#0
item2_loop:
	clc
	lda	gr_offsets,Y
	adc	#3	; indent
	sta	BASL

	lda	gr_offsets+1,Y
	adc	DRAW_PAGE
	sta	BASH

	lda	MASK
	and	HERO_INVENTORY2
	beq	item2_not_there

	lda	item2_name_addr,X
	sta	OUTL
	lda	item2_name_addr+1,X
	sta	OUTH

	sty	TEMPY
	jsr	print_string
	ldy	TEMPY

	iny
	iny

item2_not_there:

	asl	MASK
	inx
	inx
	cpx	#16
	bne	item2_loop

	;============
	; print item3

	lda	#$1
	sta	MASK
	ldx	#0
item3_loop:
	clc
	lda	gr_offsets,Y
	adc	#3	; indent
	sta	BASL

	lda	gr_offsets+1,Y
	adc	DRAW_PAGE
	sta	BASH

	lda	MASK
	and	HERO_INVENTORY3
	beq	item3_not_there

	lda	item3_name_addr,X
	sta	OUTL
	lda	item3_name_addr+1,X
	sta	OUTH

	sty	TEMPY
	jsr	print_string
	ldy	TEMPY

	iny
	iny

item3_not_there:

	asl	MASK
	inx
	inx
	cpx	#4
	bne	item3_loop


	;=====================
	; done printing info


	jsr	page_flip

	jsr	wait_until_keypressed

	bit     SET_GR                  ; set graphics

	jsr	clear_bottoms

	rts






;          1         2         3         4
;01234567890123456789012345678901234567890
;****************************************  1
;* DEATER            * LEVEL 1          *  2
;****************************************  3
;* INVENTORY         * STATS            *  4
;****************************************  5
;*		    * HP:      50/100  *  6
;*		    * MP:         0/0  *  7
;*                  *                  *  8
;*		    * EXPERIENCE:   0  *  9
;*		    * NEXT LEVEL:  16  * 10
;*                  *                  * 11
;*		    * MONEY: $1        * 12   0-256
;*		    * TIME: 00:00      * 13
;*		    *		       * 14
;*		    *		       * 15
;*		    *		       * 16
;*		    *		       * 17
;*		    *		       * 18
;*		    *		       * 19
;*		    *		       * 20
;*		    *		       * 21
;*		    *		       * 22
;*		    *	               * 23
;**************************************** 24

;EXPERIENCE = 0...255
;LEVEL = EXPERIENCE /  = 0...63
;NEXT LEVEL =
;MONEY   = 0...255
;MAX_HP  = 32+EXPERIENCE (maxing at 255)


info_name_string:
.byte	 2,1,"DEATER  ",0

info_level_string:
.byte	22,1,"LEVEL  1",0

info_inventory_string:
.byte	 2,3,"INVENTORY:",0

info_stats_string:
.byte	22,3,"STATS",0

info_hp_string:
.byte	23,5,"HP:   123 / 456",0

info_mp_string:
.byte	23,6,"MP:    55 /  99",0

info_exp_string:
.byte	22,8,"EXPERIENCE:  123",0

info_nextlev_string:
.byte	22,9,"NEXT LEVEL:  123",0

info_money_string:
.byte	22,11,"MONEY: $123",0

info_time_string:
.byte	22,13,"TIME: 00:00",0

item1_name_addr:
	.word	item1_cupcake
	.word	item1_carrot
	.word	item1_smartpass
	.word	item1_elf_runes
	.word	item1_lizbeth_star
	.word	item1_karte_spiel
	.word	item1_glamdring
	.word	item1_vegemite

item1_names:
	item1_cupcake:		.byte	"CUPCAKE",0
	item1_carrot:		.byte	"CARROT",0
	item1_smartpass:	.byte	"METRO SMARTPASS",0
	item1_elf_runes:	.byte	"ELF RUNES",0
	item1_lizbeth_star:	.byte	"STAR OF LIZBETH",0
	item1_karte_spiel:	.byte	"KARTE SPIEL",0
	item1_glamdring:	.byte	"GLAMDRING",0
	item1_vegemite:		.byte	"VEGEMITE",0

item2_name_addr:
	.word	item2_blue_led
	.word	item2_red_led
	.word	item2_1k_resistor
	.word	item2_4p7k_resistor
	.word	item2_9v_battery
	.word	item2_1p5v_battery
	.word	item2_linux_cd
	.word	item2_army_knife

item2_names:
	item2_blue_led:		.byte	"BLUE LED",0
	item2_red_led:		.byte	"RED LED",0
	item2_1k_resistor:	.byte	"1K RESISTOR",0
	item2_4p7k_resistor:	.byte	"4.7K RESISTOR",0
	item2_9v_battery:	.byte	"9V BATTERY",0
	item2_1p5v_battery:	.byte	"1.5V BATTERY",0
	item2_linux_cd:		.byte	"LINUX CD",0
	item2_army_knife:	.byte	"SWISS ARMY KNIFE",0

item3_name_addr:
	.word	item3_chex_mix
	.word	item3_class_ring
	.word	item3_missing
	.word	item3_missing
	.word	item3_missing
	.word	item3_missing
	.word	item3_missing
	.word	item3_missing

item3_names:
	item3_chex_mix:		.byte	"CHEX MIX",0
	item3_class_ring:	.byte	"CLASS RING",0	; from golf course?
	item3_missing:		.byte	"MISSING",0


