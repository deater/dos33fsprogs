; Lo-res movie player of sorts

; by deater (Vince Weaver) <vince@deater.net>

.include "zp.inc"
.include "hardware.inc"


movie1_start:


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

	lda	#<img025_bg_zx02
	sta	ZX0_src
	lda	#>img025_bg_zx02
        sta	ZX0_src+1

	lda	#$04			; decompress page1 (dangerous? holes?)

	jsr	full_decomp



.if 0
	lda	#num_scenes
	sta	SCENE_COUNT

	lda	#<frame15
	sta	INL
	lda	#>frame15
	sta	INH
.endif


.if 0


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
.endif

done_movie1:
	bit	KEYRESET

	jmp	done_movie1

	rts


;===================================

;	.include	"../wait_keypress.s"

;	.include	"draw_boxes.s"
	.include	"movie1/movie1.inc"

	.include	"zx02_optim.s"
