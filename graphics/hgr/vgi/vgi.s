; VGI

.include "zp.inc"
.include "hardware.inc"

VGI_MAXLEN	=	7

vgi_test:
	jsr	HGR2

	; get pointer to image data

	lda	#<clock_data
	sta	VGIL
	lda	#>clock_data
	sta	VGIH

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
	.word vgi_clearscreen-1
	.word vgi_simple_rectangle-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1
	.word all_done-1

all_done:
	jmp	all_done


.include "vgi_clearscreen.s"
.include "vgi_rectangle.s"

.include "clock.data"
