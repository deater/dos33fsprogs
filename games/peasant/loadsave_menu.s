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
	; do actual load
	rts

;	jmp	draw_inv_box

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

