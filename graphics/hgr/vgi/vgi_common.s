; VGI library

VGI_MAXLEN      =       7

	;==================================
	; play_vgi
	;==================================
play_vgi:

vgi_loop:

	ldy	#0
data_smc:
	lda	(VGIL),Y
	sta	VGI_BUFFER,Y
	iny
	cpy	#VGI_MAXLEN
	bne	data_smc

	lda	TYPE
	and	#$f

	clc
	adc	VGIL
	sta	VGIL
	bcc	no_oflo
	inc	VGIH
no_oflo:

	lda	TYPE
	lsr
	lsr
	lsr
	lsr

	; look up action in jump table
	asl
	tax
	lda	vgi_rts_table+1,X
	pha
	lda	vgi_rts_table,X
	pha
	rts				; "jump" to subroutine

vgi_rts_table:
	.word vgi_clearscreen-1		; 0 = clearscreen
	.word vgi_simple_rectangle-1	; 1 = simple rectangle
	.word vgi_circle-1		; 2 = plain circle
	.word vgi_filled_circle-1	; 3 = filled circle
	.word vgi_point-1		; 4 = dot
	.word vgi_lineto-1		; 5 = line to
	.word vgi_dithered_rectangle-1	; 6 = dithered rectangle
	.word vgi_vertical_triangle-1	; 7 = vertical triangle
	.word vgi_horizontal_triangle-1	; 8 = horizontal triangle
	.word vgi_vstripe_rectangle-1	; 9 = vstripe rectangle
	.word vgi_line-1		;10 = line
	.word vgi_line_far-1		;11 = line far
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1		; 15 = done

all_done:
	rts


.include "vgi_clearscreen.s"
.include "vgi_circles.s"
.include "vgi_rectangle.s"
.include "vgi_lines.s"
.include "vgi_triangles.s"

