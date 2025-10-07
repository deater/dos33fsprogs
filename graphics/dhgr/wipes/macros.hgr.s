;license:MIT
;(c) 2019-2022 by 4am
;

;!ifndef _FX_MACROS_HGR_ {
.ifndef _FX_MACROS_HGR_

;!macro HGR_CALC {
.macro HGR_CALC
; in:    A = HGR row (0x00..0xBF)
; out:   A/X clobbered
;        Y preserved
;        ($26) points to first byte of given HGR row on hi-res page 1
;        ($3C) points to same byte on hi-res page 2
; based on 'Woz Recodes Hi-Res Address Calculations'
; Apple Assembly Line vol. 7 issue 3 (December 1986)
; http://www.txbobsc.com/aal/1986/aal8612.html#a9

	.local calc1
	.local calc2

         asl
         tax
         and   #$F0
         bpl   calc1
         ora   #$05
calc1:   bcc   calc2
         ora   #$0A
calc2:   asl
         asl
         sta   $26
         txa
         and   #$0E
         adc   #$10
         asl   $26
         rol
         sta   $27
         eor   #$60
         sta   $3d
         lda   $26
         sta   $3c
;}
.endmacro

;!macro HGR_ROW_CALC {
.macro HGR_ROW_CALC
	asl
	asl
	asl
;         +HGR_CALC
	HGR_CALC
;}
.endmacro

; /!\ C must be clear before using this macro
;!macro HGR_INC_WITHIN_BLOCK {
.macro HGR_INC_WITHIN_BLOCK
         lda   $27
         adc   #$04
         sta   $27
         eor   #$60
         sta   $3d
;}
.endmacro

;!macro RESET_HGR_CALC {
.macro RESET_HGR_CALC
         lda   $27
         sec
         sbc   #$20
         sta   $27
         eor   #$60
         sta   $3d
;}
.endmacro

;!macro SWITCH_TO_MASKS .copy {
.macro SWITCH_TO_MASKS copy
         lda   #<copy
         sta   CopyMaskAddr
         lda   #>copy
         sta   CopyMaskAddr+1
;}
.endmacro

;!macro ROW_X_TO_BASE_ADDRESSES .src1, .src2, .dest1, .dest2 {
.macro ROW_X_TO_BASE_ADDRESSES src1, src2, dest1, dest2
         lda   hgrlo, x
         sta   <dest1
         sta   <src1
         lda   hgr1hi, x
         sta   <dest1+1
         eor   #$60
         sta   <src1+1
         lda   hgrlo+1, x
         sta   <dest2
         sta   <src2
         lda   hgr1hi+1, x
         sta   <dest2+1
         eor   #$60
         sta   <src2+1
;}
.endmacro

;!macro ROW_X_TO_MIRROR_ADDRESSES .mirror_src1, .mirror_src2, .mirror_dest1, .mirror_dest2 {
.macro ROW_X_TO_MIRROR_ADDRESSES mirror_src1, mirror_src2, mirror_dest1, mirror_dest2
         lda   hgrlomirror, x
         sta   <mirror_dest1
         sta   <mirror_src1
         lda   hgr1himirror, x
         sta   <mirror_dest1+1
         eor   #$60
         sta   <mirror_src1+1
         lda   hgrlomirror+1, x
         sta   <mirror_dest2
         sta   <mirror_src2
         lda   hgr1himirror+1, x
         sta   <mirror_dest2+1
         eor   #$60
         sta   <mirror_src2+1
;}
.endmacro

;!macro ROW_X_TO_2BIT_BASE_ADDRESSES .src1, .src2, .dest1, .dest2 {
.macro ROW_X_TO_2BIT_BASE_ADDRESSES src1, src2, dest1, dest2
         ; X = $01..$C0, mapping to row 0..191
         lda   hgrlo-1, x
         sta   <dest1
         sta   <src1
         lda   hgr1hi-1, x
         sta   <dest1+1
         eor   #$60
         sta   <src1+1
         lda   hgrlo, x
         sta   <dest2
         sta   <src2
         lda   hgr1hi, x
         sta   <dest2+1
         eor   #$60
         sta   <src2+1
;}
.endmacro

;!macro ROW_X_TO_3BIT_BASE_ADDRESSES .src1, .src2, .src3, .dest1, .dest2, .dest3 {
.macro ROW_X_TO_3BIT_BASE_ADDRESSES src1, src2, src3, dest1, dest2, dest3
         ; X = $00..$3F, mapping to row 0, 3, 6, 9, 12, ... 189
         lda   hgrlo3a, x
         sta   <dest1
         sta   <src1
         lda   hgrhi3a, x
         sta   <dest1+1
         eor   #$60
         sta   <src1+1
         lda   hgrlo3b, x
         sta   <dest2
         sta   <src2
         lda   hgrhi3b, x
         sta   <dest2+1
         eor   #$60
         sta   <src2+1
         lda   hgrlo3c, x
         sta   <dest3
         sta   <src3
         lda   hgrhi3c, x
         sta   <dest3+1
         eor   #$60
         sta   <src3+1
;}
.endmacro

;!macro HGR_CALC_ROUTINES {
.macro HGR_CALC_ROUTINES
HGRCalc:
; in:    A = HGR row (0x00..0xBF)
; out:   A/X clobbered
;        Y preserved
;        ($26) points to first byte of given HGR row on hi-res page 1
;        ($3C) points to same byte on hi-res page 2
; based on 'Woz Recodes Hi-Res Address Calculations'
; Apple Assembly Line vol. 7 issue 3 (December 1986)
; http://www.txbobsc.com/aal/1986/aal8612.html#a9
         HGR_CALC
         rts
;}
.endmacro

;!macro HGR_BLOCK_COPY_ROUTINES {
.macro HGR_BLOCK_COPY_ROUTINES
HGRBlockCopy:
; in:    A = HGR row / 8 (0x00..0x17)
;        Y = HGR column (0x00..0x27)
; out:   Y preserved
;        X = #$00
;        Z set
;        C clear
;        all other flags and registers clobbered
         HGR_ROW_CALC
HGRBlockCopyNoRecalc:
         clc
         ldx   #$08
@loop:
         lda   ($3c),y
         sta   ($26),y
         HGR_INC_WITHIN_BLOCK
         dex
         bne   @loop
         rts
;}
.endmacro

;!macro HGR_HALF_BLOCK_COPY_ROUTINES {
.macro HGR_HALF_BLOCK_COPY_ROUTINES
HGRHalfBlockCopy:
; in:    A = HGR row / 4 (0x00..0x2F)
;        Y = HGR column (0x00..0x27)
; out:   Y preserved
;        X = #$00
;        Z set
;        C clear
;        all other flags and registers clobbered
         asl
         asl
         HGR_CALC
HGRStaggerCopy:
         clc
         ldx   #$04
@loop:
         lda   ($3c),y
         sta   ($26),y
         HGR_INC_WITHIN_BLOCK
         dex
         bne   @loop
         rts
;}
.endmacro

;!macro HGR_WHITE_ROUTINES {
.macro HGR_WHITE_ROUTINES
HGRBlockToWhite:
; in:    A = HGR row / 8 (0x00..0x17)
;        Y = HGR column (0x00..0x27)
; out:   Y preserved
;        X = #$00
;        Z set
;        C clear
;        all other flags and registers clobbered
         HGR_ROW_CALC
         clc
         ldx   #$08
@loop:
         lda   #$7F
         sta   ($26),y
         HGR_INC_WITHIN_BLOCK
         dex
         bne   @loop
         rts

HGRHalfBlockToWhite:
; in:    A = HGR row / 4 (0x00..0x2F)
;        Y = HGR column (0x00..0x27)
; out:   Y preserved
;        X = #$00
;        Z set
;        C clear
;        all other flags and registers clobbered
         asl
         asl
         HGR_CALC
HGRStaggerToWhite:
         clc
         ldx   #$04
@loop:
         lda   #$7F
         sta   ($26),y
         HGR_INC_WITHIN_BLOCK
         dex
         bne   @loop
         rts
;}
.endmacro

;!macro HGR_COPY_MASK_ROUTINES {
.macro HGR_COPY_MASK_ROUTINES
SetCopyMask:
; in:    A/Y points to 8-byte array of bit masks used by HGRBlockCopyWithMask
         ST16 CopyMaskAddr
         rts

HGRBlockCopyWithMask:
; in:    A = HGR row / 8 (0x00..0x17)
;        Y = HGR column (0x00..0x27)
;        must call SetCopyMask first
; out:   Y preserved
;        A/X clobbered
;        $00 clobbered
         HGR_ROW_CALC
HGRBlockCopyWithMaskNoRecalc:
         ldx   #7
HGRBlockCopyWithMasksLoop:
         lda   ($26),y
         eor   ($3c),y
CopyMaskAddr=*+1
         and   $FDFD,x               ; call SetCopyMask to set
         eor   ($26),y
         sta   ($26),y
         clc
         HGR_INC_WITHIN_BLOCK
         dex
         bpl   HGRBlockCopyWithMasksLoop
         rts
;}
.endmacro
_FX_MACROS_HGR_=*
.endif
;}
