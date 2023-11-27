; dots
; based on Second Reality Dots code

; zero-page
GBASL	=	$26
GBASH	=	$27
MASK	=	$2E
COLOR	=	$30

DRAW_PAGE = 	$E0

OUTL	=	$FC
OUTH	=	$FD
INL	=	$FE
INH	=	$FF

; soft-switches
FULLGR  =       $C052
PAGE1	=	$C054
PAGE2	=	$C055

; ROM routines
PLOT	=	$F800   ;; PLOT AT Y,A
SETGR	=	$FB40

WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

dots:
	jsr	SETGR
	bit	FULLGR

init_vars:

	lda	#0
	sta	DRAW_PAGE

	;===============================
	; setup

	lda	#<dot_data
	sta	INL
	lda	#>dot_data
	sta	INH

main_loop:

	; FIXME: draw once offscreen and do a fast copy
draw_background:

	ldx	#11
draw_sky_outer_loop:
	lda	gr_offsets_l,X
	sta	GBASL
	lda	gr_offsets_h,X
	clc
	adc	DRAW_PAGE
	sta	GBASH

	lda	#0
	ldy	#39
draw_sky_inner_loop:
	sta	(GBASL),Y
	dey
	bpl	draw_sky_inner_loop

	dex
	bpl	draw_sky_outer_loop

	ldx	#23
draw_ground_outer_loop:
	lda	gr_offsets_l,X
	sta	GBASL
	lda	gr_offsets_h,X
	clc
	adc	DRAW_PAGE
	sta	GBASH

	lda	#$55			; grey
	ldy	#39
draw_ground_inner_loop:
	sta	(GBASL),Y
	dey
	bpl	draw_ground_inner_loop

	dex
	cpx	#11
	bne	draw_ground_outer_loop

	jmp	decode_loop



	;===============================
decode_next:
	inc	INL
	bne	decode_loop
	inc	INH

decode_loop:
	ldy	#0
	lda	(INL),Y

	cmp	#$FF
	bne	check_shadow

	jmp	done

check_shadow:
	cmp	#$FE
	bne	check_balls

	lda	#$00
	sta	COLOR
	beq	done_frame

check_balls:
	cmp	#$FD
	bne	check_row

	lda	#$66
	sta	COLOR
	bne	decode_next

check_row:
	tax
	and	#$C0
	bne	check_dot_both

	; row value
	txa
	and	#$1F
	tax
	lda	gr_offsets_l,X
	sta	OUTL
	lda	gr_offsets_h,X
	clc
	adc	DRAW_PAGE
	sta	OUTH
	bne	decode_next

check_dot_both:
	cmp	#$C0
	bne	check_dot_top
draw_dot_both:
	txa
	and	#$3f
	tay
	lda	COLOR
	sta	(OUTL),Y
	jmp	decode_next

	;==================

check_dot_top:
	cmp	#$80
	bne	check_dot_bottom
draw_dot_top:
	txa
	and	#$3f
	tay

	lda	COLOR
	and	#$0F
	sta	MASK

	lda	(OUTL),Y
	and	#$F0
	ora	MASK
	sta	(OUTL),Y
	jmp	decode_next

check_dot_bottom:
draw_dot_bottom:
	txa
	and	#$3f
	tay

	lda	COLOR
	and	#$F0
	sta	MASK

	lda	(OUTL),Y
	and	#$0F
	ora	MASK

	sta	(OUTL),Y
	jmp	decode_next

done_frame:
	inc	INL
	bne	done_frame_noinc
	inc	INH
done_frame_noinc:

	; switch pages

	lda	DRAW_PAGE
	beq	switch_to_draw_page2

	bit	PAGE2
	lda	#0
	beq	done_switch_page

switch_to_draw_page2:
	bit	PAGE1
	lda	#$4
done_switch_page:
	sta	DRAW_PAGE





	; delay 143000us

	; delay 1/2(26+27A+5A^2) us
	; ~236

	lda	#236
	jsr	WAIT

	jmp	draw_background


done:
	jmp	done


gr_offsets_h:
	.byte	>$400,>$480,>$500,>$580,>$600,>$680,>$700,>$780
	.byte	>$428,>$4a8,>$528,>$5a8,>$628,>$6a8,>$728,>$7a8
	.byte	>$450,>$4d0,>$550,>$5d0,>$650,>$6d0,>$750,>$7d0


gr_offsets_l:
	.byte	<$400,<$480,<$500,<$580,<$600,<$680,<$700,<$780
	.byte	<$428,<$4a8,<$528,<$5a8,<$628,<$6a8,<$728,<$7a8
	.byte	<$450,<$4d0,<$550,<$5d0,<$650,<$6d0,<$750,<$7d0

dot_data:
.incbin "out2.128.7fps",0,36000
