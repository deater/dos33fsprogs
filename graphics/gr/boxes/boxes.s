; make pictures by drawing boxes

; 223 -- initial
; 220 -- update end
; 219 -- store color already multiplied by 17
; 215 -- load Y0 directly into X
; 211 -- load X1 directly into H2
; 208 -- add subroutine to read byte into A, no need to save Y
; 205 -- optimize end loop
; 197 -- only update color if changed

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
	bmi	use_old_color
	cmp	#$7F
end:
	beq	end		; hit end

	jsr	SETCOL

	jsr	load_byte	; Y0

use_old_color:
	and	#$3f
	tax

	jsr	load_byte	; Y1
	sta	Y1

	jsr	load_byte	; X0
	sta	X0

	jsr	load_byte	; X1
	sta	H2

inner_loop:

	;; HLINE Y,H2 at A
	;; X left alone, carry set on exit
	;; H2 left alone
	;; Y and A trashed

	ldy	X0
	txa
	jsr	HLINE

	cpx	Y1
	inx
	bcc	inner_loop
	bcs	draw_box_loop


load_byte:
	inc	load_byte_smc+1	; assume we are always < 256 bytes
				; so no need to wrap
load_byte_smc:
	lda	box_data-1

	rts


	; 4 6 6 6 6
box_data:

	.byte $0F,$00,$2F,$00,$27
	.byte $08,$01,$2B,$0A,$1B
	.byte $0D,$28,$29,$03,$14
	.byte $A4,$27,$03,$16
	.byte $A0,$23,$05,$17
	.byte $9C,$1F,$08,$18
	.byte $08,$23,$26,$07,$0E
	.byte $A4,$27,$08,$12
	.byte $9F,$1F,$0D,$12
	.byte $05,$2A,$2B,$03,$14
	.byte $AC,$2D,$06,$13
	.byte $08,$2C,$2D,$14,$17
	.byte $88,$16,$1C,$1C
	.byte $0D,$02,$1A,$09,$18
	.byte $08,$04,$18,$0A,$15
	.byte $00,$06,$17,$0B,$14
	.byte $08,$15,$29,$22,$22
	.byte $93,$28,$22,$24
	.byte $05,$13,$14,$1C,$23
	.byte $95,$16,$1B,$21
	.byte $0D,$17,$2B,$19,$21
	.byte $00,$18,$20,$1A,$20
	.byte $A2,$2A,$1A,$20
	.byte $05,$1C,$1C,$1B,$20
	.byte $A6,$26,$1B,$20
	.byte $03,$1F,$20,$1F,$1F
	.byte $A9,$2A,$1F,$1F
	.byte $05,$19,$1E,$1D,$1E
	.byte $A3,$28,$1D,$1E
	.byte $0C,$02,$03,$17,$17
	.byte $7F
