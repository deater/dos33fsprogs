; Lake East Intro

; nothing shown first 4 s
; then lake text for 2 s
; then another 2s

; walking right
; start moving diagonal (still facing right)
; start walking up (facing up)

LAKE_E_TEXT1 = 0		; nothing
LAKE_E_TEXT2 = $1A		; lake message
LAKE_E_TEXT3 = $35		; nothing again

LAKE_E_WALKING1 = $24		; start diagonal
LAKE_E_WALKING2 = $35		; start vertical
LAKE_E_WALKING_END = $5b	; all over

	;========================
	; Lake East
	;========================
intro_lake_east:
	lda	#0
	sta	FRAME
	sta	WALK_OVER

	;=========================
	; init peasant position
	; draw at 0,151

	lda	#0
	sta	PEASANT_X
	lda	#151
	sta	PEASANT_Y

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

	;============================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<lake_e_priority_zx02
	sta	zx_src_l+1
	lda	#>lake_e_priority_zx02
	sta	zx_src_h+1

	lda	#>priority_temp		; temporarily load to $7000

	jsr	zx02_full_decomp

	; copy to $400

	jsr	priority_copy

	;=========================
	; load bg to $6000

	lda	#<(lake_e_zx02)
	sta	zx_src_l+1
	lda	#>(lake_e_zx02)
	sta	zx_src_h+1

	lda	#$60

	jsr	zx02_full_decomp

	;================
	; print title line

	jsr	intro_print_title



	;====================
	; walk loop setup
	;====================

	lda	#0
	sta	WALK_COUNT

	lda	#28
	sta	WALK_DEST_X

	lda	#151
	sta	WALK_DEST_Y

	;===================
	;===================
	; lake_e walk loop
	;===================
	;===================

lake_e_walk_loop:

	;===========================
	; copy bg to current screen

	; also checks keyboard

	jsr	hgr_copy_faster


	;=======================
	; draw peasant

	jsr	draw_peasant

	;======================
	; move peasant

	jsr	move_peasant_lake_e

	jsr	display_text_lake_e


	;=======================
	; animate bubbles

	jsr	animate_bubbles_e

;	jsr	wait_until_keypress

	;======================
	; flip page

	jsr	hgr_page_flip


	;========================
	; check if escape pressed

;	jsr	intro_drain_keyboard_buffer

	lda	ESC_PRESSED
	bne	done_lake_e

	inc	FRAME

	lda	WALK_OVER
	beq	lake_e_walk_loop


	;===================
	; done

done_lake_e:

	rts


; walk sideways, near corner

;lake_e_message1:
;	.byte 0,35,34, 0,253,72
;	.byte 7,49,"That's a nice looking lake.",0

; nearly hit head on sign, it goes away, walk off screen
.if 0
lake_e_path:
	.byte 4,151
	.byte 5,151
	.byte 6,151
	.byte 7,151
	.byte 8,151
	.byte 9,151
	.byte 10,151
	.byte 11,151
	.byte 12,151
	.byte 13,151
	.byte 14,151
	.byte 15,151
	.byte 16,151
	.byte 17,151
	.byte 18,151
	.byte 19,151
	.byte 20,151
	.byte 21,151
	.byte 22,151
	.byte 23,151
	.byte 24,151
	.byte 25,151
	.byte 26,151
	.byte 27,151
	.byte 28,151
	.byte 29,141
	.byte 30,131
	.byte 31,121
	.byte 32,111
	.byte 33,101
	.byte 34,91
	.byte 35,81
	.byte 35,71
	.byte 35,61
	.byte 35,51
	.byte 35,41
	.byte $FF,$FF
.endif

	;==========================
	; move_peasant lake_e

move_peasant_lake_e:

	lda	FRAME

	cmp	#LAKE_E_WALKING1
	beq	lake_e_switch1

	cmp	#LAKE_E_WALKING2
	beq	lake_e_switch2

	cmp	#LAKE_E_WALKING_END
	beq	lake_e_switch3

	bne	no_lake_e_switch


lake_e_switch1:
	lda	#35
	sta	WALK_DEST_X

	lda	#81
	sta	WALK_DEST_Y

	bne	no_lake_e_switch		; bra

lake_e_switch2:
	lda	#35
	sta	WALK_DEST_X

	lda	#41
	sta	WALK_DEST_Y

	; face upward

	lda	#PEASANT_DIR_UP
	sta	PEASANT_DIR

	jmp	no_lake_e_switch

lake_e_switch3:
	inc	WALK_OVER

no_lake_e_switch:

	jsr	walk_to

	jsr	update_peasant_steps

	rts

	;=======================
	; handle text display
	;=======================
	; FRAME 0		nothing
	; FRAME LAKE_E_TEXT2	lake_e_message1
	; FRAME LAKE_E_TEXT3	change peasant direction?

display_text_lake_e:

	lda	FRAME
check_lake_e_action1:
	cmp	#LAKE_E_TEXT2			; blt
	bcc	done_lake_e_action
	cmp	#LAKE_E_TEXT3			;
	bcs	done_lake_e_action		; bge

	; print message

	lda	#<lake_e_message1
	sta	OUTL
	lda	#>lake_e_message1
	sta	OUTH
	jsr	hgr_text_box

done_lake_e_action:

	rts
