
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
	;  in X
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
	.byte $10	; 00100
	.byte $10	; 00100
	.byte $10	; 00100
	.byte $10	; 00100
	.byte $10	; 00100
	.byte $00	; 00000
	.byte $10	; 00100
	.byte $00
; " $22
	.byte $28	; 01010
	.byte $28	; 01010
	.byte $28	; 01010
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00
; # $23
	.byte $28	; 01010
	.byte $28	; 01010
	.byte $7c	; 11111
	.byte $28	; 01010
	.byte $7c	; 11111
	.byte $28	; 01010
	.byte $28	; 01010
	.byte $00
; $ $24
	.byte $10	; 00100
	.byte $3c	; 01111
	.byte $50	; 10100
	.byte $38	; 01110
	.byte $14	; 00101
	.byte $78	; 11110
	.byte $10	; 00100
	.byte $00
; % $25
	.byte $60	; 11000
	.byte $64	; 11001
	.byte $08	; 00010
	.byte $10	; 00100
	.byte $20	; 01000
	.byte $4c	; 10011
	.byte $0c	; 00011
	.byte $00
; & $26
	.byte $20	; 01000
	.byte $50	; 10100
	.byte $50	; 10100
	.byte $20	; 01000
	.byte $54	; 10101
	.byte $48	; 10010
	.byte $34	; 01101
	.byte $00
; ' $27
	.byte $10	; 00100
	.byte $10	; 00100
	.byte $10	; 00100
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00
; ( $28
	.byte $10	; 00100
	.byte $20	; 01000
	.byte $40	; 10000
	.byte $40	; 10000
	.byte $40	; 10000
	.byte $20	; 01000
	.byte $10	; 00100
	.byte $00
; ) $29
	.byte $10	; 00100
	.byte $08	; 00010
	.byte $04	; 00001
	.byte $04	; 00001
	.byte $04	; 00001
	.byte $08	; 00010
	.byte $10	; 00100
	.byte $00
; * $2A
	.byte $10	; 00100
	.byte $54	; 10101
	.byte $38	; 01110
	.byte $10	; 00100
	.byte $38	; 01110
	.byte $54	; 10101
	.byte $10	; 00100
	.byte $00
; + $2B
	.byte $00	; 00000
	.byte $10	; 00100
	.byte $10	; 00100
	.byte $7c	; 11111
	.byte $10	; 00100
	.byte $10	; 00100
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
; ? $3F
	.byte $1c	; 01110 X001 1100
	.byte $22	; 10001 X010 0010
	.byte $10	; 00010 X001 0000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $00	; 00000 X000 0000
	.byte $08	; 00100 X000 1000
	.byte $00
; @ $40
	.byte $1c	; 01110 X001 1100
	.byte $22	; 10001 X010 0010
	.byte $2a	; 10101 X010 1010
	.byte $3a	; 10111 X011 1010
	.byte $1a	; 10110 X001 1010
	.byte $02	; 10000 X000 0010
	.byte $3c	; 01111 X011 1100
	.byte $00
; A $41
	.byte $08	; 00100	X000 1000
	.byte $14	; 01010 X001 0100
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $3E	; 11111 X011 1110
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $00
; B $42
	.byte $1E	; 11110	X001 1110
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $1E	; 11110 X001 1110
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $1E	; 11110 X001 1110
	.byte $00
; C $43
	.byte $1c	; 01110 X001 1100
	.byte $22	; 10001 X010 0010
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $22	; 10001 X010 0010
	.byte $1c	; 01110 X001 1100
	.byte $00
; D $44
	.byte $1e	; 11110 X001 1110
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $1e	; 11110 X001 1110
	.byte $00
; E $45
	.byte $3E	; 11111 X011 1110
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $1e	; 11110 X001 1110
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $3E	; 11111 X011 1110
	.byte $00
; F $46
	.byte $3E	; 11111 X011 1110
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $1E	; 11110 X001 1110
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $00
; G $47
	.byte $3c	; 01111 X011 1100
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $32	; 10011 X011 0010
	.byte $22	; 10001 X010 0010
	.byte $3c	; 01111 X011 1100
	.byte $00
; H $48
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $3E	; 11111 X011 1110
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $00
; I $49
	.byte $1c	; 01110 X001 1100
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $1c	; 01110 X001 1100
	.byte $00
; J $4A
	.byte $20	; 00001 X010 0000
	.byte $20	; 00001 X010 0000
	.byte $20	; 00001 X010 0000
	.byte $20	; 00001 X010 0000
	.byte $20	; 00001 X010 0000
	.byte $22	; 10001 X010 0010
	.byte $1c	; 01110 X001 1100
	.byte $00
; K $4B
	.byte $22	; 10001 X010 0010
	.byte $12	; 10010 X001 0010
	.byte $1A	; 10100 X000 1010
	.byte $06	; 11000 X000 0110
	.byte $0A	; 10100 X000 1010
	.byte $12	; 10010 X001 0010
	.byte $22	; 10001 X010 0010
	.byte $00
; L $4C
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $3E	; 11111 X011 1110
	.byte $00
; M $4D
	.byte $22	; 10001 X010 0010
	.byte $36	; 11011 X011 0110
	.byte $2a	; 10101 X010 1010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $00
; N $4E
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $26	; 11001 X010 0110
	.byte $2a	; 10101 X010 1010
	.byte $32	; 10011 X011 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $00
; O $4F
	.byte $1c	; 01110 X001 1100
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $1c	; 01110 X001 1100
	.byte $00
; P $50
	.byte $1e	; 11110 X001 1110
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $1e	; 11110 X001 1110
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $00
; Q $51
	.byte $1c	; 01110 X001 1100
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $2a	; 10101 X010 1010
	.byte $12	; 10010 X001 0010
	.byte $2c	; 01101 X010 1100
	.byte $00
; R $52
	.byte $1e	; 11110 X001 1110
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $1e	; 11110 X001 1110
	.byte $0a	; 10100 X000 1010
	.byte $12	; 10010 X001 0010
	.byte $22	; 10001 X010 0010
	.byte $00
; S $53
	.byte $1c	; 01110 X001 1100
	.byte $22	; 10001 X010 0010
	.byte $02	; 10000 X000 0010
	.byte $1c	; 01110 X001 1100
	.byte $20	; 00001 X010 0000
	.byte $22	; 10001 X010 0010
	.byte $1c	; 01110 X001 1100
	.byte $00
; T $54
	.byte $3E	; 11111 X011 1110
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $00
; U $55
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $1C	; 01110 X001 1100
	.byte $00
; V $56
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $14	; 01010 X001 0100
	.byte $08	; 00100 X000 1000
	.byte $00
; W $57
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $2A	; 10101 X010 1010
	.byte $2A	; 10101 X010 1010
	.byte $36	; 11011 X011 0110
	.byte $22	; 10001 X010 0010
	.byte $00
; X $58
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $14	; 01010 X001 0100
	.byte $08	; 00100 X000 1000
	.byte $14	; 01010 X001 0100
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $00
; Y $59
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $14	; 01010 X001 0100
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $00
; Z $5A
	.byte $3e	; 11111 X011 1110
	.byte $20	; 00001 X010 0000
	.byte $10	; 00010 X001 0000
	.byte $08	; 00100 X000 1000
	.byte $04	; 01000 X000 0100
	.byte $02	; 10000 X000 0010
	.byte $3e	; 11111 X011 1110
	.byte $00
; [ $5B
	.byte $3e	; 11111 X011 1110
	.byte $06	; 11000 X000 0110
	.byte $06	; 11000 X000 0110
	.byte $06	; 11000 X000 0110
	.byte $06	; 11000 X000 0110
	.byte $06	; 11000 X000 0110
	.byte $3e	; 11111 X011 1110
	.byte $00
; \ $5C
	.byte $00	; 00000 X000 0000
	.byte $02	; 10000 X000 0010
	.byte $04	; 01000 X000 0100
	.byte $08	; 00100 X000 1000
	.byte $10	; 00010 X001 0000
	.byte $20	; 00001 X010 0000
	.byte $00	; 00000 X000 0000
	.byte $00
; ] $5d
	.byte $3e	; 11111 X011 1110
	.byte $30	; 00011 X011 0000
	.byte $30	; 00011 X011 0000
	.byte $30	; 00011 X011 0000
	.byte $30	; 00011 X011 0000
	.byte $30	; 00011 X011 0000
	.byte $3e	; 11111 X011 1110
	.byte $00
; ^ $5e
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $08	; 00100 X000 1000
	.byte $14	; 01010 X001 0100
	.byte $22	; 10001 X010 0010
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00
; _ $5f
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $7f	; 11111 X111 1111


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
	.byte $00
		; @
	.byte $04	; 00100
	.byte $0a	; 01010
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1f	; 11111
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $00
		; A
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
	.byte $00
		; B
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $11	; 10001
	.byte $0e	; 01110
	.byte $00
		; C
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
	.byte $00
		; D
	.byte $1f	; 11111
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $1e	; 11110
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $1f	; 11111
	.byte $00
		; E
	.byte $1f	; 11111
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $1e	; 11110
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $00
		; F
	.byte $0f	; 01111
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $13	; 10011
	.byte $11	; 10001
	.byte $0f	; 01111
	.byte $00
		; G
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1f	; 11111
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $00
		; H
	.byte $0e	; 01110
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $0e	; 01110
	.byte $00
		; I
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $01	; 00001
	.byte $11	; 10001
	.byte $0e	; 01110
	.byte $00
		; J
	.byte $11	; 10001
	.byte $12	; 10010
	.byte $14	; 10100
	.byte $18	; 11000
	.byte $14	; 10100
	.byte $12	; 10010
	.byte $11	; 10001
	.byte $00
		; K
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $1f	; 11111
	.byte $00
		; L
	.byte $11	; 10001
	.byte $1b	; 11011
	.byte $15	; 10101
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $00
		; M
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $19	; 11001
	.byte $15	; 10101
	.byte $13	; 10011
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $00
		; N
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0e	; 01110
	.byte $00
		; O
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $10	; 10000
	.byte $00
		; P
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $15	; 10101
	.byte $12	; 10010
	.byte $0d	; 01101
	.byte $00
		; Q
	.byte $1e	; 11110
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $1e	; 11110
	.byte $14	; 10100
	.byte $12	; 10010
	.byte $11	; 10001
	.byte $00
		; R
	.byte $0e	; 01110
	.byte $11	; 10001
	.byte $10	; 10000
	.byte $0e	; 01110
	.byte $01	; 00001
	.byte $11	; 10001
	.byte $0e	; 01110
	.byte $00
		; S
	.byte $1f	; 11111
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $00
		; T
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0e	; 01110
	.byte $00
		; U
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0a	; 01010
	.byte $04	; 00100
	.byte $00
		; V
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $15	; 10101
	.byte $15	; 10101
	.byte $1b	; 11011
	.byte $11	; 10001
	.byte $00
		; W
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0a	; 01010
	.byte $04	; 00100
	.byte $0a	; 01010
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $00
		; 
	.byte $11	; 10001
	.byte $11	; 10001
	.byte $0a	; 01010
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $04	; 00100
	.byte $00
		; Y
	.byte $1f	; 11111
	.byte $01	; 00001
	.byte $02	; 00010
	.byte $04	; 00100
	.byte $08	; 01000
	.byte $10	; 10000
	.byte $1f	; 11111
	.byte $00
		; Z
	.byte $1f	; 11111
	.byte $18	; 11000
	.byte $18	; 11000
	.byte $18	; 11000
	.byte $18	; 11000
	.byte $18	; 11000
	.byte $1f	; 11111
	.byte $00
		; [
	.byte $00	; 00000
	.byte $10	; 10000
	.byte $08	; 01000
	.byte $04	; 00100
	.byte $02	; 00010
	.byte $01	; 00001
	.byte $00	; 00000
	.byte $00
		; \.
	.byte $1f	; 11111
	.byte $03	; 00011
	.byte $03	; 00011
	.byte $03	; 00011
	.byte $03	; 00011
	.byte $03	; 00011
	.byte $1f	; 11111
	.byte $00
		; ]
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $04	; 00100
	.byte $0a	; 01010
	.byte $11	; 10001
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00
		; ^
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $00	; 00000
	.byte $1f	; 11111
	.byte $00
		; _


