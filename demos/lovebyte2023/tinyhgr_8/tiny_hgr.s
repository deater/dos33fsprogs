; Tiny HGr

; 8-byte Apple II Hi-res intro

; by Vince `deater` Weaver, vince@deater.net	--- d e s i r e ---

; drops into the middle of the CHRGET get next token routine
; that the Applesoft interpreter copies to $B1 - $C8 on boot

; Depends on $F3 being executed as a NOP

; zero page locations

; ROM calls
HGR2 = $F3D8
HPOSN = $F411
XDRAW0 = $F65D
BKGND0         = $F3F4	; A is color, after A=$40/$60, Y=0
			; $E6 needs to be $20/$40
			;   alternately can jump slightly further
			;   and have $1B be $20/$40

tiny_hgr:

;chrget	B1:	E6 B8		inc	txtptrl
;	B3:	D0 02		bne	chrgot
;	B5:	E6 B9		inc	txtptrh
;chrgot	B7:	AD 00 08	lda	$800	txtprtrl/txtptrh
;	BA:	C9 3A		cmp	#$3A
;	BC:	B0 0A		bcs	end
;	BE:	C9 20		cmp	#$20
;	C0:	F0 EF		beq	chrget
;	C2:	38		sec
;	C3:	E9 30		sbc	#$30
;	C5:	38		sec
;	C6:	E9 D0		sbc	#$D0
;	C8:	60		rts


; we drop this at B8


tiny_loop:
.byte	$2c	; BIT 		; skips the BKGND0 first time through
				;	otherwise it rights garbage all over
				;	first 8k of RAM due to HGR_PAGE
				;	not being set

	nop	; $EA		; points to ROM $EA2C as base for random colors

	jsr	BKGND0		; clear screen to value in A
				; $20 $F3 $F4, depends on f3/f4 being nops
				;	first time through the loop

	jsr	HGR2		; HGR2	-- init full-screen hi-res graphics
				; zero flag set

; code already in RAM does a BEQ
