; Rocket Takeoff

; Simple HGR/GR split


; STATE0 = RIDE IN ON BIRD
; STATE2 = BIRD RUNS / WALK INTO SHIP
; STATE4 = PAUSE / SMOKE OUT BACK
; STATE6 = ROTATING / FLAME SPRITES + TREES MOVING/SPEED UP
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
	sta	FRAME
	sta	FRAMEH
	sta	STATE
	lda	#1
	sta	XPOS

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
	; Takeoff Loop
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



	;===========================
	; Draw Lores bottom
	; 144 * 65 = 9360
	;	       -4 swith to LORES
	;====================
	;	     9356


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
	;			     -23 state jump
	;			     -23 wrap counter
	;			      -7 timeout
	;			   -3602 state
	;			     -10 keypress
	;			===========
	;			     885


	;================
	; wrap counter
	;================
	; nowrap = 13+10=23
	;   wrap = 13+10=23
	inc	FRAME							; 5
	lda	FRAME							; 3
	cmp	#8	; 7.5 Hz						; 2
	beq	to_wrap							; 3
to_nowrap:
									;-1
	lda	$0			; nop				; 3
	lda	$0			; nop				; 3
	nop								; 2
	jmp	to_wrap_done						; 3
to_wrap:
	lda	#0							; 2
	sta	FRAME							; 3
	inc	FRAMEH							; 5
to_wrap_done:


	;==============
	; timeout after 5s or so?
	;==============
	; 7 cycles
to_timeout:
	lda	FRAMEH							; 3
	cmp	#80							; 2
	beq	to_exit							; 3
									; -1


	; Try X=43 Y=4 cycles=885
	; Try X=88 Y=2 cycles=893 R5

	ldy	#4							; 2
toloop1:ldx	#43							; 2
toloop2:dex								; 2
	bne	toloop2							; 2nt/3
	dey								; 2
	bne	toloop1							; 2nt/3

	; Set up jump table that runs same speed on 6502 and 65c02
	ldy     STATE						; 3
	lda	to_jump_table+1,y				; 4
	pha							; 3
	lda	to_jump_table,y					; 4
	pha							; 3
	rts							; 6
                                                        ;=============
                                                        ;        23

to_done_state:


	lda	KEYPRESS				; 4
	bpl	to_no_keypress				; 3
	jmp	to_exit
to_no_keypress:

	jmp	to_begin_loop				; 3

to_exit:
	bit	KEYRESET	; clear keypress	; 4
	rts						; 6


;.include "takeoff.inc"
;takeoff_hgr:
;.incbin "takeoff.img.lz4",11
;takeoff_hgr_end:

to_jump_table:
	.word   (to_state0-1)
	.word   (to_state2-1)
	.word   (to_state0-1)
	.word   (to_state0-1)


;.align	$100

	;============================
	; state0: Draw+move Bird+Rider
	;============================
	; 13 + 2208 + 762 + 578 + 13 + 25 + 3 = 3602
to_state0:

	jsr	gr_copy_row22				; 6+572

	; INC XPOS, 13 cycles
	lda	FRAME					; 3
	bne	to_xpos_no_inc				; 3
to_xpos_inc:						;-1
	inc	XPOS					; 5
	jmp	to_xpos_done				; 7
to_xpos_no_inc:
	lda	$0					; 3
	nop						; 2
	nop						; 2
to_xpos_done:


	lda     #22					; 2
	sta	YPOS					; 3

	lda	FRAMEH					; 3
	and	#$1					; 2
	beq	to_bwalk				; 3
						;===========
						;        13


to_bstand:
	; draw bird/rider standing                              ; -1
	lda	#>bird_rider_stand_right                ; 2
	sta	INH                                     ; 3
	lda	#<bird_rider_stand_right                ; 2
	sta	INL                                     ; 3
	jsr	put_sprite                              ; 6

	jmp	to_done_bwalk                           ; 3
                                                        ;=========
                                                        ; 18 + 2190 = 2208


to_bwalk:
	; draw bird/rider walking
	lda     #>bird_rider_walk_right			; 2
	sta     INH					; 3
	lda     #<bird_rider_walk_right			; 2
	sta     INL					; 3
	jsr     put_sprite				; 6

	nop						; 2
	lda	$0
	lda	$0
	lda	$0
	nop
	nop
	nop
	                                                ;=========
                                                        ; 33 + 2175 = 2208

to_done_bwalk:
	lda	$0
	nop
;	inc	XPOS					; 5
	lda	XPOS					; 3
	cmp	#21					; 2
	bne	to_keep_state				; 3

							; -1
	inc	STATE					; 5
	inc	STATE					; 5
	jmp	to_done_keep_state			; 3
							;========
							; 12
to_keep_state:
	lda	$0
	lda	$0
	lda	$0
	lda	$0


to_done_keep_state:

        ; delay

	; Try X=151 Y=1 cycles=762

        ldy	#1							; 2
toloopV:ldx	#151							; 2
toloopW:dex                                                             ; 2
        bne	toloopW                                                 ; 2nt/3
        dey                                                             ; 2
        bne	toloopV                                                 ; 2nt/3

	jmp	to_done_state						; 3



	;============================
	; state2: Do nothing
	;============================
	; 3599 + 3 = 3602
to_state2:

        ; delay

	; Try X=5 Y=116 cycles=3597 R2

	nop

	ldy	#116							; 2
toloopZ:ldx	#5							; 2
toloopY:dex                                                             ; 2
	bne	toloopY                                                 ; 2nt/3
	dey                                                             ; 2
	bne	toloopZ							; 2nt/3

	jmp	to_done_state						; 3




