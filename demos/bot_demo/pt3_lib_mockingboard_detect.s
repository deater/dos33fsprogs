;===================================================================
; code to detect mockingboard
;===================================================================
; this isn't always easy
; my inclination is to just assume slot #4 but that isn't always realistic

; code below based on "hw.mockingboard.a" from "Total Replay"

;license:MIT
; By Andrew Roughan
;   in the style of 4am for Total Replay
;
; Mockingboard support functions
;

;------------------------------------------------------------------------------
; HasMockingboard
; detect Mockingboard card by searching for 6522 timers across all slots
; access 6522 timers with deterministic cycle counts
;
;   based on prior art in Mockingboard Developers Toolkit
;   with optimisation from deater/french touch
;   also takes into account FastChip //e clock difference
;
; in:    none
;        accelerators should be off
; out:   C set if Mockingboard found in any slot
;        if card was found, X = #$Cn where n is the slot number of the card
;        C clear if no Mockingboard found
;        other flags clobbered
;        zp $65-$67 clobbered
;        A/Y clobbered
;------------------------------------------------------------------------------

mockingboard_detect:
	lda	#$00
	sta	MB_ADDR_L
	ldx	#$C7			; start at slot #7
mb_slot_loop:
	stx	MB_ADDR_H
	ldy	#$04			; 6522 #1 $Cx04
	jsr	mb_timer_check
	bne	mb_next_slot
	ldy	#$84			; 6522 #2 $Cx84
	jsr	mb_timer_check
	bne	mb_next_slot
mb_found:
	sec				; found
	rts

mb_next_slot:
	dex
	cpx	#$C0
	bne	mb_slot_loop

	clc				; not found
	rts

mb_timer_check:
	lda	(MB_ADDR_L),Y		; read 6522 timer low byte
	sta	MB_VALUE
	lda	(MB_ADDR_L),Y		; second time
	sec
	sbc	MB_VALUE
	cmp	#$F8			; looking for (-)8 cycles between reads
	beq	mb_timer_check_done
	cmp	#$F7			; FastChip //e clock is different
mb_timer_check_done:
	rts



;===================================================================
; code to patch mockingboard if not in slot#4
;===================================================================
; this is the brute force version, we have to patch 39 locations
; see further below if you want to try a smaller, more dangerous, patch

.if 0
mockingboard_patch:

	lda	MB_ADDR_H

	sta	pt3_irq_smc1+2		; 1

	sta	pt3_irq_smc2+2		; 2
	sta	pt3_irq_smc2+5		; 3

	sta	pt3_irq_smc3+2		; 4
	sta	pt3_irq_smc3+5		; 5

	sta	pt3_irq_smc4+2		; 6
	sta	pt3_irq_smc4+5		; 7

	sta	pt3_irq_smc5+2		; 8
	sta	pt3_irq_smc5+5		; 9

	sta	pt3_irq_smc6+2		; 10
	sta	pt3_irq_smc6+5		; 11

	sta	pt3_irq_smc7+2		; 12
	sta	pt3_irq_smc7+5		; 13

	sta	mock_init_smc1+2	; 14
	sta	mock_init_smc1+5	; 15

	sta	mock_init_smc2+2	; 16
	sta	mock_init_smc2+5	; 17

	sta	reset_ay_smc1+2		; 18
	sta	reset_ay_smc2+2		; 19
	sta	reset_ay_smc3+2		; 20
	sta	reset_ay_smc4+2		; 21

	sta	write_ay_smc1+2		; 22
	sta	write_ay_smc1+5		; 23

	sta	write_ay_smc2+2		; 24
	sta	write_ay_smc2+5		; 25

	sta	write_ay_smc3+2		; 26
	sta	write_ay_smc3+5		; 27

	sta	write_ay_smc4+2		; 28
	sta	write_ay_smc4+5		; 29

	sta	write_ay_smc5+2		; 30
	sta	write_ay_smc5+5		; 31

	sta	write_ay_smc6+2		; 32
	sta	write_ay_smc6+5		; 33

	sta	setup_irq_smc1+2	; 34
	sta	setup_irq_smc2+2	; 35
	sta	setup_irq_smc3+2	; 36
	sta	setup_irq_smc4+2	; 37
	sta	setup_irq_smc5+2	; 38
	sta	setup_irq_smc6+2	; 39

	rts
.endif

;===================================================================
; dangerous code to patch mockingboard if not in slot#4
;===================================================================
; this code patches any $C4 value to the proper slot# if not slot4
; this can be dangerous, it might over-write other important values
;	that should be $C4

; safer ways to do this:
;	only do this if 2 bytes after a LDA/STA/LDX/STX
;	count total and if not 39 then print error message

mockingboard_patch:
	; from mockingboard_init 	$1BBF
	;   to done_pt3_irq_handler	$1D85

	ldx	MB_ADDR_H
	ldy	#0

	lda	#<mockingboard_init
	sta	MB_ADDR_L
	lda	#>mockingboard_init
	sta	MB_ADDR_H

mb_patch_loop:
	lda	(MB_ADDR_L),Y
	cmp	#$C4
	bne	mb_patch_nomatch

	txa
	sta	(MB_ADDR_L),Y
mb_patch_nomatch:

	inc	MB_ADDR_L
	lda	MB_ADDR_L
	bne	mb_patch_oflo
	inc	MB_ADDR_H

mb_patch_oflo:
	lda	MB_ADDR_H
	cmp	#>done_pt3_irq_handler
	bne	mb_patch_loop
	lda	MB_ADDR_L
	cmp	#<done_pt3_irq_handler
	bne	mb_patch_loop

mb_patch_done:
	rts

.if 0


	;=======================================
	; Detect a Mockingboard card
	;=======================================
	; Based on code from the French Touch "Pure Noise" Demo
	; Attempts to time an instruction sequence with a 6522
	;
	; If found, puts in  bMB
	; MB_ADDRL:MB_ADDRH has address of Mockingboard
	; returns X=0 if not found, X=1 if found

mockingboard_detect:
	lda	#0
	sta	MB_ADDRL

mb_detect_loop:	; self-modifying
	lda	#$07	; we start in slot 7 ($C7) and go down to 0 ($C0)
	ora	#$C0	; make it start with C
	sta	MB_ADDRH
	ldy	#04	; $CX04
	ldx	#02	; 2 tries?
mb_check_cycle_loop:
	lda	(MB_ADDRL),Y		; timer 6522 (Low Order Counter)
					; count down
	sta	PT3_TEMP		; 3 cycles
	lda	(MB_ADDRL),Y		; + 5 cycles = 8 cycles
					; between the two accesses to the timer
	sec
	sbc	PT3_TEMP		; subtract to see if we had 8 cycles
	cmp	#$f8			; -8
	bne	mb_not_in_this_slot
	dex				; decrement, try one more time
	bne	mb_check_cycle_loop	; loop detection
	inx				; Mockingboard found (X=1)
done_mb_detect:
	;stx	bMB			; store result to bMB
	rts				; return

mb_not_in_this_slot:
	dec	mb_detect_loop+1	; decrement the "slot" (self_modify)
	bne	mb_detect_loop		; loop down to one
	ldx	#00
	beq	done_mb_detect

;alternative MB detection from Nox Archaist
;	lda	#$04
;	sta	MB_ADDRL
;	ldx	#$c7
;
;find_mb:
;	stx	MB_ADDRH
;
;	;detect sound I
;
;	sec
;	ldy	#$00
;	lda	(MB_ADDRL), y
;	sbc	(MB_ADDRL), y
;	cmp	#$05
;	beq	found_mb
;	dex
;	cpx	#$c0
;	bne	find_mb
;	ldx	#$00 ;no mockingboard found
;	rts
;
;found_mb:
;	ldx	#$01 ;mockingboard found
;	rts
;
;	;optionally detect sound II
;
;	sec
;	ldy	#$80
;	lda	(MB_ADDRL), y
;	sbc	(MB_ADDRL), y
;	cmp	#$05
;	beq	found_mb


	;=======================================
	; Detect a Mockingboard card in Slot4
	;=======================================
	; Based on code from the French Touch "Pure Noise" Demo
	; Attempts to time an instruction sequence with a 6522
	;
	; MB_ADDRL:MB_ADDRH has address of Mockingboard
	; returns X=0 if not found, X=1 if found

mockingboard_detect_slot4:
	lda	#0
	sta	MB_ADDRL

mb4_detect_loop:	; self-modifying
	lda	#$04	; we're only looking in Slot 4
	ora	#$C0	; make it start with C
	sta	MB_ADDRH
	ldy	#04	; $CX04
	ldx	#02	; 2 tries?
mb4_check_cycle_loop:
	lda	(MB_ADDRL),Y		; timer 6522 (Low Order Counter)
					; count down
	sta	PT3_TEMP		; 3 cycles
	lda	(MB_ADDRL),Y		; + 5 cycles = 8 cycles
					; between the two accesses to the timer
	sec
	sbc	PT3_TEMP		; subtract to see if we had 8 cycles
	cmp	#$f8			; -8
	bne	mb4_not_in_this_slot
	dex				; decrement, try one more time
	bne	mb4_check_cycle_loop	; loop detection
	inx				; Mockingboard found (X=1)
done_mb4_detect:
	rts				; return

mb4_not_in_this_slot:
	ldx	#00
	beq	done_mb4_detect



.endif
