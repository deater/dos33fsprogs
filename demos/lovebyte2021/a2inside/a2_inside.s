; Apple II self portrait using Boxes
;	running sierpinski inside
;	I heard you liked demos, so...

; by Vince `deater` Weaver <vince@deater.net> / dSr

; For LoveByte 2021

; 223 -- initial
; 220 -- update end
; 219 -- store color already multiplied by 17
; 215 -- load Y0 directly into X
; 211 -- load X1 directly into H2
; 208 -- add subroutine to read byte into A, no need to save Y
; 205 -- optimize end loop
; 197 -- only update color if changed
; 194 -- pack color in with the other 4 bytes
; 191 -- do more common stuff in load_byte
; 189 -- change how end is detected
; 260 -- add sierpinski code
; 255 -- optimize FRAME count
; 248 -- realize PLOT doesn't have to be fast
; 251 -- add pause at beginning
;	would have liked to have more elaborate startup, no room

; LoveByte Rule is 252 bytes (there's a 4-byte DOS33 header)

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
	bit	FULLGR		; make it 40x48

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


	;=========================
	; draw the demo
	;=========================
	; screen is from (11,6) - (20,23)
	; so size is 9,17?
end:

	; A comes in as $FF which is fine
	; actually frame value doesn't matter at all
;	lda	#0
;	sta	FRAME


	; pause a bit at beginning
	jsr	WAIT

sier_loop:

	lda	#100		; Wait a bit, we're too fast
	jsr	WAIT

	inc	FRAME		; increment frame

	ldx	#17		; YY

sier_yloop:

	lda	#9		; XX
	sta	XX

sier_xloop:

	txa			; get YY
	clc
	adc	FRAME		; and add in FRAME

	and	XX		; and it with XX

	bne	black
	lda	FRAME		; color is based on frame
	lsr			; only update every 16 lines?
	lsr
	lsr
	lsr
	bne	not_zero	; but no color 0 (would be all black)
	lda	#3		; how about purple instead

not_zero:

	.byte	$2C	; bit trick
black:
	lda	#$00

	jsr	SETCOL		; set top/bottom nibble same color

	lda	XX		; offset XX to tiny screen
	clc
	adc	#11
	tay			; put into Y

	txa			; offset YY to tiny screen
	clc
	adc	#6		; put into A

	jsr	PLOT		; PLOT AT Y,A

	dec	XX
	bpl	sier_xloop

	dex
	bpl	sier_yloop
	bmi	sier_loop


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
	.byte $00,$2F,$C0,$E7
	.byte $01,$2B,$0A,$9B
	.byte $28,$29,$43,$D4
	.byte $24,$27,$43,$D6
	.byte $20,$23,$45,$D7
	.byte $1C,$1F,$48,$D8
	.byte $23,$26,$07,$8E
	.byte $24,$27,$08,$92
	.byte $1F,$1F,$0D,$92
	.byte $2A,$2B,$43,$54
	.byte $2C,$2D,$46,$53
	.byte $2C,$2D,$14,$97
	.byte $08,$16,$1C,$9C
	.byte $02,$1A,$49,$D8
	.byte $04,$18,$0A,$95
	.byte $06,$17,$0B,$14
	.byte $15,$29,$22,$A2
	.byte $13,$28,$22,$A4
	.byte $13,$14,$5C,$63
	.byte $15,$16,$5B,$61
	.byte $17,$2B,$59,$E1
	.byte $18,$20,$1A,$20
	.byte $22,$2A,$1A,$20
	.byte $1C,$1C,$5B,$60
	.byte $26,$26,$5B,$60
	.byte $1F,$20,$DF,$1F
	.byte $29,$2A,$DF,$1F
	.byte $19,$1E,$5D,$5E
	.byte $23,$28,$5D,$5E
	.byte $02,$03,$17,$D7
	.byte $FF
