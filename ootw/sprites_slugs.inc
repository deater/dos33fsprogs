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





