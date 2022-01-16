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

	;===============================
	;===============================
	;===============================
	; seek then read
	;===============================
	;===============================
	;===============================
	; Y = starting sector
	; A = page to read into
	; X = number of sectors to read

        ;fill address array for one track
seekread:
	sty	startsec+1
	sta	tmpadr_smc+1
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

	;===========================================
	; fill in table of addresses we want to read
	; corresponding to sectors on the track
	; if they are 0, it means we don't need it

tmpadr_loop:

tmpadr_smc:
	lda	#$d1
	sta	addrtbl, y
	inc	tmpadr_smc+1
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

	ldx	#0	; if we don't set this, bad things can happen
			; if we start on a data field w/o setting
			; the sector first
outer_read:
	jsr	readnib
inner_read:
	cmp	#$d5			; look for $D5 part of addr field
	bne	outer_read

	jsr	readnib			; look for $D5 $AA
	cmp	#$aa
	bne	inner_read

					; look for $D5 $AA $AD

	tay				; we need Y=#$AA later
	jsr	readnib
	eor	#$ad			; zero A if match
	beq	check_mode		; WHY?

        ; if not #$AD, then #$96 is assumed
	; so in address field

	; following are volume, track, sector

	ldy	#2			; volume, track, sector
another:

	; these are stored in a weird 4+4 format and this is how
	; you decode them

	jsr	readnib
	rol
	sta	sector_smc+1
	jsr	readnib
	and	sector_smc+1		; now A has the value

	dey				; work through the values
	bpl	another

	tay				; A should be sector#?
					; Y is now sector # VMW
	ldx	addrtbl, Y		; fetch corresponding address
					; in table.

	beq	outer_read		; if address 0, not valid, try again

	sta	sector_smc+1		; store sector for later

	stx	adrpatch1+2		; store address to all of these
	stx	adrpatch8+2
	stx	adrpatch2+2
	stx	adrpatch3+2
	stx	adrpatch5+2
	stx	adrpatch7+2

	inx
	stx	adrpatch9+2		; store address+1 here
	dex

	dex
	stx	adrpatch4+2		; store address-1 here?
	stx	adrpatch6+2

	ldy	#$fe			; Y=-2

loop2:
adrpatch1:
	lda	$d102, Y
	pha
	iny
	bne	loop2

branch_read:
        bcs	outer_read	; branch always

check_mode:
	cpx	#0
	beq	outer_read	; loop if not expecting #$AD

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

	rts


	;=================================
	;=================================
	; seek, SEEK!
	;=================================
	;=================================
	; phase_smc+1 = track*2 to seek to
	; curtrk+1 = current track


	; due to problems when switching drive1/drive
	; we include here instead the larger but less fancy
	; seek from PRORWTS

	; "no tricks here, just the regular stuff" -- qkumba

step      = $CC         ;(internal) state for stepper motor
;tmptrk    = $CD         ;(internal) temporary copy of current track
;phase     = $CE         ;(internal) current phase for seek
;tmpsec	  = $3c

	; X = destination track
	; Y = 0

;cu;rtrk_smc:
;	lda	#0

seek:

;p;hase_smc:
;	lda	#0
;	sta	phase

curtrk_smc:
	lda	#0

	ldy	#0		; added
	sty	step
;	asl	phase

;	txa			; get destination in A
;	asl			; multiply to get half track
copy_cur:
	tax			; current track
	sta	tmpval_smc+1 ;tmptrk		; save current track for later

	; calculate direction to seek

	sec
phase_smc:
	sbc	#$d1		; track *2 to seek to?
	beq	done_seek	; if match, we're there

	; update direction

	bcs	seeking_out	; if positive, seeking out toward T34

seeking_in:
	eor	#$ff		; negate the result?
	inx			; move current track inward
	bcc	seek_dir_done

seeking_out:
	sbc	#1		; difference -1 (carry is set here)
	dex			; move current track outward

seek_dir_done:
	cmp	step		; compare to step
	bcc	skip_set_step	; if below minimum, don't change?

	lda	step		; load step value

skip_set_step:

	; set acceleration/momentum

	cmp	#8			; see if > 8
					; our momentum table is 8
					; (DOS3.3 it's 12)
					; Y maxes out if over 8

	bcs	skip_update_momentum
	tay				; acceleration offset in Y
	sec				; carry set is phase on
skip_update_momentum:

	txa				; current track in A
	pha				; save for later
	ldx	phase_on_time, Y	; load on time from table

done_seek:	; +++
	php				; save flags(?)
	bne	skip_p			; bra?
loop_mmm:
	clc				; set phase off
	lda	tmpval_smc+1 ;tmptrk			; restore saved track
	ldx	phase_off_time, Y	; get off time from table
skip_p:
	stx	sector_smc+1 ;tmpsec			; why
	and	#3			; mask to 1 of 3 phases
	rol				; multiply by 2, set low bit to carry
					; carry holds on/off
	tax
	lsr				; get low bit in carry for later
					; but must do before A destroyed
;unrseek=unrelocdsk+(*-reloc)

slotpatch8:
	lda	$C0D1, X

seek_delay:

	; delay 2+(19*5)-1 = 97 cycles, + 6+2 = 105 cycles = ~100us

seek_delay_outer:
	ldx	#$13			; 2
seek_delay_inner:
	dex				; 2
	bne	seek_delay_inner	; 2/3

	dec	sector_smc+1 ;tmpsec			; 6	holds on/off delay time
	bne	seek_delay_outer	; 2/3
seek_delay_end:

	; C is from the LSR previously? so phase bit

	bcs	loop_mmm		; if carry set, try again phase off
	plp				; restore?

	beq	seekret			; if zero we were done

	pla				; restore current track
	inc	step			; increment step count
	bne	copy_cur		; (bra) try again

seekret:
	; update current track
	ldx	phase_smc+1
	stx	curtrk_smc+1
	; the DOS3.3 RWTS waits 25ms after seeking for things to settle

	rts


;curtrk_smc:				; FIXME
;	lda	#0


.if 0
seek:
	ldx	#0			; reset acceleration count?
	stx	step_smc+1

copy_cur:

curtrk_smc:
	lda	#0			; current track
	sta	tmpval_smc+1		; save current track for later

	; calculate direction to seek

	sec
phase_smc:
	sbc	#$d1			; track*2 to seek to
	beq	seekret			; if equal, we are already there
					; so we are done

	; A is distance, update direction

	bcs	seeking_out		; if positive, seeking out to 34

seeking_in:
	eor	#$ff			; negate the result? (why?)
	inc	curtrk_smc+1		; move track counter inward
        bcc     ssback			; bra

seeking_out:
        adc     #$fe			; difference -=1 (carry always 1)
        dec     curtrk_smc+1		; move track counter outward

ssback:
	cmp	step_smc+1		; compare to step
	bcc	skip_set_step		; if below minimum, don't change?

	;================================
	; step the proper length of time
	; taking into account momentum?

step_smc:
	lda	#$d1			; load step value

skip_set_step:

	; set acceleration (???)

	cmp	#8			; see if >8
					; our on/off
					; tables only 8 bytes long
					; (dos33 they are 12?)

					; what is Y in that case?
					; apparently in maxes out

	bcs	skip11

	tay				; acceleration offset in Y

do_phase_on:
	sec				; carry set is phase on

skip11:
	lda	curtrk_smc+1		; current track in A
	ldx	phase_on_time, Y	; get phase on time in X
	bne	do_phase_common		; (bra?)

do_phase_off:
	clc				; carry set, phase off
	lda	tmpval_smc+1		; restore original track
	ldx	phase_off_time, Y	; get phase off time in X

do_phase_common:
	stx	sector_smc+1
					; A is the track?
	and	#3			; mask to 1 of 4 phases
	rol				; double to the 8 phase on/off
					; with carry the on/off
	tax
slotpatch8:
	sta	$c0d1, X		; flip the phase
					; C080...C087 seeks inward (toward 34)
					; C087...C080 seeks outward (to 0)


seek_delay:

seek_delay_outer:

	; inner delay
	; delay 2+(19*5)-1 = 97 cycles, + 6+2 = 105 cycles = ~100us

	ldx	#$13			; 2
seek_delay_inner:
	dex				; 2
	bne	seek_delay_inner	; 2/3


	dec	sector_smc+1		; 6	 holds the on/off delay time
	bne	seek_delay_outer	; 2/3

seek_delay_end:

	lsr				; bottom bit of A here
					; is the carry bit
					; from phase on/off

	bcs	do_phase_off		; repeat, this time off

	inc	step_smc+1		; increment step count
	bne	copy_cur		; bra(?) back to beginning

.endif

; phase on/off tables, in 100us multiples

phase_on_time:	.byte $01, $30, $28, $24, $20, $1e, $1d, $1c
phase_off_time:	.byte $70, $2c, $26, $22, $1f, $1e, $1d, $1c


addrtbl:	.res 16

partial1:	.byte $00
partial2:	.byte $00


;==========================
; enable drive motor
;==========================

driveon:

slotpatch9:
        lda     $c0d1		; turn drive on first
				; then you select drive


driveon_disk1:

slotpatch10:
	lda     $C0d1			;       drive 1 select
;	jmp	done_drive_select


	; this could be more compact

	lda	CURRENT_DRIVE
	cmp	#2
	bne	done_drive_select


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


code_end:

.assert (>seek_delay_end - >seek_delay) < 1 , error, "seek delay spans page"
