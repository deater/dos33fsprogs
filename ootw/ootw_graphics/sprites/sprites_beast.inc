;=========================
; Beast

background_beast:
	.byte	$5,$3
	.byte	$1a,$00,$0a,$aa,$aa
	.byte	$00,$00,$00,$00,$aa
	.byte	$aa,$00,$a0,$a0,$0a


beast_standing:
	.byte	$9,$6
	.byte	$aa,$0a,$00,$00,$0a,$aa,$aa,$aa,$aa
	.byte	$aa,$00,$00,$00,$00,$00,$00,$aa,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$aa,$aa,$00,$a0,$aa,$a0,$00,$00,$aa
	.byte	$aa,$aa,$00,$aa,$aa,$aa,$00,$aa,$00


beast_run_progression:
	.word	beast_running1
	.word	beast_running2
	.word	beast_running3
	.word	beast_running4
	.word	beast_running5
	.word	beast_running6
	.word	beast_running7
	.word	beast_running8



beast_running1:	; piskel2
	.byte	$9,$6
	.byte	$aa,$0a,$00,$00,$0a,$aa,$aa,$aa,$aa
	.byte	$0a,$00,$00,$00,$00,$0a,$0a,$aa,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$a0,$a0,$00,$00,$00,$00,$00,$00,$aa
	.byte	$aa,$0a,$00,$aa,$aa,$a0,$00,$00,$00
	.byte	$a0,$a0,$aa,$aa,$aa,$aa,$a0,$0a,$00

beast_running2:	; piskel3
	.byte	$9,$6
	.byte	$aa,$0a,$00,$00,$0a,$aa,$aa,$aa,$aa
	.byte	$00,$00,$00,$00,$00,$00,$0a,$aa,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$aa,$aa,$00,$00,$00,$00,$00,$00,$aa
	.byte	$0a,$0a,$0a,$aa,$aa,$a0,$00,$00,$0a
	.byte	$aa,$aa,$aa,$aa,$aa,$aa,$aa,$00,$00

beast_running3:	; piskel4
	.byte	$9,$6
	.byte	$aa,$aa,$0a,$0a,$0a,$aa,$aa,$aa,$aa
	.byte	$0a,$00,$00,$00,$00,$00,$0a,$aa,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$a0,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$00,$a0,$0a,$aa,$aa,$a0,$a0,$00,$00
	.byte	$a0,$a0,$aa,$aa,$aa,$aa,$aa,$aa,$aa

beast_running4:	; piskel5
	.byte	$9,$6
	.byte	$aa,$aa,$0a,$0a,$0a,$aa,$aa,$aa,$aa
	.byte	$aa,$00,$00,$00,$00,$00,$00,$aa,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$aa,$0a,$00,$aa,$aa,$a0,$a0,$00,$0a
	.byte	$aa,$00,$aa,$aa,$aa,$aa,$aa,$a0,$a0

beast_running5:	; piskel6
	.byte	$9,$6
	.byte	$aa,$aa,$0a,$0a,$aa,$aa,$aa,$aa,$aa
	.byte	$0a,$00,$00,$00,$00,$0a,$0a,$aa,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$aa,$aa,$00,$aa,$aa,$a0,$00,$00,$aa
	.byte	$aa,$aa,$00,$aa,$aa,$aa,$00,$a0,$00

beast_running6:	; piskel7
	.byte	$8,$6
	.byte	$aa,$aa,$0a,$0a,$aa,$aa,$aa,$aa
	.byte	$0a,$00,$00,$00,$00,$0a,$0a,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$a0,$00,$00,$00,$00,$00,$00,$00
	.byte	$aa,$aa,$00,$0a,$aa,$00,$00,$00
	.byte	$aa,$aa,$aa,$00,$aa,$00,$a0,$aa

beast_running7:	; piskel8
	.byte	$8,$6
	.byte	$aa,$aa,$0a,$0a,$aa,$aa,$aa,$aa
	.byte	$0a,$00,$00,$00,$00,$0a,$0a,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$aa,$a0,$a0,$00,$aa,$00,$00,$a0
	.byte	$aa,$aa,$aa,$00,$00,$00,$aa,$aa

beast_running8:	; piskel9
	.byte	$8,$6
	.byte	$aa,$aa,$0a,$0a,$aa,$aa,$aa,$aa
	.byte	$0a,$00,$00,$00,$00,$0a,$0a,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00,$00,$00
	.byte	$aa,$a0,$00,$aa,$aa,$aa,$00,$a0
	.byte	$aa,$aa,$00,$a0,$aa,$aa,$00,$aa
