; play a cute sound
BE9F-   A2 40       LDX   #$40
BEA1-   A9 14       LDA   #$14
BEA3-   20 A8 FC    JSR   $FCA8
BEA6-   AD 30 C0    LDA   $C030
BEA9-   CA          DEX
BEAA-   D0 F5       BNE   $BEA1
BEAC-   A9 00       LDA   #$00
BEAE-   20 A8 FC    JSR   $FCA8
BEB1-   E8          INX
BEB2-   E0 06       CPX   #$06
BEB4-   D0 F6       BNE   $BEAC
