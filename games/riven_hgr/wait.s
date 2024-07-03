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

.assert (>wait_end - >wait) < 1 , error, "wait crosses page boundary"
