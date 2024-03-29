; Not actually 3D at all
;  is really a lo-res shape plotter that can play movie-like things

; o/~ We went to Threed to see the Queen o/~

;
; by deater (Vince Weaver) <vince@deater.net>

.include "../zp.inc"
.include "../hardware.inc"
.include "../qload2.inc"
;.include "music2.inc"

threed_start:


	;===================
	; Setup graphics
	;===================

	bit	SET_GR
	bit	LORES
	bit	FULLGR
	bit	PAGE1

	lda	#0
	sta	DRAW_PAGE

	bit	KEYRESET

	lda	#num_scenes
	sta	SCENE_COUNT

	lda	#<frame15
	sta	INL
	lda	#>frame15
	sta	INH

scene_loop:
	jsr	draw_scene

	;============================
	; flip pages
	;============================
	lda	DRAW_PAGE						; 3
	beq	was_page1						; 2/3
was_page2:
	bit     PAGE2							; 4
	lda	#$0							; 2
	beq	done_pageflip						; 2/3
was_page1:
	bit	PAGE1							; 4
	lda	#$4							; 2
done_pageflip:
	sta	DRAW_PAGE						; 3

	lda	#12
	sta	IRQ_COUNTDOWN

wait_for_irq:
	lda	IRQ_COUNTDOWN
	bne	wait_for_irq

	lda	KEYPRESS
	bmi	done_threed

	dec	SCENE_COUNT
	bne	scene_loop

done_threed:
	bit	KEYRESET

	rts


;===================================

;	.include	"../wait_keypress.s"

	.include	"draw_boxes.s"
	.include	"3d.inc"

