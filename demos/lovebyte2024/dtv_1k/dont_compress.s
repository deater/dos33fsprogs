; Don't Tell Valve

; by Vince `deater` Weaver / DsR

.include "zp.inc"

.incbin "graphics/scene.hgr"

dont:

;	jsr	HGR		; Hi-res, full screen		; 3
				; Y=0, A=0 after this call

	lda	#$1
	sta	HGR_SCALE
	lda	#$0
	sta	HGR_ROTATION
	sta	FRAME

	lda	#<chell_right
	sta	SHAPE_L
	lda	#>chell_right
	sta	SHAPE_H


	lda	#9
	sta	CX

	lda	#113
	sta	CY

	;==========================
	; jump into sludge

	jsr	do_motion

	;========================
	; in sludge

	lda	#$20
	sta	HGR_ROTATION

	inc	FRAME
	jsr	do_motion

	;========================
	; try again

	lda	#$0
	sta	HGR_ROTATION
	lda	#9
	sta	CX

	lda	#113
	sta	CY

	inc	FRAME
	jsr	do_motion

	;========================
	; make portals (TODO)

	inc	HGR_SCALE

	lda	#<portal
	sta	SHAPE_L
	lda	#>portal
	sta	SHAPE_H

	lda	#115
	sta	CX
	lda	#105
	sta	CY

	jsr	do_xdraw

	lda	#164
	sta	CX

	jsr	do_xdraw


	;========================
	; jump again

	dec	HGR_SCALE

	lda	#<chell_right
	sta	SHAPE_L
	lda	#>chell_right
	sta	SHAPE_H

	lda	#105
	sta	CX
	lda	#113
	sta	CY

	inc	FRAME
	jsr	do_motion

	;=======================
	; portal warp

	lda	#163
	sta	CX

	inc	FRAME
	jsr	do_motion




;wait_for_it:
;	lda	KEYPRESS
;	bpl	wait_for_it
;	bit	KEYRESET

	jmp	still

	;======================
	; do motion
	;======================
do_motion:

frame_loop:
	ldy	FRAME
	lda	motion,Y
	cmp	#$ff
	beq	done_move

	pha

	and	#$f
	clc
	adc	CX
	sta	CX

	pla

	rol
	php
	rol
	rol
	rol
	rol
	and	#$7
	sta	MOVEMENT
	plp
	bcs	do_sub
do_add:
	clc
	adc	CY
	jmp	done_addsub
do_sub:
	sec
	lda	CY
	sbc	MOVEMENT

done_addsub:
	sta	CY

	jsr	do_xdraw

	lda	#200
	jsr	WAIT

	jsr	do_xdraw

	inc	FRAME

	jmp	frame_loop

done_move:
	rts

	;==================================
	; motion data

motion:
	.byte	$00
	.byte	$06,$06,$06,$06,$06,$06,$06,$06
	.byte	$06,$06,$06,$06,$06,$06,$06,$06
	.byte	$00,$00,$00,$00
	.byte	$B4,$A4,$94,$84,$14,$24,$34,$44
	.byte	$44,$44,$44,$00
	.byte	$FF
	; in sludge
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$FF
	; again with portals
	.byte	$00
	.byte	$06,$06,$06,$06,$06,$06,$06,$06
	.byte	$06,$06,$06,$06,$06,$06,$06,$06
	.byte	$00,$00,$00,$00
	.byte	$FF
	; portal jump left
	.byte	$00,$00,$00,$00,$B4,$A4,$94,$84,$FF
	; portal jump right
	.byte	$04,$14,$24,$34,$04,$04,$04
	.byte	$06,$06,$06,$06,$06,$06,$06,$06
	.byte	$06,$06,$02,$02
	.byte	$00,$00,$00,$00,$00,$00,$00,$FF

	;====================================


do_xdraw:

	; A and Y are 0 here.
	; X is left behind by the boot process?

	; set GBASL/GBASH
	; we really have to call this, otherwise it won't run
	; on some real hardware depending on setup of zero page at boot


	ldy	#0
	ldx	CX
	lda	CY
	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)
				; saves X,Y,A to zero page
				; after Y= orig X/7
				; A and X are ??

	ldx	SHAPE_L			; load $E2 into A, X, and Y
	ldy	SHAPE_H			; 	our shape table is in ROM at $E2E2
	lda	HGR_ROTATION

	jsr	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies

	rts




;.byte	$07,$00
;.byte	$10,$00, $1b,$00, $2e,$00
;.byte	$42,$00, $61,$00, $80,$00
;.byte	$8a,$00

; crosshair

;.byte	$1b,$6d,$39,$97,$12,$24,$24,$24
;.byte	$24,$04,$00

; portal
portal:
.byte	$1b,$24,$0c,$24,$0c
.byte	$15,$36,$0e,$36,$36,$1e,$36,$1e
.byte	$1c,$24,$1c,$24,$04,$00

; sideways portal

;.byte	$52,$0d
;.byte	$0d,$0d,$6c,$24,$1f,$fc,$1f,$1f
;.byte	$1f,$1f,$1f,$fe,$36,$0d,$6e,$0d
;.byte	$05,$00

; chell right
chell_right:
.byte	$1b,$36,$36,$36,$0d,$df
.byte	$1b,$24,$0c,$24,$24,$1c,$24,$64
.byte	$69,$1e,$37,$2d,$1e,$77,$6e,$25
.byte	$2d,$2d,$f5,$ff,$13,$2d,$2d,$2d
.byte	$00

; chell left

;.byte	$09,$36,$36,$36,$1f,$4d,$09
;.byte	$24,$1c,$24,$24,$0c,$24,$e4,$fb
;.byte	$0e,$35,$3f,$0e,$f5,$fe,$27,$3f
;.byte	$3f,$77,$6d,$11,$3f,$3f,$3f,$00

; fireball

;.byte	$12,$0c,$0c,$1c,$1c,$1e,$1e,$0e
;.byte	$0e,$00

; blue core
;.byte	$fa,$24,$0d,$0d,$36,$9f
;.byte	$3a,$3f,$3c,$3c,$2c,$3c,$0c,$25
;.byte	$2d,$2d,$2d,$2e,$2e,$3e,$2e,$1e
;.byte	$37,$3f,$07,$00

.include "still.s"


