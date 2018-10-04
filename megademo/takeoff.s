; Rocket Takeoff

; Simple HGR/GR split


; STATE1 = RIDE IN ON BIRD
; STATE2 = OFF BIRD
; STATE3 = BIRD RUNS AWAY
; STATE4 = WALK INTO SHIP
; STATE5 = PAUSE
; STATE6 = SMOKE OUT BACK
; STATE7 = ROTATING FLAME SPRITES + TREES MOVING/SPEED UP
;          also horizon drop away?


	; 5 4 3 2 1 blastoff, another rocketship run
	; o/~ Take me to the moon o/~
rocket_takeoff:


	;===================
	; init screen
	bit	KEYRESET

setup_rocket:


	;===================
	; init vars

	lda	#0
	sta	DRAW_PAGE


	;=============================
	; Load graphic hgr

	lda	#<takeoff_hgr
	sta	LZ4_SRC
	lda	#>takeoff_hgr
	sta	LZ4_SRC+1

	lda	#<(takeoff_hgr_end-8)	; skip checksum at end
	sta	LZ4_END
	lda	#>(takeoff_hgr_end-8)	; skip checksum at end
	sta	LZ4_END+1

	lda	#<$2000
	sta	LZ4_DST
	lda	#>$2000
	sta	LZ4_DST+1
	sta	HGR_PAGE

	jsr	lz4_decode

	jsr	draw_stars

	;=============================
	; Load graphic page0

	lda	#$0c
	sta	BASH
	lda	#$00
	sta	BASL                    ; load image to $c00


	lda	#<takeoff
	sta	GBASL
	lda	#>takeoff
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
toloopA:ldx	#9							; 2
toloopB:dex								; 2
	bne	toloopB							; 2nt/3
	dey								; 2
	bne	toloopA							; 2nt/3

	jmp	to_begin_loop
.align  $100


	;================================================
	; Starring People Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	; want 12*4 = 48 lines of HIRES = 3120-4=3116
	; want 192-48=144 lines of LORES = 9360-4=9356



to_begin_loop:

	bit	HIRES			; 4

	; Try X=11 Y=51 cycles=3112 R4

	nop
	nop
	ldy	#51							; 2
toloop8:ldx	#11							; 2
toloop9:dex								; 2
	bne	toloop9							; 2nt/3
	dey								; 2
	bne	toloop8							; 2nt/3

	bit	LORES			; 4

	; Try X=10 Y=167 cycles=9353 R3

	lda	$0

	ldy	#167							; 2
toloop6:ldx	#10							; 2
toloop7:dex								; 2
	bne	toloop7							; 2nt/3
	dey								; 2
	bne	toloop6							; 2nt/3


	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================

	; do_nothing should be      4550
	;			     -10 keypress
	;			===========
	;			    4540

	; Try X=9 Y=89 cycles=4540

	ldy	#89							; 2
toloop1:ldx	#9							; 2
toloop2:dex								; 2
	bne	toloop2							; 2nt/3
	dey								; 2
	bne	toloop1							; 2nt/3

	lda	KEYPRESS				; 4
	bpl	to_no_keypress				; 3
	jmp	to_start_over
to_no_keypress:

	jmp	to_begin_loop				; 3

to_start_over:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6


.include "takeoff.inc"
takeoff_hgr:
.incbin "takeoff.img.lz4",11
takeoff_hgr_end:


