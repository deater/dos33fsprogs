; copy of ROM wait
; because we might disable ROM

; waits 0.5 * (26 + 27A + 5A^2) useconds

wait:
	sec
wait2:
	pha
wait3:
	sbc	#$01
	bne	wait3
	pla
	sbc	#$01
	bne	wait2
	rts
wait_end:


	; to wait 50ms its approximately 139?

wait_50ms:
	ldx	#1
wait_50xms:

wait_50_loop:
	lda	#139
	jsr	wait
	dex
	bne	wait_50_loop

	rts


.assert (>wait_end - >wait) < 1 , error, "wait crosses page boundary"
