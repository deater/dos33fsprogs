;
;	Ride the bird past the mountain
;		by Vince Weaver
;


	TREE1X	= $E1
	TREE2X	= $E2

bird_mountain:

	;===================
	; init screen

	jsr	TEXT
	jsr	HOME

	;==================
	; Init vars

	lda	#28
	sta	TREE1X
	lda	#37
	sta	TREE2X

	;=========================
	; setup scrolling letters
	;=========================

	; Patch the inverse values out (as used by check_email)
	lda	#39
	sta	ml_patch_dest+1
	lda	#$80
	sta	ml_patch_or+1
	lda	#$09
	sta	ml_patch_or
	lda	#' '|$80
	sta	ml_patch_space+1

	lda	#<letters_bm
	sta	LETTERL
	lda	#>letters_bm
	sta	LETTERH
	lda	#39
	sta	LETTERX
	lda	#1
	sta	LETTERY
	lda	#15
	sta	LETTERD

	;=================
	; Set draw page

	lda	#0
	sta	DISP_PAGE
	lda	#0
	sta	DRAW_PAGE

	;==========================
	; Load the background image

	lda	#<katahdin
	sta	LZ4_SRC
	lda	#>katahdin
	sta	LZ4_SRC+1

	lda	#<(katahdin_end-8)		; skip checksum at end
	sta	LZ4_END
	lda	#>(katahdin_end-8)		; skip checksum at end
	sta	LZ4_END+1

	lda	#<$2000			; Destination is HGR page0
	sta	LZ4_DST
	lda	#>$2000
	sta	LZ4_DST+1

	jsr	lz4_decode


	;=====================================================
	; attempt vapor lock
	;=====================================================
	jsr	vapor_lock


	;==========================
	; setup text screen

	; clear top 6 lines to space

	; takes (Y/2)*(6+435+7)+5 = ?
	lda	#$A0			; space			; 2
	ldy	#10			; 6 lines		; 2
	jsr	clear_page_loop					; 2693

;                                1               2
;                0123456789abcdef0123456789abcdef0123456
;line1:.asciiz	"   *                            .      " $400
;line2:.asciiz	"  *    .                            .  " $480
;line3:.asciiz	"  *                                    " $500
;line4:.asciiz	"   *                                   " $580
;line5:.asciiz	" .                          .    .     " $600
;line6:.asciiz	"             .                         " $680

	lda	#'.'|$80	; print star			; 2
	sta	$420						; 4
	sta	$487						; 4
	sta	$4A4						; 4
	sta	$601						; 4
	sta	$61c						; 4
	sta	$621						; 4
	sta	$68d						; 4
							;============
							;	 30
	; draw the moon
	lda	#' '		; print inv space		; 2
	sta	$403						; 4
	sta	$482						; 4
	sta	$502						; 4
	sta	$583						; 4
							;============
							;	 18



	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 cycles to go
	; 5070+4550 = 9620
	;	     -2745 (draw text)
	;	===========
	;	      6875


	; Try X=97 Y=14 cycles=6875

	ldy	#14							; 2
bmloopA:ldx	#97							; 2
bmloopB:dex								; 2
	bne	bmloopB							; 2nt/3
	dey								; 2
	bne	bmloopA							; 2nt/3

	jmp	bm_display_loop
.align	$100

	;=====================================================
	;=====================================================
	; Loop forever display loop
	;=====================================================
	;=====================================================
bm_display_loop:
	; each scan line 65 cycles
	;	1 cycle each byte (40cycles) + 25 for horizontal
	;Total of 12480 cycles to draw screen
	;Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was
	;	Text mode for 6*8=48 scanlines (3120 cycles)
	;	hgr for 64 scalines (4160 cycles)
	;	gr for 80 scalines (5200 cycles)
	;	vblank = 4550 cycles

	; text
	bit	SET_TEXT						; 4

	;================
	; clear bottom green

	jsr	draw_bottom_green				; 2209+6


	;================
	; Draw Small Tree

	lda	#>small_tree				; 2
	sta	INH					; 3
	lda	#<small_tree				; 2
	sta	INL					; 3

	lda	TREE1X					; 3
	sta	XPOS					; 3
	lda	#28					; 2
	sta	YPOS					; 3

	jsr	put_sprite				; 6
							;=========
							; 27
							; + 576
							;========
							; 603


	; want		 3120
	; green		-2215
	; tree1		 -603
	; set_test	   -4
	;=============== 298 cycles

	; Try X=1 Y=27 cycles=298

	ldy	#27							; 2
bmloop2:ldx	#1							; 2
bmloop1:dex								; 2
	bne	bmloop1							; 2nt/3
	dey								; 2
	bne	bmloop2							; 2nt/3

;=============================================

	; hgr
	bit	HIRES							; 4
	bit	SET_GR							; 4


	;================
	; Draw Big Tree

	lda	#>big_tree				; 2
	sta	INH					; 3
	lda	#<big_tree				; 2
	sta	INL					; 3

	lda	TREE2X					; 3
	sta	XPOS					; 3
	lda	#30					; 2
	sta	YPOS					; 3

	jsr	put_sprite				; 6
							;=========
							; 27
							; + 1410
							;========
							; 1437

	lda	FRAME							; 3
	and	#$1f							; 2
	and	#$10							; 2

	beq	bird_walking
									; 2
	lda	#>bird_rider_stand_right				; 2
	sta	INH							; 3
	lda	#<bird_rider_stand_right				; 2
	sta	INL							; 3

	jmp	draw_bird						; 3

bird_walking:
									; 3
	lda	#>bird_rider_walk_right					; 2
	sta	INH							; 3
	lda	#<bird_rider_walk_right					; 2
	sta	INL							; 3
	; must be 15
	lda	#0							; 2
	; Must add another 15 as sprite is different
	inc	XPOS							; 5
	inc	XPOS							; 5
	inc	XPOS							; 5


draw_bird:

							; 15 + 7
	lda	#17					; 2
	sta	XPOS					; 3
	lda	#30					; 2
	sta	YPOS					; 3

	jsr	put_sprite				; 6
							;=========
							; 38

							; + 2190
							;========
							; 2228


	;==========================
	; Update frame = 13 cycles


	inc	FRAME			; frame++			; 5
	lda	FRAME							; 3
	and	#$3f			; roll over after 63		; 2
	sta	FRAME							; 3

								;===========
								;        13

	;===========================
	; Update tree1 = 21 cycles
	and	#$3f			; if (frame%64==0)		; 2
	beq	dec_tree1
									; 2
	; need to do 19-5 cycles of nonsense
	inc	TREE1X							; 5
	dec	TREE1X							; 5
	lda	#0							; 2
	lda	#0							; 2

	jmp	done_tree1						; 3

dec_tree1:
									; 3
	dec	TREE1X			; tree1_x--			; 5
	lda	TREE1X							; 3
	bmi	tree1_neg
									; 2
	ldx	TREE1X							; 3
	jmp	done_tree1						; 3
tree1_neg:
							; incoming br     3
	ldx	#37							; 2
	stx	TREE1X							; 3
done_tree1:

	;===========================
	; Update tree2 = 24 cycles
	lda	FRAME							; 3
	and	#$f			; if (frame%16==0)		; 2
	beq	dec_tree2
									; 2
	; need to do 19-5 cycles of nonsense
	inc	TREE2X							; 5
	dec	TREE2X							; 5
	lda	#0							; 2
	lda	#0							; 2

	jmp	done_tree2						; 3

dec_tree2:
									; 3
	dec	TREE2X			; tree2_x--			; 5
	lda	TREE2X							; 3
	bmi	tree2_neg
									; 2
	ldx	TREE2X							; 3
	jmp	done_tree2						; 3
tree2_neg:
							; incoming br     3
	ldx	#37							; 2
	stx	TREE2X							; 3
done_tree2:


	; want                   4160
	; Tree2 Sprite		-1437
	; Sprite		-2228
	; Frame Update		  -13
	; Tree1 Update		  -21
	; Tree2 Update		  -24
	; hgr bits		   -8
	; ======================  429 cycles

	; Try X=13 Y=6 cycles=427 R2

	lda	#0							; 2

	ldy	#6							; 2
loop3:
	ldx	#13							; 2
loop4:
	dex								; 2
	bne	loop4							; 2nt/3

	dey								; 2
	bne	loop3							; 2nt/3

;===========================================================================


	; gr
	bit	LORES							; 4


	; Mockingboard went here***

	; lores want 	5200
	; mockingboard			-492
	; softswitch	  -4
	;===================
	;		5196 cycles

	; Try X=46 Y=22 cycles=5193 R3

	lda	$0							; 3

	ldy	#22							; 2
bmloop5:ldx	#46							; 2
bmloop6:dex								; 2
	bne	bmloop6							; 2nt/3
	dey								; 2
	bne	bmloop5							; 2nt/3

;========================================================================

	; vertical blank

	; want 4550 cycles
	; Try X=13 Y=64 cycles=4545 R2

;=========================================================================

	jsr	move_letters					; 6+126

	; Blanking time:	 4550
	; move_letters		 -132
	; check keypress	   -7
	; JMP at end		   -3
	;========================4408 cycles

	; Try X=175 Y=5 cycles=4406 R2

	nop								; 2

	ldy	#5							; 2
bmloop7:ldx	#175							; 2
bmloop8:dex								; 2
	bne	bmloop8							; 2nt/3
	dey								; 2
	bne	bmloop7							; 2nt/3

	; Skip if keypressed

	lda	KEYPRESS						; 4
	bpl	bm_no_keypress						; 3
        jmp	bm_done							; 3
bm_no_keypress:

	jmp	bm_display_loop						; 3

bm_done:
	bit	KEYRESET	; clear keypress			; 4
        rts								; 6

;===========================================================
;===========================================================
;===========================================================

;wait_until_keypressed:
;	lda	KEYPRESS			; check if keypressed
;	bpl	wait_until_keypressed		; if not, loop
;	bit	KEYRESET
;	rts


.align $100
	;====================================
	; Draw bottom green
	;====================================
	; using hlin 7127, optimized a bit but still awful
	; this one is much better
	; 2209 cycles
draw_bottom_green:

	lda	#$44							; 2
	ldx	#39							; 2
green_loop:
	sta	$728,X		; 28					; 5
	sta	$7a8,X		; 30					; 5
	sta	$450,X		; 32					; 5
	sta	$4d0,X		; 34					; 5
	sta	$550,X		; 36					; 5
	sta	$5d0,X		; 38					; 5
	sta	$650,X		; 40					; 5
	sta	$6d0,X		; 42					; 5
	sta	$750,X		; 44					; 5
	sta	$7d0,X		; 46					; 5

	dex								; 2
	bpl	green_loop						; 2nt/3

	rts								; 6

; 4 + (40*55) + 6 - 1


letters_bm:
	;.byte	1,15
	.byte	     "T A L B O T",128
	.byte	2,14,"F A N T A S Y",128
	.byte	3,16,"S E V E N",128
	.byte	1,15," ",128
	.byte	2,14," ",128
	.byte	3,16," ",128
	.byte	1,19,"BY",128
	.byte	3,14,"VINCE WEAVER",128
	.byte	1,19," ",128
	.byte	3,14," ",128
	.byte	1,16,"MUSIC BY",128
	.byte	3,12,"HIROKAZU TANAKA",128
	.byte	1,16," ",128
	.byte	3,12," ",128
	.byte	2,13,"CYCLE COUNTING",128
	.byte	3,16,"IS HARD!"
	.byte	255

.align	$100
.include "tfv_sprites.inc"

katahdin:
.incbin	"KATC.BIN.lz4",11		; skip the header
katahdin_end:


