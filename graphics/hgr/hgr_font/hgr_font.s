
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
;	rts	; inc once more



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
	.byte $00	; 00000	X000 0000
	.byte $00	; 00000	X000 0000
	.byte $00	; 00000	X000 0000
	.byte $00	; 00000	X000 0000
	.byte $00	; 00000	X000 0000
	.byte $00	; 00000	X000 0000
	.byte $00	; 00000	X000 0000
	.byte $00	; 00000	X000 0000
; ! $21
	.byte $08	; 00100	X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $00	; 00000 X000 0000
	.byte $08	; 00100 X000 1000
	.byte $00
; " $22
	.byte $14	; 01010 X001 0100
	.byte $14	; 01010 X001 0100
	.byte $14	; 01010 X001 0100
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00
; # $23
	.byte $14	; 01010 X001 0100
	.byte $14	; 01010 X001 0100
	.byte $3e	; 11111 X011 1110
	.byte $14	; 01010 X001 0100
	.byte $3e	; 11111 X011 1110
	.byte $14	; 01010 X001 0100
	.byte $14	; 01010 X001 0100
	.byte $00
; $ $24
	.byte $08	; 00100 X000 1000
	.byte $3c	; 01111 X011 1100
	.byte $0a	; 10100 X000 1010
	.byte $1c	; 01110 X001 1100
	.byte $28	; 00101 X010 1000
	.byte $1e	; 11110 X001 1110
	.byte $08	; 00100 X000 1000
	.byte $00
; % $25
	.byte $06	; 11000 X000 0110
	.byte $26	; 11001 X010 0110
	.byte $10	; 00010 X001 0000
	.byte $08	; 00100 X000 1000
	.byte $04	; 01000 X000 0100
	.byte $32	; 10011 X011 0010
	.byte $30	; 00011 X011 0000
	.byte $00
; & $26
	.byte $04	; 01000 X000 0100
	.byte $0a	; 10100 X000 1010
	.byte $0a	; 10100 X000 1010
	.byte $04	; 01000 X000 0100
	.byte $2a	; 10101 X010 1010
	.byte $12	; 10010 X001 0010
	.byte $2c	; 01101 X010 1100
	.byte $00
; ' $27
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00
; ( $28
	.byte $08	; 00100 X000 1000
	.byte $04	; 01000 X000 0100
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $02	; 10000 X000 0010
	.byte $04	; 01000 X000 0100
	.byte $08	; 00100 X000 1000
	.byte $00
; ) $29
	.byte $08	; 00100 X000 1000
	.byte $10	; 00010 X001 0000
	.byte $20	; 00001 X010 0000
	.byte $20	; 00001 X010 0000
	.byte $20	; 00001 X010 0000
	.byte $10	; 00010 X001 0000
	.byte $08	; 00100 X000 1000
	.byte $00
; * $2A
	.byte $08	; 00100 X000 1000
	.byte $2a	; 10101 X010 1010
	.byte $1c	; 01110 X001 1100
	.byte $08	; 00100 X000 1000
	.byte $1c	; 01110 X001 1100
	.byte $2a	; 10101 X010 1010
	.byte $08	; 00100 X000 1000
	.byte $00
; + $2B
	.byte $00	; 00000 X000 0000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $3e	; 11111 X011 1110
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $00	; 00000 X000 0000
	.byte $00
; , $2C
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $04	; 01000 X000 0100
	.byte $00
; - $2D
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $3e	; 11111 X011 1110
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 01000 X000 0000
	.byte $00
; . $2E
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $08	; 00100 X000 1000
	.byte $00
; / $2F
	.byte $00	; 00000	X000 0000
	.byte $20	; 00001	X010 0000
	.byte $10	; 00010 X001 0000
	.byte $08	; 00100 X000 1000
	.byte $04	; 01000 X000 0100
	.byte $02	; 10000 X000 0010
	.byte $00	; 00000 X000 0000
	.byte $00
; 0 $30
	.byte $1c	; 01110 X001 1100
	.byte $22	; 10001 X010 0010
	.byte $32	; 10011 X011 0010
	.byte $2a	; 10101 X010 1010
	.byte $26	; 11001 X010 0110
	.byte $22	; 10001 X010 0010
	.byte $1c	; 01110 X001 1100
	.byte $00
; 1 $31
	.byte $08	; 00100 X000 1000
	.byte $0c	; 01100 X000 1100
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $1c	; 01110 X001 1100
	.byte $00
; 2 $32
	.byte $1c	; 01110 X001 1100
	.byte $22	; 10001 X010 0010
	.byte $20	; 00001 X010 0000
	.byte $18	; 00110 X001 1000
	.byte $04	; 01000 X000 0100
	.byte $02	; 10000 X000 0010
	.byte $3e	; 11111 X011 1110
	.byte $00
; 3 $33
	.byte $3e	; 11111 X011 1110
	.byte $20	; 00001 X010 0000
	.byte $10	; 00010 X001 0000
	.byte $18	; 00110 X001 1000
	.byte $20	; 00001 X010 0000
	.byte $22	; 10001 X010 0010
	.byte $1c	; 01110 X001 1100
	.byte $00
; 4 $34
	.byte $10	; 00010 X001 0000
	.byte $18	; 00110 X001 1000
	.byte $14	; 01010 X001 0100
	.byte $12	; 10010 X001 0010
	.byte $3e	; 11111 X011 1110
	.byte $10	; 00010 X001 0000
	.byte $10	; 00010 X001 0000
	.byte $00
; 5 $35
	.byte $3e	; 11111 X011 1110
	.byte $02	; 10000 X000 0010
	.byte $1e	; 11110 X001 1110
	.byte $20	; 00001 X010 0000
	.byte $20	; 00001 X010 0000
	.byte $22	; 10001 X010 0010
	.byte $1c	; 01110 X001 1100
	.byte $00
; 6 $36
	.byte $38	; 00111 X011 1000
	.byte $04	; 01000 X000 0100
	.byte $02	; 10000 X000 0010
	.byte $1e	; 11110 X001 1110
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $1c	; 01110 X001 1100
	.byte $00
; 7 $37
	.byte $3e	; 11111 X011 1110
	.byte $20	; 00001 X010 0000
	.byte $10	; 00010 X001 0000
	.byte $08	; 00100 X000 1000
	.byte $04	; 01000 X000 0100
	.byte $04	; 01000 X000 0100
	.byte $04	; 01000 X000 0100
	.byte $00
; 8 $38
	.byte $1c	; 01110 X001 1100
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $1c	; 01110 X001 1100
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $1c	; 01110 X001 1100
	.byte $00
; 9 $39
	.byte $1c	; 01110 X001 1100
	.byte $22	; 10001 X010 0010
	.byte $22	; 10001 X010 0010
	.byte $3c	; 01111 X011 1100
	.byte $20	; 00001 X010 0000
	.byte $10	; 00010 X001 0000
	.byte $0e	; 11100 X000 1110
	.byte $00
; : $3A
	.byte $00	; 00000	X000 0000
	.byte $00	; 00000 X000 0000
	.byte $08	; 00100 X000 1000
	.byte $00	; 00000 X000 0000
	.byte $08	; 00100 X000 1000
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00
; ; $3B
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $08	; 00100 X000 1000
	.byte $00	; 00000 X000 0000
	.byte $08	; 00100 X000 1000
	.byte $08	; 00100 X000 1000
	.byte $04	; 01000 X000 0100
	.byte $00
; < $3C
	.byte $10	; 00010 X001 0000
	.byte $08	; 00100 X000 1000
	.byte $04	; 01000 X000 0100
	.byte $02	; 10000 X000 0010
	.byte $04	; 01000 X000 0100
	.byte $08	; 00100 X000 1000
	.byte $10	; 00010 X001 0000
	.byte $00
; = $3D
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $3e	; 11111 X011 1110
	.byte $00	; 00000 X000 0000
	.byte $3e	; 11111 X011 1110
	.byte $00	; 00000 X000 0000
	.byte $00	; 00000 X000 0000
	.byte $00
; > $3E
	.byte $04	; 01000 X000 0100
	.byte $08	; 00100 X000 1000
	.byte $10	; 00010 X001 0000
	.byte $20	; 00001 X010 0000
	.byte $10	; 00010 X001 0000
	.byte $08	; 00100 X000 1000
	.byte $04	; 01000 X000 0100
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

; ` $60
	.byte $04	; 0010000 000 0100
	.byte $08	; 0001000 000 1000
	.byte $10	; 0000100 001 0000
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $00
; a $61
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $1c	; 0011100 001 1100
	.byte $20	; 0000010 010 0000
	.byte $3c	; 0011110 011 1100
	.byte $22	; 0100010 010 0010
	.byte $3c	; 0011110 011 1100
	.byte $00
; b $62
	.byte $02	; 0100000 000 0010
	.byte $02	; 0100000 000 0010
	.byte $1e	; 0111100 001 1110
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $1e	; 0111100 001 1110
	.byte $00
; c $63
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $3c	; 0011110 011 1100
	.byte $02	; 0100000 000 0010
	.byte $02	; 0100000 000 0010
	.byte $02	; 0100000 000 0010
	.byte $3c	; 0011110 011 1100
	.byte $00
; d $64
	.byte $20	; 0000010 010 0000
	.byte $20	; 0000010 010 0000
	.byte $3c	; 0011110 011 1100
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $3c	; 0011110 011 1100
	.byte $00
; e $65
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $1c	; 0011100 001 1100
	.byte $22	; 0100010 010 0010
	.byte $3e	; 0111110 011 1110
	.byte $02	; 0100000 000 0010
	.byte $3c	; 0011110 011 1100
	.byte $00
; f $66
	.byte $18	; 0001100 001 1000
	.byte $24	; 0010010 010 0100
	.byte $04	; 0010000 000 0100
	.byte $1e	; 0111100 001 1110
	.byte $04	; 0010000 000 0100
	.byte $04	; 0010000 000 0100
	.byte $04	; 0010000 000 0100
	.byte $00
; g $67
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $1c	; 0011100 001 1100
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $3c	; 0011110 011 1100
	.byte $20	; 0000010 010 0000
	.byte $1c	; 0011100 001 1100
; h $68
	.byte $02	; 0100000 000 0010
	.byte $02	; 0100000 000 0010
	.byte $1e	; 0111100 001 1110
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $00
; i $69
	.byte $08	; 0001000 000 1000
	.byte $00	; 0000000 000 0000
	.byte $0c	; 0011000 000 1100
	.byte $08	; 0001000 000 1000
	.byte $08	; 0001000 000 1000
	.byte $08	; 0001000 000 1000
	.byte $1c	; 0011100 001 1100
	.byte $00
; j $6A
	.byte $10	; 0000100 001 0000
	.byte $00	; 0000000 000 0000
	.byte $18	; 0001100 001 1000
	.byte $10	; 0000100 001 0000
	.byte $10	; 0000100 001 0000
	.byte $10	; 0000100 001 0000
	.byte $12	; 0100100 001 0010
	.byte $0c	; 0011000 000 1100
; k $6B
	.byte $02	; 0100000 000 0010
	.byte $02	; 0100000 000 0010
	.byte $22	; 0100010 010 0010
	.byte $12	; 0100100 001 0010
	.byte $0e	; 0111000 000 1110
	.byte $12	; 0100100 001 0010
	.byte $22	; 0100010 010 0010
	.byte $00
; l $6c
	.byte $0c	; 0011000 000 1100
	.byte $08	; 0001000 000 1000
	.byte $08	; 0001000 000 1000
	.byte $08	; 0001000 000 1000
	.byte $08	; 0001000 000 1000
	.byte $08	; 0001000 000 1000
	.byte $1c	; 0011100 001 1100
	.byte $00
; m $6d
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $36	; 0110110 011 0110
	.byte $2a	; 0101010 010 1010
	.byte $2a	; 0101010 010 1010
	.byte $2a	; 0101010 010 1010
	.byte $22	; 0100010 010 0010
	.byte $00
; n $6e
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $1e	; 0111100 001 1110
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $00
; o $6f
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $1c	; 0011100 001 1100
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $1c	; 0011100 001 1100
	.byte $00
; p $70
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $1e	; 0111100 001 1110
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $1e	; 0111100 001 1110
	.byte $02	; 0100000 000 0010
	.byte $02	; 0100000 000 0010
; q $71
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $3c	; 0011110 011 1100
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $3c	; 0011110 011 1100
	.byte $20	; 0000010 010 0000
	.byte $20	; 0000010 010 0000
; r $72
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $3a	; 0101110 011 1010
	.byte $06	; 0110000 000 0110
	.byte $02	; 0100000 000 0010
	.byte $02	; 0100000 000 0010
	.byte $02	; 0100000 000 0010
	.byte $00
; s $73
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $3c	; 0011110 011 1100
	.byte $02	; 0100000 000 0010
	.byte $1c	; 0011100 001 1100
	.byte $20	; 0000010 010 0000
	.byte $3e	; 0111110 011 1110
	.byte $00
; t $74
	.byte $00	; 0000000 000 0000
	.byte $04	; 0010000 000 0100
	.byte $1e	; 0111100 001 1110
	.byte $04	; 0010000 000 0100
	.byte $04	; 0010000 000 0100
	.byte $24	; 0010010 010 0100
	.byte $18	; 0001100 001 1000
	.byte $00
; u $75
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $32	; 0100110 011 0010
	.byte $2c	; 0011010 010 1100
	.byte $00
; v $76
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $14	; 0010100 001 0100
	.byte $08	; 0001000 000 1000
	.byte $00
; w $77
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $2a	; 0101010 010 1010
	.byte $2a	; 0101010 010 1010
	.byte $36	; 0110110 011 0110
	.byte $00
; x $78
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $22	; 0100010 010 0010
	.byte $14	; 0010100 001 0100
	.byte $08	; 0001000 000 1000
	.byte $14	; 0010100 001 0100
	.byte $22	; 0100010 010 0010
	.byte $00
; y $79
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $22	; 0100010 010 0010
	.byte $3c	; 0011110 011 1100
	.byte $20	; 0000010 010 0000
	.byte $1c	; 0011100 001 1100
; z $7A
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $3e	; 0111110 011 1110
	.byte $10	; 0000100 001 0000
	.byte $08	; 0001000 000 1000
	.byte $04	; 0010000 000 0100
	.byte $3e	; 0111110 011 1110
	.byte $00
; { $7b
	.byte $38	; 0001110 011 1000
	.byte $0c	; 0011000 000 1100
	.byte $0c	; 0011000 000 1100
	.byte $06	; 0110000 000 0110
	.byte $0c	; 0011000 000 1100
	.byte $0c	; 0011000 000 1100
	.byte $38	; 0001110 011 1000
	.byte $00
; | $7c
	.byte $08	; 0001000 000 1000
	.byte $08	; 0001000 000 1000
	.byte $08	; 0001000 000 1000
	.byte $08	; 0001000 000 1000
	.byte $08	; 0001000 000 1000
	.byte $08	; 0001000 000 1000
	.byte $08	; 0001000 000 1000
	.byte $08	; 0001000 000 1000
; } $7d
	.byte $0e	; 0111000 000 1110
	.byte $18	; 0001100 001 1000
	.byte $18	; 0001100 001 1000
	.byte $30	; 0000110 011 0000
	.byte $18	; 0001100 001 1000
	.byte $18	; 0001100 001 1000
	.byte $0e	; 0111000 000 1110
	.byte $00
; ~ $7e
	.byte $2c	; 0011010 010 1100
	.byte $1a	; 0101100 001 1010
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $00	; 0000000 000 0000
	.byte $00
; del $7F
	.byte $00	; 0000000 000 0000
	.byte $2a	; 0101010 010 1010
	.byte $14	; 0010100 001 0100
	.byte $2a	; 0101010 010 1010
	.byte $14	; 0010100 001 0100
	.byte $2a	; 0101010 010 1010
	.byte $00	; 0000000 000 0000
	.byte $00