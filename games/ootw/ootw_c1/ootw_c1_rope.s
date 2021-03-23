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

	lda	#(39+128)
	sta	RIGHT_LIMIT
	sta	RIGHT_WALK_LIMIT
	lda	#(11+128)
	sta	LEFT_LIMIT
	sta	LEFT_WALK_LIMIT

	lda	#0
	sta	SWING_PROGRESS


	;=============================
	; Load background to $c00

	lda	BEFORE_SWING
	beq	after_swing_bg

before_swing_bg:
	lda     #<(rope_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda     #>(rope_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI
	jmp	load_swing_bg

after_swing_bg:
	lda     #<(broke_rope_lzsa)
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda     #>(broke_rope_lzsa)
	sta	getsrc_smc+2    ; LZSA_SRC_HI

load_swing_bg:
	lda	#$c			; load image off-screen $c00
	jsr	decompress_lzsa2_fast

	;================================
	; Load quake background to $BC00

	jsr	gr_make_quake

	;=================================
	; copy $c00 to both pages $400/$800

;	jsr	gr_copy_to_current
;	jsr	page_flip

	;=================================
	; setup vars

	lda	#0
	sta	GAIT
	sta	GAME_OVER

	lda	#3
	sta	WHICH_CAVE

	jsr	setup_beast

	;============================
	;============================
	; Rope Loop
	;============================
	;============================
rope_loop:

	;============================
	; Check if swinging
	;============================

	lda	SWING_PROGRESS
	beq	no_swing


	cmp	#80			; only load background on first frame
	bne	swing_not_first

	lda     #<no_rope_lzsa
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>no_rope_lzsa
	sta	getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$C			; load image off-screen $C00
	jsr	decompress_lzsa2_fast

swing_not_first:
	dec	SWING_PROGRESS
	dec	SWING_PROGRESS

	ldx	SWING_PROGRESS
	lda     swing_progression,X
	sta	getsrc_smc+1    ; LZSA_SRC_LO
	lda     swing_progression+1,X
	sta	getsrc_smc+2    ; LZSA_SRC_HI
	lda	#$10			; load image off-screen $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay_40x40


; FIXME
;	jsr	gr_make_quake		; make quake

	jmp	beyond_quake

no_swing:

	;================================
	; handle earthquakes

	jsr	earthquake_handler

beyond_quake:

	;===============================
	; check keyboard

	jsr	handle_keypress

	;===============================
	; move physicist

	jsr	move_physicist

	;===============================
	; check screen limits

	jsr	check_screen_limit


	;================
	; handle beast

	lda	BEAST_OUT
	beq	rope_no_beast

	;================
	; move beast

	jsr	move_beast

	;================
	; draw beast


	; adjust y for slope

	; shift by 2 from physicist as beast is 9 wide (vs 5)

	lda	BEAST_X
	cmp	#24
	bcs	beast_no_adjust_y	; bge

	cmp	#15
	bcc	beast_on_platform	; blt

	clc
	adc	#1
	and	#$fe			; our sprite code only draws even y

	jmp	beast_done_adjust_y
				; 16 maps to -> 16
				; 24 maps to -> 24

beast_on_platform:
	lda	#16
	bne	beast_done_adjust_y

beast_no_adjust_y:
	lda	#24
beast_done_adjust_y:
	sta	BEAST_Y


	jsr	draw_beast

rope_no_beast:


	;===============================
	; check if swinging off

	lda	PHYSICIST_STATE
	cmp	#P_SWINGING
	bne	done_swing_check

	lda	SWING_PROGRESS
	bne	done_swing_check

	; swung off screen!

	lda	#5
	sta	GAME_OVER



done_swing_check:
	;===============
	; draw physicist

	; adjust y for slope

	lda	PHYSICIST_X
	cmp	#26
	bcs	phys_no_adjust_y	; bge

	cmp	#17
	bcc	phys_on_platform

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


	lda	PHYSICIST_STATE
	cmp	#P_SWINGING
	beq	hes_swinging

	jsr	draw_physicist
hes_swinging:

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


	;===================
	; check cliff's edge

	lda	PHYSICIST_X
	cmp	#11
	bcs	already_swung

	lda	BEFORE_SWING
	beq	already_swung

	lda	#0
	sta	BEFORE_SWING

	; FIXME: check for jump

	lda	#80
	sta	SWING_PROGRESS

	lda	#11
	sta	PHYSICIST_X

	lda	#P_SWINGING
	sta	PHYSICIST_STATE

	jmp	not_done_rope

already_swung:


	;=========================
	; check if done this room
	;=========================


	; handle game over

	lda	GAME_OVER
	cmp	#$ff
	beq	done_rope

	; if 2 then exiting right, to pool
	cmp	#$2
	bne	check_cliff_edge

	lda	#0
	sta	PHYSICIST_X
	sta	EARTH_OFFSET

	jmp	ootw_pool


	; if 1 then at edge of cliff
check_cliff_edge:
	cmp	#$1
	bne	check_swung_off

	lda	#0
	sta	GAME_OVER


check_swung_off:
	cmp	#$5
	bne	not_done_rope


	;==========================
	; swung off screen to right

	lda	#1
	sta	PHYSICIST_X
	sta	EARTH_OFFSET
	sta	DIRECTION		; face right
	sta	BEAST_DIRECTION
	lda	#10
	sta	PHYSICIST_Y
	lda	#P_FALLING_SIDEWAYS
	sta	PHYSICIST_STATE

	jmp	ootw_pool


not_done_rope:
	; loop forever

	jmp	rope_loop

done_rope:
	rts





swing_progression:
.word	swing25_lzsa
.word	swing24_lzsa
.word	swing23_lzsa
.word	swing22_lzsa
.word	swing21_lzsa
.word	swing20_lzsa
.word	swing19_lzsa
.word	swing18_lzsa
.word	swing17_lzsa
.word	swing16_lzsa
.word	swing15_lzsa
.word	swing14_lzsa
.word	swing13_lzsa
.word	swing12_lzsa
.word	swing11_lzsa
.word	swing10_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing08_lzsa
.word	swing06_lzsa
.word	swing05_lzsa
.word	swing04_lzsa
.word	swing03_lzsa
.word	swing02_lzsa
.word	swing01_lzsa

