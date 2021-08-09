
; Apple II font based on the one in ROM that sadly we can't access
; For II/II+ was uppercase only 5x7 using 2513 character generator
; For IIe moved to 5x8 though the descenders on lowercase can touch next line

; This is fixed-width can only put the fonts easily in a 40x24 grid



	;===================
	; in OUTL/OUTH
	;	first byte X, next byte Y, then string (NUL terminated)
hgr_put_string:
	ldy	#0
	lda	(OUTL),Y
	sta	CURSOR_X
	jsr	inc_outl
	lda	(OUTL),Y
	sta	CURSOR_Y
	jsr	inc_outl
hgr_put_string_loop:
	ldy	#0
	lda	(OUTL),Y
	beq	hgr_put_string_done

	jsr	hgr_put_char_cursor

	inc	CURSOR_X
	jsr	inc_outl
	jmp	hgr_put_string_loop

hgr_put_string_done:
	rts



inc_outl:
	inc	OUTL
	bne	outl_no_oflo
	inc	OUTH
outl_no_oflo:
	rts

	;==================
	; X in X
	; Y in Y
	; Char in A
hgr_put_char:
	stx	CURSOR_X
	sty	CURSOR_Y
hgr_put_char_cursor:
	and	#$7f			; strip high bit
	sec
	sbc	#$20
	bpl	char_positive

	; control char, just print space
	lda	#$0

char_positive:

	ldx	#$0
	stx	put_char_smc1+1
	clc

	rol
	rol	put_char_smc1+1

	rol
	rol	put_char_smc1+1

	rol
	rol	put_char_smc1+1

	clc
	adc	#<(hgr_font)
	sta	INL
	lda	#>(hgr_font)
put_char_smc1:
	adc	#$d0
	sta	INH

	jsr	hgr_draw_sprite_1x8


	rts



.include "hgr_1x8_sprite.s"

; we skip control chars before $20

hgr_font:

; ' ' $20
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
; ! $21
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $00	; 00000
	.byte $04	; 00100
	.byte $00
; " $22
	.byte $0a	; 01010
	.byte $0a	; 01010
	.byte $0a	; 01010
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00
; #
	.byte $0a	; 01010
	.byte $0a	; 01010
	.byte $1f	; 11111
	.byte $0a	; 01010
	.byte $1f	; 11111
	.byte $0a	; 01010
	.byte $0a	; 01010
	.byte $00
; $
	.byte $04	; 00100
	.byte $0f	; 01111
	.byte $14	; 10100
	.byte $0e	; 01110
	.byte $05	; 00101
	.byte $1e	; 11110
	.byte $04	; 00100
	.byte $00
; %
	.byte $18	; 11000
	.byte $19	; 11001
	.byte $02	; 00010
	.byte $04	; 00100
	.byte $08	; 01000
	.byte $13	; 10011
	.byte $03	; 00011
	.byte $00
; &
	.byte $08	; 01000
	.byte $14	; 10100
	.byte $14	; 10100
	.byte $08	; 01000
	.byte $15	; 10101
	.byte $12	; 10010
	.byte $0d	; 01101
	.byte $00
; '
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00
; (
	.byte $04	; 00100
	.byte $08	; 01000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $08	; 01000
	.byte $04	; 00100
	.byte $00
; )
	.byte $04	; 00100
	.byte $02	; 00010
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $02	; 00010
	.byte $04	; 00100
	.byte $00
; *
	.byte $04	; 00100
	.byte $15	; 10101
	.byte $0e	; 01110
	.byte $04	; 00100
	.byte $0e	; 01110
	.byte $15	; 10101
	.byte $04	; 00100
	.byte $00
; +
	.byte $00	; 00000
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $1f	; 11111
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $00	; 00000
	.byte $00
; ,
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $08	; 01000
	.byte $00
; -
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $1f	; 11111
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 01000
	.byte $00
; .
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $04	; 00100
	.byte $00
; /
	.byte $00	; 00000
	.byte $01	; 00001
	.byte $02	; 00010
	.byte $04	; 00100
	.byte $08	; 01000
	.byte $10	; 10000
	.byte $00	; 00100
	.byte $00
; 0
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $13	; 10011
	.byte $15	; 10101
	.byte $19	; 11001
	.byte $11	; 10001
	.byte $0e	; 01110
	.byte $00
; 1
	.byte $04	; 00100
	.byte $0c	; 01100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $0e	; 01110
	.byte $00
; 2
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $01	; 00001
	.byte $06	; 00110
	.byte $08	; 01000
	.byte $10	; 10000
	.byte $1f	; 11111
	.byte $00
; 3
	.byte $1f	; 11111
	.byte $01	; 00001
	.byte $02	; 00010
	.byte $06	; 00110
	.byte $01	; 00001
	.byte $11	; 10001
	.byte $0e	; 01110
	.byte $00
; 4
	.byte $02	; 00010
	.byte $06	; 00110
	.byte $0a	; 01010
	.byte $12	; 10010
	.byte $1f	; 11111
	.byte $02	; 00010
	.byte $02	; 00010
	.byte $00
; 5
	.byte $1f	; 11111
	.byte $10	; 10000
	.byte $1e	; 11110
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $11	; 10001
	.byte $0e	; 01110
	.byte $00
; 6
	.byte $07	; 00111
	.byte $08	; 01000
	.byte $10	; 10000
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0e	; 01110
	.byte $00
; 7
	.byte $1f	; 11111
	.byte $01	; 00001
	.byte $02	; 00010
	.byte $04	; 00100
	.byte $08	; 01000
	.byte $08	; 01000
	.byte $08	; 01000
	.byte $00
; 8
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0e	; 01110
	.byte $00
; 9
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0f	; 01111
	.byte $01	; 00001
	.byte $02	; 00010
	.byte $1c	; 11100
	.byte $00
; :
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $04	; 00100
	.byte $00	; 00000
	.byte $04	; 00100
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00
; ;
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $04	; 00100
	.byte $00	; 00000
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $08	; 01000
	.byte $00
; <
	.byte $02	; 00010
	.byte $04	; 00100
	.byte $08	; 01000
	.byte $10	; 10000
	.byte $08	; 01000
	.byte $04	; 00100
	.byte $02	; 00010
	.byte $00
; =
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $1f	; 11111
	.byte $00	; 00000
	.byte $1f	; 11111
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00
; >
	.byte $08	; 01000
	.byte $04	; 00100
	.byte $02	; 00010
	.byte $01	; 00001
	.byte $02	; 00010
	.byte $04	; 00100
	.byte $08	; 01000
	.byte $00
; ?
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $02	; 00010
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $00	; 00000
	.byte $04	; 00100
	.byte $00
; @
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $15	; 10101
	.byte $17	; 10111
	.byte $16	; 10110
	.byte $10	; 10000
	.byte $0f	; 01111
	.byte $00
; A
	.byte $04	; 00100
	.byte $0a	; 01010
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1f	; 11111
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $00

	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
		; B
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $11	; 10001
	.byte $0e	; 01110
		; C
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
		; D
	.byte $1f	; 11111
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $1e	; 11110
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $1f	; 11111
		; E
	.byte $1f	; 11111
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $1e	; 11110
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
		; F
	.byte $0f	; 01111
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $13	; 10011
	.byte $11	; 10001
	.byte $0f	; 01111
		; G
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1f	; 11111
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
		; H
	.byte $0e	; 01110
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $0e	; 01110
		; I
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $11	; 10001
	.byte $0e	; 01110
		; J
	.byte $11	; 10001
	.byte $12	; 10010
	.byte $14	; 10100
	.byte $18	; 11000
	.byte $14	; 10100
	.byte $12	; 10010
	.byte $11	; 10001
		; K
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $1f	; 11111
		; L
	.byte $11	; 10001
	.byte $1b	; 11011
	.byte $15	; 10101
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
		; M
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $19	; 11001
	.byte $15	; 10101
	.byte $13	; 10011
	.byte $11	; 10001
	.byte $11	; 10001
		; N
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0e	; 01110
		; O
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
		; P
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $15	; 10101
	.byte $12	; 10010
	.byte $0d	; 01101
		; Q
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
	.byte $14	; 10100
	.byte $12	; 10010
	.byte $11	; 10001
		; R
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $10	; 10000
	.byte $0e	; 01110
	.byte $01	; 00001
	.byte $11	; 10001
	.byte $0e	; 01110
		; S
	.byte $1f	; 11111
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
		; T
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0e	; 01110
		; U
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0a	; 01010
	.byte $04	; 00100
		; V
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $15	; 10101
	.byte $15	; 10101
	.byte $1b	; 11011
	.byte $11	; 10001
		; W
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0a	; 01010
	.byte $04	; 00100
	.byte $0a	; 01010
	.byte $11	; 10001
	.byte $11	; 10001
		; X
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0a	; 01010
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
		; Y
	.byte $1f	; 11111
	.byte $01	; 00001
	.byte $02	; 00010
	.byte $04	; 00100
	.byte $08	; 01000
	.byte $10	; 10000
	.byte $1f	; 11111
		; Z
	.byte $1f	; 11111
	.byte $18	; 11000
	.byte $18	; 11000
	.byte $18	; 11000
	.byte $18	; 11000
	.byte $18	; 11000
	.byte $1f	; 11111
		; [
	.byte $00	; 00000
	.byte $10	; 10000
	.byte $08	; 01000
	.byte $04	; 00100
	.byte $02	; 00010
	.byte $01	; 00001
	.byte $00	; 00000
		; \.
	.byte $1f	; 11111
	.byte $03	; 00011
	.byte $03	; 00011
	.byte $03	; 00011
	.byte $03	; 00011
	.byte $03	; 00011
	.byte $1f	; 11111
		; ]
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $04	; 00100
	.byte $0a	; 01010
	.byte $11	; 10001
	.byte $00	; 00000
	.byte $00	; 00000
		; ^
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $1f	; 11111
		; _

;*******************
; Lowercase
;*******************

	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $15	; 10101
	.byte $17	; 10111
	.byte $16	; 10110
	.byte $10	; 10000
	.byte $0f	; 01111
		; @
	.byte $04	; 00100
	.byte $0a	; 01010
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1f	; 11111
	.byte $11	; 10001
	.byte $11	; 10001
		; A
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
		; B
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $11	; 10001
	.byte $0e	; 01110
		; C
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
		; D
	.byte $1f	; 11111
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $1e	; 11110
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $1f	; 11111
		; E
	.byte $1f	; 11111
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $1e	; 11110
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
		; F
	.byte $0f	; 01111
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $13	; 10011
	.byte $11	; 10001
	.byte $0f	; 01111
		; G
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1f	; 11111
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
		; H
	.byte $0e	; 01110
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $0e	; 01110
		; I
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $11	; 10001
	.byte $0e	; 01110
		; J
	.byte $11	; 10001
	.byte $12	; 10010
	.byte $14	; 10100
	.byte $18	; 11000
	.byte $14	; 10100
	.byte $12	; 10010
	.byte $11	; 10001
		; K
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $1f	; 11111
		; L
	.byte $11	; 10001
	.byte $1b	; 11011
	.byte $15	; 10101
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
		; M
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $19	; 11001
	.byte $15	; 10101
	.byte $13	; 10011
	.byte $11	; 10001
	.byte $11	; 10001
		; N
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0e	; 01110
		; O
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
		; P
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $15	; 10101
	.byte $12	; 10010
	.byte $0d	; 01101
		; Q
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
	.byte $14	; 10100
	.byte $12	; 10010
	.byte $11	; 10001
		; R
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $10	; 10000
	.byte $0e	; 01110
	.byte $01	; 00001
	.byte $11	; 10001
	.byte $0e	; 01110
		; S
	.byte $1f	; 11111
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
		; T
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0e	; 01110
		; U
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0a	; 01010
	.byte $04	; 00100
		; V
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $15	; 10101
	.byte $15	; 10101
	.byte $1b	; 11011
	.byte $11	; 10001
		; W
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0a	; 01010
	.byte $04	; 00100
	.byte $0a	; 01010
	.byte $11	; 10001
	.byte $11	; 10001
		; X
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0a	; 01010
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
		; Y
	.byte $1f	; 11111
	.byte $01	; 00001
	.byte $02	; 00010
	.byte $04	; 00100
	.byte $08	; 01000
	.byte $10	; 10000
	.byte $1f	; 11111
		; Z
	.byte $1f	; 11111
	.byte $18	; 11000
	.byte $18	; 11000
	.byte $18	; 11000
	.byte $18	; 11000
	.byte $18	; 11000
	.byte $1f	; 11111
		; [
	.byte $00	; 00000
	.byte $10	; 10000
	.byte $08	; 01000
	.byte $04	; 00100
	.byte $02	; 00010
	.byte $01	; 00001
	.byte $00	; 00000
		; \.
	.byte $1f	; 11111
	.byte $03	; 00011
	.byte $03	; 00011
	.byte $03	; 00011
	.byte $03	; 00011
	.byte $03	; 00011
	.byte $1f	; 11111
		; ]
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $04	; 00100
	.byte $0a	; 01010
	.byte $11	; 10001
	.byte $00	; 00000
	.byte $00	; 00000
		; ^
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $1f	; 11111
		; _


