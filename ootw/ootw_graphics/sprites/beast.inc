;=========================
; Beast


beast_incoming:
	.word beast_bg2		; 2
	.byte 38,0
	.word beast_bg3		; 4
	.byte 38,0
	.word beast_bg4		; 6
	.byte 36,0
	.word beast_bg5		; 8
	.byte 36,0
	.word beast_bg6		; 10
	.byte 35,0
	.word beast_bg7		; 12
	.byte 34,0
	.word beast_bg7		; 14
	.byte 33,0

beast_outgoing:
	.word beast_bg8		; F4
	.byte 33,0
	.word beast_bg9		; F6
	.byte 34,0
	.word beast_bg10	; F8
	.byte 34,0
	.word beast_bg11	; FA
	.byte 35,0
	.word beast_bg12	; FC
	.byte 36,0
	.word beast_bg13	; FE
	.byte 38,0






beast_bg2:
	.byte 5,3
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA
	.byte $AA,$A0,$AA,$AA,$AA

beast_bg3:
	.byte 5,3
	.byte $AA,$AA,$AA,$AA,$AA
	.byte $AA,$00,$AA,$AA,$AA
	.byte $A0,$A0,$AA,$AA,$AA

beast_bg4:
	.byte 5,3
	.byte $AA,$AA,$0A,$AA,$AA
	.byte $AA,$00,$00,$00,$0A
	.byte $0A,$A0,$A0,$AA,$AA

beast_bg5:
	.byte 5,3
	.byte $AA,$0A,$0A,$AA,$AA
	.byte $00,$00,$00,$00,$AA
	.byte $00,$A0,$A0,$A0,$0A

beast_bg6:
	.byte 5,3
	.byte $AA,$0A,$0A,$AA,$AA
	.byte $00,$00,$00,$00,$0A
	.byte $AA,$00,$A0,$A0,$00

beast_bg7:			; old bg beast
	.byte	$5,$3
	.byte	$1a,$00,$0a,$aa,$aa
	.byte	$00,$00,$00,$00,$aa
	.byte	$aa,$00,$a0,$a0,$0a

beast_bg8:	; looking
	.byte 5,3
	.byte $1A,$10,$0A,$AA,$AA
	.byte $00,$00,$00,$00,$AA
	.byte $AA,$00,$A0,$A0,$0A

beast_bg9:	; turning
	.byte 5,3
	.byte $0A,$00,$0A,$AA,$AA
	.byte $00,$00,$00,$AA,$AA
	.byte $AA,$00,$00,$AA,$AA

beast_bg10:	; turning
	.byte 5,3
	.byte $0A,$00,$0A,$AA,$AA
	.byte $00,$00,$00,$AA,$AA
	.byte $00,$00,$AA,$AA,$AA

beast_bg11:	; going left
	.byte 5,3
	.byte $AA,$0A,$0A,$00,$0A
	.byte $00,$00,$00,$00,$A0
	.byte $00,$AA,$AA,$AA,$A0

beast_bg12:	; going left
	.byte 5,3
	.byte $AA,$0A,$0A,$0A,$AA
	.byte $0A,$00,$00,$00,$AA
	.byte $AA,$AA,$AA,$A0,$A0

beast_bg13:	; going left
	.byte 5,3
	.byte $AA,$0A,$0A,$0A,$AA
	.byte $00,$00,$00,$00,$AA
	.byte $AA,$A0,$AA,$A0,$A0





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
	.word	beast_standing


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
	.byte	$a0,$a0,$a0,$aa,$aa,$a0,$00,$00,$0a
	.byte	$aa,$aa,$aa,$aa,$aa,$aa,$aa,$00,$00

beast_running3:	; piskel4
	.byte	$9,$6
	.byte	$aa,$aa,$0a,$0a,$0a,$aa,$aa,$aa,$aa
	.byte	$0a,$00,$00,$00,$00,$00,$0a,$aa,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$a0,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$aa,$0a,$00,$aa,$aa,$a0,$a0,$00,$00
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
	.byte	$9,$6
	.byte	$aa,$aa,$0a,$0a,$aa,$aa,$aa,$aa,$aa
	.byte	$0a,$00,$00,$00,$00,$0a,$0a,$aa,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$a0,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$aa,$aa,$00,$0a,$aa,$00,$00,$00,$aa
	.byte	$aa,$aa,$aa,$00,$aa,$00,$a0,$aa,$aa

beast_running7:	; piskel8
	.byte	$9,$6
	.byte	$aa,$aa,$0a,$0a,$aa,$aa,$aa,$aa,$aa
	.byte	$0a,$00,$00,$00,$00,$0a,$0a,$aa,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$aa,$a0,$a0,$00,$aa,$00,$00,$a0,$aa
	.byte	$aa,$aa,$aa,$00,$00,$00,$aa,$aa,$aa

beast_running8:	; piskel9
	.byte	$9,$6
	.byte	$aa,$aa,$0a,$0a,$aa,$aa,$aa,$aa,$aa
	.byte	$0a,$00,$00,$00,$00,$0a,$0a,$aa,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$00,$00,$00,$00,$00,$00,$00,$00,$aa
	.byte	$aa,$a0,$00,$aa,$aa,$aa,$00,$a0,$aa
	.byte	$aa,$aa,$00,$a0,$aa,$aa,$00,$aa,$aa
