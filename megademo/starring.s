; Display Starring Message

; 1st screen = triple page flip
; 2nd/3rd = split  low/hires


starring:

	;===================
	; init screen
	jsr	TEXT
	jsr	HOME
	bit	KEYRESET

	;===================
	; init vars

	lda	#0
	sta	FRAME
	sta	DRAW_PAGE

	;=============================
	; Load graphic hgr

	lda	#<starring3
	sta	LZ4_SRC
	lda	#>starring3
	sta	LZ4_SRC+1

	lda	#<(starring3_end-8)		; skip checksum at end
	sta	LZ4_END
	lda	#>(starring3_end-8)		; skip checksum at end
	sta	LZ4_END+1

	lda	#<$2000
	sta	LZ4_DST
	lda	#>$2000
	sta	LZ4_DST+1

	jsr	lz4_decode


	;=============================
	; Load graphic page0

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00


	lda	#<starring1
	sta	GBASL
	lda	#>starring1
	sta	GBASH
	jsr	load_rle_gr

	lda	#4
	sta	DRAW_PAGE

	jsr	gr_copy_to_current	; copy to page1

	; GR part
	bit	PAGE1
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	;=============================
	; Load graphic page1

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00

	lda	#<starring2
	sta	GBASL
	lda	#>starring2
	sta	GBASH
	jsr	load_rle_gr

	lda	#0
	sta	DRAW_PAGE

	jsr	gr_copy_to_current

	; GR part
	bit	PAGE0


	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

	jsr	gr_copy_to_current		; 6+ 9292

	; now we have 322 left

	; GR part
	bit	LORES							; 4
	bit	SET_GR							; 4
	bit	FULLGR							; 4

	; 322 - 12 = 310
	; - 3 for jmp
	; 307

	; Try X=9 Y=6 cycles=307

        ldy	#6							; 2
stloopA:ldx	#9							; 2
stloopB:dex								; 2
	bne	stloopB							; 2nt/3
	dey								; 2
	bne	stloopA							; 2nt/3

	jmp	st_display_loop
.align  $100

	;================================================
	; Starring Loop
	;================================================
	; just kill time, 65*192 = 12480

st_display_loop:

	; Try X=15 Y=154 cycles=12475 R5

	nop								; 2
	lda	$0							; 3

	ldy	#154							; 2
suloop1:ldx	#15							; 2
suloop2:dex								; 2
	bne	suloop2							; 2nt/3
	dey								; 2
	bne	suloop1							; 2nt/3

	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================


	; we want to flip between GR Page0, GR Page1, HGR Page0
	; we want to flip at roughly 3Hz, so every 20 times through
	; what if 16, for power-of-two easiness?  3.75Hz?

	; FRAME== 0 GR/PAGE0
	; FRAME==20 GR/PAGE1
	; FRAME==40 HGR/PAGE0
	; FRAME==60 reset

	; default = 13+5+5+7  = 30
	; sixty   = 13+17     = 30
	; forty   = 13+5+12   = 30
	; twenty  = 13+5+5+7  = 30


	inc	FRAME							; 5
	lda	FRAME							; 3
	cmp	#60							; 2
	bne	st_not_sixty						; 3
								;===========
								;        13

st_sixty:								; -1
	lda	#0			; wrap frame counter		; 2
	sta	FRAME							; 3

	bit	LORES							; 4
	bit	PAGE0							; 4
	nop								; 2
	jmp	done_st_vblank						; 3
								;===========
								;	 17

st_not_sixty:
	cmp	#20							; 2
	bne	st_not_twenty						; 3
								;============
								;         5

st_twenty:								; -1
	bit	LORES							; 4
	nop								; 2
st_seven_cycles:
	bit	PAGE1	; 2C 55 C0, 55C0 = EOR $20,X (4 cyc)		; 4
	jmp	done_st_vblank						; 3
								;============
								;	 12

st_not_twenty:
	cmp	#40							; 2
	bne	st_seven_cycles+1					; 3
								;============
								;         5

st_forty:								; -1
	bit	HIRES							; 4
	bit	PAGE0							; 4

								;============
								;	 7
done_st_vblank:

	; do_nothing should be      4550
	;			     -10 keypress
	;			     -30 page flipping
	;			===========
	;			    4407

	; Try X=99 Y=9 cycles=4510

	ldy	#9							; 2
stloop1:ldx	#99							; 2
stloop2:dex								; 2
	bne	stloop2							; 2nt/3
	dey								; 2
	bne	stloop1							; 2nt/3

	lda	KEYPRESS				; 4
	bpl	st_no_keypress				; 3

	jmp	st_start_over
st_no_keypress:

	jmp	st_display_loop				; 3

st_start_over:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6

.include "starring1.inc"
.include "starring2.inc"

starring3:
.incbin	"starring3.img.lz4",11
starring3_end:
