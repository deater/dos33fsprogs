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
;        A/Y clobbered
;------------------------------------------------------------------------------

mockingboard_detect:

	; activate Mockingboard IIc
	; + the Mockingboard has to take over Slot#4 (IIc has no slots)
	;   in theory any write to the firmware area in $C400 will
	;   activate it, but that might not be fast enough when detecting
	;   so writing $FF to $C403/$C404 is official way to enable
	; + Note this disables permanently the mouse firmware in $C400
	;   so "normal" interrupts are broken :(  The hack to fix things
	;   is to switch in RAM for $F000 and just replace the IRQ
	;   vectors at $FFFE/$FFFF instead of $3FE/$3FF but that makes
	;   it difficult if you actually wanted to use any
	;   Applesoft/Monitor ROM routines

;.ifdef PT3_ENABLE_APPLE_IIC
	lda	APPLEII_MODEL
	cmp	#'C'
	bne	not_iic

	lda	#$ff

	; don't bother patching these, IIc mockingboard always slot 4

        sta	MOCK_6522_DDRA1		; $C403
	sta	MOCK_6522_T1CL		; $C404
;.endif

not_iic:
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
