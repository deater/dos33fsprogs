; pattern 0
; 0 -> F
; 48-> C
; 50-> A
; 52-> 9
; 54-> 8
; 56-> 7
; 58-> 6
; 60-> 5
; 62-> 4
.byte	$FF,$FF,$FF,$2C,$2A,$29,$28,$27,$26,$25,$24

; pattern 1
; 0 -> F
; 9 -> C
;10 -> F
;20 -> C
;22 -> F
;29 -> C
;30 -> F
;31 -> C
;32 -> F
;40 -> C
; 48-> A
; 50-> 9
; 52-> 8
; 54-> 7
; 56-> 6
; 58-> 5
; 60-> 4
; 62-> 3
.byte $9F,$1C,$AF,$2C,$7F,$1C,$1F,$1C,$8F,$8C,$2A,$29,$28,$27,$26,$25,$24,$23

; pattern 2
; 0 ->F
; 13->C
; 14->F
; 15->C
; 16->F
; 24->C
; 26->9
; 28->8
; 30->7
; 32->F
; 45->C
; 46->F
; 47->C
; 48->F
; 56->C
; 58->9
; 60->7
; 62->6
.byte $DF,$1C,$1F,$1C,$8F,$2C,$29,$28,$27,$DF,$1C,$1F,$1C,$8F,$2C,$29,$27,$26

; pattern3
; 0->F
; 24->C
; 26->9
; 28->8
; 30->7
; 32->F
; 45->C
; 46->F
; 47->C
; 48->F
; 56->C
; 58->9
; 60->7
; 62->6
.byte $FF,$8F,$2C,$29,$28,$27,$DF,$1C,$1F,$1C,$8F,$2C,$29,$27,$26

; pattern4
;  0->0
; 60->F
; 61->C
; 62->F
; 63->C
.byte $F0,$F0,$F0,$C0,$1F,$1C,$1F,$1C