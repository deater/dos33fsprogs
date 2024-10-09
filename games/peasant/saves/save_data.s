
.include "../zp.inc"

; Note, all three saves fit in 256 bytes
; We actually handle being in 512 bytes as Prodos loasd in 512 byte chunks

.align $20
.include "save1_30_heights.s"
.align $20
.include "save1_18_nn_cottage.s"
.align $20
.include "save1_04_mask.s"

