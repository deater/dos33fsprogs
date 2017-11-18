
game_over:
	lda	#$a0
	jsr	clear_top_a

	bit	SET_TEXT

	lda	#10
	sta	CV
	lda	#15
	sta	CH

	lda     #>(game_over_man)
        sta     OUTH
        lda     #<(game_over_man)
        sta     OUTL

	jsr	move_and_print

	jsr	page_flip

hang_forever:
	jmp	hang_forever

	rts

game_over_man:
	.asciiz	"GAME OVER"

show_map:

	lda	DRAW_PAGE
	clc
	adc	#$4
	sta	BASH
	lda	#$00
	sta	BASL

	lda     #>(map_rle)
	sta     GBASH
	lda     #<(map_rle)
	sta     GBASL
	jsr     load_rle_gr


	; basic_plot(8+((map_x&0x3)*6)+(tfv_x/6),
	;	8+(((map_x&0xc)>>2)*6)+(tfv_y/6))

	; horizontal

	lda	MAP_X
	and	#3
	asl
	sta	TEMP
	asl
	clc
	adc	TEMP		; ( MAP_X & 3 ) * 6
	sta	TEMP

	lda	TFV_X
	lsr
	lsr
	lsr			; TFV/8

	adc	TEMP
	adc	#8
	sta	CH

	; vertical

	lda	MAP_X
	and	#$c
	lsr
	sta	TEMP
	asl
	clc
	adc	TEMP		; ( MAP_X & C ) * 6
	sta	TEMP

	lda	TFV_Y
	lsr
	lsr
	lsr			; TFV/8

	adc	TEMP
	adc	#8
	lsr			; divide by 2 as htab_vtab multiplies
	sta	CV

	jsr	htab_vtab
	lda	#$19		; red/orange
	ldy	#0
	sta	(BASL),Y


	jsr	page_flip

	jsr	wait_until_keypressed

	rts



print_help:
	lda	#$a0
	jsr	clear_top_a

	bit	SET_TEXT

	lda	#1
	sta	CV
	lda	#18
	sta	CH

	lda     #>(help1)
        sta     OUTH
        lda     #<(help1)
        sta     OUTL

	jsr	move_and_print
	jsr	point_to_end_string

	lda	#3
	sta	CV
	lda	#4
	sta	CH

help_loop:
	jsr	move_and_print
	jsr	point_to_end_string
	inc	CV

	lda	#11
	cmp	CV
	bne	help_loop

	jsr	page_flip

	jsr	wait_until_keypressed

	bit     SET_GR                  ; set graphics

	rts

help1:	.asciiz "HELP"
help2:	.asciiz "ARROWS  - MOVE"
help3:	.asciiz "W/A/S/D - MOVE"
help4:	.asciiz "Z/X     - SPEED UP / SLOW DOWN"
help5:	.asciiz "SPACE   - STOP"
help6:	.asciiz "RETURN  - LAND / ENTER / ACTION"
help7:	.asciiz "I       - INVENTORY"
help8:	.asciiz "M       - MAP"
help9:	.asciiz "ESC     - QUIT"

