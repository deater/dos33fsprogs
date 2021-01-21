; make pictures by drawing boxes

; 223 -- initial
; 220 -- update end
; 219 -- store color already multiplied by 17
; 215 -- load Y0 directly into X
; 211 -- load X1 directly into H2

.include "zp.inc"
.include "hardware.inc"

X0	=	$F0
Y1	=	$F3


;1DEFFNP(X)=PEEK(2054+I*5+X)-32:
;GR:POKE49234,0:
;FORI=0TO29:COLOR=FNP(0):FORY=FNP(3)TOFNP(4)
;:HLINFNP(1),FNP(2)ATY:NEXTY,I:GETA


	;================================
	; Clear screen and setup graphics
	;================================
boxes:

	jsr	SETGR		; set lo-res 40x40 mode
	bit	FULLGR		; make it 40x48

draw_box_loop:

	; get color

	jsr	load_byte
	cmp	#$AA
end:
	beq	end		; hit end

	sta	COLOR

	jsr	load_byte
	tax

;	ldx	box_data+1,Y	; Y0

	jsr	load_byte
;	lda	box_data+2,Y
	sta	Y1


	jsr	load_byte
;	lda	box_data+3,Y
	sta	X0

	jsr	load_byte
;	lda	box_data+4,Y
	sta	H2

inner_loop:
	tya
	pha

	;; HLINE Y,H2 at A
	;; X left alone, carry set on exit
	;; H2 left alone
	;; Y and A trashed

	ldy	X0
	txa
	jsr	HLINE

	pla
	tay

	inx
	cpx	Y1
	beq	inner_loop
	bcc	inner_loop

	jmp	draw_box_loop


load_byte:
	lda	box_data
	inc	load_byte+1	; assume we are always < 256 bytes
				; so no need to wrap
	rts


	; 4 6 6 6 6
box_data:
	.byte $FF,$00,$2F,$00,$27
	.byte $88,$01,$2B,$0A,$1B
	.byte $DD,$28,$29,$03,$14
	.byte $DD,$24,$27,$03,$16
	.byte $DD,$20,$23,$05,$17
	.byte $DD,$1C,$1F,$08,$18
	.byte $88,$23,$26,$07,$0E
	.byte $88,$24,$27,$08,$12
	.byte $88,$1F,$1F,$0D,$12
	.byte $55,$2A,$2B,$03,$14
	.byte $55,$2C,$2D,$06,$13
	.byte $88,$2C,$2D,$14,$17
	.byte $88,$08,$16,$1C,$1C
	.byte $DD,$02,$1A,$09,$18
	.byte $88,$04,$18,$0A,$15
	.byte $00,$06,$17,$0B,$14
	.byte $88,$15,$29,$22,$22
	.byte $88,$13,$28,$22,$24
	.byte $55,$13,$14,$1C,$23
	.byte $55,$15,$16,$1B,$21
	.byte $DD,$17,$2B,$19,$21
	.byte $00,$18,$20,$1A,$20
	.byte $00,$22,$2A,$1A,$20
	.byte $55,$1C,$1C,$1B,$20
	.byte $55,$26,$26,$1B,$20
	.byte $33,$1F,$20,$1F,$1F
	.byte $33,$29,$2A,$1F,$1F
	.byte $55,$19,$1E,$1D,$1E
	.byte $55,$23,$28,$1D,$1E
	.byte $CC,$02,$03,$17,$17
	.byte $AA
