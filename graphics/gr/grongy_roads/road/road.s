	;=====================================
	; data frames for Grongy Road
	;=====================================
	; should probably be pure data
	; but have some code here too
	; this gets loaded at $2E00 for reasons


.include "../zp.inc"
.include "../hardware.inc"
.include "../qload.inc"
.include "../music.inc"
.include "../common_defines.inc"

	;=================================
	; Grongy Road
	;=================================

grongy_road:
	bit	KEYRESET	; just to be safe

	lda	#0		; reset count and file offsets
	sta	ROAD_COUNT
	sta	ROAD_FILE

	lda	#1		; decompress right away
	sta	START_DECOMPRESS

	lda	#5		; set initial IRQ countdown
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


	;=============================
	; Init Lo-res graphics
	;=============================

	bit	SET_GR
	bit	LORES
	bit	FULLGR
        bit	PAGE2		; DISPLAY PAGE2


	;==============================
	; decompress graphics (main)
	;==============================
decompress_loop:

	lda	START_DECOMPRESS
	beq	decompress_loop		; wait until IRQ sets this to 1

;	jsr	decompress_next


	;===============================
	; decompress next frame

decompress_next:
	ldy	ROAD_FILE		; get file to decompress
	lda	low_road,Y
        sta	zx_src_l+1
        lda	high_road,Y
        sta	zx_src_h+1

        lda	#$0e			; decompress 8k from $0E-$2E

        jsr	zx02_full_decomp_main

decompress_finished:

	inc	ROAD_FILE		; point to next file
	lda	ROAD_FILE
	cmp	#25			; if 25, then wrap back to 0
	bne	done_decompress_next

	lda	#0
	sta	ROAD_FILE

done_decompress_next:

	lda	#0			; turn off decompressing
	sta	START_DECOMPRESS

	beq	decompress_loop		; bra


;==================================
; lookup tables for frame offsets

high_road:
	.byte >road00_zx02,>road01_zx02,>road02_zx02,>road03_zx02
	.byte >road04_zx02,>road05_zx02,>road06_zx02,>road07_zx02
	.byte >road08_zx02,>road09_zx02,>road10_zx02,>road11_zx02
	.byte >road12_zx02,>road13_zx02,>road14_zx02,>road15_zx02
	.byte >road16_zx02,>road17_zx02,>road18_zx02,>road19_zx02
	.byte >road20_zx02,>road21_zx02,>road22_zx02,>road23_zx02
	.byte >road24_zx02

low_road:
	.byte <road00_zx02,<road01_zx02,<road02_zx02,<road03_zx02
	.byte <road04_zx02,<road05_zx02,<road06_zx02,<road07_zx02
	.byte <road08_zx02,<road09_zx02,<road10_zx02,<road11_zx02
	.byte <road12_zx02,<road13_zx02,<road14_zx02,<road15_zx02
	.byte <road16_zx02,<road17_zx02,<road18_zx02,<road19_zx02
	.byte <road20_zx02,<road21_zx02,<road22_zx02,<road23_zx02
	.byte <road24_zx02


road00_zx02:
	.incbin "../grongy/road000.zx02"
road01_zx02:
	.incbin "../grongy/road001.zx02"
road02_zx02:
	.incbin "../grongy/road002.zx02"
road03_zx02:
	.incbin "../grongy/road003.zx02"
road04_zx02:
	.incbin "../grongy/road004.zx02"
road05_zx02:
	.incbin "../grongy/road005.zx02"
road06_zx02:
	.incbin "../grongy/road006.zx02"
road07_zx02:
	.incbin "../grongy/road007.zx02"

road08_zx02:
	.incbin "../grongy/road008.zx02"
road09_zx02:
	.incbin "../grongy/road009.zx02"
road10_zx02:
	.incbin "../grongy/road010.zx02"
road11_zx02:
	.incbin "../grongy/road011.zx02"
road12_zx02:
	.incbin "../grongy/road012.zx02"
road13_zx02:
	.incbin "../grongy/road013.zx02"
road14_zx02:
	.incbin "../grongy/road014.zx02"
road15_zx02:
	.incbin "../grongy/road015.zx02"

road16_zx02:
	.incbin "../grongy/road016.zx02"
road17_zx02:
	.incbin "../grongy/road017.zx02"
road18_zx02:
	.incbin "../grongy/road018.zx02"
road19_zx02:
	.incbin "../grongy/road019.zx02"
road20_zx02:
	.incbin "../grongy/road020.zx02"

; these live in "MUSIC" for space reasons

;road21_zx02:
;	.incbin "../grongy/road021.zx02"
;road22_zx02:
;	.incbin "../grongy/road022.zx02"
;road23_zx02:
;	.incbin "../grongy/road023.zx02"

;road24_zx02:
;	.incbin "../grongy/road024.zx02"



