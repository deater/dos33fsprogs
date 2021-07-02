; nyan

; by Vince `deater` Weaver <vince@deater.net> / dSr

; zero page

H2	= $2C
COLOR	= $30
X0	= $F0
XX	= $F1
FRAME	= $F2
Y1	= $F3

; soft-switches
FULLGR	= $C052

; ROM routines

PLOT	= $F800		;; PLOT AT Y,A
PLOT1	= $F80E		;; PLOT at (GBASL),Y (need MASK to be $0f or $f0)
HLINE	= $F819		;; HLINE Y,$2C at A
SETCOL	= $F864		;; COLOR=A
SETGR	= $FB40		;; init lores and clear screen
WAIT	= $FCA8		;; delay 1/2(26+27A+5A^2) us



;1DEFFNP(X)=PEEK(2054+I*5+X)-32:
;GR:POKE49234,0:
;FORI=0TO29:COLOR=FNP(0):FORY=FNP(3)TOFNP(4)
;:HLINFNP(1),FNP(2)ATY:NEXTY,I:GETA


	;================================
	; Clear screen and setup graphics
	;================================
boxes:

	jsr	SETGR		; set lo-res 40x40 mode

draw_box_loop:

	; get color/Y0
	jsr	load_byte
	tax			; Y0 is in X

	tya			; check for end

	bmi	end


	jsr	load_byte	; Y1
	sta	Y1

	jsr	load_byte	; X0
	sta	X0

	tya
	lsr
	lsr
	sta	COLOR


	jsr	load_byte	; X1
	sta	H2

	tya
	and	#$C0
	ora	COLOR

	lsr
	lsr
	lsr
	lsr

	jsr	SETCOL


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


end:
	jmp	end


	;=========================
	; load byte routine
	;=========================

load_byte:
	inc	load_byte_smc+1	; assume we are always < 256 bytes
				; so no need to wrap
load_byte_smc:
	lda	box_data-1
	tay
	and	#$3f
	rts


	; 4 6 6 6 6
box_data:
.byte $00,$27,$40,$27
	.byte $02,$25,$81,$26
	.byte $04,$23,$C2,$25
	.byte $06,$21,$03,$64
	.byte $08,$1F,$44,$63
	.byte $0A,$1D,$85,$62
	.byte $0C,$1B,$C6,$61
	.byte $0E,$19,$07,$A0
	.byte $10,$17,$48,$1F
	.byte $12,$15,$89,$1E
	.byte $12,$15,$89,$1E
	.byte $12,$15,$89,$1E
	.byte $FF
