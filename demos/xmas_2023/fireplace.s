

	;=============================
	; draw the fireplace scene
	;=============================
fireplace:
	lda	#0
	sta	FRAMEL
	sta	FRAMEH

	lda	#120
	sta	HGR_COPY_Y1
	lda	#160
	sta	HGR_COPY_Y2

	bit     SET_GR
        bit     LORES
        bit     FULLGR
        bit     PAGE1

	lda	#<merry_graphics
	sta	zx_src_l+1
	lda	#>merry_graphics
	sta	zx_src_h+1
	lda	#$40
	jsr	zx02_full_decomp

;	jsr	wait_until_keypress


	bit     SET_GR
        bit     LORES
        bit     FULLGR
        bit     PAGE2

        lda     #4
        sta     DRAW_PAGE

        bit     KEYRESET

	lda	#<fireplace_data
	sta	INL
	lda	#>fireplace_data
	sta	INH

	jsr	draw_scene

	; write text to page2
	; this is inefficient at best

	ldy	#39
text_loop:
	lda	merry_text+6,Y
	ora	#$80
	sta	$A50,Y

	lda	merry_text+4,Y
	ora	#$80
	sta	$AD0,Y

	lda	merry_text+2,Y
	ora	#$80
	sta	$B50,Y

	lda	merry_text,Y
	ora	#$80
	sta	$BD0,Y
early_out:
	dey
	bpl	text_loop



	bit	PAGE1

	lda	#$DD
	sta	FIRE_COLOR



	; attempt vapor lock

	jmp	pad_skip
.align $100
pad_skip:
	jsr	vapor_lock

	bit	PAGE2

	; vapor lock returns with us at beginning of hsync in line
	; 114 (7410 cycles)


	; we want to do the split at line 160, so 46 more lines, or
	; 2990 cycles

	; Try X=11 Y=49 cycles=2990

	ldy	#49							; 2
loop11:	ldx	#11							; 2
loop22:	dex								; 2
        bne	loop22							; 2nt/3
        dey								; 2
        bne	loop11							; 2nt/3


loop_forever:
	;================================================
        ; each scan line 65 cycles
        ;       1 cycle each byte (40cycles) + 25 for horizontal
        ;       Total of 12480 cycles to draw screen
        ; Vertical blank = 4550 cycles (70 scan lines)
        ; Total of 17030 cycles to get back to where was

	; want 32 lines of hires, which will take us into VBLANK
	; 2080 cycles - 4 = 2076

	;	 -4
	bit	HIRES							; 4

	; Try X=137 Y=3 cycles=2074

	nop	; 2

	ldy	#3							; 2
loop1:	ldx	#137							; 2
loop2:	dex								; 2
        bne	loop2							; 2nt/3
        dey								; 2
        bne	loop1							; 2nt/3

	; do the VBLANK
	; 4550 cycles

	; Try X=19 Y=45 cycles=4546

	nop
	nop

	ldy	#45							; 2
loop10:	ldx	#19							; 2
loop20:	dex								; 2
        bne	loop20							; 2nt/3
        dey								; 2
        bne	loop10							; 2nt/3

	;===================================
	; LORES SCREEN

	; DO THINGS
	;  count FRAMES
	;	every 1/2 second flicker fireplace
	;	show for 1s
	;	copy over text, 32 lines, 10 frames each = 3.2s

	;=================
	; set LORES

	bit	LORES							; 4

	;==================
	; frame increment

	inc	FRAMEL							; 5
	lda	FRAMEL							; 3
	and	#$3f							; 2
	sta	FRAMEL							; 3

	bne	frame_noflo						; 2/3

	inc	FRAMEH							; 5

	jmp	frame_inc_done						; 3
; 23
frame_noflo:
; 16
	lda	$0	; nop3						; 3
	nop								; 2
	nop								; 2
frame_inc_done:
	; 23 / 23



	;==================
	; do the action

	; FRAMEH = 0/1 do nothing
	; FRAMEH = 2 every other line do copy
	; FRAMEH = 3 exit
	; FRAMEL = 1 exactly, flicker

check_action:

; 0
	lda	FRAMEL				; 3
	cmp	#1				; 2
	beq	do_flicker			; 2/3
; 7
	and	#1				; 2
	bne	do_nothing_odd			; 2/3
; 11
	lda	FRAMEH				; 3
	cmp	#3				; 2
	beq	done_cycle_count		; 2/3
; 18
	cmp	#2				; 2
	bcc	do_nothing_less_than_2	; blt	; 2/3
; 22


	;========================
	; copy text

copy_text:

	ldx	HGR_COPY_Y1					; 3
	lda	hposn_high,X					; 4
	clc							; 2
	adc	#$20						; 2
	sta	INH						; 3
	lda	hposn_low,X					; 4
	sta	INL						; 3
; 21

	ldx	HGR_COPY_Y2					; 3
	lda	hposn_high,X					; 4
	clc							; 2
	adc	#$20						; 2
	sta	OUTH						; 3
	lda	hposn_low,X					; 4
	sta	OUTL						; 3
; 21


	ldy	#39						; 2
copy_hgr_line_loop:
	lda	(INL),Y						; 5
	sta	(OUTL),Y					; 6
	dey							; 2
	bpl	copy_hgr_line_loop				; 2/3

	; 2+(40*16)-1 = 641

	inc	HGR_COPY_Y1					; 5
	inc	HGR_COPY_Y2					; 5

	jmp	done_action					; 3

	; 22 + 21 + 21 + 641 + 10 + 3 = 718

do_flicker:
; 8

	lda	FIRE_COLOR			; 3
	eor	#$0D				; 2
	sta	FIRE_COLOR			; 3
	sta	$9A8+34				; 4
	sta	$9A8+35				; 4
; 24



	; 718-27 = 691
	; Try X=8 Y=15 cycles=691

	ldy	#15							; 2
loop5:	ldx	#8							; 2
loop6:	dex								; 2
        bne	loop6							; 2nt/3
        dey								; 2
        bne	loop5							; 2nt/3

	jmp	done_action						; 3

do_nothing_odd:
	; 12 if from odd
	lda	$0	; nop3
	lda	$0	; nop3
	lda	$0	; nop3
	nop		; 2

do_nothing_less_than_2:
	; 23 if from less than 2

	; 718-23=695
	; Try X=68 Y=2 cycles=693

	nop

	ldy	#2							; 2
loop7:	ldx	#68							; 2
loop8:	dex								; 2
        bne	loop8							; 2nt/3
        dey								; 2
        bne	loop7							; 2nt/3


done_action:

	; 718 from copy_text


	; do the lores screen, 160 lines
	; 10400
	;  -4 (bit LORES)
	; -23 (inc FRAME)
	;  -3 (jmp)
	; -718 actions
	;=======
	; 9652

	; Try X=39 Y=48 cycles=9649

	lda	$0	; nop3

	ldy	#48							; 2
loop3:	ldx	#39							; 2
loop4:	dex								; 2
        bne	loop4							; 2nt/3
        dey								; 2
        bne	loop3							; 2nt/3



	jmp	loop_forever						; 3




done_cycle_count:
	bit	TEXTGR


	;==========================
	; start music

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	no_music
	cli	; enable sound
no_music:

	;=================================
	;=================================
	;=================================
	; main fireplace loop
	;=================================
	;=================================
	;=================================

	lda	#$DD
	sta	FIRE_COLOR

	lda	#0
	sta	FRAMEL
	sta	FRAMEH


new_loop:

	; update frame count

	inc	FRAMEL							; 5
	lda	FRAMEL							; 3
	and	#$3f							; 2
	sta	FRAMEL							; 3
	bne	frame_noflo2						; 2/3
	inc	FRAMEH							; 5
frame_noflo2:

	lda	#255
	jsr	wait

	jsr	toggle_flame

	lda	KEYPRESS
	bmi	totally_done_fireplace

	; wait for_pattern / end

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	no_music2

	lda	#1
	cmp	current_pattern_smc+1
	bcc	totally_done_fireplace
	beq	totally_done_fireplace
	jmp	done_music2

no_music2:
	lda	FRAMEH
	cmp	#2
	beq	totally_done_fireplace

done_music2:


	jmp	new_loop

totally_done_fireplace:
	bit	KEYRESET



	;=================================
	;=================================
	;=================================
	; scroller
	;=================================
	;=================================
	;=================================


	lda	#0
	sta	OFFSET
	sta	FRAMEL
	sta	FRAMEH

	lda	#4
	sta	DRAW_PAGE

	lda	#<greets_raw_zx02
	sta	zx_src_l+1
	lda	#>greets_raw_zx02
	sta	zx_src_h+1
	lda	#$20
	jsr	zx02_full_decomp

	bit	FULLGR
do_scroll:

	; update frame count

	inc	FRAMEL							; 5
	lda	FRAMEL							; 3
	and	#$3f							; 2
	sta	FRAMEL							; 3
	bne	frame_noflo3						; 2/3
	inc	FRAMEH							; 5
frame_noflo3:

	jsr	toggle_flame

	jsr	scroll_loop

	lda	#128
	jsr	wait


	lda	KEYPRESS
	bmi	totally_done_scroll

	; wait for_pattern / end

	lda	SOUND_STATUS
	and	#SOUND_MOCKINGBOARD
	beq	no_music3

	lda	#3
	cmp	current_pattern_smc+1
	bcc	totally_done_scroll
	beq	totally_done_scroll
	jmp	done_music3

no_music3:
	lda	FRAMEH
	cmp	#2
	beq	totally_done_fireplace

done_music3:




	jmp	do_scroll

done_scroll:
totally_done_scroll:

	rts


	;=========================
	; toggle flame
	;=========================

toggle_flame:
	lda	FIRE_COLOR			; 3
	eor	#$0D				; 2
	sta	FIRE_COLOR			; 3
	sta	$9A8+34				; 4
	sta	$9A8+35				; 4

	rts

.include "gr_scroll.s"

greets_raw_zx02:
.incbin "graphics/greets.raw.zx02"

fireplace_data:

.byte SET_COLOR | YELLOW
.byte BOX, 0,0,39,29			; wall
.byte SET_COLOR | BROWN
.byte BOX,0,30,39,39	; monitor back
.byte BOX,1,0,9,20	; window
.byte SET_COLOR | BLACK
.byte BOX,2,0,8,9	; upper
.byte SET_COLOR | WHITE
.byte BOX,2,12,8,18	; bottom snow
.byte SET_COLOR | RED
.byte	27,12,39,30	; fireplace
.byte SET_COLOR | BLACK
.byte	30,17,39,30	; hearth
.byte SET_COLOR | BROWN
.byte	32,27,38,29	; wood
.byte SET_COLOR | WHITE
.byte	26,10,39,11	; mantle
.byte SET_COLOR | GREEN
.byte	15,0,17,39	; tree center
.byte	13,5,19,39	; tree middle
.byte	12,15,20,39	; tree wider
.byte	10,23,22,39	; tree wide
.byte SET_COLOR | LIGHT_BLUE
.byte	13,11,16,12	; garland top
.byte	17,13,19,14	; garland top
.byte	12,23,15,24	; garland middle
.byte	16,25,19,26	; garland middle
.byte	20,27,22,28	; garland middle
.byte	10,36,14,37	; garland bottom
.byte	15,38,18,39	; garland bottom
.byte SET_COLOR | RED
.byte	14,7,15,9	; ball1
.byte	18,17,19,19	; ball2
.byte	11,31,12,33	; ball3
.byte	20,34,21,36	; ball4
.byte SET_COLOR | YELLOW
.byte	34,22,36,26	; fire
.byte SET_COLOR | ORANGE
.byte	35,24,35,26	; fire
.byte SET_COLOR | BLACK
.byte	34,22,35,22	; flicker
.byte SET_COLOR | YELLOW
.byte	BOX,34,22,35,22	; flicker
.byte	END



               ;0123456789012345678901234567890123456789
merry_text:
	.byte   "      MERRY CHRISTMAS!!! MERRY CHRISTMAS!!! ME"

merry_graphics:
.incbin "graphics/merry.hgr.zx02"

.include "vapor_lock.s"
.include "delay_a.s"
.include "draw_blocks.s"
