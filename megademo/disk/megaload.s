;fast bootable seek/read, slot 6 version
;copyright (c) Peter Ferrie 2011-2012

; Translated to ca64 by Vince Weaver

		chksum    = 0		;otherwise safer but 12 bytes larger
		secldr2   = $0e		;14th sector is fastest when loaded from bootsector but can be any of them
		seekback  = 0		;set to 1 to enable seek backwards

		adrlo     = $26		;constant from boot prom
		adrhi     = $27		;constant from boot prom
		slot      = $2b		;constant from boot prom
		tmpsec    = $3c		;constant from boot prom
		tmpadr    = $41
		partial2  = $f9		;copy of partial1
		partial1  = $fa		;sectors to read from one track
		total     = $fb		;total sectors to read
		step      = $fc		;state for stepper motor
		tmptrk    = $fd		;temporary copy of current track
		curtrk    = $fe		;current track (must initialise before calling seek)
		phase     = $ff		;current phase for seek
		addrtbl   = $50		;requires 16 bytes
		nibtbl    = $2d6	;constant from boot prom
		bit2tbl   = $200	;hard-coded (uses $2aa-$2ff)

		maxsec    = $10		;sectors per track, usually 10 but 0b for Olympic Decathlon, 0c for Karateka

		;this section is specific to bootsectors
		;load second stage sector to $900, enabling track seek
;		tax			;1 sector
;		lda #secldr2
;		ldy #9
;		jsr seekread
		jmp ldr2
		;

seekread:	stx total
		sta addrtbl
		sty tmpadr
calcpart:	sec
		lda #maxsec
		sbc addrtbl
		cmp total
		bcs L1
		tax
L1:		stx partial1
		stx partial2
callseek:	jsr seek - 1		;(seekret) disabled during boot, increment to enable
		ldy addrtbl
		ldx #$0f
		lda #0
L2:		sta addrtbl, x
		dex
		bpl L2
L3:		lda tmpadr
		ldx sectbl, y
		sta addrtbl, x
		inc tmpadr
		iny
		dec partial1
		bne L3

read:		ldx #0
read1:
L4:		jsr readnib
L5:		cmp #$d5
		bne L4
		jsr readnib
		cmp #$aa
		bne L5
		tay			;we need Y=#$AA later
		jsr readnib
		eor #$ad		;zero A if match
		beq check_mode

		;if not #$AD, then #$96 is assumed

		ldy #2			;high 8 bits of bit2tbl
		sty adrhi		;store 2-bits array at $2xx
L6:		jsr readnib
		rol			;set carry
		sta tmpsec
		jsr readnib
		and tmpsec
		dey
		bpl L6
.if chksum
		sta tmpsec
		tay
		ldx addrtbl, y
		stx step
.else
		tay
		lda addrtbl, y
		sta step
		stx addrtbl, y
		tax
.endif
		bcs read1
check_mode:	cpx #0			;set carry if non-zero
		beq read1
		.byte $90
L7:		clc
L8:		ldx $c0ec
		bpl L8
		eor nibtbl, x
		sta (adrlo), y		;$2xx initially, and then the real address
		iny
		bne L8
		ldx step
		stx adrhi		;set real address
		bcs L7			;carry is set on first pass, clear on second, loops one time
.if chksum
L9:		ldx $c0ec
		bpl L9
		eor nibtbl, x
		bne read
		ldx tmpsec
		sta addrtbl, x
.endif
L10:		ldx #$a9
L11:		inx
		beq L10
		lda (adrlo), y
		lsr bit2tbl, x
		rol
		lsr bit2tbl, x
		rol
		sta (adrlo), y
		iny
		bne L11
		dec total
		dec partial2
		bne read		;read all requested sectors in one track
		ldx total
		beq seekret
		inc phase
		inc phase		;update current track
		jmp calcpart

sectbl:		.byte 0, $0d, $0b, 9, 7, 5, 3, 1, $0e, $0c, $0a, 8, 6, 4, 2, $0f

readnib:
L12:		lda $c0ec
		bpl L12
seekret:	rts			;hard-coded relative to seek

seek:		lda #0
		sta step
copy_cur:	lda curtrk
		sta tmptrk
		sec
		sbc phase
		beq seekret
.if seekback
		bcs L13
.endif
		eor #$ff
		inc curtrk
.if seekback
		bcc L14
L13:		adc #$fe
		dec curtrk
L14:
.endif
		cmp step
		bcc L15
		lda step
L15:		cmp #8
		bcs L16
		tay
		sec
L16:		lda curtrk
		ldx step1, y
		bne L18
L17:		clc
		lda tmptrk
		ldx step2, y
L18:		stx tmpsec
		and  #3
		rol
		tax
		sta $c0e0, x
L19:		ldx #$13
L20:		dex
		bne L20
		dec tmpsec
		bne L19
		lsr
		bcs L17
		inc step
		bne copy_cur

step1:		.byte 1, $30, $28, $24, $20, $1e, $1d, $1c
step2:		.byte $70, $2c, $26, $22, $1f, $1e, $1d, $1c

		newtrk    = $36		;track*2 for main stage
		newnum    = $80		;number of sectors in main stage
		newsec    = 0		;first sector in main stage
		newadr    = $40		;load address for main stage
		newstart  = $4000	;start address for main stage

ldr2:		;jmp ldr2
		;replace with something like the following:

		inc callseek + 1

		lda #$50
    		sta curtrk
		    lda #0
	    sta phase
    		jsr seek

		ldy	#0

		sty curtrk
		lda #newtrk
		sta phase
		ldx #newnum
		lda #newsec
		ldy #newadr
		jsr seekread
;		jmp newstart

ldr3:		jmp ldr3
