; Ootw Rope course

ootw_rope:
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
	; Setup right/left exit paramaters

	lda	#37
	sta	RIGHT_LIMIT
	lda	#11
	sta	LEFT_LIMIT


	;=============================
	; Load background to $c00

	lda	BEFORE_SWING
	beq	after_swing_bg

before_swing_bg:
	lda     #>(rope_rle)
        sta     GBASH
	lda     #<(rope_rle)
        sta     GBASL
	jmp	load_swing_bg

after_swing_bg:
	lda     #>(broke_rope_rle)
        sta     GBASH
	lda     #<(broke_rope_rle)
        sta     GBASL

load_swing_bg:
	lda	#$c			; load image off-screen $c00
	jsr	load_rle_gr

	;================================
	; Load quake background to $1000

	jsr	gr_make_quake

	;=================================
	; copy $c00 to both pages $400/$800

	jsr	gr_copy_to_current
	jsr	page_flip

	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER

	;============================
	; Rope Loop
	;============================
rope_loop:

	;================================
	; handle earthquakes

	jsr	earthquake_handler


	;===============================
	; check keyboard

	jsr	handle_keypress

	;===============================
	; check screen limits

	jsr	check_screen_limit


	;===============
	; draw physicist

	; adjust y for slope

	lda	PHYSICIST_X
	cmp	#26
	bcs	phys_no_adjust_y	; blt

	cmp	#17
	bcc	phys_on_platform

;	lda	PHYSICIST_X
	sec
	sbc	#3
	and	#$fe			; our sprite code only draws even y

	jmp	phys_done_adjust_y
				; slope is 15 - 26 ( 28 - 36)
				; 26 -> 22

phys_on_platform:
	lda	#14
	bne	phys_done_adjust_y

phys_no_adjust_y:
	lda	#22
phys_done_adjust_y:
	sta	PHYSICIST_Y

	jsr	draw_physicist


	;======================
	; draw foreground plant

	lda	#<foreground_spikes
	sta	INL
	lda	#>foreground_spikes
	sta	INH

        lda     #30
        sta     XPOS
        lda     #30
	sec
	sbc	EARTH_OFFSET
        sta     YPOS

	jsr	put_sprite

	;================
	; draw falling boulder

	jsr	draw_boulder


	;===============
	; page flip

	jsr	page_flip

	;================
	; inc frame count

	inc	FRAMEL
	bne	rope_frame_no_oflo
	inc	FRAMEH

rope_frame_no_oflo:

	; pause?

	; check if done this level

	lda	GAME_OVER
	cmp	#$ff
	beq	done_rope

	; check if done this level
	cmp	#$2
	bne	check_cliff_edge

	lda	#0
	sta	PHYSICIST_X
	sta	EARTH_OFFSET

	jmp	ootw_pool


	; at edge of cliff
check_cliff_edge:
	cmp	#$1
	bne	not_done_rope

	lda	#0
	sta	GAME_OVER

	;===================
	; at cliff's edge

;	lda	#0
;	sta	BEFORE_SWING

	lda	#11
	sta	PHYSICIST_X

not_done_rope:
	; loop forever

	jmp	rope_loop

done_rope:
	rts
