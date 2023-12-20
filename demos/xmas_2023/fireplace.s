	;=============================
	; draw the fireplace scene
	;=============================
fireplace:
	lda	#0
	sta	FRAMEL
	sta	FRAMEH

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

	lda	#<merry_text
	sta	INL
	lda	#>merry_text
	sta	INH

	ldy	#39
text_loop:
	lda	(INL),Y
	ora	#$80
	sta	$A50,Y
	cpy	#38
	bcs	early_out
	sta	$AD0+2,Y
	cpy	#36
	bcs	early_out
	sta	$B50+4,Y
	cpy	#34
	bcs	early_out
	sta	$BD0+6,Y
early_out:
	dey
	bpl	text_loop



	bit	PAGE1

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

	; want 32 lines of lores, which will take us into VBLANK
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
	bne	frame_noflo						; 2/3
	inc	FRAMEH							; 5

	jmp	frame_inc_done						; 3
; 15
frame_noflo:
; 8
	lda	$0	; nop3						; 3
	nop								; 2
	nop								; 2
frame_inc_done:
	; 15 / 15

	;==================
	; do the action



	; do the lores screen, 160 lines
	; 10400
	;  -4 (bit LORES)
	; -15 (inc FRAME)
	;  -3 (jmp)
	;=======
	;10378

	; Try X=17 Y=114 cycles=10375

	lda	$0	; nop3

	ldy	#114							; 2
loop3:	ldx	#17							; 2
loop4:	dex								; 2
        bne	loop4							; 2nt/3
        dey								; 2
        bne	loop3							; 2nt/3



	jmp	loop_forever						; 3

stop_cycle_count:
	bit	TEXTGR

	cli	; enable sound: FIXME check if mockingboard there


	; TODO: flicker fire a bit
	;	start scrolling text

	jsr	wait_until_keypress

	rts

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





;==========================
; draw box scene
;==========================
; data in INL/INH

SET_COLOR = $C0		; special case, color 0..15 in bottom nybble

END	=	$80	; 0 :
CLEAR	=	$81	; 0 : clear screen to black (0)
BOX	=	$82	; 4 : x1,y1 to x2,y2
HLIN	=	$83	; 3 : x1,x2 at y1
VLIN	=	$84	; 3 : at x1 from y1 to y2
PLOT	=	$85	; 2 : x1,y1
HLIN_ADD=	$86	; 2 : x1,x2 at prev_y1+1
HLIN_ADD_LSAME=	$87	; 1 : prev_x1,x2 at prev_y1+1
HLIN_ADD_RSAME=	$88	; 1 : x1,prev_x2 at prev_y1+1
BOX_ADD=	$89	; 3 : x1,prev_y1+1, x2, y2
BOX_ADD_LSAME=	$8A	; 2 : prev_x1,prev_y1+1, x2, y2
BOX_ADD_RSAME=	$8B	; 2 : x1,prev_y1+1, prev_x2, y2
VLIN_ADD=	$8C	; 2 : at prev_x1+1 from y1 to y2

BLACK		= $00
RED		= $01
DARK_BLUE	= $02
MAGENTA		= $03
GREEN		= $04
GREY1		= $05
MEDIUM_BLUE	= $06
LIGHT_BLUE	= $07
BROWN		= $08
ORANGE		= $09
GREY2		= $0A
PINK		= $0B
LIGHT_GREEN	= $0C
YELLOW		= $0D
AQUA		= $0E
WHITE		= $0f

; top bit not set, command
; top bit set, repeat last command


; ??xx xxxx

; 00 = co-ord
; 10 = new command
; 11 = new-color


draw_scene:

	lda	#0	; always clear to black
;	sta	COLOR
	sta	clear_all_color+1
	jsr	clear_all

draw_scene_loop:

	lda	#200
	jsr	wait

	ldy	#0
	lda	(INL),Y				; load next byte

	bpl	repeat_last			; if top bit 0, repeat last
						; command

	asl					; clear top bit
	bmi	set_color			; if negative, color
	lsr					; shift back down

	sta	LAST_TYPE			; store last type

	jsr	inc_inl				; 16 bit increment

repeat_last:
	lda	LAST_TYPE

	beq	done_scene			; if 0, END


	; use jump table for rest
	and	#$3f
	tax
	dex				; types start at 1
	lda	draw_table_h,X
	sta	table_jsr_smc+2
;	pha
	lda     draw_table_l,X
;	pha
	sta	table_jsr_smc+1

table_jsr_smc:
	jsr	$FFFF

	;========================================
	; adds A to input pointer and continues
update_pointer:
	ldx	LAST_TYPE
	lda	bytes_used,X

update_pointer_already_in_a:
	clc
	adc	INL
	sta	INL
	lda	#0
	adc	INH
	sta	INH
	bcc	draw_scene_loop	; bra (would only be set if wrap $FFFF)


	;============================
	; done scene
	;============================
	; return
done_scene:
	rts


	;============================
	; set color
	;============================
	; color is A*2h

set_color:
	; make top and bottom byte the same

	lsr					; shift back down
	and	#$f
	sta	COLOR
	asl
	asl
	asl
	asl
	adc	COLOR
	sta	COLOR

	; special case as we are encoded differently from
	; the actions

	lda	#1				; we were one byte long
	bne	update_pointer_already_in_a	; bra

bytes_used:
	.byte 0,0,4,3	; END, CLEAR, BOX, HLIN
	.byte 3,2,2,1	; VLIN, PLOT, HLIN_ADD, HLIN_ADD_LSAME
	.byte 1,3,2,2	; HLIN_ADD_RSAME, BOX_ADD, BOX_ADD_LSAME
	.byte 2,2	; BOX_ADD_RSAME, VLIN_ADD

draw_table_l:
	.byte	<(clear_screen),<(draw_box),<(draw_hlin),<(draw_vlin)
	.byte	<(draw_plot)
	.byte	<(draw_hlin_add),<(draw_hlin_add_lsame),<(draw_hlin_add_rsame)
	.byte	<(draw_box_add),<(draw_box_add_lsame),<(draw_box_add_rsame)
	.byte	<(draw_vlin_add)
draw_table_h:
	.byte	>(clear_screen),>(draw_box),>(draw_hlin),>(draw_vlin)
	.byte	>(draw_plot)
	.byte	>(draw_hlin_add),>(draw_hlin_add_lsame),>(draw_hlin_add_rsame)
	.byte	>(draw_box_add),>(draw_box_add_lsame),>(draw_box_add_rsame)
	.byte	>(draw_vlin_add)

	;=================================
	;=================================
	; clear screen
	;=================================
	;=================================
clear_screen:
	lda	COLOR
	sta	clear_all_color+1
	jmp	clear_all		; tail call

	;=================================
	;=================================
	; draw box
	;=================================
	;=================================

	; blurgh.  Cases
	;	Y1=EVEN, Y2=ODD ->       loop Y1/2 to Y2/2, inclusive
	;	Y1=ODD,  Y2=ODD -> HLIN, loop (Y1/2)+1 to Y2/2 inclusive
	;	Y1=EVEN, Y2=EVEN->       loop Y1/2 to (Y2/2)-1, HLIN
	;	Y1=ODD, Y2=EVEN -> HLIN, loop (Y1/2)+1 to (Y2/2)-1, HLIN
	; 2/3 case, 1 to 1
	; 3/5 case, (>1) 2 to 2
	; 2/4 case, 1 to 1 (<2)
	; 3/4 case, 2 to 1 (!)
	; 3/6 case, 2 to 2
draw_box:
	lda	(INL),Y
	sta	X1
	iny
	lda	(INL),Y
	sta	Y1
	iny

draw_box_common_x2:

	lda	(INL),Y
	sta	X2

	;==================================
	; draw box common
	;==================================

draw_box_common:
	iny
	lda	(INL),Y
	sta	Y2		; keep even though not necessary

	lsr
	; if even, go to one less
	; else, fine
	bcs	odd_bottom_draw_box
even_bottom_draw_box:
	sec
	sbc	#1

odd_bottom_draw_box:

	sta	draw_box_yend_smc+1

	; see if we start at multiple of two

	lda	Y1
	lsr
	tay
	bcc	even_draw_box_start

	; we're odd, need to call HLIN

	jsr	hlin_mask_odd
	iny


even_draw_box_start:

draw_box_yloop:

draw_box_yend_smc:
	cpy	#0
	bcc	bbbb
	beq	bbbb
	jmp	done_draw_box_yloop		; bge

bbbb:
	lda	gr_offsets_l,Y
	sta	draw_box_xloop_smc+1

	lda	gr_offsets_h,Y
	clc
	adc	DRAW_PAGE
	sta	draw_box_xloop_smc+2

	lda	COLOR
	ldx	X2
draw_box_xloop:
draw_box_xloop_smc:
	sta	$400,X
	dex
	cpx	X1
	bpl	draw_box_xloop	; bge (signed)

	iny

	jmp	draw_box_yloop

done_draw_box_yloop:
	; done

	; if Y2 was even we need to fixup and draw one more line

	lda	Y2
	lsr
	bcs	definitely_odd_bottom

	jsr	hlin_mask_even

definitely_odd_bottom:
	; done

	rts


	;=================================
	;=================================
	; draw hlin
	;=================================
	;=================================
draw_hlin:

	lda	(INL),Y
	sta	X1
	iny
	lda	(INL),Y
	sta	X2
	iny
	lda	(INL),Y

	sta	Y1		; needed for HLIN_ADD


	;===================================
	;===================================
	; hlin common code
	;===================================
	;===================================
	; X1, X2 set up
	; Y-coord is in A
	; Y is A/2

hlin_common:

	lsr
	tay
	bcc	hlin_mask_even

hlin_mask_odd:
	lda	#$0F
	.byte	$2C		; bit trick
hlin_mask_even:
	lda	#$F0
	sta	MASK
	eor	#$FF
	and	COLOR
	sta	COLOR2

	lda	gr_offsets_l,Y
	sta	draw_hlin_l_xloop_smc+1
	sta	draw_hlin_s_xloop_smc+1

	lda	gr_offsets_h,Y
	clc
	adc	DRAW_PAGE
	sta	draw_hlin_l_xloop_smc+2
	sta	draw_hlin_s_xloop_smc+2

	ldx	X2
draw_hlin_xloop:
draw_hlin_l_xloop_smc:
	lda	$400,X
	and	MASK
	ora	COLOR2
draw_hlin_s_xloop_smc:
	sta	$400,X
	dex
	cpx	X1
	bpl	draw_hlin_xloop	; bge
done_hlin_xloop:
	rts



	;=================================
	;=================================
	; draw hlin add
	;=================================
	;=================================
	; increment Y1
draw_hlin_add:

	lda	(INL),Y
	sta	X1
	iny

draw_hlin_add_lsame:
	lda	(INL),Y
	sta	X2

hlin_inc_y1:
	inc	Y1
	lda	Y1

	jmp	hlin_common


	;=================================
	;=================================
	; draw hlin add_lsame
	;=================================
	;=================================
	; increment Y1
	; use old left value
;draw_hlin_add_lsame:

;	lda	(INL),Y
;	sta	X2

;	jmp	hlin_inc_y1


	;=================================
	;=================================
	; draw hlin add_rsame
	;=================================
	;=================================
	; increment Y1
	; use old right value
draw_hlin_add_rsame:

	lda	(INL),Y
	sta	X1

	jmp	hlin_inc_y1


	;=================================
	;=================================
	; draw box add
	;=================================
	;=================================
	; increment Y2, put into Y1
draw_box_add:
	lda	Y2
	sta	Y1
	inc	Y1

	lda	(INL),Y
	sta	X1
	iny

	jmp	draw_box_common_x2


	;=================================
	;=================================
	; draw box add_lsame
	;=================================
	;=================================
	; increment Y2, store in Y1
	; use old X1 value
draw_box_add_lsame:

	lda	Y2
	sta	Y1
	inc	Y1

	jmp	draw_box_common_x2


	;=================================
	;=================================
	; draw box add_rsame
	;=================================
	;=================================
	; increment Y2, put in Y1
	; use old right value X2
draw_box_add_rsame:

	lda	Y2
	sta	Y1
	inc	Y1

	lda	(INL),Y
	sta	X1

	jmp	draw_box_common


	;=================================
	;=================================
	; draw vlin add
	;=================================
	;=================================
draw_vlin_add:
	inc	X1				; X1 is prev_X1+1

	bne	draw_vlin_skip_x1		; bra


	;=================================
	;=================================
	; draw vlin
	;=================================
	;=================================
draw_vlin:
	lda	(INL),Y
	sta	X1
	iny
draw_vlin_skip_x1:
	lda	(INL),Y
	sta	Y1
	iny
	lda	(INL),Y
	sta	Y2

	;================================
draw_vlin_common:
	lda	Y2
	lsr
	; if even, go to one less
	; else, fine
	bcs	odd_bottom_vlin
even_bottom_vlin:
	sec
	sbc	#1

odd_bottom_vlin:

	sta	vlin_yend_smc+1

	; handle top
	; see if we start at multiple of two

	lda	Y1
	lsr
	tay				; needed!  Sets Y for vlin_yloop
	bcc	even_vlin_start

odd_vlin_start:
	; we're odd, need to call PLOT
	lda	Y1
	jsr	plot_common

	iny				; update Y for vlin_yloop


even_vlin_start:

vlin_yloop:
vlin_yend_smc:
	cpy	#0
	bcc	cccc
	beq	cccc
	jmp	done_vlin_yloop		;

cccc:

	lda	gr_offsets_l,Y
	sta	vlin_xloop_smc+1

	lda	gr_offsets_h,Y
	clc
	adc	DRAW_PAGE
	sta	vlin_xloop_smc+2

	lda	COLOR
	ldx	X1

vlin_xloop_smc:
	sta	$400,X

	iny

	jmp	vlin_yloop

	; done
done_vlin_yloop:

	; if Y2 was even we need to fixup and draw one more line

	lda	Y2
	lsr
	bcs	definitely_odd_vlin

	lda	Y2
	jmp	plot_common	; plot_mask_even (tail call)

definitely_odd_vlin:
	; done

	rts




	;=================================
	;=================================
	; draw plot
	;=================================
	;=================================
draw_plot:
	lda	(INL),Y
	sta	X1

	iny
	lda	(INL),Y
	sta	Y1		; needed for HLIN_ADD


	; fallthrough


	;===================================
	;===================================
	; plot common code
	;===================================
	;===================================
	; X-coord in X1
	; Y-coord in A
	; Y is Y-coord/2 at end
plot_common:

	lsr	; need Y-coord/2 because 2 rows per byte
	tay
	bcc	plot_mask_even
plot_mask_odd:
	lda	#$0F
	.byte	$2C		; bit trick
plot_mask_even:
	lda	#$F0
	sta	MASK
	eor	#$FF
	and	COLOR
	sta	COLOR2

	lda	gr_offsets_l,Y
	sta	plot_l_smc+1
	sta	plot_s_smc+1

	lda	gr_offsets_h,Y
	clc
	adc	DRAW_PAGE
	sta	plot_l_smc+2
	sta	plot_s_smc+2

	ldx	X1
plot_l_smc:
	lda	$400,X
	and	MASK
	ora	COLOR2
plot_s_smc:
	sta	$400,X

	rts

	;===========================
	; 16-bit increment of INL
	; inline this?
inc_inl:
	inc	INL
	bne	done_inc_inl
	inc	INH
done_inc_inl:
	rts

;.include "gr_fast_clear.s"

gr_offsets_l:
	.byte	<$400,<$480,<$500,<$580,<$600,<$680,<$700,<$780
	.byte	<$428,<$4a8,<$528,<$5a8,<$628,<$6a8,<$728,<$7a8
	.byte	<$450,<$4d0,<$550,<$5d0,<$650,<$6d0,<$750,<$7d0

gr_offsets_h:
	.byte	>$400,>$480,>$500,>$580,>$600,>$680,>$700,>$780
	.byte	>$428,>$4a8,>$528,>$5a8,>$628,>$6a8,>$728,>$7a8
	.byte	>$450,>$4d0,>$550,>$5d0,>$650,>$6d0,>$750,>$7d0

               ;0123456789012345678901234567890123456789
merry_text:
       .byte   "MERRY CHRISTMAS!!! MERRY CHRISTMAS!!! ME"



merry_graphics:
.incbin "graphics/merry.hgr.zx02"

.include "vapor_lock.s"
.include "delay_a.s"
