.include "zp.inc"
.include "hardware.inc"
.include "qload.inc"

	;=====================
	; show inventory
	;=====================
show_inventory:

	lda	#0
	sta	INVENTORY_Y

	;=================
	; save bg

	lda	#20
	sta	BOX_Y1
	lda	#135
	sta	BOX_Y2

	jsr	hgr_partial_save


	;====================
	; draw text box
draw_inv_box:

	lda	#0
	sta	BOX_X1H
	lda	#14
	sta	BOX_X1L
	lda	#20
	sta	BOX_Y1

	lda	#1
	sta	BOX_X2H
	lda	#5		; ?
	sta	BOX_X2L
	lda	#135
	sta	BOX_Y2

	jsr	draw_box

	;===================
	; draw main text
draw_inv_text:
	lda	#<inventory_message
	sta	OUTL
	lda	#>inventory_message
	sta	OUTH

	jsr	disp_put_string


	lda	#<press_esc_message
	sta	OUTL
	lda	#>press_esc_message
	sta	OUTH

	jsr	disp_put_string


	;===============
	; draw text
	;===============

	lda	#28
	sta	CURSOR_Y

	ldy	#0			; row

inv_reset_mask:
	lda	#1			; start at low item
	sta	INVENTORY_MASK

draw_inv_loop:

	cpy	#9			; if <9, left column >=9, right
	bcs	right_column		; bge

left_column:
	lda	#4			; left column is #4
	bne	done_column		; bra
right_column:
	lda	#23			; right column is #23
done_column:
	sta	CURSOR_X

	tya
	pha				; save Y

	jsr	have_item_y		; check if have item

	beq	questionmarks

we_have_item:
	clc
	lda	item_offsets,Y
	adc	#<item_strings
	sta	OUTL
	lda	#0
	adc	#>item_strings

	jmp	print_item

questionmarks:
	lda	#<unknown_string
	sta	OUTL
	lda	#>unknown_string

print_item:
	sta	OUTH

	jsr	disp_one_line


	lda	CURSOR_Y	; incrememnt cursor location
	clc
	adc	#8

	cmp	#100
	bne	inv_cursory_good
	lda	#28
inv_cursory_good:
	sta	CURSOR_Y

	asl	INVENTORY_MASK

	pla

	tay
	iny

	tya
	and	#$7
	beq	inv_reset_mask

	cpy	#18
	bne	draw_inv_loop

	;=================
	; draw strikeouts
	;=================
draw_strikeouts:

	ldy	#0
draw_strikeouts_loop:

	tya
	pha

	jsr	lost_item_y

	pla
	tay

	bcs	draw_strikeouts_continue


	; actually strike it out
	tya
	pha

	lda	#$7f
	sta	overwrite_char_smc+1

	lda	invert_smc1+1
	eor	#$7f
	sta	invert_smc1+1

	jsr	overwrite_entry

	lda	invert_smc1+1
	eor	#$7f
	sta	invert_smc1+1

	lda	#$20
	sta	overwrite_char_smc+1

	pla
	tay

draw_strikeouts_continue:
	iny
	cpy	#18
	bne	draw_strikeouts_loop



	;=======================
	; draw initial highlight
	;=======================

	ldy	INVENTORY_Y
	jsr	overwrite_entry

	;===========================
	; handle inventory keypress
	;===========================

handle_inv_keypress:

	;================
	; draw item

	jsr	draw_inv_sprite

	lda	KEYPRESS
	bpl	handle_inv_keypress	; no keypress

	bit	KEYRESET		; clear keyboard strobe

	pha

	;=================
	; erase old

	ldy	INVENTORY_Y
	jsr	overwrite_entry

	pla

	and	#$5F			; clear top bit, make uppercase

	cmp	#27
	beq	urgh_done		; ESCAPE
	cmp	#$7f
	bne	inv_check_down		; DELETE

urgh_done:
	jmp	done_inv_keypress

inv_check_down:
	cmp	#$0A
	beq	inv_handle_down
	cmp	#'S'
	bne	inv_check_up
inv_handle_down:

	ldx	INVENTORY_Y
	cpx	#8
	beq	inv_down_wrap
	cpx	#17
	beq	inv_down_wrap

	inx

	jmp	inv_down_done
inv_down_wrap:
	txa
	sec
	sbc	#8
	tax

inv_down_done:
	stx	INVENTORY_Y
	jmp	inv_done_moving

inv_check_up:
	cmp	#$0B
	beq	inv_handle_up
	cmp	#'W'
	bne	inv_check_left_right
inv_handle_up:

	ldx	INVENTORY_Y
	beq	inv_up_wrap
	cpx	#9
	beq	inv_up_wrap

	dex
	jmp	inv_up_done

inv_up_wrap:
	txa
	clc
	adc	#8
	tax

inv_up_done:
	stx	INVENTORY_Y
	jmp	inv_done_moving


inv_check_left_right:
	cmp	#$15
	beq	inv_handle_left_right
	cmp	#'D'
	beq	inv_handle_left_right
	cmp	#$08
	beq	inv_handle_left_right
	cmp	#'A'
	bne	inv_check_return
inv_handle_left_right:
	lda	INVENTORY_Y
	clc
	adc	#9
	cmp	#18
	bcc	inv_lr_good
	sec
	sbc	#18

inv_lr_good:
	sta	INVENTORY_Y
	jmp	inv_done_moving

inv_check_return:
	jsr	have_item
	beq	inv_done_moving

	jsr	show_item
	jmp	draw_inv_box

inv_done_moving:

	;================
	; draw new
	ldy	INVENTORY_Y
	jsr	overwrite_entry

	;================
	; repeat

	jmp	handle_inv_keypress

done_inv_keypress:

	rts


	;==================
	; have_item
	;==================
	; do we have Inventory Y
	; ZERO if no
	; not zero if yes
have_item:
	ldy	INVENTORY_Y
have_item_y:
	tya				; move to A
	and	#$7			; mask off to bottom 2?
	tax
	lda	masks,X			; load in mask
	sta	INVENTORY_MASK

	tya

	lsr
	lsr
	lsr		; Y/8
	tax

	lda	INVENTORY_1,X
	and	INVENTORY_MASK

	rts


	;==================
	; lost_item
	;==================
	; do we no longer have Inventory Y
	; CC if no
	; CS if yes
lost_item:
	ldy	INVENTORY_Y
lost_item_y:
	tya
	and	#$7
	tax
	lda	masks,X
	sta	INVENTORY_MASK

	tya

	lsr
	lsr
	lsr		; Y/8
	tax

	lda	INVENTORY_1_GONE,X
	and	INVENTORY_MASK
	beq	really_gone

	clc
	rts

really_gone:
	sec
	rts



	;=======================
	; draw inventory sprite
	;=======================
draw_inv_sprite:

	jsr	have_item

	bne	do_draw_inv_sprite

no_draw_inv_sprite:
	lda	#<no_sprite
	sta	INL
	lda	#>no_sprite
	jmp	done_draw_inv_sprite

do_draw_inv_sprite:
	lda	inv_sprite_table_low,Y
	sta	INL
	lda	inv_sprite_table_high,Y
done_draw_inv_sprite:
	sta	INH

	lda	#18
	sta	CURSOR_X
	lda	#88
	sta	CURSOR_Y

	jsr	hgr_draw_sprite_2x16

	rts


	;====================
	;====================
	; show item
	;====================
	;====================
show_item:

	lda	#0
	sta	BOX_X1H
	lda	#14
	sta	BOX_X1L
	lda	#20
	sta	BOX_Y1

	lda	#1
	sta	BOX_X2H
	lda	#5		; ?
	sta	BOX_X2L
	lda	#135
	sta	BOX_Y2

	jsr	draw_box


	lda	#<item_message
	sta	OUTL
	lda	#>item_message
	sta	OUTH

	jsr	disp_put_string

	lda	#<press_esc_message
	sta	OUTL
	lda	#>press_esc_message
	sta	OUTH

	jsr	disp_put_string

	ldy	INVENTORY_Y

	lda	descriptions_low,Y
	sta	OUTL
	lda	descriptions_high,Y
	sta	OUTH

	lda	#4
	sta	CURSOR_X
	lda	#32
	sta	CURSOR_Y

	jsr	disp_put_string_cursor

	;==========================
	; print no longer message

	jsr	lost_item
	bcs	skip_no_longer

	lda	#<no_longer_message
	sta	OUTL
	lda	#>no_longer_message
	sta	OUTH
	jsr	disp_put_string

skip_no_longer:

	;=======================
	; display sprite

	jsr	draw_inv_sprite



handle_item_keypress:

	lda	KEYPRESS
	bpl	handle_item_keypress	; no keypress

	bit	KEYRESET		; clear keyboard strobe


	rts


;======================
; text
;======================
;
; Note, greyed out could maybe print ---- for strikethrough

; printed after description
no_longer_message:
.byte	4,86,"You no longer    has this item.",0

item_message:
.byte	5,106,"Hit RETURN to go back to list",0

; first is only printed if have in inventory, though still can
inventory_message:
.byte	6,106,"Press RETURN for description",0
press_esc_message:
.byte 	6,115,"Press ESC or DELETE to exit",0

;====================
; Inventory Strings
;====================

unknown_string:
.byte	"???",0

item_offsets:
.byte	(item_arrow-item_strings)
.byte	(item_baby-item_strings)
.byte	(item_kerrek_belt-item_strings)
.byte	(item_chicken_feed-item_strings)
.byte	(item_funbow-item_strings)
.byte	(item_monster_mask-item_strings)
.byte	(item_pebbles-item_strings)
.byte	(item_pills-item_strings)
.byte	(item_riches-item_strings)
.byte	(item_robe-item_strings)
.byte	(item_soda-item_strings)
.byte	(item_meatball_sub-item_strings)
.byte	(item_super_trinket-item_strings)
.byte	(item_troghelmet-item_strings)
.byte	(item_trogshield-item_strings)
.byte	(item_trogsword-item_strings)
.byte	(item_impossible-item_strings)
.byte	(item_shirt-item_strings)



item_string_lens:
.byte	5	; arrow
.byte	4	; baby
.byte	11	; kerrek belt
.byte	12	; chicken feed
.byte	18	; SuprTime FunBow TM
.byte	14	; monster maskus
.byte	7	; pebbles
.byte	5	; pills
.byte	6	; riches
.byte	4	; robe
.byte	4	; soda
.byte	12	; meatball sub
.byte	13	; super trinket
.byte	10	; TrogHelmet
.byte	10	; TrogShield
.byte	9	; TrogSword
.byte	3	; ???
.byte	5	; shirt

item_strings:

item_arrow:
.byte	"arrow",0
item_baby:
.byte	"baby",0
item_kerrek_belt:
.byte	"kerrek belt",0
item_chicken_feed:
.byte	"chicken feed",0
item_funbow:
.byte	"SuprTime FunBow TM",0	; should be Super, makes column too wide
item_monster_mask:
.byte	"monster maskus",0
item_pebbles:
.byte	"pebbles",0
item_pills:
.byte	"pills",0
item_riches:
.byte	"riches",0
item_robe:
.byte	"robe",0
item_soda:
.byte	"soda",0
item_meatball_sub:
.byte	"meatball sub",0
item_super_trinket:
.byte	"super trinket",0
item_troghelmet:
.byte	"TrogHelmet",0
item_trogshield:
.byte	"TrogShield",0
item_trogsword:
.byte	"TrogSword",0
item_impossible:
.byte	"???",0
item_shirt:
.byte	"shirt",0

descriptions_low:
	.byte <arrow_description
	.byte <baby_description
	.byte <kerrek_belt_description
	.byte <chicken_feed_description
	.byte <funbow_description
	.byte <monster_maskus_description
	.byte <pebbles_description
	.byte <pills_description
	.byte <riches_description
	.byte <robe_description
	.byte <soda_description
	.byte <meatball_sub_description
	.byte <super_trinket_description
	.byte <troghelmet_description
	.byte <trogshield_description
	.byte <trogsword_description
	.byte <map_description
	.byte <tshirt_description

descriptions_high:
	.byte >arrow_description
	.byte >baby_description
	.byte >kerrek_belt_description
	.byte >chicken_feed_description
	.byte >funbow_description
	.byte >monster_maskus_description
	.byte >pebbles_description
	.byte >pills_description
	.byte >riches_description
	.byte >robe_description
	.byte >soda_description
	.byte >meatball_sub_description
	.byte >super_trinket_description
	.byte >troghelmet_description
	.byte >trogshield_description
	.byte >trogsword_description
	.byte >map_description
	.byte >tshirt_description

.include "text/lookup.inc"
.include "text/inventory.inc.lookup"

.if 0

; arrow
arrow_description:
.byte "Boy, you sure know how to pick",13
.byte "em! This arrow's kinda pointy",13
.byte "even!!",0

; baby
baby_description:
.byte "Awww! Peasant babies are",13
.byte "adorable. No wonder they fetch",13
.byte "such a pretty penny on the black",13
.byte "market.",0

; kerrek belt
kerrek_belt_description:
.byte "Phew! This thing stinks like all",13
.byte "getout. Why couldn't the Kerrek",13
.byte "have kidnapped a hot wench or",13
.byte "something that you coulda saved?",0

; chicken feed
chicken_feed_description:
.byte "Woah! Gold nuggets! Oh",13
.byte "wait...This is just chicken",13
.byte "feed. Crap.",0

; SuperTime FunBow TM
funbow_description:
.byte "This is a pretty fancy bow.",13
.byte "You're suprised those shady",13
.byte "archers give away such decent",13
.byte "prizes. You half-expected gold",13
.byte "fish in a bag.",0

; monster maskus
monster_maskus_description:
.byte "Man, those pagans sure can make",13
.byte "a freaky lookin mask when they",13
.byte "want to. It's like those theatre",13
.byte "masks' evil uncle or something.",0

; pebbles
pebbles_description:
.byte "Woah! Gray chicken feed! Oh",13
.byte "wait... those are just pebbles.",13
.byte "Heavier than they look, though.",0

; pills
pills_description:
.byte "The innkeeper's medication says",13
.byte "it's supposed to treat ",34,"general",13
.byte "oldness.  May cause checkers",13
.byte "playing, hiked-up pants, and",13
.byte "overall pee smell.",34,0

; riches
riches_description:
.byte "Riches, dude. Riches. That",13
.byte "peasant lady totally has to",13
.byte "share some of this with you,",13
.byte "right? At least that shiny,",13
.byte "clawed sceptre thing.",0

; robe
robe_description:
.byte "A propa peasant robe. It smells",13
.byte "freshly washed and has the",13
.byte "initials 'N.N' sewn onto the",13
.byte "tag.",0

; soda
soda_description:
.byte "A full bottle of popular soda.",0

; meatball sub
meatball_sub_description:
.byte "A piping hot meatball sub fresh",13
.byte "from the bottom of a dingy old",13
.byte "well. All you need is a bag of",13
.byte "chips and you've got a combo",13
.byte "meal!",0

; super trinket
super_trinket_description:
.byte "This super trinket is weird. It",13
.byte "looks like it could either kill",13
.byte "you or make you the hit of your",13
.byte "Christmas party.",0

; TrogHelmet
troghelmet_description:
.byte "The TrogHelmet is not screwing",13
.byte "around. It's a serious helmet.",13
.byte "It also protects against",13
.byte "harmful UV rays.",0

; TrogShield
trogshield_description:
.byte "Behold the TrogSheild! No",13
.byte "seriously, behold it. There's",13
.byte "no way Trogdor's fire breath can",13
.byte "penetrate this thing.",0

; TrogSword
trogsword_description:
.byte "The TrogSword is for real.",13
.byte "Hands-down the coolest item in",13
.byte "this whole game. You can't wait",13
.byte "to lop off that beefy arm of",13
.byte "Trogdor's with this guy.",0

; ???
map_description:

; t-shirt
tshirt_description:
.byte "This has got to be your favorite",13
.byte "T-Shirt ever. Oh, the times you",13
.byte "had at Scalding Lake. Canoeing,",13
.byte "fishing, stoning heathens. What",13
.byte "a Blast!",0

.endif

	;========================
	; overwrite entry
	;========================
	; Y = which

overwrite_entry:

;	lda	#$7f
;	sta	invert_smc1+1

	lda	invert_smc1+1
	eor	#$7f
	sta	invert_smc1+1

overwrite_set_mask:

	;==============
	; set X

	cpy	#9
	bcs	overwrite_right_column		; bge

overwrite_left_column:
	lda	#4
	sta	CURSOR_X

	tya

	jmp	overwrite_done_column


overwrite_right_column:
	lda	#23
	sta	CURSOR_X

	tya
	sec
	sbc	#9


overwrite_done_column:
	asl
	asl
	asl
	clc
	adc	#28

	sta	CURSOR_Y

	tya

	;===================
	; check if have item

	jsr	have_item_y

	beq	overwrite_not_have

overwrite_have:
	ldx	item_string_lens,Y
	bne	overwrite_have_loop

overwrite_not_have:
	ldx	#3

overwrite_have_loop:
	txa
	pha
overwrite_char_smc:
	lda	#$20
	jsr	hgr_put_char_cursor
	inc	CURSOR_X
	pla
	tax
	dex
	bne	overwrite_have_loop


;	lda	#$00
;	sta	invert_smc1+1

	lda	invert_smc1+1
	eor	#$7f
	sta	invert_smc1+1

	rts


masks:
	.byte $01,$02,$04,$08, $10,$20,$40,$80

no_sprite:
	.byte $7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f
	.byte $7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f
	.byte $7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f
	.byte $7f,$7f,$7f,$7f,$7f,$7f,$7f,$7f

inv_sprite_table_low:
	.byte	<arrow_sprite
	.byte	<baby_sprite
	.byte	<kerrek_belt_sprite
	.byte	<chicken_feed_sprite
	.byte	<bow_sprite
	.byte	<mask_sprite
	.byte	<pebbles_sprite
	.byte	<pills_sprite
	.byte	<riches_sprite
	.byte	<robe_sprite
	.byte	<soda_sprite
	.byte	<sub_sprite
	.byte	<trinket_sprite
	.byte	<troghelm_sprite
	.byte	<trogshield_sprite
	.byte	<trogsword_sprite
	.byte	<no_sprite
	.byte	<tshirt_sprite

inv_sprite_table_high:
	.byte	>arrow_sprite
	.byte	>baby_sprite
	.byte	>kerrek_belt_sprite
	.byte	>chicken_feed_sprite
	.byte	>bow_sprite
	.byte	>mask_sprite
	.byte	>pebbles_sprite
	.byte	>pills_sprite
	.byte	>riches_sprite
	.byte	>robe_sprite
	.byte	>soda_sprite
	.byte	>sub_sprite
	.byte	>trinket_sprite
	.byte	>troghelm_sprite
	.byte	>trogshield_sprite
	.byte	>trogsword_sprite
	.byte	>no_sprite
	.byte	>tshirt_sprite




.include "sprites/inventory_sprites.inc"

.include "hgr_2x16_sprite.s"
