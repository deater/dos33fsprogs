; write track0 sector 10

WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

test_write:

	lda	#$ec
	sta	slotpatch1+1

	jsr	popwr_init

	

; fill in $d00 with pattern

	ldx	#0
loop:
	txa
	sta	$d00,X
	inx
	bne	loop

	; turn on motor
	jsr	turn_on_motor

	; seek to track 0

	lda	#0
	asl
	sta	phase+1

	jsr	seek

	; write to sector 0

	lda	#10
	sta	requested_sector+1

	jsr	sector_write




forever:
	jmp	forever


seekret:
	rts

seek:
.if 0
        ldx     #0
        stx     step+1
copy_cur:
curtrk:
        lda     #0
        sta     tmpval+1
        sec
.endif
phase:
        sbc     #$d1
        beq     seekret
.if 0
        ; if seek backwards
        bcs     sback

        eor     #$ff
        inc     curtrk+1

        bcc     ssback
sback:
        adc     #$fe
        dec     curtrk+1
ssback:
        cmp     step+1
        bcc     loop10
step:
        lda     #$d1
loop10:
        cmp     #8
        bcs     loop11
        tay
        sec
loop11:
        lda     curtrk+1
        ldx     step1, Y
        bne     loop12
loopmmm:
        clc
        lda     tmpval+1
        ldx     step2, Y
loop12:
        stx     sector+1
        and     #3
        rol
        tax
slotpatch8:
        sta     $c0d1, X
loopmm:
        ldx     #$13
loopm:
        dex
        bne     loopm
        dec     sector+1
        bne     loopmm
        lsr
        bcs     loopmmm
        inc     step+1
        bne     copy_cur

step1:          .byte 1, $30, $28, $24, $20, $1e, $1d, $1c
step2:          .byte $70, $2c, $26, $22, $1f, $1e, $1d, $1c
.endif
	rts






readd5aa:
L16:
        jsr     readnib
L17:
        cmp     #$d5
        bne     L16
        jsr     readnib
        cmp     #$aa
        bne     L17
        tay             ; we need Y=#$AA later
readnib:
slotpatch1:                     ; smc
	lda	$c0d1           ; gets set to C08C (Q6L) read
	bpl	readnib
	rts


;====================
; enable drive motor
;====================
turn_on_motor:
slotpatch9:
        lda     $c0e9           ; fixme, patch

        ; wait 1s

        ldx     #6
wait_1s:
        lda     #255
        jsr     WAIT
        dex
        bne     wait_1s

	rts

.include "qkumba_popwr.s"
