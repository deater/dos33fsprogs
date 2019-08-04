; They see me rolling...

rolling_progression:
.word rolling1
.word rolling2
.word rolling3
.word rolling4
.word rolling5
.word rolling6
.word rolling7
.word rolling8

rolling1:
.byte 5,2
.byte $AA,$AA,$9B,$9B,$B4
.byte $AA,$AA,$99,$99,$AB

rolling2:
.byte 5,2
.byte $AA,$44,$9B,$9B,$BA
.byte $AA,$AB,$99,$99,$AB

rolling3:
.byte 5,2
.byte $AA,$44,$9B,$BA,$AA
.byte $AA,$AB,$99,$99,$AA

rolling4:
.byte 5,2
.byte $55,$44,$9B,$9B,$AA
.byte $AA,$AB,$A9,$99,$AA

rolling5:
.byte 5,2
.byte $4A,$4B,$99,$99,$AA
.byte $A4,$AB,$B9,$A9,$AA

rolling6:
.byte 5,2
.byte $AA,$04,$99,$99,$AA
.byte $AA,$AB,$B9,$B9,$AA

rolling7:
.byte 5,2
.byte $AA,$04,$99,$99,$04
.byte $AA,$BB,$B9,$B9,$BB

rolling8:
.byte 5,2
.byte $AA,$AA,$99,$99,$B4
.byte $AA,$AA,$99,$99,$BB


poisoned1:
.byte 8,2
.byte $AA,$AA,$AA,$88,$88,$44,$DA,$AA
.byte $AA,$AA,$DD,$88,$88,$DD,$AA,$AA

poisoned2:
.byte 8,2
.byte $AA,$AA,$AA,$88,$88,$44,$DA,$AA
.byte $AA,$DD,$DA,$88,$88,$D4,$DD,$AA

poisoned3:
.byte 8,2
.byte $AA,$AA,$AA,$88,$88,$44,$AA,$AA
.byte $DA,$DA,$DA,$88,$88,$D4,$DA,$DA


rolling_falling1:
.byte 2,5
.byte $9B,$9B
.byte $99,$99
.byte $AA,$AA
.byte $AA,$AA
.byte $AA,$AA

rolling_falling2:
.byte 2,5
.byte $B4,$b4
.byte $99,$99
.byte $A9,$A9
.byte $AA,$AA
.byte $AA,$AA

rolling_falling3:
.byte 2,5
.byte $44,$44
.byte $b4,$0B
.byte $99,$99
.byte $A9,$A9
.byte $AA,$AA

rolling_falling4:
.byte 2,5
.byte $45,$45
.byte $44,$44
.byte $bb,$00
.byte $9b,$90
.byte $99,$99

rolling_splat1:
.byte 4,4
.byte $AA,$A5,$45,$4A
.byte $AA,$BA,$94,$94
.byte $AA,$AA,$99,$99
.byte $AA,$AA,$AA,$AA

rolling_splat2:
.byte 4,4
.byte $AA,$45,$45,$AA
.byte $AA,$BA,$04,$04
.byte $AA,$AB,$99,$99
.byte $AA,$A1,$AA,$AA

rolling_splat3:
.byte 4,4
.byte $AA,$4A,$4A,$4A
.byte $AA,$A4,$04,$04
.byte $BA,$BA,$99,$99
.byte $A1,$A1,$AA,$AA


