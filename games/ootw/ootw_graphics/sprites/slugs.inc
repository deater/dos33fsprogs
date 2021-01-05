;=========================
; slug creatures
;	going left on ground

slug1:
	.byte	$4,$4
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$0a,$0a,$0a,$0a

slug2:
	.byte	$3,$4
	.byte	$aa,$aa,$aa
	.byte	$aa,$aa,$aa
	.byte	$aa,$aa,$aa
	.byte	$0a,$a0,$0a

;=========================
; slug creatures
;	going left on roof

slug_ceiling1:
	.byte	$4,$1
	.byte	$a0,$a0,$a0,$a0


slug_ceiling2:
	.byte	$3,$1
	.byte	$a0,$0a,$a0

;===============
;===============
; slug on roof
;   swings a bit, then falls

slug_falling_progression_hi:
	.byte >slug_falling1	; 0
	.byte >slug_falling2	; 1
	.byte >slug_falling3	; 2
	.byte >slug_falling4	; 3
	.byte >slug_falling5	; 4
	.byte >slug_falling4	; 5
	.byte >slug_falling6	; 6
	.byte >slug_falling12	; 7
	; falls
	.byte >slug_falling7	; 8
	.byte >slug_falling8	; 9
	.byte >slug_falling9	; 10
	.byte >slug_falling10	; 11
	.byte >slug_falling7	; 12

slug_falling_progression_lo:
	.byte <slug_falling1
	.byte <slug_falling2
	.byte <slug_falling3
	.byte <slug_falling4
	.byte <slug_falling5
	.byte <slug_falling4
	.byte <slug_falling6
	.byte <slug_falling12
	; falls
	.byte <slug_falling7
	.byte <slug_falling8
	.byte <slug_falling9
	.byte <slug_falling10
	.byte <slug_falling7


	

slug_falling1:
	.byte	4,1
	.byte	$AA,$A0,$A0,$A0


slug_falling2:
	.byte	4,2
	.byte	$AA,$A0,$0A,$AA
	.byte	$AA,$AA,$AA,$A0


slug_falling3:
	.byte	3,2
	.byte	$AA,$00,$AA
	.byte	$AA,$AA,$00

slug_falling4:
	.byte	3,2
	.byte	$AA,$00,$AA
	.byte	$AA,$00,$AA

slug_falling5:
	.byte	3,2
	.byte	$AA,$00,$AA
	.byte	$0A,$A0,$AA

slug_falling6:
	.byte	3,2
	.byte	$AA,$00,$AA
	.byte	$AA,$A0,$0A

slug_falling12:
	.byte 2,4
	.byte $AA,$00
	.byte $AA,$00
	.byte $AA,$00
	.byte $AA,$00


slug_falling7:
	.byte 3,4
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $0A,$00,$0A

slug_falling8:
	.byte 3,4
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $0A,$AA,$AA
	.byte $aA,$A0,$0A

slug_falling9:
	.byte 3,4
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $0A,$AA,$AA
	.byte $00,$a0,$0A

slug_falling10:
	.byte 3,4
	.byte $AA,$AA,$AA
	.byte $AA,$AA,$AA
	.byte $0A,$AA,$AA
	.byte $00,$0A,$0A




slug_dropping:
	.byte	3,4
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA


;=======================
; slug dying

slug_die_progression:
	.word	slug_die4	; 0
	.word	slug_die4	; 2
	.word	slug_die3	; 4
	.word	slug_die2	; 6
	.word	slug_die1	; 8
	.word	slug_die1	; 10

slug_die1:
	.byte	$2,$4
	.byte	$aa,$aa
	.byte	$aa,$aa
	.byte	$0a,$aa
	.byte	$aa,$0a

slug_die2:
	.byte	$3,$4
	.byte	$aa,$aa,$aa
	.byte	$0a,$aa,$aa
	.byte	$aa,$0a,$aa
	.byte	$aa,$aa,$a0

slug_die3:
	.byte	$4,$4
	.byte	$0a,$aa,$aa,$aa
	.byte	$aa,$aa,$0a,$aa
	.byte	$aa,$aa,$aa,$0a
	.byte	$aa,$aa,$aa,$aa

slug_die4:
	.byte	$5,$4
	.byte	$aa,$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$a0,$aa
	.byte	$aa,$aa,$aa,$aa,$a0
	.byte	$aa,$aa,$aa,$aa,$aa

;===============
;===============
; slug attacking

slug_attack_progression:
	.word	slug_attack0
	.word	slug_attack1
	.word	slug_attack2
	.word	slug_attack3
	.word	slug_attack4
	.word	slug_attack1
	.word	slug_attack2
	.word	slug_attack3

slug_attack0:
	.byte	$3,$4
	.byte	$aa,$aa,$00
	.byte	$aa,$aa,$00
	.byte	$aa,$aa,$00
	.byte	$aa,$aa,$00

slug_attack1:
	.byte	$3,$4
	.byte	$aa,$aa,$aa
	.byte	$00,$aa,$aa
	.byte	$aa,$00,$aa
	.byte	$aa,$aa,$00

slug_attack2:
	.byte	$3,$4
	.byte	$aa,$aa,$aa
	.byte	$aa,$aa,$aa
	.byte	$aa,$aa,$aa
	.byte	$00,$00,$00

slug_attack3:
	.byte	$3,$4
	.byte	$aa,$aa,$aa
	.byte	$aa,$aa,$00
	.byte	$aa,$00,$aa
	.byte	$00,$aa,$aa

slug_attack4:
	.byte	$1,$4
	.byte	$aa
	.byte	$00
	.byte	$00
	.byte	$00





