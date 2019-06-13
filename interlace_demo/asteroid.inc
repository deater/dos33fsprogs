; all hard-coded 3x2

asteroid_lookup:
	.word	asteroid_p1,explode0_p1,explode1_p1,explode2_p1

asteroid_p1:
.byte	$50,$85,$80
.byte	$05,$88,$08

explode0_p1:
.byte	$d0,$95,$d0
.byte	$0d,$59,$0d

explode1_p1:
.byte	$0d,$90,$0d
.byte	$d0,$09,$d0

explode2_p1:
.byte	$05,$80,$05
.byte	$50,$08,$50

void_p1:
.byte	$00,$00,$00
.byte	$00,$00,$00
