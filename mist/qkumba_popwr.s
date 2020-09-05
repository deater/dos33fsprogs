; popwr -- code provided by qkumba


frombuff=$d00		; sector data to write

; note these must be contiguous
encbuf=$e00		; nibble buffer must be page alined
bit2tbl=$f00

readnib = $1001


readd5aa:

try_again:
        jsr     readnib
try_for_d5:
        cmp     #$d5
        bne     try_again
        jsr     readnib
        cmp     #$aa
        bne     try_for_d5

        jsr     readnib
        rts


	;================================
	; set up the self-modifying code
	; to point to the proper slot
	;================================
	; slot number is in high nibble of A
popwr_init:
	lda	#$60

	and	#$70		; the slot number is in the top here
	sta	slotpatchw1+1	; self modify the code
	sta	slotpatchw2+1
	sta	slotpatchw3+1
	sta	slotpatchw4+1

	rts


	;================================
	; write a sector
	;================================

sector_write:

	; convert the input to nibbles

	ldy	#2			; why start at 2?
aa:
	ldx	#$aa
b1:
	dey
frombuff_smc:
	lda	frombuff, y
	lsr
	rol	bit2tbl-$aa, x
	lsr
	rol	bit2tbl-$aa, x
	sta	encbuf, y
	lda	bit2tbl-$aa, x
	and	#$3f
	sta	bit2tbl-$aa, x
        inx
        bne     b1
        tya
        bne     aa

	; look for the proper sector to write

cmpsecwr:
b2:
	jsr	readd5aa	; look for dd55aa marker
	cmp	#$96
	bne	b2

	ldy	#3		; try getting the sector number
b3:
	jsr	readnib
	rol
	sta	tmpsec
	jsr	readnib
	and	tmpsec		; and with prev nibble?
	dey
	bne	b3


requested_sector:
	cmp	#$d1

	bne	cmpsecwr	; retry if not what we want?

        ;skip tail #$DE #$AA #$EB some #$FFs ...

	ldy	#$24
b4:
	dey
	bpl     b4


	; c0e0	slot 6 ph0 off
	; c0e1	slot 6 ph0 on
	; c0e2	slot 6 ph1 off
	; c0e3	slot 6 ph1 on
	; c0e4	slot 6 ph2 off
	; c0e5	slot 6 ph2 on
	; c0e6	slot 6 ph3 off
	; c0e7	slot 6 ph3 on
	; c0e8	slot 6 motor off
	; c0e9	slot 6 motor on
	; c0ea	slot 6 drive 1
	; c0eb	slot 6 drive 2
	; c0ec	slot 6 q6 off \                   Q6  Q7
	; c0ed	slot 6 q6 on  |-- state machine    0  0   READ
	; c0ee	slot 6 q7 off |                    0  1   WRITE
	; c0ef	slot 6 q7 on  /                    1  0   SENSE WRITE PROTECT
	;                                          1  1   WRITE LOAD

        ; write sector data

slotpatchw1:
        ldx	#$d1		; cycle num smc        Q6  Q7
        lda	$c08d, x	; prime drive		1   X
        lda	$c08e, x	; required by Unidisk	1   0   ; senese wp?
        tya
        sta	$c08f, x	;                       1   1   ; write load
        ora	$c08c, x	;                       0   1   ; write

        ; 40 cycles

        ldy	#4						; 2 cycles
        cmp	$ea		; nop				; 3 cycles
        cmp	($ea,x)		; nop				; 6 cycles
b5:
	jsr	writenib1					; (29 cycles)

								; +6 cycles
        dey							; 2 cycles
        bne	b5						; 3/2nt

        ; 36 cycles
                                				; +10 cycles
	ldy	#(prolog_e-prolog)
								; 2 cycles
	cmp	$ea		; nop				; 3 cycles
b6:
	lda	prolog-1, y					; 4 cycles
	jsr	writenib3					; (17 cycles)

	; 32 cycles if branch taken
								; +6 cycles
	dey							; 2 cycles
	bne	b6						; 3/2nt

        ; 36 cycles on first pass
								; +10 cycles
	tya							; 2 cycles
	ldy	#$56						; 2 cycles
b7:
	eor	bit2tbl-1, y					; 5 cycles
	tax							; 2 cycles
	lda	xlattbl, x      				; 4 cycles
slotpatchw2:
        ldx	#$d1		; slot number smc		; 2 cycles
        sta	$c08d, x	; wp sense			; 5 cycles
        lda	$c08c, x	; read				; 4 cycles

	; 32 cycles if branch taken

        lda	bit2tbl-1, y					; 5 cycles
        dey							; 2 cycles
        bne     b7						; 3/2nt

        ; 32 cycles
								; +9 cycles
        clc							; 2 cycles
b88:
	eor	encbuf, y					; 4 cycles
b8:
	tax							; 2 cycles
        lda	xlattbl, x					; 4 cycles
slotpatchw3:
	ldx	#$d1		; slot number smc		; 2 cycles
	sta	$c08d, x	; wp sense			; 5 cycles
	lda	$c08c, x	; read				; 4 cycles
	bcs	f1						; 3/2nt

	; 32 cycles if branch taken

	lda	encbuf, y					; 4 cycles
	iny							; 2 cycles
	bne	b88						; 3/2nt

	; 32 cycles
								; +10 cycles
	sec							; 2 cycles
	bcs	b8						; 3 cycles

	; 32 cycles
								; +3 cycles
f1:
	ldy	#(epilog_e-epilog)
								; 2 cycles
        cmp	($ea,x)		; nop				; 6 cycles
b9:
	lda	epilog-1, y					; 4 cycles
	jsr	writenib3					; (17 cycles)

	; 32 cycles if branch taken
								; +6 cycles
        dey							; 2 cycles
        bne     b9						;3/2nt

        lda     $c08e, x	; read/wp
        lda     $c08c, x	; read
        lda     $c088, x	; motor off
	rts							; 6 cycles

writenib1:
	cmp     ($ea,x)		; nop				; 6 cycles
	cmp     ($ea,x)		; nop				; 6 cycles
writenib3:
slotpatchw4:
	ldx     #$d1		; slot number			; 2 cycles
writenib4:
	sta     $c08d, x	; wp sense?			; 5 cycles
	ora     $c08c, x	; read				; 4 cycles
	rts							; 6 cycles

prolog:	.byte $ad, $aa, $d5
prolog_e:
epilog:	.byte $ff, $eb, $aa, $de
epilog_e:

xlattbl:
.byte $96,$97,$9A,$9B,$9D,$9E,$9F,$A6
.byte $A7,$AB,$AC,$AD,$AE,$AF,$B2,$B3
.byte $B4,$B5,$B6,$B7,$B9,$BA,$BB,$BC
.byte $BD,$BE,$BF,$CB,$CD,$CE,$CF,$D3
.byte $D6,$D7,$D9,$DA,$DB,$DC,$DD,$DE
.byte $DF,$E5,$E6,$E7,$E9,$EA,$EB,$EC
.byte $ED,$EE,$EF,$F2,$F3,$F4,$F5,$F6
.byte $F7,$F9,$FA,$FB,$FC,$FD,$FE,$FF
