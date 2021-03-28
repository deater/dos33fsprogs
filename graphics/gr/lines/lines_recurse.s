; Bresenham Lines

; by Vince `deater` Weaver <vince@deater.net>

; http://www.retroprogramming.com/2016/05/divide-and-conquer-line-algorithm-for.html

.include "zp.inc"
.include "hardware.inc"

B_X1	= $F0
B_Y1	= $F1
B_X2	= $F2
B_Y2	= $F3
COUNT	= $F9

X1	=	$1000
Y1	=	$1100
X2	=	$1200
Y2	=	$1300
MIDX	=	$1400
MIDY	=	$1500

lines:

	jsr	SETGR		; set lo-res 40x40 mode
				; A=$D0 afterward

restart:
	lda	#0
	sta	COUNT
lines_loop:

	jsr	NEXTCOL

	lda	#0
	sta	X1
	lda	#36
	sta	Y2

	lda	COUNT
	cmp	#10
;end:
	beq	restart

	asl
	asl
	sta	Y1
	sta	X2

	jsr	draw_line

	inc	COUNT

	jmp	lines_loop



	;============================
	; draw line
	;	from x1,y1 to x2,y2
	;============================
draw_line:
	ldx	#0
draw_recurse:

;int draw ( ax, ay, bx, by )
;{
;    int midx, midy;
;    midx = ( ax+bx ) / 2;
;    midy = ( ay+by ) / 2;
;    if ( midx != ax && midy != ay )
;    {
;        draw( midx, midy, ax, ay );
;        draw( bx, by, midx, midy );
;        plot( midx, midy );
;    }
;}

	clc
	lda	X1,X
	adc	X2,X
	lsr
	sta	MIDX,X
	tay

	clc
	lda	Y1,X
	adc	Y2,X
	lsr
	sta	MIDY,X
	; plot midx,midy
	jsr	PLOT	;; PLOT AT Y,A (A colors output, Y preserved)

	; check if done

	lda	X1,X
	cmp	MIDX,X
	bne	recurse

	lda	Y1,X
	cmp	MIDY,X
	beq	done_draw_line

recurse:
	; draw( ax, ay, midx, midy);
	lda	MIDX,X
	sta	X1+1,X
	lda	MIDY,X
	sta	Y1+1,X
	lda	X1,X
	sta	X2+1,X
	lda	Y1,X
	sta	Y2+1,X

	inx

	jsr	draw_recurse

	; draw( bx, by, midx, midy );

	lda	X2,X
	sta	X1+1,X
	lda	Y2,X
	sta	Y1+1,X
	lda	MIDX,X
	sta	X2+1,X
	lda	MIDY,X
	sta	Y2+1,X

	inx

	jsr	draw_recurse

done_draw_line:
	dex
	rts


