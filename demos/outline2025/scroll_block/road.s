	;=====================================
	; data frames for Grongy Road
	;=====================================
	; should probably be pure data
	; but have some code here too
	; this gets loaded at $2E00 for reasons


.include "zp.inc"
.include "hardware.inc"
.include "qload.inc"
.include "music.inc"
.include "common_defines.inc"

	;=================================
	; Grongy Road
	;=================================

grongy_road:
	bit	KEYRESET	; just to be safe

	;=========================
	; clear screen
	;=========================

	jsr	hgr_clear_slow

	bit	SET_GR
	bit	HIRES
	bit	FULLGR
        bit	PAGE1

	;=========================
	; start music
	;=========================

	lda	#0
	sta	START_ANIMATION

	cli			; start music

	;=================================
	; Display Title
	;=================================

	lda	#<title_graphic
        sta	zx_src_l+1
        lda	#>title_graphic
        sta	zx_src_h+1

	lda	#$A0			; decompress to $A000

        jsr	zx02_full_decomp_main

	;================================
	; wipe to hires page 1
	;================================

	jsr	wipe_diamond


	;========================================
	; wait a bit (pattern 4)
	;========================================
	lda	#$4
wait_for_pattern4:
	cmp	current_pattern_smc+1
	bne	wait_for_pattern4

	jsr	pinch_title


	;========================================
	; wait here until music slows (pattern 7)
	;========================================

	; either pattern 7 (when it slows) or 8 (when speeds up)

	lda	#$7
wait_for_pattern2:
	cmp	current_pattern_smc+1
	bne	wait_for_pattern2

	jsr	wipe_lr



	;=================================
	; Prepare Animation
	;=================================


	lda	#0		; reset count and file offsets
	sta	ROAD_COUNT
	sta	ROAD_FILE
	sta	ROAD_FILE_DECOMPRESSING

	sta	START_DECOMPRESS	; start already decompressed

	lda	#FRAME_DELAY		; set initial IRQ countdown
	sta	IRQ_COUNTDOWN

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



	;========================================================
	; wait here until just before music speeds up (pattern 8)
	;========================================================

	lda	#$8
wait_for_pattern3:
	cmp	current_pattern_smc+1
	bne	wait_for_pattern3


	;=============================
	; Init Lo-res graphics
	;=============================

	bit	SET_GR
	bit	LORES
	bit	FULLGR
        bit	PAGE2		; DISPLAY PAGE2


	;===============================
	; decompress initial graphics

	jsr	decompress_next


	lda	#1
	sta	START_ANIMATION

	;==============================
	; decompress graphics (main)
	;==============================
decompress_loop:

	lda	START_DECOMPRESS
	beq	decompress_loop		; wait until IRQ sets this to 1

	;===============================
	; decompress next frame

	jsr	decompress_next



	lda	#0			; turn off decompressing
	sta	START_DECOMPRESS

	beq	decompress_loop		; bra







	;===========================================
	;===========================================
	; common routine to decompress next chunk
	;===========================================
	;===========================================

decompress_next:
	ldy	ROAD_FILE_DECOMPRESSING		; get file to decompress
	lda	low_road,Y
	sta	zx_src_l+1
	lda	high_road,Y
	sta	zx_src_h+1

	lda	#$20			; decompress 8k t0  $20-$3F

	jsr	zx02_full_decomp_main

decompress_finished:

	inc	ROAD_FILE_DECOMPRESSING		; point to next file
	lda	ROAD_FILE_DECOMPRESSING
	cmp	#12			; if 12, then wrap back to 0
	bne	done_decompress_next

	lda	#0
	sta	ROAD_FILE_DECOMPRESSING

done_decompress_next:

	rts


;==================================
; lookup tables for frame offsets

high_road:
	.byte >road00_zx02,>road01_zx02,>road02_zx02,>road03_zx02
	.byte >road04_zx02,>road05_zx02,>road06_zx02,>road07_zx02
	.byte >road08_zx02,>road09_zx02,>road10_zx02,>road11_zx02
;	.byte >road12_zx02

low_road:
	.byte <road00_zx02,<road01_zx02,<road02_zx02,<road03_zx02
	.byte <road04_zx02,<road05_zx02,<road06_zx02,<road07_zx02
	.byte <road08_zx02,<road09_zx02,<road10_zx02,<road11_zx02
;	.byte <road12_zx02



.include "hgr_clear_slow.s"

road00_zx02:
	.incbin "grongy/sroad000.zx02"
road01_zx02:
	.incbin "grongy/sroad001.zx02"
road02_zx02:
	.incbin "grongy/sroad002.zx02"
road03_zx02:
	.incbin "grongy/sroad003.zx02"
road04_zx02:
	.incbin "grongy/sroad004.zx02"
road05_zx02:
	.incbin "grongy/sroad005.zx02"
road06_zx02:
	.incbin "grongy/sroad006.zx02"
road07_zx02:
	.incbin "grongy/sroad007.zx02"

road08_zx02:
	.incbin "grongy/sroad008.zx02"
road09_zx02:
	.incbin "grongy/sroad009.zx02"
road10_zx02:
	.incbin "grongy/sroad010.zx02"
road11_zx02:
	.incbin "grongy/sroad011.zx02"
;road12_zx02:
;	.incbin "grongy/sroad012.zx02"

;title_graphic:
;	.incbin "graphics/title1.hgr.zx02"


.include "wipes.s"
