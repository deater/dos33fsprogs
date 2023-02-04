

draw_wait_erase:
	jsr	xdraw			; draw

	lda	#100			; wait a bit
	jsr	WAIT

	jmp	xdraw			; draw for good


	;=========================
	; slide in
	;=========================

slide_in:

	lda	#4
	sta	HGR_SCALE

	lda	#0
	sta	WHICH

outer_slide_loop:

start_smc:
	lda	#252			; start position
	sta	XPOS			; 252 instead of 279 for size reasons

	lda	WHICH
	tax
type_smc:
	lda	desire_ends+1,X
	sta	ends_smc+1

offsets_smc:
	lda	deater_offsets,X	; point to next
	sta	xdraw_offset_smc+1

	bmi	done

slide_loop:

	jsr	draw_wait_erase

	clc
	lda	XPOS
add_smc:
	adc	#$FC
	sta	XPOS

	lsr				; derive rotation from location
	lsr
	and	#$f
	tax
	lda	rotate_pattern,X
	sta	ROTATE

	lda	XPOS			; see if hit end
ends_smc:
	cmp	#65
	bne	slide_loop

	jsr	xdraw			; one last draw so remains onscreen

	inc	WHICH			; move to next letter

	bpl	outer_slide_loop	; bra (WHICH always positive)
done:
	rts


	;=======================
	; xdraw
	;=======================

xdraw:
	ldy	#0		; guess we can't draw far right edge
	ldx	XPOS
	lda	YPOS
	jsr	HPOSN		; X= (y,x) Y=(a)

	clc			; get shape table from offset
	lda	#<shape_table_d
xdraw_offset_smc:
	adc	#0
	tax
	ldy	#>shape_table_d		; assume always in same page

	lda	ROTATE

	jmp	XDRAW0			; tail call


.if 0

	; border pattern

	lda	#4
	sta	HGR_SCALE
	lda	#67
	sta	xdraw_offset_smc+1
	lda	#8
	sta	ROTATE
	lda	#128
	sta	YPOS
loop:
	lda	#8
	sta	ROTATE
	lsr
	sta	XPOS
	jsr	xdraw

	lda	#$fc
	sta	ROTATE
	lda	#255
	sta	XPOS
	jsr	xdraw

	dec	YPOS
	dec	YPOS
	dec	YPOS
	dec	YPOS

	bne	loop

.endif


;	ldy	#3		; 2
;init_loop:
;	tya			; 1
;	asl
;	asl
;	sta	rotate_pattern,Y; 3
;	dey			; 1
;	bne	init_loop	; 2

.align $100


deater_offsets:
	.byte 0		; D
	.byte 8		; E
	.byte 15	; A
	.byte 23	; T
	.byte 8		; E
	.byte 30	; R
	.byte $FF	; end


ma2e_offsets:
	.byte 8		; E
	.byte 47	; 2
	.byte 15	; A
	.byte 39	; M
	.byte $FF	; end


desire_offsets:
	.byte 67	; -
	.byte 0		; D
	.byte 8		; E
	.byte 54	; S
	.byte 61	; I
	.byte 30	; R
	.byte 8		; E
	.byte 67	; -
	.byte $FF	; end

desire_ends:
	; center of screen is 140, offset by 16 each way
	.byte	28,60,92,124,156,188,220,252

ma2e_ends:
	.byte	 188,156,124,92

rotate_pattern:
	; offset by 3 to give original effect
;	.byte 0,3,6
	.byte 9, 9,6,3,0, 0,$FD,$FA,$F7, $F7,$FA,$FD, 0
	.byte 0,3,6


shape_table:

shape_table_d:	.byte	$23,$2c,$2e,$36, $37,$27,$04,$00	; 0
shape_table_e:	.byte	$27,$2c,$95,$12, $3f,$24,$00		; 8
shape_table_a:	.byte	$23,$2c,$35,$96, $24,$3f,$36,$00	; 15
shape_table_t:	.byte	$12,$24,$e4,$2b, $2d,$05,$00		; 23
shape_table_r:	.byte	$97,$24,$24,$2d, $36,$37,$35,$06,$00	; 30
shape_table_m:	.byte	$24,$37,$36,$4e, $24,$24,$07,$00	; 39
shape_table_2:	.byte	$25,$3c,$97,$39, $36,$2d,$00		; 47
shape_table_s:	.byte	$27,$2c,$95,$2b, $36,$3f,$00		; 54
shape_table_i:	.byte	$d2,$ed,$24,$e4, $2d,$00		; 61
shape_table_hline:	.byte	$2b,$05,$00			; 67




;shape_table_vline:	.byte	$12,$24,$24,$00			; 67
;shape_table_o:	.byte	$23,$2c,$35,$36, $3e,$27,$04,$00	;
;shape_table_v:	.byte	$18,$30,$36,$35, $28,$24,$04,$00	;

