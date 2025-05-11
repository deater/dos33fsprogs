.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"

	;=================================
	; Grongy Road
	;=================================

dancing:
	bit	KEYRESET	; just to be safe

	lda	#0
	sta	ROAD_COUNT
	sta	ROAD_FILE

	;============================
	; clear both lo-res screens
	;============================

	lda	#0
	sta	clear_all_color+1

	lda	#4
	sta	DRAW_PAGE	; DRAW PAGE1
	jsr	clear_all

	lda	#0
	sta	DRAW_PAGE	; DRAW PAGE1
	jsr	clear_all


	;=============================
	; Init Lo-res graphics
	;=============================

	bit	SET_GR
	bit	LORES
	bit	FULLGR
        bit	PAGE2		; DISPLAY PAGE2

	;==============================
	; reset road
	;==============================
reset_road:
	lda	#0
	sta	ROAD_FILE

	;==============================
	; decompress graphics (main)
	;==============================
decompress_loop:
	ldy	ROAD_FILE
	lda	low_road,Y
        sta	zx_src_l+1
        lda	high_road,Y
        sta	zx_src_h+1

        lda	#$D0

        jsr	zx02_full_decomp_main


	;==============================
	; animate loop
	;==============================

animate_loop:

	;================================
	; start 5-tick (10Hz) countdown

	lda	#5
	sta	IRQ_COUNTDOWN

	;================================
	; copy in MAIN graphics

	ldy	ROAD_COUNT
	ldx	animation_main,Y
	jsr	copy_to_400_main


	;============================
	; wait until 5 frames are up

wait_10hz:
	jsr	check_timeout
	bcc	wait_10hz

	jsr	wait_vblank

	;============================
	; page flip

	jsr	gr_flip_page

	;==============================
	; move to next animation frame


	inc	ROAD_COUNT
	lda	ROAD_COUNT
	cmp	#8
	bne	animate_loop

	lda	#0
	sta	ROAD_COUNT

	inc	ROAD_FILE
	lda	ROAD_FILE
	cmp	#4
	beq	reset_road
	bne	decompress_loop

	rts

animation_main:
;	.byte $40,$44,$48,$4c,$50,$54,$58,$5c		; plain
	.byte $d0,$d4,$d8,$dc,$e0,$e4,$e8,$ec		; plain

high_road:
	.byte >road00_zx02,>road01_zx02,>road02_zx02,>road03_zx02

low_road:
	.byte <road00_zx02,<road01_zx02,<road02_zx02,<road03_zx02


road00_zx02:
	.incbin "../grongy/road000.zx02"
road01_zx02:
	.incbin "../grongy/road001.zx02"
road02_zx02:
	.incbin "../grongy/road002.zx02"
road03_zx02:
	.incbin "../grongy/road003.zx02"

