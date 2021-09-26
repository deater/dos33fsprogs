
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

	; 16-bit increment

	inc	MB_ADDR_L
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

