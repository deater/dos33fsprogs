;=========================
;=========================
; Beast
;=========================
;=========================

; FIXME: add tripping+falling sprites
; FIXME: add background beast for first cavern room
; FIXME: better running sprites


;=============================
; big beast sprites
;=============================

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

beast_dead_sprite:
	.byte	8,3
	.byte	$AA,$0A,$00,$0a,$00,$00,$0a,$AA
	.byte	$AA,$00,$00,$00,$00,$00,$00,$00
	.byte	$00,$A0,$00,$00,$00,$00,$00,$00

; the right way to do this would be to have the pounce sprites
; then have the zap sprites
; start the pounce/zapping with the beast at the YPOS
; adjust, etc.
; then draw the laser manually
; don't really have time/inclination to fix this properly

beast_blast_sprite0:
	.byte	6,7
	.byte	$AA,$0A,$00,$00,$00,$0A
	.byte	$AA,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$11,$00,$00,$AA
	.byte	$00,$00,$A1,$00,$AA,$AA
	.byte	$00,$00,$AA,$AA,$AA,$AA
	.byte	$AA,$00,$AA,$AA,$AA,$AA

beast_blast_sprite1:
	.byte	6,8
	.byte	$AA,$AA,$AA,$0A,$AA,$AA
	.byte	$AA,$AA,$00,$00,$00,$0A
	.byte	$AA,$0A,$00,$00,$00,$00
	.byte	$AA,$00,$00,$13,$00,$1A
	.byte	$00,$00,$00,$11,$00,$AA
	.byte	$A0,$00,$00,$AA,$A0,$A0
	.byte	$AA,$A0,$00,$AA,$AA,$AA
	.byte	$AA,$AA,$A0,$AA,$AA,$AA

beast_blast_sprite2:
	.byte	6,8
	.byte	$AA,$0A,$00,$00,$00,$AA
	.byte	$00,$00,$00,$00,$00,$00
	.byte	$00,$00,$00,$00,$00,$A0
	.byte	$00,$00,$00,$33,$11,$00
	.byte	$00,$00,$00,$33,$11,$10
	.byte	$00,$00,$00,$11,$01,$AA
	.byte	$A0,$00,$0A,$AA,$AA,$AA
	.byte	$AA,$AA,$00,$AA,$AA,$AA

beast_blast_sprite3:
	.byte	7,7
	.byte	$AA,$AA,$AA,$AA,$0A,$AA,$AA
	.byte	$AA,$AA,$AA,$00,$00,$00,$AA
	.byte	$AA,$AA,$0A,$00,$00,$00,$00
	.byte	$AA,$00,$00,$00,$00,$A0,$A0
	.byte	$00,$00,$00,$13,$00,$1A,$1A
	.byte	$00,$00,$03,$A1,$A0,$AA,$AA
	.byte	$AA,$A0,$00,$0A,$AA,$AA,$AA

beast_blast_sprite4:
	.byte	8,5
	.byte	$0A,$0A,$0A,$AA,$0A,$0A,$0A,$AA
	.byte	$00,$00,$00,$00,$00,$00,$00,$0A
	.byte	$AA,$00,$00,$00,$00,$00,$00,$00
	.byte	$1A,$00,$1A,$1A,$10,$1A,$00,$1A
	.byte	$AA,$A0,$AA,$AA,$A0,$0A,$A0,$AA

beast_blast_sprite5:
	.byte	10,6
	.byte	$AA,$AA,$00,$0A,$AA,$AA,$AA,$AA,$AA,$AA
	.byte	$AA,$00,$00,$00,$00,$0a,$0A,$0A,$AA,$AA
	.byte	$10,$10,$1A,$10,$10,$00,$00,$00,$11,$1A
	.byte	$AA,$AA,$AA,$AA,$AA,$00,$00,$A0,$A1,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$00,$AA,$AA,$AA,$AA
	.byte	$AA,$AA,$AA,$AA,$AA,$A0,$AA,$AA,$AA,$AA






;========================
;========================
; Beast in background
;========================
;========================

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


