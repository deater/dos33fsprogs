	;================================
	; spacebars gameplay
	;================================
game:

	;===================
	; init screen
	bit	KEYRESET

	;===================
	; init vars
	lda	#15
	sta	XPOS
	lda	#38
	sta	YPOS

	lda	#0
	sta	FRAMEH

	;=============================
	; Load graphic hgr

	lda	#<background_hgr
	sta	LZ4_SRC
	lda	#>background_hgr
	sta	LZ4_SRC+1

	lda	#<(background_hgr_end-8)	; skip checksum at end
	sta	LZ4_END
	lda	#>(background_hgr_end-8)	; skip checksum at end
	sta	LZ4_END+1

	lda	#<$2000
	sta	LZ4_DST
	lda	#>$2000
	sta	LZ4_DST+1

	jsr	lz4_decode



	;==================
	; setup framebuffer

	lda	#0
	sta	ZPOS

;	lda	#$12
;	sta	FRAMEBUFFER+0
;	lda	#$3f
;	sta	FRAMEBUFFER+1
;	lda	#$56
;	sta	FRAMEBUFFER+2
;	lda	#$78
;	sta	FRAMEBUFFER+3
;	lda	#$9A
;	sta	FRAMEBUFFER+4
;	lda	#$BC
;	sta	FRAMEBUFFER+5
;	lda	#$DE
;	sta	FRAMEBUFFER+6
;	lda	#$F0
;	sta	FRAMEBUFFER+7
;	lda	#$12
;	sta	FRAMEBUFFER+8
;	lda	#$3f
;	sta	FRAMEBUFFER+9
;	lda	#$56
;	sta	FRAMEBUFFER+10
;	lda	#$78
;	sta	FRAMEBUFFER+11
;	lda	#$9A
;	sta	FRAMEBUFFER+12






	;=============================
	; Load graphic page1 $800

	lda	#4
	sta	DRAW_PAGE

	lda	#$22
	jsr	clear_gr




	;=============================
	; Load graphic page2 $c00


	lda	#8
	sta	DRAW_PAGE

	lda	#$44
	jsr	clear_gr


	lda	#<score_text
        sta	OUTL
        lda	#>score_text
        sta	OUTH

	jsr     move_and_print


	lda	#0
	sta	DRAW_PAGE

	; GR part
	bit	PAGE0


	;==============================
	; setup graphics for vapor lock
	;==============================

	jsr	vapor_lock						; 6

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles), so with 5070 lines to go

	; so we have 5070 + 4550 = 9620 to kill

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
sbloopA:ldx	#9							; 2
sbloopB:dex								; 2
	bne	sbloopB							; 2nt/3
	dey								; 2
	bne	sbloopA							; 2nt/3

	jmp	sb_begin_loop
.align  $100


	;================================================
	; Spacebars Loop
	;================================================
	; each scan line 65 cycles
	;       1 cycle each byte (40cycles) + 25 for horizontal
	;       Total of 12480 cycles to draw screen
	; Vertical blank = 4550 cycles (70 scan lines)
	; Total of 17030 cycles to get back to where was

sb_begin_loop:

sb_display_loop:


;          1         2         3
;0123456789012345678901234567890123456789
;LEVEL: 6 LIVES: 2 SCORE: 01978 HI: 02018

	; 0-7  = text mode
	; 8-87 = hgr
	; 88 - 168 = split
	; 169 - 191 = gr


	; 8 lines of text mode


	ldy	#8					; 2

sb_text_loop:
	bit	SET_TEXT				; 4
	lda	#29					; 2
	jsr	delay_a					; 25+29

	dey						; 2
	bne	sb_text_loop				; 3
						;================
						;	65


							; -1


sb_hgr_loop:
	; delay 80*65 =  5200
	;                2180
	;                    -2
	;		     +1
	;		     -8
	;=========================
	;		3011

	bit	SET_GR				; 4
	bit	HIRES				; 4



	; draw sprite at same time
	lda	#>ship_forward						; 2
	sta	INH							; 3
	lda	#<ship_forward						; 2
	sta	INL							; 3
	jsr	put_sprite						; 6
								; + 2164
								;===========
								; 2180



	; Try X=59 Y=10 cycles=3011

	ldy	#10							; 2
sbloopC:ldx	#59							; 2
sbloopD:dex								; 2
	bne	sbloopD							; 2nt/3
	dey								; 2
	bne	sbloopC							; 2nt/3




sb_mixed:
	lda	$0		;kill 6 cycles (room for rts)	; 2
	ldx	#9					; 2
	ldy	#9 ; 14 ; 126				; 2

sb_mixed_loop:
	lda	ss_multiples,x				; 4
	sta	split_smc+1				; 4
split_smc:
	jsr	split_4					; 6+46
	dey						; 2
	bne	sb_mixed_loop				; 3

							; -1
	nop						; 2
	ldy	#9					; 2
	dex						; 2
	bne	split_smc				; 3

							; -1

						; need to kill
						; -6 from offset
						; +1 fall through
						; -9 from check 
						; +1 from other fallthrough
					;================
					;	 -13



sb_all_gr:
	; 23 lines of this

	; 23 * 65 = 1495
	;             -4
	;            -13
	;       =========
	;	    1478

	bit	LORES						; 4

	; Try X=41 Y=7 cycles=1478

	ldy	#7							; 2
sbloopE:ldx	#41							; 2
sbloopF:dex								; 2
	bne	sbloopF							; 2nt/3
	dey								; 2
	bne	sbloopE							; 2nt/3



	;======================================================
	; We have 4550 cycles in the vblank, use them wisely
	;======================================================

	; do_nothing should be      4550
	;			   -3470 draw_framebuffer
	;			    -793 setup framebuffer
	;			     -21 frame count
	;			     -34 keypress
	;				-1 adjust center mark back
	;			===========
	;			     231

	; Try X=8 Y=5 cycles=231


	ldy	#5							; 2
sbloop1:ldx	#8							; 2
sbloop2:dex								; 2
	bne	sbloop2							; 2nt/3
	dey								; 2
	bne	sbloop1							; 2nt/3

	jsr	setup_framebuffer			; 6+787

	jsr	draw_framebuffer			; 6+3464

	; Increment frame count
	; noflo: 16 + 2 + (3)  = 21
	;  oflo: 16 + 5  = 21
	inc	FRAME						; 5
	lda	FRAME						; 3
	and	#3			; 15 Hz			; 2
	sta	FRAME						; 3
	beq	sb_frame_oflo					; 3
							;============
							;        16
								; -1
	lda	$0			; nop			;  3
	jmp	sb_frame_noflo					;  3
sb_frame_oflo:
	inc	FRAMEH						; 5
sb_frame_noflo:


	; no keypress =  10+(24)   = 34
	; left pressed = 9+8+12+(5)= 34
	; right pressed = 9+8+5+12 = 34

	lda	KEYPRESS				; 4
	bpl	sb_no_keypress				; 3
							; -1
	jmp	sb_handle_keypress			; 3
sb_no_keypress:
	inc	$0					; 5
	dec	$0					; 5
	inc	$0					; 5
	dec	$0					; 5
	nop						; 2
	nop						; 2

	jmp	sb_display_loop				; 3

sb_handle_keypress:
	bit	KEYRESET	; clear keypress	; 4
	cmp	#'Q'|$80				; 2
	beq	sb_exit					; 3
							; -1

sb_check_left:
	cmp	#$08|$80	; left			; 2
	bne	sb_check_right				; 3
							; -1
	dec	XPOS					; 5

	nop		; nop				; 2
	lda	$0	; nop				; 3
	jmp	sb_display_loop				; 3

sb_check_right:
	cmp	#$15|$80				; 2
	bne	sb_exit					; 3
							; -1
	inc	XPOS					; 5

	jmp	sb_display_loop				; 3




sb_exit:
	rts						; 6


.align	$100

	; total =
	;	   4 wide:         =   53
	;	  12 wide:	   =  253
	;	  20 wide:	   =  421
	;         28 wide:	   =  813
	;	  36 wide:         =  757
	;         40 wide:         = 1161
	;                               6
	;====================================
	;                            3464
draw_framebuffer:


	; 2 + (4*(X*8)+5) -1 =
	; 2 + 4*(8+5) -1 = 85

	ldx	#4					; 2
fb4_loop:
	lda	FRAMEBUFFER+0				; 3
	sta	$5a8+18-1,x				; 5
	dex						; 2
	bne	fb4_loop				; 3


	; 2 + (12*(X*8)+5) -1 =
	; 2 + 12*(16+5) -1 = 253

	ldx	#12					; 2
fb12_loop:
	lda	FRAMEBUFFER+1				; 3
	sta	$628+14-1,x				; 5
	lda	FRAMEBUFFER+2				; 3
	sta	$6a8+14-1,x				; 5
	dex						; 2
	bne	fb12_loop				; 3

	; 2 + (20*(X*8)+5) -1 =
	; 2 + 20*(16+5) -1 = 421

	ldx	#20					; 2
fb20_loop:
	lda	FRAMEBUFFER+3				; 3
	sta	$728+10-1,x				; 5
	lda	FRAMEBUFFER+4				; 3
	sta	$7a8+10-1,x				; 5
	dex						; 2
	bne	fb20_loop				; 3


	; 2 + (28*(X*8)+5) -1 =
	; 2 + 28*(24+5) -1 = 813

	ldx	#28					; 2
fb28_loop:
	lda	FRAMEBUFFER+5				; 3
	sta	$450+6-1,x				; 5
	lda	FRAMEBUFFER+6				; 3
	sta	$4d0+6-1,x				; 5
	lda	FRAMEBUFFER+7				; 3
	sta	$550+6-1,x				; 5
	dex						; 2
	bne	fb28_loop				; 3


	; 2 + (36*(X*8)+5) -1 =
	; 2 + 36*(16+5) -1 = 757

	ldx	#36					; 2
fb36_loop:
	lda	FRAMEBUFFER+8				; 3
	sta	$5d0+2-1,x				; 5
	lda	FRAMEBUFFER+9				; 3
	sta	$650+2-1,x				; 5
	dex						; 2
	bne	fb36_loop				; 3

	; 2 + (40*(X*8)+5) -1 =
	; 2 + 40*(24+5) + -1 = 1161

	ldx	#40					; 2
fb40_loop:
	lda	FRAMEBUFFER+10				; 3
	sta	$6d0-1,x				; 5
	lda	FRAMEBUFFER+11				; 3
	sta	$750-1,x				; 5
	lda	FRAMEBUFFER+12				; 3
	sta	$7d0-1,x				; 5
	dex						; 2
	bne	fb40_loop				; 3

							; -1
	rts						; 6



.align $100
.include "screen_split.s"


;.include "deater.inc"
background_hgr:
.incbin "SB_BACKGROUNDC.BIN.lz4",11
background_hgr_end:

score_text:
.byte 0,0
.asciiz "LEVEL:6  LIVES:2  SCORE:001978 HI:002018"



; Note on the distance calculations
; we use something simplistic here
; see http://www.extentofthejam.com/pseudo/

; "Texture": 64?
; 0    GREY	5,7,f,7,5,0,0,0
; 1		0,0,0,0,0,0,0,0
; 2    BLUE	2,6,f,6,2,0,0,0
; 3		0,0,0,0,0,0,0,0
; 4    GREEN	4,c,f,c,4,0,0,0
; 5		0,0,0,0,0,0,0,0
; 6    RED	1,b,f,b,1,0,0,0
; 7		0,0,0,0,0,0,0,0

.align 64
raster_texture:
	.byte	$5,$7,$f,$7,$5,$0,$0,$0		; grey
	.byte	$0,$0,$0,$0,$0,$0,$0,$0
	.byte	$2,$6,$f,$6,$2,$0,$0,$0		; blue
	.byte	$0,$0,$0,$0,$0,$0,$0,$0
	.byte	$4,$c,$f,$c,$4,$0,$0,$0		; green
	.byte	$0,$0,$0,$0,$0,$0,$0,$0
	.byte	$1,$b,$f,$b,$1,$0,$0,$0		; red
	.byte	$0,$0,$0,$0,$0,$0,$0,$0,$0

offset_lookup:
;	.byte	0,1,2,3,4,5,6,7,8,9,10,11,12
;	.byte	13,14,15,16,17,18,19,20,21,22,23,24

	.byte   25,24
	.byte	23,22,21,20,19,18,17,16,15,14,13,12
	.byte	11,10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0

.align $100

	; 2 + 60*13 + 5 = 787
setup_framebuffer:
	ldx	#0							; 2
setup_fb_loop:
	lda	offset_lookup,X						; 4
	clc								; 2
	adc	FRAMEH							; 3
	and	#$3f							; 2
	tay								; 2
	lda	raster_texture,y					; 4
	asl								; 2
	asl								; 2
	asl								; 2
	asl								; 2
	pha								; 3
								;===========
								;        28

	lda	offset_lookup+1,X					; 4
	clc								; 2
	adc	FRAMEH							; 3
	and	#$3f							; 2
	tay								; 2
	pla								; 4
	ora	raster_texture,y					; 4

	sta	FRAMEBUFFER,x				; zp		; 4
	inx								; 2
	cpx	#13							; 2
	bne	setup_fb_loop						; 3
								;===========
								;        32

									; -1
	rts								; 6




