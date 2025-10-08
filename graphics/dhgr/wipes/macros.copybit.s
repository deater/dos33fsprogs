;license:MIT
;(c) 2019-2022 by 4am
;

;!ifndef _FX_MACROS_COPYBIT_ {
.ifndef _FX_MACROS_COPYBIT_

;!macro COPY_BIT .src1, .dest1, .copymasks {
.macro COPY_BIT src1, dest1, copymasks
         lda   (src1),y
         eor   (dest1),y            ; merge source and destination bits
         and   copymasks,x          ; isolate the bits to replace, zero the rest
         eor   (dest1),y            ; unmerge source and destination bits, leaves 'to keep' destination bits intact
         sta   (dest1),y            ; write the result
;}
.endmacro

;!macro COPY_BIT_DITHER .src1, .dest1, .copymasks, .dithermaskptr {
.macro COPY_BIT_DITHER src1, dest1, copymasks, dithermaskptr
         lda   (src1),y
         eor   (dest1),y            ; merge source and destination bits
         and   copymasks,x          ; isolate the bits to replace, zero the rest
         and   (dithermaskptr),y    ; apply dither mask (if any)
         eor   (dest1),y            ; unmerge source and destination bits, leaves 'to keep' destination bits intact
         sta   (dest1),y            ; write the result
;}
.endmacro

;!macro COPY_BIT_ZP .src1, .dest1, .zpcopymask {
.macro COPY_BIT_ZP src1, dest1, zpcopymask
         lda   (src1),y
         eor   (dest1),y            ; merge source and destination bits
         and   <zpcopymask          ; isolate the bits to replace, zero the rest
         eor   (dest1),y            ; unmerge source and destination bits, leaves 'to keep' destination bits intact
         sta   (dest1),y            ; write the result
;}
.endmacro

;!macro COPY_BIT_ZP_DITHER .src1, .dest1, .zpcopymask, .ditherptr {
.macro COPY_BIT_ZP_DITHER src1, dest1, zpcopymask, ditherptr
         lda   (src1),y
         eor   (dest1),y            ; merge source and destination bits
         and   <zpcopymask          ; isolate the bits to replace, zero the rest
         and   (ditherptr), y       ; apply dither mask (if any)
         eor   (dest1),y            ; unmerge source and destination bits, leaves 'to keep' destination bits intact
         sta   (dest1),y            ; write the result
;}
.endmacro

;!macro COPY_BIT_IMMEDIATE .copymask {
.macro COPY_BIT_IMMEDIATE copymask
         lda   (src), y
         eor   (dst), y              ; merge source and destination bits
         and   #copymask            ; isolate the bits to replace, zero the rest
         eor   (dst), y              ; unmerge source and destination bits, leaves 'to keep' destination bits intact
         sta   (dst), y              ; write the result
;}
.endmacro

_FX_MACROS_COPYBIT_=*
;}
.endif
