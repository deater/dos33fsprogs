; THATCHED ROOF COTTAGES

; More specifically, the Dashing Residence


TEXT1_FRAME=0		; display at 0:00  (for 5s)
TEXT2_FRAME=25		; display at 0:05s (for 8s)
TEXT3_FRAME=50		; display at 0:13s (until end)

WALK1_FRAME=0		; no walking
WALK2_FRAME=44		; start walking at roughly 10s
WALK3_FRAME=50		; turn corner at roughtly 13s
WALK4_FRAME=80		; end of level at 19s?

; text message 1 (displays 5s)
; text message 2 (displays 5s)
; start walking, text message 2 still (displays 3s)
; walk head by cottage, text message 3
; total time to walk 3+3=6

intro_cottage:

	;========================
	; Cottage
	;========================

	lda	#0
	sta	FRAME
	sta	WALK_OVER

	;=========================
	; init peasant position
	; draw at 70,117

	lda	#10
	sta	PEASANT_X
	lda	#117
	sta	PEASANT_Y

	lda	#PEASANT_DIR_RIGHT
	sta	PEASANT_DIR

	;==========================
	; load bg graphics

	ldx	#INTRO_COTTAGE_BG
	jsr	intro_load_bg_common

.if 0
	;=============================
	; load priority to $400
	; indirectly as we can't trash screen holes

	lda	#<cottage_priority_zx02
	sta	zx_src_l+1
	lda	#>cottage_priority_zx02
	sta	zx_src_h+1

	lda	#>priority_temp		; temporarily load to $7000

	jsr	zx02_full_decomp

	; copy to $400

	jsr	priority_copy



	;==========================
	; load background to $6000

	lda	#<(cottage_zx02)
	sta	zx_src_l+1
	lda	#>(cottage_zx02)
	sta	zx_src_h+1

	lda	#$60

	jsr	zx02_full_decomp

	;===================
	; print title line

	jsr	intro_print_title
.endif

	;====================
	; walk loop setup
	;====================


	lda	#0
	sta	WALK_COUNT


	;====================
	;====================
	; cottage walk loop
	;====================
	;====================
cottage_walk_loop:

	;===========================
	; copy bg to current screen

	; also checks keyboard

	jsr	hgr_copy_faster

	;=======================
	; draw peasant

	jsr	draw_peasant

	;=====================
	; move peasant

	jsr	move_peasant_cottage

move_good:


	jsr	display_text_cottage


done_cottage_action:

	;======================
	; flip page

	jsr	hgr_page_flip


	;========================
	; check if escape pressed

;	jsr	check_escape_pressed
;	bcs	done_cottage

	lda	ESC_PRESSED
	bne	done_cottage

	inc	FRAME

	lda	WALK_OVER
	beq	cottage_walk_loop

;	jmp	cottage_walk_loop


	;===================
	; done

done_cottage:

	rts

.if 0
; Walk to edge of screen

	; note by default XADD=1,YADD=5
	;	though note originally only moved every other frame?

cottage_path_x:
	.byte 10		; 0 ; original location	(5s, then text 1)
	.byte 10		; 1 ; original location (5s, then text 2)
	.byte 16
	.byte 38
	.byte $FF		; end

cottage_path_y:
	.byte 117		; 0 ; original location	(5s, then text 1)
	.byte 117		; 1 ; original location (5s, then text 2)
	.byte 147
	.byte 147


cottage_path_frames:
	.byte 20		; 0 ; original location	(5s, then text 1)
	.byte 20		; 1 ; original location (5s, then text 2)
	.byte 20
	.byte 20
.endif

	;=======================
	; move_peasant cottage
	;=======================

move_peasant_cottage:

	lda	FRAME

check_cottage_walk1:

	cmp	#WALK1_FRAME
	bcc	done_cottage_no_walk

	cmp	#WALK2_FRAME
	bcs	check_cottage_walk2

	;========================
	; walk cottage text 1

	; no walking for 10s

	jmp	done_cottage_no_walk

check_cottage_walk2:

	cmp	#WALK3_FRAME
	bcs	check_cottage_walk3		; bge

	;  walk to 16,147

	lda	#16
	sta	WALK_DEST_X

	lda	#147
	sta	WALK_DEST_Y

	bne	cottage_walk_common	; bra

check_cottage_walk3:

	cmp	#WALK4_FRAME
	bcs	check_cottage_walk4

	; walk to 38,147

	lda	#38
	sta	WALK_DEST_X

	lda	#147
	sta	WALK_DEST_Y

	bne	cottage_walk_common	; bra

check_cottage_walk4:
	inc	WALK_OVER

cottage_walk_common:
	; updates peasant animation frame

	jsr	walk_to

	jsr	update_peasant_steps

done_cottage_no_walk:
	rts






	;=======================
	; handle text display
	;=======================

display_text_cottage:

	lda	FRAME

check_cottage_text1:

	cmp	#TEXT1_FRAME
	bcc	done_display_text

	cmp	#TEXT2_FRAME
	bcs	check_cottage_text2

	;========================
	; display cottage text 1

	lda	#<cottage_text1
	sta	OUTL
	lda	#>cottage_text1
	jmp	common_cottage_text

check_cottage_text2:

	cmp	#TEXT3_FRAME
	bcs	check_cottage_text3		; bge

	lda	#<cottage_text2
	sta	OUTL
	lda	#>cottage_text2
	jmp	common_cottage_text

check_cottage_text3:
	lda	#<cottage_text3
	sta	OUTL
	lda	#>cottage_text3

common_cottage_text:
	sta	OUTH
	jsr	hgr_text_box
done_display_text:
	rts
