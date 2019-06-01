; Lo-res fire animation, size-optimized

; by deater (Vince Weaver) <vince@deater.net>

; based on code described here http://fabiensanglard.net/doom_fire_psx/

FIRE_YSIZE=20

	;=======================
	; fire_init
	;=======================
	; call at beginning to clear out framebuffer

fire_init:
	lda	#<fire_framebuffer
	sta	FIRE_FB_L

	lda	#>fire_framebuffer
	sta	FIRE_FB_H

	ldx	#FIRE_YSIZE
clear_fire_loop:

	lda	#0
	ldy	#39
clear_fire_line_loop:
	sta	(FIRE_FB_L),Y
	dey
	bpl	clear_fire_line_loop
done_fire_line_loop:

	clc
	lda	FIRE_FB_L
	adc	#40
	sta	FIRE_FB_L
	bcc	skip_inc_hi
	inc	FIRE_FB_H
skip_inc_hi:

	dex
	bne	clear_fire_loop

	lda	#7
	jsr	fire_setline

	rts



	;======================================
	; set bottom line to color in A
	;======================================
	; Set to 7 to init, Set to 0 to have fire go out
fire_setline:

	ldx	#<(fire_framebuffer+(FIRE_YSIZE-1)*40)
	stx	FIRE_FB_L

	ldx	#>(fire_framebuffer+(FIRE_YSIZE-1)*40)
	stx	FIRE_FB_H

	ldy	#39
set_fire_line:
	sta	(FIRE_FB_L),Y
	dey
	bpl	set_fire_line
done_set_fire_line:

	rts


	;===============================
	;===============================
	; Draw fire frame
	;===============================
	;===============================

draw_fire_frame:

	;===============================
	; Update fire frame
	;===============================
	; Unroll x 2

	; set up working line (to store to)

	lda	#<fire_framebuffer					; 2
	sta	fire_smc5_fb+1						; 4
	lda	#>fire_framebuffer					; 2
	sta	fire_smc5_fb+2						; 4

	; set up input line, one below,  (to load from)

	lda	#<(fire_framebuffer+40)					; 2
	sta	fire_smc5_fb2+1						; 4
	lda	#>(fire_framebuffer+40)					; 2
	sta	fire_smc5_fb2+2						; 4


	; loop X (ypos) from 0 - FIRE_YSIZE-1

	ldx	#0							; 2
fire_fb_update:

	; FIXME: optimize
	;	original = ??? (complex)
	; TODO: unroll once and combine with the lores copy on even lines?


	; Loop Y (xpos) from 39 to 0
	ldy	#39							; 2
fire_fb_update_loop:

	; Get random 16-bit number

	jsr	random16						; 40

	; get random number Q 0..3
	; Q used to see if whether we grab same lower value or if decrement

	lda	SEEDL							; 3
	and	#$3							; 2
	sta	FIRE_Q							; 3

	; 0..12 = A volume, 13-25 = B volume, 26-39 = C volume

	lda	A_VOLUME						; 3
	cpy	#13							; 2
	bcc	fire_vol	; blt					; 2/3
	lda	B_VOLUME						; 3
	cpy	#26							; 2
	bcc	fire_vol	; blt					; 2/3
	lda	C_VOLUME						; 3
fire_vol:
	and	#$f							; 2

	; adjust fire height with volume

	cmp	#$8							; 2
	bcs	fire_medium	; bge					; 2/3
fire_low:
	; Q=1 3/4 of time
	lda	FIRE_Q							; 3
	bne	fire_one	; 0-3, is not 0 3/4 of time		; 2/3
	beq	fire_set						; 3
fire_medium:
	cmp	#$d							; 2
	lda	FIRE_Q							; 3
	bcs	fire_high	; bge					; 2/3

	; Q=1 1/2 of time
	and	#$1							; 2
	bcc	fire_set	; branch always				; 3
fire_high:
	; Q=1 1/4 of time
	;;lda	FIRE_Q		; is 0 1/4 of time			; 3
	bne	fire_zero						; 2/3
fire_one:
	lda	#1							; 2
	bne	fire_set						; 3
fire_zero:
	lda	#0							; 2
fire_set:
	sta	FIRE_Q							; 3



	;=================
	; check if flame from left/right

	; store Y as we over-write it
	sty	FIRE_Y							; 3

	; bounds check
	; on edges, don't wrap

	tya								; 2
	beq	fire_r_same						; 2/3
	cpy	#39							; 2
	beq	fire_r_same						; 2/3

	; RAND_R
	; 50% chance fire comes from below
	; 25% chance comes from right
	; 25% change comes from left

	lda	SEEDH							; 3
	lsr								; 2
	and	#$1							; 2
	bne	fire_r_same						; 2/3
	bcc	r_up							; 2/3
r_down:
	dey								; 2
	.byte	$a9							; 2
r_up:
	iny								; 2
fire_r_same:

	; get next line color
fire_smc5_fb2:
	lda	$1234,Y							; 4+

	; restore saved Y
	ldy	FIRE_Y							; 3

	; have value, subtract Q
	sec								; 2
	sbc	FIRE_Q							; 3

	; saturate to 0
	bpl	fb_positive						; 2/3
	lda	#0							; 2
fb_positive:

	; store out
fire_smc5_fb:
	sta	$1234,Y			; store out			; 5

	dey								; 2
	bpl	fire_fb_update_loop					; 2/3

done_fire_fb_update_loop:

	; if just finished odd line, we are already set up
	; to do the framebuffer copy for the prev two lines?



	; complicated adjustment
	clc								; 2
	lda	fire_smc5_fb+1						; 4
	adc	#40							; 2
	sta	fire_smc5_fb+1						; 4
	bcc	skip_fb_inc1						; 2/3
	inc	fire_smc5_fb+2						; 4
	clc								; 2
skip_fb_inc1:

	lda	fire_smc5_fb2+1						; 4
	adc	#40							; 2
	sta	fire_smc5_fb2+1						; 4
	bcc	skip_fb2_inc1						; 2/3
	inc	fire_smc5_fb2+2						; 4
skip_fb2_inc1:

	inx								; 2
	cpx	#(FIRE_YSIZE-1)						; 2
	beq	fire_update_done					; 2/3
	jmp	fire_fb_update						; 3

fire_update_done:



	;===================================
	; copy framebuffer to low-res screen
	;===================================

	lda	#<fire_framebuffer					; 2
	sta	fire_smc_fb+1						; 5
	lda	#<(fire_framebuffer+40)					; 2
	sta	fire_smc_fb2+1						; 5

	lda	#>fire_framebuffer					; 2
	sta	fire_smc_fb+2						; 5
	;this lda could be omitted if values match
	lda	#>(fire_framebuffer+40)					; 2
	sta	fire_smc_fb2+2						; 5

	lda	#16							; 2
	sta	FIRE_FB_LINE						; 3

	ldx	#(FIRE_YSIZE/2)						; 2

fire_fb_copy:

	ldy	FIRE_FB_LINE						; 3
	iny								; 2
	iny								; 2
	sty	FIRE_FB_LINE						; 3


	; Set up output, self-modifying code
	lda	gr_offsets,Y						; 4+
	sta	fire_smc_outl+1						; 4
	lda	gr_offsets+1,Y						; 4+
	clc								; 2
	adc	DRAW_PAGE						; 3
	sta	fire_smc_outl+2						; 4

	; FIXME: below, can we do this better?
	; 50: original code
	; 39: move to big lookup table
	; 33: move save/restore X outside inner loop
	; 30: self-modifying code

	ldy	#39							; 2
	stx	FIRE_X							; 3
fire_fb_copy_loop:
	; get top byte
	; note, seems backwards, apple II LORES bottom byte is on top
fire_smc_fb2:
	lda	$1234,Y							; 4+
	asl								; 2
	asl								; 2
	asl								; 2
	; get bottom byte
fire_smc_fb:
	ora	$1234,Y							; 4+
	tax								; 2
	lda	fire_colors,X						; 4+
fire_smc_outl:
	sta	$1234,Y		; store out				; 5

	dey								; 2
	bpl	fire_fb_copy_loop					; 2/3
done_fire_fb_copy_loop:
	ldx	FIRE_X							; 3


	; complicated adjustment
	clc								; 2
	lda	fire_smc_fb+1						; 4
	adc	#80							; 2
	sta	fire_smc_fb+1						; 5
	bcc	skip_fb_inc2						; 2/3
	inc	fire_smc_fb+2						; 5
	clc								; 2
skip_fb_inc2:

	lda	fire_smc_fb2+1						; 4
	adc	#80							; 2
	sta	fire_smc_fb2+1						; 5
	bcc	skip_fb2_inc2						; 2/3
	inc	fire_smc_fb2+2						; 5
skip_fb2_inc2:

	dex								; 2
	bne	fire_fb_copy						; 2/3


	rts								; 6

;fire_colors_low:	.byte	$00,$00,$03,$02,$06,$07,$0E,$0F
;fire_colors_high:	.byte	$00,$00,$30,$20,$60,$70,$E0,$F0

fire_colors:
	; 0   1	  2   3	  4   5	  6   7
	; 0   0	  3   2	  6   7	  e   f
.byte	$00,$00,$03,$02,$06,$07,$0e,$0f		; 0
.byte	$00,$00,$03,$02,$06,$07,$0e,$0f		; 0
.byte	$30,$30,$33,$32,$36,$37,$3e,$3f		; 3
.byte	$20,$20,$23,$22,$26,$27,$2e,$2f		; 2
.byte	$60,$60,$63,$62,$66,$67,$6e,$6f		; 6
.byte	$70,$70,$73,$72,$76,$77,$7e,$7f		; 7
.byte	$e0,$e0,$e3,$e2,$e6,$e7,$ee,$ef		; e
.byte	$f0,$f0,$f3,$f2,$f6,$f7,$fe,$ff		; f

	; FIXME: just reserve space in our memory map
fire_framebuffer:
	.res    40*FIRE_YSIZE, $00

