;=========================
; slug creatures
;	going left

slug1:
	.byte	$4,$4
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$0a,$0a,$0a,$0a

slug2:
	.byte	$4,$4
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$0a,$a0,$0a,$aa

slug_die_progression:
	.word	slug_die4	; 0
	.word	slug_die4	; 2
	.word	slug_die3	; 4
	.word	slug_die2	; 6
	.word	slug_die1	; 8
	.word	slug_die1	; 10

slug_die1:
	.byte	$4,$4
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$0a,$aa,$aa,$aa
	.byte	$aa,$0a,$aa,$aa

slug_die2:
	.byte	$4,$4
	.byte	$aa,$aa,$aa,$aa
	.byte	$0a,$aa,$aa,$aa
	.byte	$aa,$0a,$aa,$aa
	.byte	$aa,$aa,$a0,$aa

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
	.byte	$4,$4
	.byte	$aa,$aa,$00,$aa
	.byte	$aa,$aa,$00,$aa
	.byte	$aa,$aa,$00,$aa
	.byte	$aa,$aa,$00,$aa

slug_attack1:
	.byte	$4,$4
	.byte	$aa,$aa,$aa,$aa
	.byte	$00,$aa,$aa,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$aa,$aa,$00,$aa

slug_attack2:
	.byte	$4,$4
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$aa,$aa
	.byte	$00,$00,$00,$aa

slug_attack3:
	.byte	$4,$4
	.byte	$aa,$aa,$aa,$aa
	.byte	$aa,$aa,$00,$aa
	.byte	$aa,$00,$aa,$aa
	.byte	$00,$aa,$aa,$aa

slug_attack4:
	.byte	$4,$4
	.byte	$aa,$aa,$aa,$aa
	.byte	$00,$aa,$aa,$aa
	.byte	$00,$aa,$aa,$aa
	.byte	$00,$aa,$aa,$aa

;slug_attack5:
;	.byte	$4,$4
;	.byte	$aa,$aa,$aa,$aa
;	.byte	$00,$aa,$aa,$aa
;	.byte	$aa,$00,$aa,$aa
;	.byte	$aa,$aa,$00,$aa

;slug_attack6:
;	.byte	$4,$4
;	.byte	$aa,$aa,$aa,$aa
;	.byte	$aa,$aa,$aa,$aa
;	.byte	$aa,$aa,$aa,$aa
;	.byte	$00,$00,$00,$aa

;slug_attack7:
;	.byte	$4,$4
;	.byte	$aa,$aa,$aa,$aa
;	.byte	$aa,$aa,$00,$aa
;	.byte	$aa,$00,$aa,$aa
;	.byte	$00,$aa,$aa,$aa





