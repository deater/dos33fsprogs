; load/save menu


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

	;=====================
	; load_menu
	;=====================
load_menu:

	;============================
	; first read all three saves
	; updating the text box

	; TODO




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
draw_loadstore_box:

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
draw_loadstore_text:

	; TODO: use SAVE message if we're saving instead

	lda	#<load_message
	sta	OUTL
	lda	#>load_message
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



	;===========================
	; handle inventory keypress
	;===========================

handle_loadsave_keypress:

	lda	KEYPRESS
	bpl	handle_loadsave_keypress	; no keypress

	bit	KEYRESET			; clear keyboard strobe


.if 0
	pha

	;=================
	; erase old

	ldy	INVENTORY_Y
	jsr	overwrite_entry

	pla

	and	#$7f			; clear top bit

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
.endif
	;================
	; repeat

	jmp	handle_loadsave_keypress

done_loadsave_keypress:

	rts

;======================
; text
;======================

load_message:
.byte 10,28
.byte	"it's a load game menu",0

save_message:
.byte 10,28
.byte	"it's a save game menu",0

save_details:
.byte	13,44
.byte	"    115 PTS",13
.byte	"Cliff base             ",13
.byte	13
.byte	"    133 PTS",13
.byte	"Trogdor's outer sanctum",13
.byte	13
.byte	"     34 PTS",13
.byte	"That hay bale          ",13
.byte  0

save_titles:
.byte	6,44, "SAVE 1",0
.byte	6,68, "SAVE 2",0
.byte	6,92, "SAVE 3",0
.byte	6,116,"BACK",0


