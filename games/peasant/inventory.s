; note this is around 2k

	;=====================
	; show inventory
	;=====================
show_inventory:

	lda	#0
	sta	INVENTORY_X
	lda	#28
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

	;===============
	; left column

	lda	#28
	sta	CURSOR_Y

	ldy	#0
	lda	#1
	sta	INVENTORY_MASK
left_column_loop:

	lda	INVENTORY_X		; we are column 0
	bne	not_left_inverted

	lda	CURSOR_Y
	cmp	INVENTORY_Y
	bne	not_left_inverted

	lda	#$7f
	sta	invert_smc1+1

not_left_inverted:

	lda	#4
	sta	CURSOR_X

	tya
	pha

	lda	INVENTORY_MASK
	and	INVENTORY_1
	beq	left_questionmarks

left_have_item:
	clc
	lda	left_item_offsets,Y
	adc	#<item_strings
	sta	OUTL
	lda	#0
	adc	#>item_strings
	jmp	left_print_item

left_questionmarks:
	lda	#<unknown_string
	sta	OUTL
	lda	#>unknown_string

left_print_item:
	sta	OUTH

	jsr	disp_one_line

	; reset inverse

	lda	#$00
	sta	invert_smc1+1

	lda	CURSOR_Y
	clc
	adc	#8
	sta	CURSOR_Y

	asl	INVENTORY_MASK

	pla

	tay
	iny
	cpy	#8
	bne	left_column_loop

	; extra for riches




	;================
	; right column

	lda	#28
	sta	CURSOR_Y

	ldy	#0
	lda	#1
	sta	INVENTORY_MASK
right_column_loop:

	lda	INVENTORY_X		; we are column 1
	beq	not_right_inverted

	lda	CURSOR_Y
	cmp	INVENTORY_Y
	bne	not_right_inverted

	lda	#$7f
	sta	invert_smc1+1

not_right_inverted:

	lda	#23
	sta	CURSOR_X

	tya
	pha

	lda	INVENTORY_MASK
	and	INVENTORY_2
	beq	right_questionmarks

right_have_item:
	clc
	lda	right_item_offsets,Y
	adc	#<item_strings
	sta	OUTL
	lda	#0
	adc	#>item_strings
	jmp	right_print_item

right_questionmarks:
	lda	#<unknown_string
	sta	OUTL
	lda	#>unknown_string

right_print_item:
	sta	OUTH

	jsr	disp_one_line

	lda	CURSOR_Y
	clc
	adc	#8
	sta	CURSOR_Y

	asl	INVENTORY_MASK

	; reset inverse

	lda	#$00
	sta	invert_smc1+1

	pla

	tay
	iny
	cpy	#8
	bne	right_column_loop


handle_inv_keypress:

	lda	KEYPRESS
	bpl	handle_inv_keypress	; no keypress

	bit	KEYRESET		; clear keyboard strobe

	and	#$7f			; clear top bit


	cmp	#27
	beq	done_inv_keypress	; ESCAPE
	cmp	#$7f
	beq	done_inv_keypress	; DELETE

inv_check_down:
	cmp	#$0A
	beq	inv_handle_down
	cmp	#'S'
	bne	inv_check_up
inv_handle_down:
	lda	INVENTORY_Y
	clc
	adc	#$8
	sta	INVENTORY_Y
	jmp	inv_done_moving

inv_check_up:
	cmp	#$0B
	beq	inv_handle_up
	cmp	#'W'
	bne	inv_check_left_right
inv_handle_up:
	lda	INVENTORY_Y
	sec
	sbc	#$8
	sta	INVENTORY_Y
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
	lda	INVENTORY_X
	eor	#$1
	sta	INVENTORY_X
	jmp	inv_done_moving

inv_check_return:


inv_done_moving:
	;================
	; check bounds

	lda	INVENTORY_Y
	cmp	#28
	bcc	inv_y_set_top		; blt too small
	cmp	#100
	bcs	inv_y_set_bottom	; bge
	bcc	inv_y_done		; bra

inv_y_set_top:
	lda	#100
	jmp	inv_y_done

inv_y_set_bottom:
	lda	#28

inv_y_done:
	sta	INVENTORY_Y

	;================
	; clear box

	;================
	; repeat

	jmp	draw_inv_box

done_inv_keypress:

	rts


;======================
; text
;======================
;
; Note, greyed out could maybe print ---- for strikethrough

; printed after description
.byte	"You no longer has this item.",0
.byte	"Hit return to go back to list",0

; first is only printed if have in inventory, though still can
inventory_message:
.byte	5,106," Press return for description",13
.byte 	      " Press ESC or DELETE to exit",0

;====================
; Inventory Strings
;====================

unknown_string:
.byte	"???",0

left_item_offsets:
.byte	(item_arrow-item_strings)
.byte	(item_baby-item_strings)
.byte	(item_kerrek_belt-item_strings)
.byte	(item_chicken_feed-item_strings)
.byte	(item_funbow-item_strings)
.byte	(item_monster_mask-item_strings)
.byte	(item_pebbles-item_strings)
.byte	(item_pills-item_strings)

right_item_offsets:
.byte	(item_robe-item_strings)
.byte	(item_soda-item_strings)
.byte	(item_meatball_sub-item_strings)
.byte	(item_super_trinket-item_strings)
.byte	(item_troghelmet-item_strings)
.byte	(item_trogshield-item_strings)
.byte	(item_trogsword-item_strings)
.byte	(item_impossible-item_strings)





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

; arrow
arrow_description:
.byte "Boy, you sure know how to pick",13
.byte "em! This arrow's kinda pointy even!!",0

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
.byte "want to.  It's like those theatre",13
.byte "masks' evil uncle or something",0

; pebbles
pebbles_description:
.byte "Woah! Gray chicken feed! Oh",13
.byte "wait... those are just pebbles.",13
.byte "Heavier than they look, though.",0

; pills
pills_description:
.byte "The innkeeper's medication says",13
.byte "it's supposed to tread ",34,"general",13
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
.byte "well.  All you need is a bag of",13
.byte "chips and you've got a combo",13
.byte "meal!",0

; super trinket
super_trinket_description:
.byte "This super trinket is weird. It",13
.byte "looks like it could either kill",13
.byte "you or make you the hit of your",13
.byte "Christmas party.",0

; TrogHelmet
.byte "The TrogHelmet is not screwing",13
.byte "around.  It's a serious helmet.",13
.byte "It also protects against",13
.byte "harmful UV rays.",0

; TrogShield
.byte "Behold the TrogSheild! No",13
.byte "seriously, behold it.  There's",13
.byte "no way Trogdor's fire breath can",13
.byte "penetrate this thing.",0

; TrogSword
.byte "The TrogSword is for real.",13
.byte "Hands-down the coolest item in",13
.byte "this whole game. You can't wait",13
.byte "to lop off that beefy arm of",13
.byte "Trogdor's with this guy.",0

; ???

; t-shirt
.byte "This has got to be your favorite",13
.byte "T-Shirt ever. Oh, the times you",13
.byte "had at Scalding Lake. Canoeing,",13
.byte "fishing, stoning heathens. What",13
.byte "a Blast!",0

