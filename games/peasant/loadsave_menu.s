; load/save menu

; o/~ It's the Loading Screen o/~

	; FIXME: we can share some of the code here a bit more

; we load one sector (256 or 512 bytes depending) to $BA00 currently
; SAVE1 is at $00, SAVE2 at $20, SAVE3 at $40


	;=====================
	; load_menu
	;=====================
load_menu:
	lda	#0
	sta	loadsave_smc1+1		; ???
	sta	loadsave_smc2+1

	jmp	common_menu

	;=====================
	; save_menu
	;=====================
save_menu:
	lda	#1
	sta	loadsave_smc1+1
	sta	loadsave_smc2+1

;	jmp	common_menu		; Fallthrough


	;=====================
	; common_menu
	;=====================
common_menu:

	; HACK: make DRAW_PAGE current visible one

	lda	DRAW_PAGE
	eor	#$20
	sta	DRAW_PAGE


	;============================
	; first read all three saves
	; updating the save info

	jsr	update_save_info

	;============================
	; Next update the save message

	ldx	#0

	lda	#<(save_pts1+7)
	sta	OUTL
	lda	#>(save_pts1+7)
	sta	OUTH

update_save_loop:


	;======================
	; print points
	;======================

	ldy	#0

	sty	usl_leading_zero_smc+1

usl_hundreds:
	lda	load_slot_pts_high,X		; get the points high
	beq	usl_no_hundreds

	inc	usl_leading_zero_smc+1

	clc
	adc	#'0'				; convert to ascii
	bne	usl_print_hundreds		; bra

usl_no_hundreds:
	lda	#' '				; no leading 0
usl_print_hundreds:
	sta	(OUTL),Y

	iny

usl_tens:
	lda	load_slot_pts_low,X		; get the points low
	lsr
	lsr
	lsr
	lsr

	bne	usl_go_tens

usl_leading_zero_smc:
	cmp	#0
	beq	usl_no_tens

usl_go_tens:
	adc	#'0'				; convert to ASCII
	bne	usl_print_tens		; bra

usl_no_tens:
	lda	#' '				; no leading 0

usl_print_tens:
	sta	(OUTL),Y

	iny

usl_ones:
	lda	load_slot_pts_low,X		; get the points low

	and	#$f
	clc
	adc	#'0'				; convert to ascii
	sta	(OUTL),Y

	; move to text line

	clc
	lda	OUTL
	adc	#8
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH


	;========================
	; clear out the old name

	ldy	#25
	lda	#' '				; clear to space
save_memset:
	sta	(OUTL),Y
	dey
	bpl	save_memset

	;=========================
	; load the name

	ldy	load_slot_levels,X		; get the level

	lda	location_names_l,Y
	sta	INL
	lda	location_names_h,Y
	sta	INH

	jsr	strcat

	;==========================
	; move out pointer to next

	clc
	lda	OUTL
	adc	#35
	sta	OUTL
	lda	OUTH
	adc	#0
	sta	OUTH

	inx
	cpx	#3
	bne	update_save_loop


	lda	#0
	sta	INVENTORY_Y

	;==========================
	; save bg range to restore

	lda	#20
	sta	BOX_Y1
        sta	SAVED_Y1

	lda	#135
	sta	BOX_Y2
	sta	SAVED_Y2

;	jsr	hgr_partial_save


	;====================
	; draw text box
draw_loadsave_box:

;	lda	#0
;	sta	BOX_X1H

;	lda	#14
	lda	#2		; 14/7=2
	sta	BOX_X1L
	lda	#20
	sta	BOX_Y1

;	lda	#1
;	sta	BOX_X2H
;	lda	#5		; ?

	lda	#38		; 261/7=~38
	sta	BOX_X2L
	lda	#135
	sta	BOX_Y2

	jsr	draw_box

	;===================
	; draw main text
draw_loadsave_text:

loadsave_smc1:
	lda	#0
	bne	do_save_message

do_load_message:
	; load message
	lda	#<load_message
	sta	OUTL
	lda	#>load_message
	jmp	loadsave_ready

do_save_message:
	; save message
	lda	#<save_message
	sta	OUTL
	lda	#>save_message

loadsave_ready:
	sta	OUTH

	jsr	disp_put_string


	lda	#<save_details
	sta	OUTL
	lda	#>save_details
	sta	OUTH

	jsr	disp_put_string


	;======================
	; draw highlighted text
	;======================


	lda	#<save_titles
	sta	OUTL
	lda	#>save_titles
	sta	OUTH

	jsr	disp_put_string
	jsr	disp_put_string
	jsr	disp_put_string
	jsr	disp_put_string

	ldy	#0
	jsr	overwrite_entry_ls

	;===========================
	; handle inventory keypress
	;===========================

handle_loadsave_keypress:

	lda	KEYPRESS
	bpl	handle_loadsave_keypress	; no keypress

	bit	KEYRESET			; clear keyboard strobe

	pha

	;=================
	; erase old

	ldy	INVENTORY_Y
	jsr	overwrite_entry_ls

	pla

	and	#$7f			; clear top bit

	cmp	#27
	beq	urgh_done_ls		; ESCAPE
	cmp	#$7f
	bne	ls_check_down		; DELETE

urgh_done_ls:
	jmp	done_ls_keypress

ls_check_down:
	and	#$5F			; make uppercase

	cmp	#$0A
	beq	ls_handle_down
	cmp	#'S'
	bne	ls_check_up
ls_handle_down:

	ldx	INVENTORY_Y
	cpx	#3
	beq	ls_down_wrap

	inx

	jmp	ls_down_done
ls_down_wrap:
	ldx	#0

ls_down_done:
	stx	INVENTORY_Y
	jmp	ls_done_moving

ls_check_up:
	cmp	#$0B
	beq	ls_handle_up
	cmp	#'W'
	bne	ls_check_return
ls_handle_up:

	ldx	INVENTORY_Y
	beq	ls_up_wrap

	dex
	jmp	ls_up_done

ls_up_wrap:
	ldx	#3

ls_up_done:
	stx	INVENTORY_Y
	jmp	ls_done_moving


ls_check_return:

	cmp	#13
	beq	ls_return
	cmp	#' '
	bne	ls_done_moving

ls_return:

	ldy	INVENTORY_Y
	cpy	#3
	bne	do_actual_load

	; back was hit

	rts

do_actual_load:

loadsave_smc2:
	lda	#0
	bne	go_for_save

go_for_load:
	jmp	load_game

go_for_save:
	jmp	save_game


ls_done_moving:

	;================
	; draw new
	ldy	INVENTORY_Y
	jsr	overwrite_entry_ls

	;================
	; repeat

	jmp	handle_loadsave_keypress

done_ls_keypress:

	rts

;======================
; text
;======================

; it's a save game menu

; SAVE 1  ?? 115 PTS
;         ?? Cliff base
;
; SAVE 2  ?? 133 PTS
;         ?? Trogdor's outer sanctum
;
; SAVE 3  ??  34 PTS
;         ?? That hay bale
;
; BACK

load_message:
.byte 10,28
.byte	"it's a load game menu",0

save_message:
.byte 10,28
.byte	"it's a save game menu",0

save_details:
.byte	10,44
save_pts1:
.byte	"       115 PTS",13
save_name1:
.byte	"Cliff base                ",13
.byte	13
.byte	"       133 PTS",13
save_name2:
.byte	"Trogdor's outer sanctum   ",13
.byte	13
.byte	"        34 PTS",13
save_name3:
.byte	"That hay bale             ",13
.byte  0

save_titles:
.byte	6,44, "SLOT 1",0
.byte	6,68, "SLOT 2",0
.byte	6,92, "SLOT 3",0
.byte	6,116,"BACK",0


        ;========================
        ; overwrite entry_ls
        ;========================
        ; Y = which

overwrite_entry_ls:
	lda	invert_smc1+1
	eor	#$7f
	sta	invert_smc1+1

	lda	#6
	sta	CURSOR_X

	; y=44+(3*Y)*8
	sty	CURSOR_Y
	tya
	asl
	clc
	adc	CURSOR_Y
	asl
	asl
	asl
	adc	#44
	sta	CURSOR_Y

	ldx	#6	; assume 6 chars wide
overwrite_loop_ls:
        txa
        pha

	lda	#$20
	jsr	hgr_put_char_cursor
	inc	CURSOR_X
	pla
	tax
	dex
	bne	overwrite_loop_ls

	lda	invert_smc1+1
	eor	#$7f
	sta	invert_smc1+1

        rts


	;===================================
	;===================================
	; load the game
	;===================================
	;===================================
load_game:

	; print are you sure message

	jsr	confirm_action

	bcs	done_load

	; actually load it
;	lda	INVENTORY_Y		; this is the pointer?
;	clc
;	adc	#LOAD_SAVE1
;	sta	WHICH_LOAD

	lda	#LOAD_SAVE1		; should already be loaded?
	jsr	load_file		; is this necessary?

	; copy to zero page

	lda	INVENTORY_Y		; this is pointer 0/1/2
	asl
	asl
	asl
	asl
	asl				; multiply by 32
	sta	load_buffer_smc+1

	ldx	#0
load_loop:

load_buffer_smc:
	lda	load_buffer,X
	sta	LOAD_START,X
	inx
	cpx	#(END_OF_SAVE-LOAD_START+1)
	bne	load_loop

	lda	#NEW_FROM_LOAD		; load whole level from disk
	sta	LEVEL_OVER

done_load:

	rts


	;===================================
	;===================================
	; save the game
	;===================================
	;===================================

save_game:

	; print are you sure message

	jsr	confirm_action

	bcs	done_save

	; put which save into A

;	lda	INVENTORY_Y

;	pha			; save slot for later on stack

;	clc
;	adc	#LOAD_SAVE1
;	sta	WHICH_LOAD	; get proper WHICH_LOAD value


	;========================
	; actually save
actually_save:

	;===============================
	; first load something from
	; disk1/track0 to seek the head there

;	lda	WHICH_LOAD		; save this value as we
					; destroy it for load
;	pha

	lda	#LOAD_SAVE1		; use SAVE1 as it's on track 0
	sta	WHICH_LOAD
	jsr	load_file

;	pla

;	sta	WHICH_LOAD

	;=================================
	; copy save data to load_buffer

	lda	INVENTORY_Y
	asl
	asl
	asl
	asl
	asl			; multiply by 32
	sta	copy_save_smc+1

	ldx	#0
copy_save_loop:
	lda	LOAD_START,X
copy_save_smc:
	sta	load_buffer,X
	inx
	cpx	#(END_OF_SAVE-LOAD_START+1)	; why +1?
	bne	copy_save_loop

	jsr	do_savegame
.if 0
	; spin up disk
	jsr	driveon

	; actually save it

	lda	#12			; save is track0 sector 12
	sta	requested_sector+1

	jsr	sector_write

	jsr	driveoff

.endif

done_save:
	lda	#NEW_LOCATION	; reload level as we scrawled on $2000
	sta	LEVEL_OVER

	rts


	;=======================================
	; confirm action
	;=======================================
	; call with first message in OUTL/OUTH
	; return: carry set if skipping

confirm_action:

	bit	KEYRESET	; clear keyboard buffer

	;===============================
	; print "are you sure" message

	lda	#<are_you_sure
	sta	OUTL
	lda	#>are_you_sure
	sta	OUTH

;	jsr	hgr_text_box_nosave
	jsr	hgr_text_box

wait_confirmation:
	lda	KEYPRESS
	bpl	wait_confirmation

	bit	KEYRESET		; clear keypress

	and	#$5F			; clear high-bit, make uppercase
	cmp	#'Y'
	bne	dont_do_it

	clc
	rts

dont_do_it:
	sec
	rts


are_you_sure:
;.byte  0,43,40, 0,240,90
.byte      6,40,    35,90
.byte  10,61
.byte  "ARE YOU SURE? (Y/N)",0


	;=========================
	; update save info
	;=========================
update_save_info:

	lda	WHICH_LOAD		; save our current disk location
	pha				; on stack

;	ldx	#0
;update_save_info_loop:
;	clc
;	txa
;	pha

	lda	#LOAD_SAVE1		; load it into memory
	sta	WHICH_LOAD

	jsr	load_file

;	pla
;	tax

	ldx	#0
	ldy	#0
update_save_info_loop:

	lda	load_buffer+(MAP_LOCATION-LOAD_START),Y	; MAP_LOCATION
	sta	load_slot_levels,X
	lda	load_buffer+(SCORE_HUNDREDS-LOAD_START),Y	; SCORE_HUNDREDS
	sta	load_slot_pts_high,X
	lda	load_buffer+(SCORE_TENSONES-LOAD_START),Y	; SCORE_TENSONES
	sta	load_slot_pts_low,X

	tya			; info at 32 byte offsets
	clc
	adc	#$20
	tay

	inx
	cpx	#3
	bne	update_save_info_loop

	pla						; restore load info
	sta	WHICH_LOAD

	rts


load_slot_levels:
	.byte	LOCATION_EMPTY		; location
	.byte	LOCATION_WAVY_TREE	; location
	.byte	LOCATION_TROGDOR_LAIR	; location

load_slot_pts_high:
	.byte	$0			; points_high
	.byte	$0			; points_high
	.byte	$1			; points_high

load_slot_pts_low:
	.byte	$00			; points_low
	.byte	$45			; points_low
	.byte	$10			; points_low


location_names_l:
	.byte <lname_poor_gary
	.byte <lname_kerrek_1
	.byte <lname_old_well
	.byte <lname_yellow_tree
	.byte <lname_waterfall
	.byte <lname_hay_bale
	.byte <lname_mud_puddle
	.byte <lname_archery
	.byte <lname_river_stone
	.byte <lname_mountain_pass
	.byte <lname_jhonka_cave
	.byte <lname_your_cottage
	.byte <lname_lake_west
	.byte <lname_lake_east
	.byte <lname_outside_inn
	.byte <lname_outside_nn
	.byte <lname_wavy_tree
	.byte <lname_kerrek_2
	.byte <lname_outside_lady
	.byte <lname_burn_tree

	.byte <lname_cliff_base
	.byte <lname_cliffland_heights
	.byte <lname_trogdor_outer
	.byte <lname_trogdor_posh

	.byte <lname_hidden_glen
	.byte <lname_inside_lady
	.byte <lname_inside_nn
	.byte <lname_inside_inn

	.byte <lname_archery_game
	.byte <lname_map

	.byte <lname_empty

location_names_h:
	.byte >lname_poor_gary
	.byte >lname_kerrek_1
	.byte >lname_old_well
	.byte >lname_yellow_tree
	.byte >lname_waterfall
	.byte >lname_hay_bale
	.byte >lname_mud_puddle
	.byte >lname_archery
	.byte >lname_river_stone
	.byte >lname_mountain_pass
	.byte >lname_jhonka_cave
	.byte >lname_your_cottage
	.byte >lname_lake_west
	.byte >lname_lake_east
	.byte >lname_outside_inn
	.byte >lname_outside_nn
	.byte >lname_wavy_tree
	.byte >lname_kerrek_2
	.byte >lname_outside_lady
	.byte >lname_burn_tree

	.byte >lname_cliff_base
	.byte >lname_cliffland_heights
	.byte >lname_trogdor_outer
	.byte >lname_trogdor_posh

	.byte >lname_hidden_glen
	.byte >lname_inside_lady
	.byte >lname_inside_nn
	.byte >lname_inside_inn

	.byte >lname_archery_game
	.byte >lname_map

	.byte >lname_empty


location_names:
lname_poor_gary:	.byte "Poor Gary's Glen",0	; A1 LOCATION_POOR_GARY
lname_kerrek_1:		.byte "Kerrek Tracks 1",0	; B1 LOCATION_KERREK_1
lname_old_well:		.byte "Old Well",0		; C1 LOCATION_OLD_WELL
lname_yellow_tree:	.byte "Yellow Tree",0		; D1 LOCATION_YELLOW_TREE
lname_waterfall:	.byte "Waterfall",0		; E1 LOCATION_WATERFALL
lname_hay_bale:		.byte "That Hay Bale",0		; A2 LOCATION_HAY_BALE
lname_mud_puddle:	.byte "That Mud Puddle",0	; B2 LOCATION_MUD_PUDDLE
lname_archery:		.byte "Archery Range",0		; C2 LOCATION_ARCHERY
lname_river_stone:	.byte "River and Stone",0	; D2 LOCATION_RIVER_STONE
lname_mountain_pass:	.byte "Mountain Pass",0		; E2 LOCATION_MOUNTAIN_PASS
lname_jhonka_cave:	.byte "Jhonka's Cave",0			; A3 LOCATION_JHONKA_CAVE
lname_your_cottage:	.byte "Your Burninated Cottage",0	; B3 LOCATION_YOUR_COTTAGE
lname_lake_west:	.byte "Pebble Lake West",0		; C3 LOCATION_LAKE_WEST
lname_lake_east:	.byte "Pebble Lake East",0		; D3 LOCATION_LAKE_EAST
lname_outside_inn:	.byte "Outside Giant Inn",0		; E3 LOCATION_OUTSIDE_INN
lname_outside_nn:	.byte "Outside Mysterious Cottage",0	; A4 LOCATION_OUTSIDE_NN
lname_wavy_tree:	.byte "Wavy Tree",0			; B4 LOCATION_WAVY_TREE
lname_kerrek_2:		.byte "Kerrek Tracks 2",0		; C4 LOCATION_KERREK_2
lname_outside_lady:	.byte "Outside Baby Lady Cottage",0	; D4 LOCATION_OUTSIDE_LADY
lname_burn_tree:	.byte "Burninated Trees",0		; E4 LOCATION_BURN_TREES

lname_cliff_base:	.byte "Cliff Base",0			; LOCATION_CLIFF_BASE
lname_cliffland_heights:.byte "Cliffland Heights",0		; LOCATION_CLIFF_HEIGHTS
lname_trogdor_outer:	.byte "Trogdor's Outer Sanctum",0	; LOCATION_TROGDOR_OUTER
lname_trogdor_posh:	.byte "Trogdor's Posh Lair",0		; LOCATION_TROGDOR_LAIR

lname_hidden_glen:	.byte "Hidden Glen",0			; LOCATION_HIDDEN_GLEN
lname_inside_lady:	.byte "Inside Baby Lady Cottage",0	; LOCATION_INSIDE_LADY
lname_inside_nn:	.byte "Inside Mysterious Cottage",0	; LOCATION_INSIDE_NN
lname_inside_inn:	.byte "Inside Giant Inn",0		; LOCATION_INSIDE_INN

lname_archery_game:	.byte "Archery Game",0			; LOCATION_INSIDE_INN
lname_map:		.byte "Map",0				; LOCATION_INSIDE_INN

lname_empty:		.byte "Empty",0
location_names_end:


	;===================
	; strcat
	;===================
	; input in INL
	; output in OUTL
strcat:
	ldy	#0
strcat_loop:
	lda	(INL),Y
	beq	strcat_done
	sta	(OUTL),Y
	iny
	jmp	strcat_loop
strcat_done:
	rts
