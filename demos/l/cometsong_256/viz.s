; Need tiny demo

.include "hardware.inc"

;.zeropage
;.globalzp       frequencies_low
;.globalzp       frequencies_high

XX = $FE
YY = $FC

viz:

	jsr	SETGR			; enable lo-res graphics
					; A=$D0, Z=1
	bit	FULLGR

maine:
;	ldx	XX		; 2
;	lda	#13		; 2
;	sta	$402,X		; 3
;	lda	#9		; 2
;	sta	$401,X		; 3
;	lda	#0		; 2
;	sta	$400,X		; 3

;	inc	XX		; 2
			;==============
			;	19


				; 4
	ldx	#3		; 2
comet_loop:
	lda	colors,X	; 2
comet_smc:
	sta	$403,X		; 3
	dex			; 1
	bpl	comet_loop	; 2
	inc	comet_smc+1	; 2
			;==============
			;	16

	lda	star_smc+1
	and	#$f
	tax
	lda	frequencies_high,X	; 3

;	beq	skip			; 2
star_smc:
	sta	$500			; 3
skip:
	inc	star_smc+1		; 2
	inc	XX			; 2


.if 0
	ldx	XX			; 2
	txa
	asl
	and	XX
	tay
	eor	COSTBL,Y
blurgh:
	sta	$400,X			; 3
	inc	XX			; 2

	bne	skip

	inc	blurgh+2

skip:
.endif


.if 0
	ldx	XX			; 2
	txa
	asl
	and	XX

blurgh:
	sta	$400,X			; 3
	inc	XX			; 2

	bne	skip

	inc	blurgh+2

skip:
.endif

	lda	#140
	jsr	WAIT

	jmp	maine


colors:
	.byte 0,9,13,15

frequencies_high:
.byte $02,$00,$01,$01,$00,$01,$01,$00,$00,$00,$03,$00,$01,$01,$03,$01
