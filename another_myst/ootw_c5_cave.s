; Ootw Checkpoint5 -- Running around the Caves


	; call once before entering cave for first time
ootw_cave_init:
	lda	#0
	sta	WHICH_CAVE
	sta	BLASTED_WALL
	; yes you fall in facing left for some reason
	sta	DIRECTION		; left
	sta	NUM_DOORS

	lda	#1
	sta	HAVE_GUN

	lda	#0
	sta	PHYSICIST_X
	lda	#24
	sta	PHYSICIST_Y

	;====================
        ; reset doors
        lda     #DOOR_STATUS_CLOSED
        sta     c4_r0_door0_status


	rts


	;===========================
	; enter new room in cave
	;===========================

ootw_cave:

	;==============================
	; each room init


	;==============================
	; setup per-room variables

	lda	WHICH_CAVE
	bne	cave1

	jsr	init_shields

	; Room0 entrance
cave0:
	lda	#(0+128)
	sta	LEFT_LIMIT
	lda	#(39+128)
	sta	RIGHT_LIMIT

	; set right exit
	lda     #$ff
	sta     cer_smc+1

	; set left exit
	lda     #0
	sta     cel_smc+1

; set up doors

        lda     #1
        sta     NUM_DOORS

        lda     #<door_c4_r0
        sta     setup_door_table_loop_smc+1
        lda     #>door_c4_r0
        sta     setup_door_table_loop_smc+2
        jsr     setup_door_table

not_falling_in:
	lda	#24
	sta	PHYSICIST_Y

	; load background
	lda	#>(temple_center_w_rle)
	sta	GBASH
	lda	#<(temple_center_w_rle)
	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call

	;=====================
	; setup walk collision
	jsr	recalc_walk_collision


cave1:

ootw_cave_already_set:
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
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER

	;============================
	;============================
	; Cave Loop
	;============================
	;============================
cave_loop:

	;================================
	; copy background to current page

	jsr	gr_copy_to_current

	;==================================
	; draw background action

	lda	WHICH_CAVE

bg_cave0:


c5_no_bg_action:

	;============================
	; switch bg if exploded

	lda	BLASTED_WALL
	cmp	#1
	bne	wall_good

	; load background
	lda	#>(temple_center_ex_rle)
	sta	GBASH
	lda	#<(temple_center_ex_rle)
	sta	GBASL
	lda	#$c				; load to page $c00
	jsr	load_rle_gr			; tail call

	inc	BLASTED_WALL
wall_good:

	;===============================
	; check keyboard

	jsr	handle_keypress

	;===============================
	; move physicist
	;===============================

	jsr	move_physicist

	;===============
	; check room limits

	jsr	check_screen_limit

	;=================
	; adjust floor


check_floor0_done:

check_floor1:


	;===============
	; draw physicist

	jsr	draw_physicist


	;===============
	; handle gun

	jsr	handle_gun


	;===============
	; handle doors

	jsr	handle_doors

	;=========
;	jsr	draw_doors

	;========================
	; draw foreground action

c5_no_fg_action:



	;================
	; move fg objects
	;================



	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	cave_frame_no_oflo
	inc	FRAMEH
cave_frame_no_oflo:

	;==========================
	; check if done this level
	;==========================

	lda	GAME_OVER
	beq	still_in_cave

	cmp	#$ff			; if $ff, we died
	beq	done_cave

	;===============================
	; check if exited room to right
	cmp	#1
	beq	cave_exit_left

	;=================
	; exit to right

cave_right_yes_exit:

	lda	#0
	sta	PHYSICIST_X
cer_smc:
	lda	#$0			; smc+1 = exit location
	sta	WHICH_CAVE
	jmp	done_cave

	;=====================
	; exit to left

cave_exit_left:

	lda	#37
	sta	PHYSICIST_X
cel_smc:
	lda	#0		; smc+1
	sta	WHICH_CAVE
	jmp	done_cave

	; loop forever
still_in_cave:
	lda	#0
	sta	GAME_OVER

	jmp	cave_loop

done_cave:
	rts


door_c4_r0:
        .word door_c4_r0_status
        .word door_c4_r0_x
        .word door_c4_r0_y
        .word door_c4_r0_xmin
        .word door_c4_r0_xmax

door_c4_r0_status:
        c4_r0_door0_status:     .byte DOOR_STATUS_CLOSED

door_c4_r0_x:
        c4_r0_door0_x:  .byte 19

door_c4_r0_y:
        c4_r0_door0_y:  .byte 20

door_c4_r0_xmin:
        c4_r0_door0_xmin:       .byte 11        ; 7-4-5

door_c4_r0_xmax:
        c4_r0_door0_xmax:       .byte 24        ; 7+4


