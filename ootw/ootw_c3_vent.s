; Ootw Checkpoint3 -- Rolling around the vents

ootw_vent:

	;==============================
	; init

	lda	#0

	; load background
	lda	#>(vent_rle)
	sta	GBASH
	lda	#<(vent_rle)
	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call

	;===========================
	; Enable graphics

	bit	LORES
	bit	SET_GR
	bit	FULLGR

	;===========================
	; Setup pages (is this necessary?)

	lda	#0
	sta	DRAW_PAGE
	lda	#1
	sta	DISP_PAGE

	;=================================
	; copy to screen

	jsr	gr_copy_to_current
	jsr	page_flip

	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER

	;============================
	; Vent Loop
	;============================
vent_loop:

	;================================
	; copy background to current page

	jsr	gr_copy_to_current

	;==================================
	; draw background action

	;===============================
	; check keyboard

	jsr	handle_keypress

	;===============================
	; move physicist

;	jsr	move_physicist

	;===============
	; check room limits

;	jsr	check_screen_limit


	;===============
	; draw physicist

;	jsr	draw_physicist


	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	vent_frame_no_oflo
	inc	FRAMEH
vent_frame_no_oflo:

	;==========================
	; check if done this level
	;==========================

	lda	GAME_OVER
	beq	still_in_vent

	cmp	#$ff			; if $ff, we died
	beq	done_vent

	;===============================
	; check if exited room to right
;	cmp	#1
;	beq	jail_exit_left

	;=================
	; exit to right

;jail_right_yes_exit:

;	lda	#0
;	sta	PHYSICIST_X
;jer_smc:
;	lda	#$0			; smc+1 = exit location
;	sta	WHICH_CAVE
;	jmp	done_jail

	;=====================
	; exit to left

;jail_exit_left:

;	lda	#37
;	sta	PHYSICIST_X
;jel_smc:
;	lda	#0		; smc+1
;	sta	WHICH_CAVE
;	jmp	done_jail

	; loop forever
still_in_vent:
	lda	#0
	sta	GAME_OVER

	jmp	vent_loop

done_vent:
	rts



puff_sprite_start1:
	.byte 3,2
	.byte $AA,$A5,$AA
	.byte $AA,$AA,$AA

puff_sprite_start2:
	.byte 3,2
	.byte $AA,$55,$AA
	.byte $AA,$AA,$AA


puff_sprite_cycle1:
	.byte 3,2
	.byte $AA,$55,$AA
	.byte $AA,$A5,$AA

puff_sprite_cycle2:
	.byte 3,2
	.byte $AA,$55,$AA
	.byte $A5,$A5,$A5

puff_sprite_cycle3:
	.byte 3,2
	.byte $5A,$55,$5A
	.byte $A5,$A5,$A5

puff_sprite_cycle4:
	.byte 3,2
	.byte $A5,$55,$A5
	.byte $A5,$A5,$A5


puff_sprite_end1:
	.byte 3,2
	.byte $AA,$AA,$AA
	.byte $A5,$AA,$5A

puff_sprite_end2:
	.byte 3,2
	.byte $A5,$AA,$A5
	.byte $AA,$AA,$AA

