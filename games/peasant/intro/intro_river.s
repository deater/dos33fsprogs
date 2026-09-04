; Intro at the River

; o/~ At the beautiful, the beautiful, River o/~


; like 2s up, then right

RIVER_SWITCH_DIRECTION = 20
RIVER_WALK_DONE = 25

	;========================
	; River
	;========================

intro_river:
	lda	#0
	sta	FRAME
	sta	WALK_OVER

	;=========================
	; init peasant position
	; draw at 33,157

	lda	#33
	sta	PEASANT_X
	lda	#160
	sta	PEASANT_Y

	lda	#PEASANT_DIR_UP
	sta	PEASANT_DIR

	;==========================
	; load bg graphics

	ldx	#INTRO_RIVER_BG
	jsr	intro_load_bg_common

.if 0
	;========================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<river_priority_zx02
	sta	zx_src_l+1
	lda	#>river_priority_zx02
	sta	zx_src_h+1

	lda	#>priority_temp		; temporarily load to $7000

	jsr	zx02_full_decomp

	; copy to $400

	jsr	priority_copy


	;====================
	; load bg to $6000


	lda	#<(river_zx02)
	sta	zx_src_l+1
	lda	#>(river_zx02)
	sta	zx_src_h+1

	lda	#$60

	jsr	zx02_full_decomp


	;==================
	; print title line

	jsr	intro_print_title
.endif

	;===================
	; walk loop setup
	;===================

	lda	#0
	sta	WALK_COUNT

	lda	#32
	sta	WALK_DEST_X

	lda	#105
	sta	WALK_DEST_Y

	;=======================
	;=======================
	; river walk loop
	;=======================
	;=======================

river_walk_loop:

	;===========================
	; copy bg to current screen

	jsr	hgr_copy_faster


	;====================
	; draw peasant

	jsr	draw_peasant

	;====================
	; move peasant

	jsr	move_peasant_river

	jsr	display_text_river

	;=====================
	; animate river

	jsr	animate_river

;	jsr	wait_until_keypress

	;======================
	; flip page

	jsr	hgr_page_flip

	;========================
	; check escape pressed

	lda	ESC_PRESSED
	bne	done_river

	inc	FRAME

	lda	WALK_OVER

	beq	river_walk_loop


	;===================
	; done

done_river:

	rts



; walk up a bit

;river_message1:
;	.byte 0,35,34, 0,253,82
;	.byte 7,49,"You can start playing in a",13
;	.byte	   "second here.",0

; walks behind tree


.if 0
river_path:
	.byte 32,157
	.byte 32,153
	.byte 32,149
	.byte 32,145
	.byte 32,141
	.byte 32,137
	.byte 32,133
	.byte 32,129
	.byte 32,125
	.byte 32,121	; message
	.byte 32,117
	.byte 32,113
	.byte 32,109
	.byte 32,105
	.byte 32,105	; turn right
	.byte 33,105
	.byte 34,105
	.byte 35,105
	.byte 36,105
	.byte 37,105
	.byte 38,105
	.byte $FF,$FF
.endif


move_peasant_river:
	lda	FRAME

	cmp	#RIVER_SWITCH_DIRECTION
	beq	river_switch_direction

	cmp	#RIVER_WALK_DONE
	bne	done_move_river

	inc	WALK_OVER

	bne	done_move_river		; bra

river_switch_direction:

	lda	#38
	sta	WALK_DEST_X

	lda	#105
	sta	WALK_DEST_Y

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

done_move_river:
	jsr	walk_to

	jsr	update_peasant_steps

	rts

	;=========================
	; handle text display
	;========================
	; 0..9 - nothing
	; 10..? - print message
	; 15    - change direction walking
display_text_river:

	lda	FRAME
check_river_action1:
	cmp	#10
	bcc	done_river_action

	; over 10, print message

	lda	#<river_message1
	sta	OUTL
	lda	#>river_message1
	sta	OUTH

	jsr	hgr_text_box


done_river_action:

	rts
