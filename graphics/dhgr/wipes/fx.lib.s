;license:MIT
;(c) 2024 by 4am
;
; common routines used by graphic effects
;
; Note: launcher code can call these routines directly. However,
; graphic effects are assembled as separate targets and must call
; these routines indirectly via the vectors defined in constants.a,
; e.g. iBuildHGRTables instead of BuildHGRTables.
;
; Public functions:
; - WaitForKeyWithTimeout
; - BuildHGRTables
; - BuildHGRMirrorTables
; - BuildHGRMirrorCols
; - BuildDHGRMirrorCols
; - BuildHGRDitherMasks
; - BuildDHGRDitherMasks

; - BuildHGRSparseBitmasks1Bit
; - BuildDHGRSparseBitmasks1Bit
; - ReverseCoordinates1Bit
; - RippleCoordinates1Bit
; - RippleCoordinates1Bit2
; - RippleCoordinates1Bit3
; - RippleCoordinates1Bit4

; - BuildHGRSparseBitmasks2Bit
; - BuildDHGRSparseBitmasks2Bit
; - ReverseCoordinates2Bit
; - RippleCoordinates2Bit

; - SetupPrecomputed3Bit
; - ReverseCoordinates3Bit
; - RippleCoordinates3Bit

;         !source "src/fx/macros.a"

WaitForKeyWithTimeout:
; in:    A = timeout length (like standard $FCA8 wait routine)
; out:   A clobbered (not always 0 if key is pressed, but also not the key pressed)
;        X/Y preserved
         sec
wait1:   pha
wait2:   sbc   #1
         bne   wait2
         pla
         bit   KBD
         bmi   wfk_exit
         sbc   #1
         bne   wait1
wfk_exit:    rts

; based on routine by John Brooks
; posted on comp.sys.apple2 on 2018-07-11
; https://groups.google.com/d/msg/comp.sys.apple2/v2HOfHOmeNQ/zD76fJg_BAAJ
BuildHGRTables:
; out:   populates tables at $0201 (hgrlo) and $0301 (hgrhi)
;        A clobbered
;        X=$C0 (important! some callers rely on this)
;        Z=1
;        Y preserved
         ldx   #0
bht_m1:        txa
         and   #$F8
         bpl   bht_p1
         ora   #5
bht_p1:        asl
         bpl   bht_p2
         ora   #5
bht_p2:        asl
         asl
         sta   hgrlo, x
         txa
         and   #7
         rol
         asl   hgrlo, x
         rol
         ora   #$20
         sta   hgrhi, x
         inx
         cpx   #$C0
         bne   bht_m1
         rts

BuildHGRMirrorTables:
         ldx   #$C0
         ldy   #0
bhm1_m1:        tya
         and   #$F8
         bpl   bhm1_p1
         ora   #5
bhm1_p1:        asl
         bpl   bhm1_p2
         ora   #5
bhm1_p2:        asl
         asl
         sta   hgrlomirror-1, x
         tya
         and   #7
         rol
         asl   hgrlomirror-1, x
         rol
         ora   #$20
         sta   hgr1himirror-1, x
         iny
         dex
         bne   bhm1_m1
         rts

BuildHGRMirrorCols:
; in:    none
; out:   mirror_cols populated with lookup table to get $27-y for y in $00..$27
;        all registers and flags clobbered
         ldx   #$27
         ldy   #$00
bhmc_m1:        tya
         sta   mirror_cols, x
         iny
         dex
         bpl   bhmc_m1
         rts

.if 0
BuildDHGRMirrorCols:
; out:   mirror_cols populated with lookup table to get $27-y for y in $00..$27
;        duplicated in both mainmem and auxmem
;        X=0
;        Z=1
         ldx   #$28
         ldy   #$00
-        tya
         sta   mirror_cols-1, x
         sta   $C005
         sta   mirror_cols-1, x
         sta   $C004
         iny
         dex
         bne   -
         rts

BuildHGRDitherMasks:
         ldy   #40
-        lda   #%10110011
         sta   dithermasks, y
         lda   #%11100110
         sta   dithermasks+1, y
         lda   #%11001100
         sta   dithermasks+2, y
         lda   #%10011001
         sta   dithermasks+3, y
         dey
         dey
         dey
         dey
         bpl   -
         ldy   #43
         lda   #$FF
-        sta   no_masks, y
         dey
         bpl   -
         rts

BuildDHGRDitherMasks:
         ldy   #40
-        lda   #%10011110
         sta   dithermasks, y
         lda   #%11111000
         sta   dithermasks+1, y
         lda   #%11100001
         sta   dithermasks+2, y
         lda   #%10000111
         sta   dithermasks+3, y
         dey
         dey
         dey
         dey
         bpl   -
         ldy   #43
-        lda   #$FF
         sta   no_masks, y
         dey
         bpl   -
         sta   $C005
         ldy   #40
-        lda   #%10001111
         sta   dithermasks, y
         lda   #%10111100
         sta   dithermasks+1, y
         lda   #%11110000
         sta   dithermasks+2, y
         lda   #%11000011
         sta   dithermasks+3, y
         dey
         dey
         dey
         dey
         bpl   -
         ldy   #43
-        lda   #$FF
         sta   no_masks, y
         dey
         bpl   -
         sta   $C004
         rts
.endif

BuildHGRSparseBitmasks1Bit:
         lda   #%10000001
         sta   copymasks1bit
         sta   mirror_copymasks1bit+$C0

         lda   #%10000010
         sta   copymasks1bit+$20
         sta   mirror_copymasks1bit+$A0

         lda   #%10000100
         sta   copymasks1bit+$40
         sta   mirror_copymasks1bit+$80

         lda   #%10001000
         sta   copymasks1bit+$60
         sta   mirror_copymasks1bit+$60

         lda   #%10010000
         sta   copymasks1bit+$80
         sta   mirror_copymasks1bit+$40

         lda   #%10100000
         sta   copymasks1bit+$A0
         sta   mirror_copymasks1bit+$20

         lda   #%11000000
         sta   copymasks1bit+$C0
         sta   mirror_copymasks1bit
         rts
.if 0
BuildDHGRSparseBitmasks1Bit:
; out:   X=0
         ldx   #$00
         txa
-        sta   copymasks1bit, x
         sta   $C005
         sta   copymasks1bit, x
         sta   $C004
         inx
         bne   -
         ; X=0

         lda   #%00000111
         sta   copymasks1bit+$80
         sta   mirror_copymasks1bit+$40

         lda   #%00011000
         sta   copymasks1bit+$A0
         sta   mirror_copymasks1bit+$20

         lda   #%01100000
         sta   copymasks1bit+$C0
         sta   mirror_copymasks1bit

         sta   $C005

         lda   #%10000011
         sta   copymasks1bit
         sta   mirror_copymasks1bit+$C0

         lda   #%10001100
         sta   copymasks1bit+$20
         sta   mirror_copymasks1bit+$A0

         lda   #%10110000
         sta   copymasks1bit+$40
         sta   mirror_copymasks1bit+$80

         lda   #%11000000
         sta   copymasks1bit+$60
         sta   mirror_copymasks1bit+$60

         sta   $C004
         rts

ReverseCoordinates1Bit:
         ldy   #0                    ; <Coordinates1Bit
         sty   $f0
         lda   #>Coordinates1Bit
         sta   $f1
         lda   #<(EndCoordinates1Bit - 2)
         sta   $f2
         lda   #>(EndCoordinates1Bit - 2)
         sta   $f3
         clc
         !byte $24
-        sec
--       lda   ($f0), y
         pha
         lda   ($f2), y
         sta   ($f0), y
         pla
         sta   ($f2), y
         iny
         bcc   -
         ldy   #0
         !byte $24
-        clc
         inc   $f0
         bne   +
         inc   $f1
+        lda   $f1
         eor   #>(Coordinates1Bit + $1A40)
         bne   +
         lda   $f0
         eor   #<(Coordinates1Bit + $1A40)
         beq   ++
+        lda   $f2
         bne   +
         dec   $f3
+        dec   $f2
         bcs   -
         bcc   --                    ; always
++       rts
.endif

BuildHGRSparseBitmasks2Bit:
         lda   #%10000011
         sta   copymasks2bit
         sta   mirror_copymasks2bit+$E0

         lda   #%10001100
         sta   copymasks2bit+$20
         sta   mirror_copymasks2bit+$C0

         lda   #%10110000
         sta   copymasks2bit+$40
         sta   mirror_copymasks2bit+$A0

         lda   #%11000000
         sta   copymasks2bit+$60
         sta   mirror_copymasks2bit+$80

         lda   #%10000001
         sta   copymasks2bit+$80
         sta   mirror_copymasks2bit+$60

         lda   #%10000110
         sta   copymasks2bit+$A0
         sta   mirror_copymasks2bit+$40

         lda   #%10011000
         sta   copymasks2bit+$C0
         sta   mirror_copymasks2bit+$20

         lda   #%11100000
         sta   copymasks2bit+$E0
         sta   mirror_copymasks2bit
         rts
.if 0
BuildDHGRSparseBitmasks2Bit:
         ldx   #$00
         txa
-        sta   copymasks2bit, x
         sta   $C005
         sta   copymasks2bit, x
         sta   $C004
         inx
         bne   -

         lda   #%10011111
         sta   copymasks2bit+$40
         sta   mirror_copymasks2bit+$A0

         lda   #%11100000
         sta   copymasks2bit+$60
         sta   mirror_copymasks2bit+$80

         lda   #%10000111
         sta   copymasks2bit+$C0
         sta   mirror_copymasks2bit+$20

         lda   #%11111000
         sta   copymasks2bit+$E0
         sta   mirror_copymasks2bit

         sta   $C005

         lda   #%10001111
         sta   copymasks2bit
         sta   mirror_copymasks2bit+$E0

         lda   #%11110000
         sta   copymasks2bit+$20
         sta   mirror_copymasks2bit+$C0

         lda   #%10000011
         sta   copymasks2bit+$80
         sta   mirror_copymasks2bit+$60

         lda   #%11111100
         sta   copymasks2bit+$A0
         sta   mirror_copymasks2bit+$40

         sta   $C004
         rts
.endif

.if 0
ReverseCoordinates2Bit:
	ldy	#0                    ; <Coordinates2Bit
	sty	$f0
	lda	#>Coordinates2Bit
	sta	$f1
	lda	#<(EndCoordinates2Bit - 2)
	sta	$f2
	lda	#>(EndCoordinates2Bit - 2)
	sta	$f3

	ldx	#$1E                  ; #$3C/2
	clc
	.byte $24			; bit ZP
rc2_m:
	sec
rc2_mm:
	lda	($f0), Y
	pha
	lda	($f2), Y
	sta	($f0), Y
	pla
	sta	($f2), Y
	iny
	bcc	rc2_m
	ldy	#0
	.byte $24
rc2_m2:
	clc
	inc	$f0
	bne	rc2_p
	inc	$f1
	dex
	beq	rc2_pp
rc2_p:
	lda	$f2
	bne	rc2_p2
	dec	$f3
rc2_p2:
	dec	$f2
	bcs	rc2_m2
	bcc	rc2_mm                    ; always branches
rc2_pp:
	rts
.endif

.if 0
RippleCoordinates2Bit:
         ldy   #0

         ldx   #$33
-        lda   @ptrtbl, x
         sta   $c0, x
         dex
         bpl   -

         lda   #$9b
         sta   $fe
         iny
         sty   $ff

         ldx   #6
-        lda   Coordinates2Bit + 1, x
         sta   $7f, x
         lda   Coordinates2Bit + 9, x
         sta   $85, x
         lda   Coordinates2Bit + 17, x
         sta   $8b, x
         lda   Coordinates2Bit + 65, x
         sta   $9b, x
         dex
         bne   -
         lda   Coordinates2Bit + 28
         sta   $92
         lda   Coordinates2Bit + 29
         sta   $93
         ldx   #4
-        lda   Coordinates2Bit + 33, x
         sta   $93, x
         lda   Coordinates2Bit + 41, x
         sta   $97, x
         lda   Coordinates2Bit + 83, x
         sta   $a1, x
         dex
         bne   -
         ldx   #2
-        lda   Coordinates2Bit + 125, x
         sta   $a5, x
         lda   Coordinates2Bit + 131, x
         sta   $a7, x
         lda   Coordinates2Bit + 139, x
         sta   $a9, x
         lda   Coordinates2Bit + 169, x
         sta   $ab, x
         lda   Coordinates2Bit + 237, x
         sta   $ad, x
         lda   Coordinates2Bit + 2193, x
         sta   $af, x
         lda   Coordinates2Bit + 6581, x
         sta   $b1, x
         dex
         bne   -

---      ldx   #$34
--       lda   $be, x
         tay
         ora   $bf, x
         beq   +
         lda   $bf, x
         jsr   @aslmod
         sty   $be, x
         sta   $bf, x
         sty   $fc
         clc
         adc   #>Coordinates2Bit
         sta   $fd
         ldy   #0
         !byte $24
-        sec
         lda   ($fc), y
         pha
         lda   $7e, x
         sta   ($fc), y
         pla
         sta   $7e, x
         inx
         iny
         bcc   -
         dex
         dex
+        dex
         dex
         bne   --
         ldy   #1
         lda   $fe
         eor   #<(411 - 2)
         beq   +
         ldy   #9
         eor   #<(411 - 2) xor <(411 - 136)
         bne   ++
+
-        ldx   @zerotbl, y
         sta   $0, x
         sta   $1, x
         dey
         bpl   -
++       dec   $fe
         bne   ---
         dec   $ff
         bpl   ---
         bmi   @exit                  ; always branches
@aslmod  jsr   +
+        cmp   #$1E
         bcc   +
         iny
+        pha
         tya
         asl
         tay
         pla
         rol
         cmp   #$3C
         bcc   @exit
         sbc   #$3C
@exit    rts
@ptrtbl  !word 2, 4, 6, 10, 12, 14, 18, 20
         !word 22, 28, 34, 36, 42, 44, 66, 68
         !word 70, 84, 86, 126, 132, 140, 170, 238
         !word 2194, 6582
@zerotbl !byte $f0, $f2, $ca, $d2, $d8, $e0, $e2, $e6, $ea, $ee

SetupPrecomputed3Bit:
         ; build regular HGR lookup tables, then split them
         jsr   BuildHGRTables
         ldx   #$BF
         ldy   #$3F
-        lda   hgrlo, x
         sta   hgrlo3c, y
         sta   hgrlo3c+$40, y
         lda   hgrhi, x
         sta   hgrhi3c, y
         sta   hgrhi3c+$40, y
         dex
         lda   hgrlo, x
         sta   hgrlo3b, y
         sta   hgrlo3b+$40, y
         lda   hgrhi, x
         sta   hgrhi3b, y
         sta   hgrhi3b+$40, y
         dex
         lda   hgrlo, x
         sta   hgrlo3a, y
         sta   hgrlo3a+$40, y
         lda   hgrhi, x
         sta   hgrhi3a, y
         sta   hgrhi3a+$40, y
         dex
         dey
         bpl   -

         ; build lookup table to get $20+y for y in $00..$07
         ldx   #$07
         ldy   #$27
-        tya
         sta   extra_cols-$20, y
         dey
         dex
         bpl   -

         ; build sparse lookup tables for bitmasks
         lda   #%10000011
         sta   copymasks3bit

         lda   #%10001100
         sta   copymasks3bit+$20

         lda   #%10110000
         sta   copymasks3bit+$40

         lda   #%11000000
         sta   copymasks3bit+$60

         lda   #%10000001
         sta   copymasks3bit+$80

         lda   #%10000110
         sta   copymasks3bit+$A0

         lda   #%10011000
         sta   copymasks3bit+$C0

         lda   #%11100000
         sta   copymasks3bit+$E0
         rts

ReverseCoordinates3Bit:
         ldy   #0                    ; <Coordinates3Bit
         sty   $f0
         lda   #>Coordinates3Bit
         sta   $f1
         lda   #<(EndCoordinates3Bit - 2)
         sta   $f2
         lda   #>(EndCoordinates3Bit - 2)
         sta   $f3

         ldx   #$28                  ; #$50/2
         clc
         !byte $24
-        sec
--       lda   ($f0), y
         pha
         lda   ($f2), y
         sta   ($f0), y
         pla
         sta   ($f2), y
         iny
         bcc   -
         ldy   #0
         !byte $24
-        clc
         inc   $f0
         bne   +
         inc   $f1
         dex
         beq   ++
+        lda   $f2
         bne   +
         dec   $f3
+        dec   $f2
         bcs   -
         bcc   --                    ; always branches
++       rts

RippleCoordinates3Bit:
         ldx   #$1B
-        lda   @ripplezp, x
         sta   $e0, x
         dex
         bpl   -

---      ldx   #$0c
--       ldy   $ee, x
         lda   $ef, x
         jsr   @aslmod
         sty   $ee, x
         sta   $ef, x
         sty   $ec
         clc
         adc   #>Coordinates3Bit
         sta   $ed
         ldy   #0
         !byte $24
-        sec
         lda   ($ec), y
         pha
         lda   $de, x
         sta   ($ec), y
         pla
         sta   $de, x
         inx
         iny
         bcc   -
         dex
         dex
         dex
         dex
         bne   --
         dec   $ee
         bne   ---
         dec   $ef
         bpl   ---
         bmi   @exit                 ; always branches
@aslmod  jsr   +
+        cmp   #$28
         bcc   +
         iny
+        pha
         tya
         asl
         tay
         pla
         rol
         cmp   #$50
         bcc   @exit
         sbc   #$50
@exit    rts
@ripplezp
         !byte $1F,$F3,$20,$F3,$20,$14,$20,$D3
         !byte $1E,$F3,$1F,$54,$00,$00,$AA,$06
         !byte $02,$00,$04,$00,$06,$00,$0C,$00
         !byte $16,$00,$1A,$00

!zone {
RippleCoordinates1Bit4:
         lda   #<aslmod4
         +HIDE_NEXT_2_BYTES
RippleCoordinates1Bit3
         lda   #<aslmod3
         +HIDE_NEXT_2_BYTES
RippleCoordinates1Bit2
         lda   #<aslmod2
         +HIDE_NEXT_2_BYTES
RippleCoordinates1Bit
         lda   #<aslmod
         sta   @jsr+1
         lda   #2                    ; <(Coordinates1Bit + 2)
         sta   $f0
         ldy   #0
         sty   $f1
         lda   #$16                  ; <(Coordinates1Bit + 22)
         sta   $f2
         sty   $f3

         lda   #$1f
         sta   $ee
         lda   #$0d
         sta   $ef

         lda   Coordinates1Bit + 2
         sta   $e0
         lda   Coordinates1Bit + 3
         sta   $e1
         lda   Coordinates1Bit + 22
         sta   $e2
         lda   Coordinates1Bit + 23
         sta   $e3

---      ldx   #4
--       ldy   $ee, x
         lda   $ef, x
@jsr     jsr   aslmod                ; SMC on entry
         sty   $ee, x
         sta   $ef, x
         sty   $ec
         clc
         adc   #>Coordinates1Bit
         sta   $ed
         ldy   #0
         !byte $24
-        sec
         lda   ($ec), y
         pha
         lda   $de, x
         sta   ($ec), y
         pla
         sta   $de, x
         inx
         iny
         bcc   -
         dex
         dex
         dex
         dex
         bne   --
         dec   $ee
         bne   ---
         dec   $ef
         bpl   ---
         bmi   exit                 ; always branches
aslmod4  jsr   aslmod
aslmod3  jsr   aslmod
aslmod2  jsr   aslmod
aslmod   cmp   #$1A
!if (>aslmod != >aslmod4) {
         !serious "aslmod entry points are not on the same page"
}
         bcc   +
         bne   ++
         cpy   #$40
         bcc   +
++       iny
+        pha
         tya
         asl
         tay
         pla
         rol
         cmp   #$34
         bcc   exit
         bne   ++
         cpy   #$80
         bcc   exit
++       pha
         tya
         sbc   #$80
         tay
         pla
         sbc   #$34
exit     rts
}

.endif
