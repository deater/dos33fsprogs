; copy of ROM wait
; because we might disable ROM

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
