;	fast seek/multi-read
;	copyright (c) Peter Ferrie 2015-16

	sectors   = $d1		; user-defined
	firsttrk  = $d1		; user-defined, first track to read
	firstsec  = $d1		; user-defined, first sector to read
	address   = $d1		; user-defined
	entry     = $d1d1	; user-defined
	version   = 1

        ;memory usage:
        ;256 bytes ($bd00-bdff) static table
        grouped   = $bd00
        ;106 bytes ($xx00-xx69) static table
	preshift	= code_end
        zvalue		= $fd         ;only during init
        znibble		= $fe         ;only during init
        zmask		= $ff         ;only during init


; $26/$27	sector read location (ROM), scratch space (RWTS)
; $3D		sector number


; at entry (at least on AppleWin) A=1, X=60, Y=0
; qkumba says cffa cards leave Y at $10
;	26/27 =	00/09
;	3D = 1

	; For Disk II booting, the firmware loads track0/sector0
	; to $800 and then jumps to $801

.org $800
	.byte	1		; number of sectors for ROM to load

boot_entry:
	; this code loads two sectors up to $BE/$BF

	lsr			; check sector number
	tay
	adc	#$bd
	sta	$27		; set or update address as needed
	asl
				; be, bf, c0  (1011 1011 1100)
				; so if hit $c000 we are done

	bmi	not_three	; branch if not 3

	inc	$3d		; increment sector (faster to find)

	; call to the read routine in proper slot
	; using rts to jump indirect to
	; $CX5C

	; this routine reads sector in $3D on track $41
	;	to address in $26/$27
	; when it's done it jumps back to $801

	txa			; x is slot# << 4
	lsr
	lsr
	lsr
	lsr
	ora	#$c0		; slot to PROM base
	pha
	lda     #$5b            ;read-1
	pha
	rts

not_three:
	txa
	ora	#$8c		; slot to Q6L
				; Q6L?
				; 1000 1100
patch_loop:
	iny
	ldx	patchtbl-3, y
	sta	code_begin, x   ;replace placeholders with Q6L
	bne	patch_loop
	and	#$f8            ;MOTOROFF
	sta	slotpatch7+1
	eor	#8              ;PHASEOFF
	sta	slotpatch8+1
	ldx	#$3f
	stx	zmask
	inx
	ldy	#$7f

	bne	skip_ahead	; branch always

	; pad with zeros until $839
.res	$839-*
;*=$839
	lda	#>(entry-1)
	pha
	lda	#<(entry-1)
	pha
	jsr	preread
	jmp	$bf00           ;DOS 3.3 launcher entrypoint

patchtbl:
	.byte   <(slotpatch1+1), <(slotpatch2+1), <(slotpatch3+1), <(slotpatch4+1), <(slotpatch5+1), <(slotpatch6+1)
indextbl:	;the 0 also terminates the patchtbl list!
	.byte   0, 2, 1, 3


        ;construct denibbilisation table
        ;pre-shifted for interleave read

skip_ahead:
loopaa:
	sty	znibble
	tya
	asl
	bit	znibble
	beq	loopz
	ora	znibble
	eor	#$ff
	and	#$7e
loopa:
	bcs	loopz
	lsr
	bne	loopa
	dex
	txa
	asl
	asl
	sta	preshift-$16, Y
loopz:
	dey
	bne	loopaa

        ;construct 2-bit group table

	sty     zvalue
loopbb:
	lsr     zmask
	lsr     zmask
loopb:
	lda	indextbl, X
	sta	grouped, Y
	inc	zvalue
	lda	zvalue
	and	zmask
	bne	loopy
	inx
	txa
	and	#3
	tax
loopy:
	iny
	iny
	iny
	iny
	cpy	#3
	bcs	loopb
	iny
	cpy	#3
	bcc	loopbb
	lda	#>(entry-1)
	pha
	lda	#<(entry-1)
	pha
	jsr	preread

	jmp	seekread

preread:

;copy post-read if necessary
;push post-read address here
;        pla
;        tax
;        pla
;        tay
;        lda     #>(postread-1)
;        pha
;        lda     #<(postread-1)
;        pha
;        tya
;        pha
;        txa
;        pha

	lda	#<(firsttrk*2)
	sta	phase+1
	ldx	#sectors
	lda	#address
	ldy	#firstsec
	rts



end_code:

.res	$8fe-*

; traditionally, entry point to jump to at end of loading
;	$be01 in this case
;*=$8fe
	.byte   $be, 1


.include "stage2.s"
