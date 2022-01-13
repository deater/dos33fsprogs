; the following lives on sectors $0E and $0D
; why?
; request sector 2 and 4, and the interleave is

; beneath apple dos (3-23)
; Physical (firmware) : 0  1   2  3   4  5   6  7   8  9  10 11 12 13 14  15
; DOS33 mapping       : 0, 7, 14, 6, 13, 5, 12, 4, 11, 3, 10, 2, 9, 1, 8, 15


; Beneath Apple DOS
; p86 (dos reference)
;

;WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

.org $900

code_begin:

	.byte	version

readnib:
slotpatch1:			; smc
	lda	$c0d1		; gets set to C08C (Q6L) read
	bpl	readnib
	rts

        ;fill address array for one track
seekread:
	sty	startsec+1
	sta	tmpadr+1
	stx	total+1

inittrk:
	sec
	lda	#$10
	sbc	startsec+1
	cmp	total+1
	bcs     it_skip

	tax

it_skip:
	stx	partial1
	stx	partial2
	jsr	seek

startsec:
	ldy	#$d1

tmpadr:
tmpadr_loop:
	lda	#$d1
	sta	addrtbl, y
	inc	tmpadr+1
	iny
	dec	partial1
	bne	tmpadr_loop

	;====================================
	; read a sector
	;====================================
	; first address field
	;====================================
	; starts with $D5 $AA $96
	; then XX YY volume
	; then XX YY track
	; then XX YY sector
	; then XX YY checksum
	; then ends with $DE $AA $EB
	;====================================
	; data field
	;====================================
	; starts with $D5 $AA $AD
	; 342 bytes of data
	; XX checksum
	; ends with $DE $AA $EB
read:

outer_read:
	jsr	readnib
inner_read:
	cmp	#$d5			; look for $D5 part of addr field
	bne	outer_read

	jsr	readnib			; look for $D5 $AA
	cmp	#$aa
	bne	inner_read

					; look for $D5 $AA $AD

	tay			; we need Y=#$AA later
	jsr	readnib
	eor	#$ad		; zero A if match
	beq	check_mode

        ; if not #$AD, then #$96 is assumed
	; so in address field

	ldy	#2		; volume, track, sector
another:
	jsr	readnib
	rol			; set carry
	sta	sector_smc+1
	jsr	readnib
	and	sector_smc+1
	dey
	bpl	another

	tay
	ldx	addrtbl, Y	; fetch corresponding address
	beq	read		; done?

	sta	sector_smc+1	; store index for later

	stx	adrpatch1+2
	stx	adrpatch8+2
	stx	adrpatch2+2
	stx	adrpatch3+2
	stx	adrpatch5+2
	stx	adrpatch7+2

	inx
	stx	adrpatch9+2
	dex

	dex
	stx	adrpatch4+2
	stx	adrpatch6+2

	ldy	#$fe

loop2:
adrpatch1:
	lda	$d102, Y
	pha
	iny
	bne	loop2

branch_read:
        bcs	read		; branch always

check_mode:
	cpx	#0
	beq	read		; loop if not expecting #$AD

loop33:
	sta	tmpval_smc+1	; zero rolling checksum
slotpatch2:
loop4:
	ldx	$c0d1
	bpl	loop4
	lda	preshift-$96, X
adrpatch2:
	sta	$d102, Y	; store 2-bit array

tmpval_smc:
	eor	#$d1
	iny
	bne	loop33
	ldy	#$aa
slotpatch3:
loop5:
	ldx	$c0d1
	bpl	loop5
	eor	preshift-$96, X
adrpatch3:
	ldx	$d102, Y	; bit2tbl
	eor	grouped+2, X	; first 86 nibbles use group bits 0-1
adrpatch4:
	sta	$d156, y
	iny
        bne	loop5
	and	#$fc
	ldy	#$aa
slotpatch4:
loop6:
	ldx	$c0d1
	bpl	loop6
	eor	preshift-$96, X
adrpatch5:
	ldx	$d102, Y	; bit2tbl
	eor	grouped+1, X	; second 86 nibbles use group bits 2-3
adrpatch6:
	sta	$d1ac, Y
	iny
	bne	loop6
	and	#$fc
	ldx	#$ac
slotpatch5:
loop7:
	ldy	$c0d1
	bpl	loop7
	eor	preshift-$96, Y
adrpatch7:
	ldy	$d100, X	; bit2tbl
	eor	grouped, Y	; last 84 nibbles use group bits 4-5
adrpatch8:
	sta	$d100, x
	inx
	bne	loop7
	and	#$fc
slotpatch6:
loop8:
	ldy	$c0d1
	bpl	loop8
	eor	preshift-$96, Y
	cmp	#1		; carry = !zero
	ldy	#1
loop9:
	pla
adrpatch9:
	sta	$d100, Y
	dey
	bpl	loop9
branch_read2:
	bcs	branch_read	; branch if checksum failure

sector_smc:
	ldy	#$d1
	txa
	sta	addrtbl, Y	; zero corresponding address
	dec	total+1
	dec	partial2	; adjust remaining count
				; (faster than looping over array)
	sec
	bne	branch_read2	; read all requested sectors in one track

	sta	startsec+1	; this was missing from original code
				; leading to trouble on wrap around
				; it not starting at sector0
total:
	ldx	#$d1
	beq	driveoff
	inc	phase_smc+1
	inc	phase_smc+1		; update current track
	jmp	inittrk

driveoff:
slotpatch7:
	lda	$c0d1

seekret:
	rts

	;=================================
	;=================================
	; seek, SEEK!
	;=================================
	;=================================
	; phase_smc+1 = track*2 to seek to
	; curtrk+1 = current track

seek:
	ldx	#0
	stx	step_smc+1

copy_cur:

curtrk_smc:
	lda	#0			; current track
	sta	tmpval_smc+1
	sec
phase_smc:
	sbc	#$d1			; track*2 to seek to
	beq	seekret			; if equal, we are already there

	; A is distance
	bcs	sback			; if positive, skip ahead

	eor	#$ff			; negate the distance
	inc	curtrk_smc+1		; move track counter up

        bcc     ssback			; bra

sback:
        adc     #$fe			; distance -=2
        dec     curtrk_smc+1		; move track counter down
ssback:
	cmp	step_smc+1		; compare to step
	bcc	loop10			; if less than, skip

step_smc:
	lda	#$d1			; load step value
loop10:
	cmp	#8
	bcs	loop11
	tay
	sec
loop11:
	lda	curtrk_smc+1
	ldx	step1, Y
	bne	loop12


loopmmm:
	clc
	lda	tmpval_smc+1
	ldx	step2, Y
loop12:
	stx	sector_smc+1
	and	#3
	rol
	tax
slotpatch8:
	sta	$c0d1, X		; PHASEOFF $c080 / $c0e0
loopmm:

	; delay 2+(19*5)+1 = 98 cycles = ~100us

	ldx	#$13			; 2
loopm:
	dex				; 2
	bne	loopm			; 2/3

	dec	sector_smc+1
	bne	loopmm

	lsr
	bcs	loopmmm

	inc	step_smc+1
	bne	copy_cur		; bra?

step1:		.byte $01, $30, $28, $24, $20, $1e, $1d, $1c
step2:		.byte $70, $2c, $26, $22, $1f, $1e, $1d, $1c
addrtbl:	.res 16

partial1:	.byte $00
partial2:	.byte $00
code_end:



;==========================
; enable drive motor
;==========================

driveon:

slotpatch9:
        lda     $c0d1		; turn drive on first

				; then you select drive

	; this could be more compact

	lda	CURRENT_DRIVE
	cmp	#2
	beq	driveon_disk2

driveon_disk1:

slotpatch10:
	lda     $C0d1		;       drive 1 select
	jmp	done_drive_select

driveon_disk2:

slotpatch11:
	lda     $C0d1		;       drive 2 select

done_drive_select:


        ; wait 1s

	; WAIT takes 1/2(26+27A+5A^2) us
	;	so for A=255 = (26+6885 +325125)*1/2 = 166018s *6 = ~1s

	; 6, 5, 4, 3, 2, 1
wait_1s:
        ldx     #6			; 2
wait_1s_loop:
        lda     #255			; 2
        jsr     wait			; 6
        dex				; 2
        bne     wait_1s_loop

	rts

load_new:

	jsr	driveon

	lda	load_track
	asl			; track to start*2
	sta     phase_smc+1

	lda	load_sector
	tay			; sector to start

	lda	load_length	; length
	tax

	lda     load_address		; address to load

	jsr	seekread

	rts

load_address:
	.byte $00
load_track:
	.byte $00
load_sector:
	.byte $00
load_length:
	.byte $00

.include "wait.s"
