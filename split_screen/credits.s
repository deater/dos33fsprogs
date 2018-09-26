.include "zp.inc"

	FRAME	= $60
	TREE1X	= $61
	TREE2X	= $62

	LETTERL	= $63
	LETTERH = $64
	LETTERX = $65
	LETTERY	= $66
	LETTERD = $67
	LETTER	= $68
	BLARGH	= $69
	MBASE	= $97
	MBOFFSET = $98

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

	lda	#0
	sta	MBOFFSET
	lda	#>music
	sta	MBASE

	lda	#<letters
	sta	LETTERL
	lda	#>letters
	sta	LETTERH
	lda	#39
	sta	LETTERX
	lda	#1
	sta	LETTERY
	lda	#15
	sta	LETTERD

	lda	#0
	sta	DISP_PAGE
	lda	#0
	sta	DRAW_PAGE

	;==========================
	; setup mockingboard

	jsr mockingboard_detect_slot4
	stx	MB_DETECTED
	ldx	MB_DETECTED
	beq	no_init_mb

	jsr	mockingboard_init

no_init_mb:


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

	;==========================
	; setup text screen

	lda	#0
	sta	CH
	sta	CV
	lda	#<line1
	sta	OUTL
	lda	#>line1
	sta	OUTH
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	inc	CV
	jsr	move_and_print

	; draw the moon
	lda	#0
	sta	CV
	lda	#3
	sta	CH
	jsr	htab_vtab	; vtab(1); htab(4)
	lda	#32	; inverse space
	ldy	#0
	sta	(BASL),Y

	inc	CV
	dec	CH
	jsr	htab_vtab
	lda	#32
	ldy	#0
	sta	(BASL),Y

	inc	CV
	jsr	htab_vtab
	lda	#32
	ldy	#0
	sta	(BASL),Y

	inc	CV
	inc	CH
	jsr	htab_vtab
	lda	#32
	ldy	#0
	sta	(BASL),Y


	; test letters
;letter_loop:
;	lda	#80
;	jsr	WAIT
;	jsr	move_letters
;	jmp	letter_loop

	; Wait

;	jsr	wait_until_keypressed

	; GR part
	bit	LORES
	bit	SET_GR
	bit	FULLGR

	jsr	draw_bottom_green				; 6

	; Wait

;	jsr	wait_until_keypressed

	bit	HIRES


	; Wait

;	jsr	wait_until_keypressed

	;=====================================================
	; attempt vapor lock
	;  by reading the "floating bus" we can see most recently
	;  written value of the display
	; we look for $44 (which is the green grass on low-res)
	;=====================================================
	; See:
	; 	Have an Apple Split by Bob Bishop
	; 	Softalk, October 1982

	; Challenges: each scan line scans 40 bytes.
	; The blanking happens at the *beginning*
	; So 65 bytes are scanned, starting at adress of the line - 25

	; the scan takes 8 cycles, look for 4 repeats of the value
	; to avoid false positive found if the horiz blanking is mirroring
	; the line (max 3 repeats in that case)


vapor_lock_loop:
	LDA #$A0
zxloop:
	LDX #$04
wiloop:
	CMP $C051
	BNE zxloop
	DEX
	BNE wiloop

	LDA #$44
zloop:
	LDX #$04
qloop:
	CMP $C051
	BNE zloop
	DEX
	BNE qloop

	; found first line of low-res green, need to kill time
	; until we can enter at top of screen
	; so we want roughly 5200+4550 - 65 (for the scanline we missed)

	; want 9685
	; Try X=34 Y=55 cycles=9681

	lda	#0							; 2
	lda	#0							; 2

	ldy	#55							; 2
loopA:
	ldx	#34							; 2
loopB:
	dex								; 2
	bne	loopB							; 2nt/3

	dey								; 2
	bne	loopA							; 2nt/3

	jmp	display_loop
.align	$100

	;=====================================================
	;=====================================================
	; Loop forever display loop
	;=====================================================
	;=====================================================
display_loop:
	; each scan line 65 cycles
	;	1 cycle each byte (40cycles) + 25 for horizontal
	;	Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

	;	16666     = 17030      x=1021.8
	;         1000        x


	; TODO: find beginning of scan
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
loop2:
	ldx	#1							; 2
loop1:
	dex								; 2
	bne	loop1							; 2nt/3

	dey								; 2
	bne	loop2							; 2nt/3

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

	;=========================
	; play mockingboard
	; 11+ 84*5 + 10*4 + 21 = 492

	lda	MBASE				; 3
	sta	MB_ADDRH			; 3
	lda	#0				; 2
	sta	MB_ADDRL			; 3
					;=============
					;	11

	ldx	#0				; 2
	ldy	MBOFFSET			; 3
	lda	(MB_ADDRL),Y			; 5
	sta	MB_VALUE			; 3
	jsr	write_ay_both			; 6+65
					;===============
					;	84

	clc					; 2
	lda	#6				; 2
	adc	MB_ADDRH			; 3
	sta	MB_ADDRH			; 3
					;==============
					;	10
	ldx	#2
	ldy	MBOFFSET
	lda	(MB_ADDRL),Y
	sta	MB_VALUE
	jsr	write_ay_both

	clc
	lda	#6
	adc	MB_ADDRH
	sta	MB_ADDRH

	ldx	#3
	ldy	MBOFFSET
	lda	(MB_ADDRL),y
	sta	MB_VALUE
	jsr	write_ay_both

	clc
	lda	#6
	adc	MB_ADDRH
	sta	MB_ADDRH

	ldx	#8
	ldy	MBOFFSET
	lda	(MB_ADDRL),y
	sta	MB_VALUE
	jsr	write_ay_both

	clc
	lda	#6
	adc	MB_ADDRH
	sta	MB_ADDRH

	ldx	#9
	ldy	MBOFFSET
	lda	(MB_ADDRL),y
	sta	MB_VALUE
	jsr	write_ay_both

	;

	lda	FRAME			; 3
	and	#1			; 2
	clc				; 2
	adc	MBOFFSET		; 3
	sta	MBOFFSET		; 3

	lda	MBASE			; 3
	adc	#0			; 2
	sta	MBASE			; 3
				;=============
				;         21

	; 2=2 not loop
	; 2+7+3= 12 = last page
	; 2+7+15=24  = loop

	cmp	#>music+5		; 2
	bne	waste_7		;
					; 2
	lda	MBOFFSET		; 3
	cmp	#16			; 2
	bne	waste_12		;
					; 2
	lda	#>music			; 2
	sta	MBASE			; 3
	lda	#0			; 2
	sta	MBOFFSET		; 3
	jmp	not_ready_to_loop	; 3
waste_7:
	lda	#0			; 2
	inc	BLARGH			; 5
waste_12:
					; 3
	lda	#0			; 2
	inc	BLARGH			; 5
	inc	BLARGH			; 5

not_ready_to_loop:

	; lores want 	5200
	; mockingboard	-492
	; wrap		 -24
	; softswitch	  -4
	;===================
	;		4680 cycles

	; Try X=7 Y=114 cycles=4675 R5

	inc 	BLARGH							; 5
;	lda	#0							; 2
;	lda	#0							; 2
;	lda	#0							; 2
;	lda	#0							; 2

	ldy	#114							; 2
loop5:
	ldx	#7							; 2
loop6:
	dex								; 2
	bne	loop6							; 2nt/3

	dey								; 2
	bne	loop5							; 2nt/3

;========================================================================

	; vertical blank

	; want 4550 cycles
	; Try X=13 Y=64 cycles=4545 R2

;=========================================================================



	jsr	move_letters					; 6+110

	; Blanking time:	 4550
	; move_letters		 -116
	; JMP at end		   -3
	;========================4431 cycles

	; Try X=176 Y=5 cycles=4431

;	lda	#0							; 2
;	lda	#0							; 2
	ldy	#5							; 2
loop7:
	ldx	#176							; 2
loop8:
	dex								; 2
	bne	loop8							; 2nt/3
	dey								; 2
	bne	loop7							; 2nt/3


	jmp	display_loop						; 3

;===========================================================
;===========================================================
;===========================================================

;wait_until_keypressed:
;	lda	KEYPRESS			; check if keypressed
;	bpl	wait_until_keypressed		; if not, loop
;	bit	KEYRESET
;	rts




	;=============================================
	; put_sprite
	;=============================================
	; Sprite to display in INH,INL
	; Location is XPOS,YPOS
	; Note, only works if YPOS is multiple of two


	; time= 28 setup
	;    Y*outerloop
	;    outerloop = 34 setup
	;	X*innerloop
	;	innerloop = 30 if $00 17+13(done)
	;		    64 if $0X 16+7+8+20(put_sprite_mask)+13(done)
	;		    69 if $X0 16+8+7+5+20(put_sprite_mask)+13(done)
	;		    54 if if $XX 16+8+8+9(put_all)+13(done)


	;       -1 for last iteration
	;    18 (-1 for last)
	;     6 return

	; so cost = 28 + Y*(34+18)+ (INNER-Y) -1 + 6
	;         = 33 + Y*(52)+(INNER-Y)
	;	  = 33 + Y*(52)+ [30A + 64B + 69C + 54D]-Y
.align $100
put_sprite:

	ldy	#0		; byte 0 is xsize			; 2
	lda	(INL),Y							; 5
	sta	CH		; xsize is in CH			; 3
	iny								; 2

	lda	(INL),Y		; byte 1 is ysize			; 5
	sta	CV		; ysize is in CV			; 3
	iny								; 2

	lda	YPOS		; make a copy of ypos			; 3
	sta	TEMPY		; as we modify it			; 3
								;===========
								;	28
put_sprite_loop:
	sty	TEMP		; save sprite pointer			; 3
	ldy	TEMPY							; 3
	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	clc								; 2
	adc	XPOS		; add in xpos				; 3
	sta	OUTL		; store out low byte of addy		; 3
	lda	gr_offsets+1,Y	; look up high byte			; 4
	adc	DRAW_PAGE	;					; 3
	sta	OUTH		; and store it out			; 3
	ldy	TEMP		; restore sprite pointer		; 3

				; OUTH:OUTL now points at right place

	ldx	CH		; load xsize into x			; 3
								;===========
								;	34
put_sprite_pixel:
	lda	(INL),Y			; get sprite colors		; 5
	iny				; increment sprite pointer	; 2

	sty	TEMP			; save sprite pointer		; 3
	ldy	#$0							; 2

	; check if completely transparent
	; if so, skip

	cmp	#$0			; if all zero, transparent	; 2
	beq	put_sprite_done_draw	; don't draw it			; 2nt/3
								;==============
								;	 16/17

	sta	COLOR			; save color for later		; 3

	; check if top pixel transparent

	and	#$f0			; check if top nibble zero	; 2
	bne	put_sprite_bottom	; if not skip ahead		; 2nt/3
								;==============
								;	7/8

	lda	#$f0			; setup mask			; 2
	sta	MASK							; 3
	bmi	put_sprite_mask		; always?			; 3
								;=============
								;	  8

put_sprite_bottom:
	lda	COLOR			; re-load color			; 3
	and	#$0f			; check if bottom nibble zero	; 2
	bne	put_sprite_all		; if not, skip ahead		; 2nt/3
								;=============
								;	7/8

	lda	#$0f							; 2
	sta	MASK			; setup mask			; 3
								;===========
								;         5

put_sprite_mask:
	lda	(OUTL),Y		; get color at output		; 5
	and	MASK			; mask off unneeded part	; 3
	ora	COLOR			; or the color in		; 3
	sta	(OUTL),Y		; store it back			; 6

	jmp	put_sprite_done_draw	; we are done			; 3
								;===========
								;        20

put_sprite_all:
	lda	COLOR			; load color			; 3
	sta	(OUTL),Y		; and write it out		; 6
								;============
								;	  9

put_sprite_done_draw:

	ldy	TEMP			; restore sprite pointer	; 3

	inc	OUTL			; increment output pointer	; 5
	dex				; decrement x counter		; 2
	bne	put_sprite_pixel	; if not done, keep looping	; 2nt/3
								;==============
								;	12/13

	inc	TEMPY			; each line has two y vars	; 5
	inc	TEMPY							; 5
	dec	CV			; decemenet total y count	; 5
	bne	put_sprite_loop		; loop if not done		; 2nt/3
								;==============
								;	17/18

	rts				; return			; 6



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

	;===============================================
	; Move Letters
	;===============================================
	; Normal	=10+25+38+9 = 82     need 28  (28)
	; End of line   =10+25+38+37 = 110
	; Next line	=10+5+12+34 = 61     need 49  (28+21)
	; done entirely =10+5+9 = 24         need 86  (28+21+37)

	; all forced to be 109

move_letters:
	ldy	#0							; 2
	lda	(LETTERL),Y						; 5
	sta	LETTER							; 3
								;==========
								;       10
	bmi	letter_special
									; 2
	lda	LETTERY							; 3
	asl								; 2
	tay								; 2
	lda	gr_offsets,Y	; lookup low-res memory address		; 4
	sta	BASL		; store out low byte of addy		; 3
	lda	gr_offsets+1,Y	; look up high byte			; 4
	sta	BASH							; 3
	lda	#0		; cycle-killer				; 2
								;==========
								;       25

	ldy	#0		; erase old char with space		; 2
	lda	#' '|$80						; 2
	ldy	LETTERX							; 3
	sta	(BASL),Y						; 6

	dey			; draw new char				; 2
	sty	LETTERX							; 3
	lda	LETTER							; 3
	ora	#$80							; 2
	ldy	LETTERX							; 3
	sta	(BASL),Y						; 6

	lda	LETTERX							; 3
	cmp	LETTERD							; 3
								;===========
								;        38
	beq	letter_next
									; 2
	lda	#0							; 2
	lda	#0							; 2
	jmp	waste_28						; 3
								;==========
								;	  9
letter_next:
									; 3
	clc								; 2
	lda	LETTERL							; 3
	adc	#1							; 2
	sta	LETTERL							; 3
	lda	LETTERH							; 3
	adc	#0							; 2
	sta	LETTERH							; 3
	inc	LETTERD							; 5
	lda	#39							; 2
	sta	LETTERX							; 3
	rts								; 6
								;===========
								;        37

letter_special:
									; 3
	cmp	#$ff							; 2
								;==========
								;         5

	beq	letter_done
									; 2
	ldy	#1							; 2
	lda	(LETTERL),Y						; 5
	sta	LETTERY							; 3
								;===========
								;	 12

	iny								; 2
	lda	(LETTERL),Y						; 5
	sta	LETTERD							; 3

	clc								; 2
	lda	LETTERL							; 3
	adc	#3							; 2
	sta	LETTERL							; 3
	lda	LETTERH							; 3
	adc	#0							; 2
	sta	LETTERH							; 3
	lda	LETTERH		; waste					; 3
	jmp	waste_21						; 3

								;===========
								;        34
letter_done:
				; 3
	lda	LETTERH		; 3
	lda	LETTERH		; 3

waste_37:
	ldx	#0		; 2
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
waste_21:
	ldx	#0		; 2
	ldx	#0		; 2
	ldx	#0		; 2
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5

waste_28:
	ldx	#0		; 2
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	inc	BLARGH		; 5
	rts			; 6

letters:
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


line1:.asciiz	"   *                            .      "
line2:.asciiz	"  *    .                            .  "
line3:.asciiz	"  *                                    "
line4:.asciiz	"   *                                   "
line5:.asciiz	" .                          .    .     "
line6:.asciiz	"             .                         "

.include "../asm_routines/text_print.s"
.include "mockingboard.s"

.align	$100
.include "../asm_routines/gr_offsets.s"
.include "tfv_sprites.inc"

.include "lz4_decode.s"

;.align	$1000

katahdin:
.incbin	"KATC.BIN.lz4",11		; skip the header
katahdin_end:

.align $100
music:
.incbin "music.tfv"
