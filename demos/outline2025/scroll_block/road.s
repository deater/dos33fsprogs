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

	lda	#0		; reset count and file offsets
	sta	ROAD_COUNT
	sta	ROAD_FILE
	sta	ROAD_FILE_DECOMPRESSING

	sta	START_DECOMPRESS	; start already decompressed

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


	;===============================
	; decompress initial graphics

	jsr	decompress_next


	cli			; start music

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

        lda	#$0e			; decompress 8k from $0E-$2E

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




