; 18x13

; frame

frame_sprite:

.byte 3,41		; 3*13, ((3*13)+2)
.byte $FF,$FF,$C0
.byte $60,$01,$80
.byte $60,$01,$80
.byte $60,$01,$80
.byte $60,$01,$80
.byte $60,$01,$80
.byte $60,$01,$80
.byte $60,$01,$80
.byte $60,$01,$80
.byte $60,$01,$80
.byte $60,$01,$80
.byte $60,$01,$80
.byte $FF,$FF,$C0


zero_sprite:
.byte 1,8		; 1*6
.byte $00
.byte $00
.byte $00
.byte $00
.byte $00
.byte $06

one_sprite:
.byte 1,13		; 11+2
.byte $06
.byte $06
.byte $06
.byte $06
.byte $06
.byte $06
.byte $06
.byte $06
.byte $06
.byte $06
.byte $06

two_sprite:
.byte 1,13		; 11+2
.byte $80
.byte $C0
.byte $60
.byte $60
.byte $60
.byte $60
.byte $60
.byte $60
.byte $60
.byte $C0
.byte $80

three_sprite:
.byte 1,13		; 11+2
.byte $06
.byte $0C
.byte $18
.byte $30
.byte $60
.byte $C0
.byte $60
.byte $30
.byte $18
.byte $0c
.byte $06

four_sprite:
.byte 2,24		; 11*2+2
.byte $00,$00
.byte $00,$00
.byte $07,$F0
.byte $06,$00
.byte $06,$00
.byte $06,$00
.byte $06,$00
.byte $06,$00
.byte $06,$00
.byte $06,$00
.byte $06,$00



empty_sprite:
.byte 1,3
.byte $00

five_sprite:
.byte 2,14		; 2*6
.byte $00,$00
.byte $00,$00
.byte $00,$00
.byte $00,$00
.byte $00,$00
.byte $FF,$F0

ten_sprite:
.byte 2,24		; 2*11
.byte $00,$00
.byte $00,$00
.byte $00,$00
.byte $00,$00
.byte $00,$00
.byte $00,$00
.byte $00,$00
.byte $00,$00
.byte $3F,$c0
.byte $40,$20
.byte $80,$10

fifteen_sprite:
.byte 2,24		; 2*11
.byte $00,$00
.byte $00,$00
.byte $00,$00
.byte $00,$00
.byte $80,$10
.byte $C0,$30
.byte $60,$60
.byte $30,$c0
.byte $19,$80
.byte $0f,$00
.byte $06,$10

twenty_sprite:
.byte 2,14		; 2*6
.byte $30,$00
.byte $30,$00
.byte $30,$00
.byte $30,$00
.byte $30,$00
.byte $3f,$f0



