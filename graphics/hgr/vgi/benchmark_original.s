; VGI Benchmark test of Original (SLOW and small) routines

.include "zp.inc"
.include "hardware.inc"


vgi_benchmark_original:
	jsr	SETGR
	jsr	HGR
	bit	FULLGR

	jsr	vgi_make_tables

	; get pointer to image data

clock:
	lda	#<clock_data
	sta	VGIL
	lda	#>clock_data
	sta	VGIH

	jsr	play_vgi

;	jsr	wait_until_keypress

rocket:
	; Rocket

	lda	#<rocket_data
	sta	VGIL
	lda	#>rocket_data
	sta	VGIH

	jsr	play_vgi

;	jsr	wait_until_keypress

rocket_door:

	; Rocket Door

	lda	#<rocket_door_data
	sta	VGIL
	lda	#>rocket_door_data
	sta	VGIH

	jsr	play_vgi

;	jsr	wait_until_keypress

red_book:

	; Red Book

	lda	#<red_book_data
	sta	VGIL
	lda	#>red_book_data
	sta	VGIH

	jsr	play_vgi

;	jsr	wait_until_keypress

fireplace:
	;==========================
	; Fireplace

	lda	#<fireplace_data
	sta	VGIL
	lda	#>fireplace_data
	sta	VGIH

	jsr	play_vgi

;	jsr	wait_until_keypress

done:
	jmp	done

.include "./vgi_original/vgi_common.s"

.include "clock.data"
.include "rocket.data"
.include "rocket_door.data"
.include "red_book.data"
.include "fireplace.data"
.include "path.data"


wait_until_keypress:
	lda	KEYPRESS
	bpl	wait_until_keypress

	bit	KEYRESET

	rts
