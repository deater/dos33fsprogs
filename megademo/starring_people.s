; Display Starring w People

; 2nd/3rd = split  low/hires w tengwar wipe at bottom


starring_people:


	;===================
	; init screen
	bit	KEYRESET

	;===================
	; copy to page3

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
sploopA:ldx	#9							; 2
sploopB:dex								; 2
	bne	sploopB							; 2nt/3
	dey								; 2
	bne	sploopA							; 2nt/3

	jmp	sp_begin_loop
.align  $100


	;================================================
	; Starring People Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; G00000000000000000000 H0000000000000000000000


sp_begin_loop:

sp_display_loop:

	ldy	#148
sp_outer_loop:

	bit	LORES			; 4
	lda	#7			; 2
	jsr	delay_a			; 25+7 = 32
					;===========
					; 38

	bit	HIRES			; 4
	nop				; 2
	nop				; 2
	nop				; 2
	lda	$0			; 3
	lda	$0			; 3
	lda	$0			; 3
	lda	$0			; 3
					;============
					; 22


	dey							; 2
	bne	sp_outer_loop					; 3
								; -1


	bit	LORES			; 4


	; want to kill 44*65 -3 = 2857

	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================

	; do_nothing should be      4550
	;			   +2857 fallthrough from above
	;			     -10 keypress
	;			      -2 ldy at top
	;			===========
	;			    7395

	; Try X=18 Y=77 cycles=7393 R2

	nop

	ldy	#77							; 2
sploop1:ldx	#18							; 2
sploop2:dex								; 2
	bne	sploop2							; 2nt/3
	dey								; 2
	bne	sploop1							; 2nt/3

	lda	KEYPRESS				; 4
	bpl	sp_no_keypress				; 3
	jmp	sp_start_over
sp_no_keypress:

	jmp	sp_display_loop				; 3

sp_start_over:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6




setup_people_fs:


	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE


	;=============================
	; Load graphic hgr

	lda	#<fs_hgr
	sta	LZ4_SRC
	lda	#>fs_hgr
	sta	LZ4_SRC+1

	lda	#<(fs_hgr_end-8)	; skip checksum at end
	sta	LZ4_END
	lda	#>(fs_hgr_end-8)	; skip checksum at end
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


	lda	#<fs
	sta	GBASL
	lda	#>fs
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

	lda	#<fs
	sta	GBASL
	lda	#>fs
	sta	GBASH
	jsr	load_rle_gr

	rts

setup_people_deater:


	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE


	;=============================
	; Load graphic hgr

	lda	#<deater_hgr
	sta	LZ4_SRC
	lda	#>deater_hgr
	sta	LZ4_SRC+1

	lda	#<(deater_hgr_end-8)	; skip checksum at end
	sta	LZ4_END
	lda	#>(deater_hgr_end-8)	; skip checksum at end
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


	lda	#<deater
	sta	GBASL
	lda	#>deater
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

	lda	#<deater
	sta	GBASL
	lda	#>deater
	sta	GBASH
	jsr	load_rle_gr

	rts







;.include "fs.inc"
;.include "deater.inc"
;fs_hgr:
;.incbin "FS_HGRC.BIN.lz4",11
;fs_hgr_end:
;deater_hgr:
;.incbin "DEATER_HGRC.BIN.lz4",11
;deater_hgr_end:

