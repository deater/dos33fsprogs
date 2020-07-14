number_sprites:
.word sprite_0,sprite_1,sprite_2,sprite_3,sprite_4
.word sprite_5,sprite_6,sprite_7,sprite_8,sprite_9

;  .   .   .   .  . .
; O O ^O  ^ O ^ O O O
; O O  O   O   ^O ^^O
; ^.^ .O. O.. ..^   O

sprite_0:
	.byte 3,4
	.byte	$AA,$0A,$AA	;
	.byte	$00,$AA,$00	;
	.byte	$00,$AA,$00	;
	.byte	$A0,$0A,$A0	;

;  .   .   .   .  . .
; O O ^O  ^ O ^ O O O
; O O  O   O   ^O ^^O
; ^.^ .O. O.. ..^   O

sprite_1:
	.byte 3,4
	.byte	$AA,$0A,$AA
	.byte	$A0,$00,$AA
	.byte	$AA,$00,$AA
	.byte	$0A,$00,$0A

;  .   .   .   .  . .
; O O ^O  ^ O ^ O O O
; O O  O   O   ^O ^^O
; ^.^ .O. O.. ..^   O

sprite_2:
	.byte 3,4
	.byte	$AA,$0A,$AA
	.byte	$A0,$AA,$00
	.byte	$AA,$00,$AA
	.byte	$00,$0A,$0A

;  .   .   .   .  . .
; O O ^O  ^ O ^ O O O
; O O  O   O   ^O ^^O
; ^.^ .O. O.. ..^   O

sprite_3:
	.byte 3,4
	.byte	$AA,$0A,$AA
	.byte	$A0,$AA,$00
	.byte	$AA,$A0,$00
	.byte	$0A,$0A,$A0

;  .   .   .   .  . .
; O O ^O  ^ O ^ O O O
; O O  O   O   ^O ^^O
; ^.^ .O. O.. ..^   O

sprite_4:
	.byte 3,4
	.byte	$0A,$AA,$0A
	.byte	$00,$AA,$00
	.byte	$A0,$A0,$00
	.byte	$AA,$AA,$00

; ...  .. ...  .   .
; O   O     O O O O O
; ^^. O^.  O  .^.  ^O
; ..^ ^.^ O   ^.^ ..O

sprite_5:
	.byte 3,4
	.byte	$0A,$0A,$0A
	.byte	$00,$AA,$AA
	.byte	$A0,$A0,$0A
	.byte	$0A,$0A,$A0

; ...  .. ...  .   .
; O   O     O O O O O
; ^^. O^.  O  .^.  ^O
; ..^ ^.^ O   ^.^ ..O

sprite_6:
	.byte 3,4
	.byte	$AA,$0A,$0A
	.byte	$00,$AA,$AA
	.byte	$00,$A0,$0A
	.byte	$A0,$0A,$A0

; ...  .. ...  .   .
; O   O     O O O O O
; ^^. O^.  O  .^.  ^O
; ..^ ^.^ O   ^.^ ..O

sprite_7:
	.byte 3,4
	.byte	$0A,$0A,$0A
	.byte	$AA,$AA,$00
	.byte	$AA,$00,$AA
	.byte	$00,$AA,$AA

; ...  .. ...  .   .
; O   O     O O O O O
; ^^. O^.  O  .^.  ^O
; ..^ ^.^ O   ^.^ ..O

sprite_8:
	.byte 3,4
	.byte	$AA,$0A,$AA
	.byte	$00,$AA,$00
	.byte	$0A,$A0,$0A
	.byte	$A0,$0A,$A0

; ...  .. ...  .   .
; O   O     O O O O O
; ^^. O^.  O  .^.  ^O
; ..^ ^.^ O   ^.^ ..^

sprite_9:
	.byte 3,4
	.byte	$AA,$0A,$AA
	.byte	$00,$AA,$00
	.byte	$AA,$A0,$00
	.byte	$0A,$0A,$A0

