

shimmer:

	;=========================================
	; SETUP
	;=========================================


	jsr	HGR
	bit	FULLGR

	ldx	#88
	jsr	long_wait

	lda	#0
	sta	FRAME

	lda	#14
	sta	YPOS

	lda	#3
	sta	HGR_SCALE

	lda	#32
	sta	DIRECTION

	lda	#22		; only set once, we wrap
	sta	XPOS

y_loop:


x_loop:

main_loop:

	;=======================
	; xdraw
	;=======================

xdraw:
	; setup X and Y co-ords

	ldy	#0		; XPOSH always 0 for us
	ldx	XPOS
	lda	YPOS
	jsr	HPOSN		; X= (y,x) Y=(a)

	ldx	#<shape_dsr
	ldy	#>shape_dsr

	lda	#0		; set rotation

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit


	inc	FRAME
	lda	FRAME
	and	#$7
	beq	reverse

add_x:
	lda	XPOS
	clc
	adc	DIRECTION
	sta	XPOS
	jmp	x_loop

reverse:

	ldx	#26			; 26 is close
	jsr	long_wait

	lda	DIRECTION		; switch direction
	eor	#$ff
	sec
	adc	#0
	sta	DIRECTION

	lda	YPOS
	clc
	adc	#16
	sta	YPOS
	cmp	#190
	bne	y_loop

	;=====================================
	; shimmer
	;=====================================


do_shimmer:
	lda	#6
	sta	FRAME


do_shimmer_y:

	ldx	#0
do_shimmer_x:

blargh:
	lda	$2000,X
	eor	#$80
blargh2:
	sta	$2000,X
	inx
	bne	do_shimmer_x


	inc	blargh+2
	inc	blargh2+2

	lda	blargh+2
	cmp	#$40
	bne	do_shimmer_y

	lda	#$20
	sta	blargh+2
	sta	blargh2+2

	dec	FRAME
	bne	do_shimmer_y

	rts

shape_dsr:
.byte	$2d,$36,$ff,$3f
.byte	$24,$ad,$22,$24,$94,$21,$2c,$4d
.byte	$91,$3f,$36,$00
