
.include "../zp.inc"

; Note, all three saves fit in 256 bytes
; We actually handle being in 512 bytes as Prodos loasd in 512 byte chunks

.align $20
.include "save1_30_heights.s"
;.include "save1_25_cliff_base.s"
;.include "save1_24_on_fire.s"
;.include "save1_02_pebbles.s"
;.include "save1_03_well.s"
.align $20
.include  "save1_20_in_robe.s"
;.include  "save1_11_riches.s"
;.include "save2_01_gary.s"
;.include "save2_02_feed.s"
;.include "save1_32_outer.s"
.align $20
.include "save1_04_mask.s"

