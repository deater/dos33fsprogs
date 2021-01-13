; Numbers


; ******    **    ****    ****    **  **  ******    ****  ******  ******  ******
; **  **  ****        **      **  **  **  **      **          **  **  **  **  **
; **  **    **      ****  ****    ******  ****    ******    **    ******  ******
; **  **    **    **          **      **      **  **  **    **    **  **      **
; ******  ******  ******  ****        **  ****    ******    **    ******      **


number_sprites:
	.word number0_sprite
	.word number1_sprite
	.word number2_sprite
	.word number3_sprite
	.word number4_sprite
	.word number5_sprite
	.word number6_sprite
	.word number7_sprite
	.word number8_sprite
	.word number9_sprite
	.word numberX_sprite
	.word numberX_sprite
	.word numberX_sprite
	.word numberX_sprite
	.word numberX_sprite
	.word numberX_sprite


number0_sprite:
	.byte $3,$3
	.byte $55,$A5,$55
	.byte $55,$AA,$55
	.byte $A5,$A5,$A5

number1_sprite:
	.byte $3,$3
	.byte $5A,$55,$AA
	.byte $AA,$55,$AA
	.byte $A5,$A5,$A5

number2_sprite:
	.byte $3,$3
	.byte $A5,$A5,$5A
	.byte $5A,$A5,$A5
	.byte $A5,$A5,$A5

number3_sprite:
	.byte $3,$3
	.byte $A5,$A5,$5A
	.byte $A5,$A5,$5A
	.byte $A5,$A5,$AA

number4_sprite:
	.byte $3,$3
	.byte $55,$AA,$55
	.byte $A5,$A5,$55
	.byte $AA,$AA,$A5

number5_sprite:
	.byte $3,$3
	.byte $55,$A5,$A5
	.byte $A5,$A5,$5A
	.byte $A5,$A5,$AA

number6_sprite:
	.byte $3,$3
	.byte $5A,$A5,$A5
	.byte $55,$A5,$55
	.byte $A5,$A5,$A5

number7_sprite:
	.byte $3,$3
	.byte $A5,$A5,$55
	.byte $AA,$55,$AA
	.byte $AA,$A5,$AA

number8_sprite:
	.byte $3,$3
	.byte $55,$A5,$55
	.byte $55,$A5,$55
	.byte $A5,$A5,$A5

number9_sprite:
	.byte $3,$3
	.byte $55,$A5,$55
	.byte $A5,$A5,$55
	.byte $AA,$AA,$A5

numberX_sprite:
	.byte $3,$3
	.byte $55,$55,$55
	.byte $55,$55,$55
	.byte $55,$55,$55
