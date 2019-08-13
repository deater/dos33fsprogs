; Ootw Checkpoint4 -- Foreground Action Sequence



make_pink:

	ldy	#0						; 2
pink_outer:
	lda	gr_offsets,Y					; 4+
	sta	pi_smc1+1					; 4
	sta	pi_smc2+1					; 4

	lda	gr_offsets+1,Y					; 4+
	clc							; 2
	adc	DRAW_PAGE					; 3
	sta	pi_smc1+2					; 4
	sta	pi_smc2+2					; 4

	sty	TEMPY						; 3

	ldx	#39						; 2
pink_inner:

pi_smc1:
	ldy	$400,X						; 4
	lda	pink_lookup,Y					; 4+
pi_smc2:
	sta	$400,X						; 4
	dex							; 2
	bpl	pink_inner					; 3/2

	ldy	TEMPY						; 3

	iny							; 2
	iny							; 2
	cpy	#48						; 2
	bne	pink_outer					; 3/2

	rts							; 6


; pink colors
;    0->  0
;    1->  3
;    2->  3
;    3->  3
;    4->  1
;    5->  1
;    6->  F
;    7->  1
;    8->  1
;    9->  1
;    10-> 1
;    11-> F?
;    12-> F?
;    13-> F?
;    14-> F?
;    15-> F?


pink_lookup:
;       0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
.byte $00,$03,$03,$03,$01,$01,$0F,$01,$01,$01,$01,$0F,$0F,$0F,$0F,$0F
.byte $30,$33,$33,$33,$31,$31,$3F,$31,$31,$31,$31,$3F,$3F,$3F,$3F,$3F
.byte $30,$33,$33,$33,$31,$31,$3F,$31,$31,$31,$31,$3F,$3F,$3F,$3F,$3F
.byte $30,$33,$33,$33,$31,$31,$3F,$31,$31,$31,$31,$3F,$3F,$3F,$3F,$3F
.byte $10,$13,$13,$13,$11,$11,$1F,$11,$11,$11,$11,$1F,$1F,$1F,$1F,$1F
.byte $10,$13,$13,$13,$11,$11,$1F,$11,$11,$11,$11,$1F,$1F,$1F,$1F,$1F
.byte $F0,$F3,$F3,$F3,$F1,$F1,$FF,$F1,$F1,$F1,$F1,$FF,$FF,$FF,$FF,$FF
.byte $10,$13,$13,$13,$11,$11,$1F,$11,$11,$11,$11,$1F,$1F,$1F,$1F,$1F
.byte $10,$13,$13,$13,$11,$11,$1F,$11,$11,$11,$11,$1F,$1F,$1F,$1F,$1F
.byte $10,$13,$13,$13,$11,$11,$1F,$11,$11,$11,$11,$1F,$1F,$1F,$1F,$1F
.byte $10,$13,$13,$13,$11,$11,$1F,$11,$11,$11,$11,$1F,$1F,$1F,$1F,$1F
.byte $F0,$F3,$F3,$F3,$F1,$F1,$FF,$F1,$F1,$F1,$F1,$FF,$FF,$FF,$FF,$FF
.byte $F0,$F3,$F3,$F3,$F1,$F1,$FF,$F1,$F1,$F1,$F1,$FF,$FF,$FF,$FF,$FF
.byte $F0,$F3,$F3,$F3,$F1,$F1,$FF,$F1,$F1,$F1,$F1,$FF,$FF,$FF,$FF,$FF
.byte $F0,$F3,$F3,$F3,$F1,$F1,$FF,$F1,$F1,$F1,$F1,$FF,$FF,$FF,$FF,$FF
.byte $F0,$F3,$F3,$F3,$F1,$F1,$FF,$F1,$F1,$F1,$F1,$FF,$FF,$FF,$FF,$FF

;========================================================
; blah

; action sequence

; frame1: (76)
; 	hlin color: $31: 0,20 at 40
;	hlin color: $13: 0,20 at 42
; frame2: (77)
; 	hlin color: $31: 0,39 at 40
;	hlin color: $13: 0,39 at 42
;	pink colors!
; frame3: (78)
; 	hlin color: $31: 20,39 at 40
;	hlin color: $13: 20,39 at 42
; 	hlin color: $A1:  0,19 at 40
;	hlin color: $1A:  0,19 at 42
; frame4: (79)
; 	hlin color: $A1:  20,39 at 40
;	hlin color: $1A:  20,39 at 42
; frame5: (80)
;	nothing for 5 frames
; frame6: (81)
; 	hlin color: $31: 0,20 at 22
;	hlin color: $13: 0,20 at 24
; frame7: (82)
; 	hlin color: $31: 0,39 at 22
;	hlin color: $13: 0,39 at 24
;	pink colors!
; frame8: (83)
; 	hlin color: $31: 20,39 at 22
;	hlin color: $13: 20,39 at 24
; 	hlin color: $A1:  4,19 at 22
;	hlin color: $1A:  4,19 at 24	; top
; 	hlin color: $31:  0,20 at 30
;	hlin color: $13:  0,20 at 32	; bottom
; frame9: (84)
; 	hlin color: $A1: 20,39 at 22
;	hlin color: $1A: 20,39 at 24	; top
; 	hlin color: $3B:  0,39 at 30
;	hlin color: $B3:  0,39 at 32	; bottom
; frame10: (85)
; 	hlin color: $31: 20,39 at 30
;	hlin color: $13: 20,39 at 32
; 	hlin color: $A1:  4,19 at 30
;	hlin color: $1A:  4,19 at 32	; top
; frame11: (86)
; 	hlin color: $A1:  20,39 at 30
;	hlin color: $1A:  20,39 at 32	; top
;	friend, eye@1,29
; frame12: (87)
;	friend, eye@8,29
; frame13: (88)
; 	hlin color: $31:  0,20 at 28
;	hlin color: $13:  0,20 at 30	; bottom
;	friend, eye@10,30
; frame14: (89)
; 	hlin color: $31:  0,39 at 28
;	hlin color: $13:  0,39 at 30	; bottom
;	friend, eye@14,30
;	pink colors!  eyes red???
; frame15: (90)
; 	hlin color: $31: 20,39 at 28
;	hlin color: $13: 20,39 at 30
; 	hlin color: $A1:  4,19 at 28
;	hlin color: $1A:  4,19 at 30	; top
;	friend, eye@20,29
; frame16: (91)
; 	hlin color: $31:  0,20 at 32
;	hlin color: $13:  0,20 at 34	; bottom
;	friend, eye@24,30
; frame17: (92)
; 	hlin color: $3B:  0,39 at 32
;	hlin color: $B3:  0,39 at 34	; bottom
;	friend, eye@29,30
; frame18: (93)
; 	hlin color: $31: 20,39 at 32
;	hlin color: $13: 20,39 at 34
; 	hlin color: $A1:  4,19 at 32
;	hlin color: $1A:  4,19 at 34	; top
; 	hlin color: $31:  0,20 at 34
;	hlin color: $13:  0,20 at 36	; bottom
;	friend, eye@33,29
; frame19: (94)
;	friend, eye@38,28
; 	hlin color: $31:  0,39 at 34
;	hlin color: $13:  0,39 at 36	; OVER FRIEND
;	PINK!
; frame20: (95)
;	friend, eye@43,28
; 	hlin color: $31: 20,39 at 34
;	hlin color: $13: 20,39 at 36
; 	hlin color: $A1:  4,19 at 34
;	hlin color: $1A:  4,19 at 36	; OVER FRIEND
; frame21: (96)
;	friend, eye@48,28
; 	hlin color: $A1: 20,39 at 34
;	hlin color: $1A: 20,39 at 36	; OVER FRIEND
; frame22: wait 5 frames
; frame23: (97)
; 	hlin color: $31:  0,20 at 24
;	hlin color: $13:  0,20 at 26
; frame24: (98)
; 	hlin color: $31:  0,39 at 24
;	hlin color: $13:  0,39 at 26
;	PINK!
; frame25: (99)
; 	hlin color: $31: 20,39 at 24
;	hlin color: $13: 20,39 at 26
; 	hlin color: $A1:  4,19 at 24
;	hlin color: $1A:  4,19 at 26
; frame26: (100)
; 	hlin color: $A1: 20,39 at 24
;	hlin color: $1A: 20,39 at 26
; frame27: wait 5 frames
; frame28: (101)
; 	hlin color: $31:  0,20 at 26
;	hlin color: $13:  0,20 at 28
; frame29: (102)
; 	hlin color: $31:  0,39 at 26
;	hlin color: $13:  0,39 at 28
; frame30: (103)
; 	hlin color: $31: 20,39 at 26
;	hlin color: $13: 20,39 at 28
; 	hlin color: $A1:  4,19 at 26
;	hlin color: $1A:  4,19 at 28	; top
; 	hlin color: $31:  0,20 at 28
;	hlin color: $13:  0,20 at 30	; bottom
; frame31: (104)
; 	hlin color: $A1: 20,39 at 26
;	hlin color: $1A: 20,39 at 28
; 	hlin color: $31:  0,39 at 28
;	hlin color: $13:  0,39 at 30
;	PINK!
; frame32: (105)
; 	hlin color: $31: 20,39 at 28
;	hlin color: $13: 20,39 at 30
; 	hlin color: $A1:  4,19 at 28
;	hlin color: $1A:  4,19 at 30
; frame33: (106)
; 	hlin color: $31:  0,20 at 32
;	hlin color: $13:  0,20 at 34
; frame34: (107)
; 	hlin color: $3B:  0,39 at 32
;	hlin color: $B3:  0,39 at 34
; frame35: (108)
; 	hlin color: $31: 20,39 at 32
;	hlin color: $13: 20,39 at 34
; 	hlin color: $A1:  4,19 at 32
;	hlin color: $1A:  4,19 at 34	; top
; 	hlin color: $31:  0,20 at 22
;	hlin color: $13:  0,20 at 24	; bottom
; frame36: (109)
; 	hlin color: $A1: 20,39 at 32
;	hlin color: $1A: 20,39 at 34
; 	hlin color: $31:  0,39 at 22
;	hlin color: $13:  0,39 at 24	; bottom
;	PINK!
; frame37: (110)
; 	hlin color: $31: 20,39 at 22
;	hlin color: $13: 20,39 at 24
; 	hlin color: $A1:  4,19 at 22
;	hlin color: $1A:  4,19 at 24
; frame38: (111)
; 	hlin color: $A1: 20,39 at 22
;	hlin color: $1A: 20,39 at 24
;	alien_eye@2,28
; frame39: (112)
;	alien_eye@6,28
; frame40: (113)
;	alien_eye@10,30
; frame41: (114)
;	alien_eye@14,30
;	alien_eye@2,28
; frame42: (115)
;	alien_eye@20,28
;	alien_eye@6,28
; frame43: (116)
;	alien_eye@24,30
;	alien_eye@10,30
; frame44: (117)
;	alien_eye@28,30
;	alien_eye@15,30
; frame45: (118)
;	alien_eye@32,30
;	alien_eye@20,30
; frame46: (119)
;	alien_eye@38,28
;	alien_eye@25,30
;	alien_eye@2,28
; frame47: (120)
;	alien_eye@43,28
;	alien_eye@29,30
;	alien_eye@6,28
; frame48: (121)
;	alien_eye@48,28
;	alien_eye@33,30
;	alien_eye@10,30
; frame49: (122)
;	alien_eye@38,28
;	alien_eye@15,30
; frame50: (123)
;	alien_eye@43,28
;	alien_eye@20,28
; frame51: (124)
;	alien_eye@48,28
;	alien_eye@24,28
; frame52: (125)
;	alien_eye@28,30
; frame53: (126)
;	alien_eye@32,30
; frame54: (127)
;	alien_eye@38,28
; frame55: (128)
;	alien_eye@43,28
; frame56: (129)
;	alien_eye@48,28













action_friend_sprite:
	.byte 12,14	; eye@12,5
	.byte $AA,$AA,$AA,$AA,$AA,$6A,$6A,$6A,$6A,$6A,$AA,$AA
	.byte $AA,$AA,$AA,$AA,$66,$66,$6F,$FF,$FF,$F6,$66,$6A
	.byte $AA,$AA,$AA,$AA,$66,$66,$66,$66,$66,$ff,$ff,$26
	.byte $AA,$AA,$AA,$0A,$06,$06,$66,$66,$66,$66,$6f,$66
	.byte $AA,$AA,$0A,$00,$00,$00,$00,$00,$66,$66,$66,$66
	.byte $AA,$0A,$00,$00,$60,$60,$00,$00,$00,$66,$66,$A6
	.byte $0A,$00,$60,$66,$FF,$FF,$F6,$00,$00,$66,$A6,$AA
	.byte $00,$00,$66,$66,$66,$FF,$6F,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$66,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$66,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$06,$00,$00,$00,$AA,$AA
	.byte $00,$00,$00,$66,$66,$66,$00,$00,$00,$00,$AA,$AA
	.byte $00,$00,$60,$66,$66,$66,$00,$00,$00,$00,$AA,$AA
	.byte $00,$00,$60,$66,$66,$66,$00,$00,$00,$00,$AA,$AA

; technically the middle alien has squatter face
; is slightly shorter, and has no red insignia

action_alien1_sprite:
	.byte 12,13	; eye@11,4
	.byte $AA,$AA,$AA,$AA,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$AA
	.byte $AA,$AA,$AA,$0A,$00,$00,$00,$00,$00,$00,$00,$60
	.byte $AA,$AA,$AA,$00,$60,$00,$00,$00,$00,$00,$f6,$26
	.byte $AA,$AA,$0A,$00,$00,$00,$00,$00,$00,$66,$66,$66
	.byte $AA,$0A,$00,$00,$10,$10,$00,$00,$60,$00,$06,$66
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$66,$00,$06
	.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$66,$AA,$AA
	.byte $00,$00,$00,$00,$60,$60,$00,$00,$00,$00,$AA,$AA
	.byte $00,$00,$60,$60,$66,$66,$60,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$66,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$06,$00,$00,$00,$AA,$AA
	.byte $00,$00,$66,$66,$66,$66,$00,$00,$00,$00,$AA,$AA
	.byte $00,$00,$00,$66,$66,$66,$00,$00,$00,$00,$AA,$AA


