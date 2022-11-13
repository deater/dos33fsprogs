draw_apple:

	;=============================
	; draw apple shape table logo
	;=============================
	; rotation in A

	pha
	lda	#10
	sta	HGR_SCALE

	ldy	#0
	ldx	#60
	txa
;	lda	#60

	jsr	HPOSN		; set screen position to X= (y,x) Y=(a)

	ldx	#<apple_table	; point to bottom byte of shape address
	ldy	#>apple_table	; point to top byte of shape address

	; ROT in A

	; this will be 0 2nd time through loop, arbitrary otherwise
	pla			; ROT
	jmp	XDRAW0		; XDRAW 1 AT X,Y
				; Both A and X are 0 at exit
				; Z flag set on exit
				; Y varies


;apple_table:
;.byte	$27,$2c,$35,$8e,$24,$2c
;.byte	$35,$be,$09,$24,$2c,$35,$be,$09
;.byte	$20,$24,$8c,$12,$2d,$3c,$37,$2e
;.byte	$0d,$25,$24,$4f,$39,$36,$2e,$00
