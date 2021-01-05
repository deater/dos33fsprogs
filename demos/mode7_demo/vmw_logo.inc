;     01 23 45 6   7 89 10 12   14 16 18 2   0 22 24 26   28 30 32 34
; 0   OO OO OO O   O OO GG BB   BB BB BB B   B GG BB BB   BB BB BB K
; 1   OO OO OO O   O OO GG BB   BB BB BB B   B GG BB BB   BB BB BB K
; 2   KK OO OO O   O GG GG GG   BB BB BB G   G GG GG BB   BB BB KK K
; 3   KK OO OO O   O GG GG GG   BB BB BB G   G GG GG BB   BB BB KK K
; 4   KK KK OO G   G GG GG GG   GG BB GG G   G GG GG GG   BB KK KK K
; 5   KK KK KK K   K KK KK KK   KK KK KK K   K KK KK KK   KK KK KK K

;   1 01 01 01 0 1 1 01 10 10 1 10 10 10 1 1 0 01 10 10 1 10 10 10 0
;   1 00 01 01 0 0 1 01 01 01 1 10 10 10 0 0 1 01 01 10 1 10 10 00 0
;   1 00 00 01 0 0 1 01 01 01 0 01 10 01 0 0 1 01 01 01 1 10 00 00 0
;   0 00 00 00 0 0 0 00 00 00 0 00 00 00 0 0 0 00 00 00 0 00 00 00 0

.byte $AA,$AD,$D5,$AC,$95
.byte $A8,$55,$95,$35,$85
.byte $A0,$55,$26,$55,$81

; 0 = black
; 1 = green  01
; 2 = purple 10
; 3 = white  11
; 4 = black  00
; 5 = orange 01
; 6 = blue   10

; Note: can only have green/purple and orange/blue in same run of 3
;       fringing happens when you change colors

; Note: each byte, values stored LSB first (legend says woz saved 2 chips)

; $2000, $2400, $2800, $2C00, $3000, $3400, $3800, $3C00

XXX  X X XX XX X   X  XXX XXX XXX XX  X X XXX XXX XXX XXX XXX
XXX  X X X X X X X X  XXX X   X X X X X X X    X   X  X X X X
X X   X  X   X XX XX  X   X   XXX XX  XXX XXX  X  XXX XXX X X
 0    ! 2    ! 4    ! 6    ! 7    ! 10    ! 12    ! 14    ! 16    !

* 11 11 11 0 * 0 00 11 00 * 11 00 11 1 * 1 00 11 11 *
* 11 11 11 0 * 0 00 11 00 * 11 00 11 0 * 0 11 00 11 *
* 11 00 11 0 * 0 00 00 11 * 00 00 11 0 * 0 00 00 11 *
.byte $bf,$98,
.byte $bf,$98
.byte $b3,$e0
