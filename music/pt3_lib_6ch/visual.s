
visualization:

	ldx	#0
vis_loop_outer:
	lda	gr_offsets_l,X
	sta	GBASL
	lda	gr_offsets_h,X
	sta	GBASH

	lda	$70,X
	ldy	#19
vis_loop_inner:
	sta	(GBASL),Y
	dey
	bne	vis_loop_inner

	inx
	cpx	#14
	bne	vis_loop_outer

	ldx	#0
vis_loop_outer2:
	lda	gr_offsets_l,X
	sta	GBASL
	lda	gr_offsets_h,X
	sta	GBASH

	lda	$80,X
	ldy	#39
vis_loop_inner2:
	sta	(GBASL),Y
	dey
	cpy	#20
	bne	vis_loop_inner2

	inx
	cpx	#14
	bne	vis_loop_outer2

	lda	#200
	jsr	wait

	rts


gr_offsets_l:
	.byte	<$400,<$480,<$500,<$580,<$600,<$680,<$700,<$780
	.byte	<$428,<$4a8,<$528,<$5a8,<$628,<$6a8,<$728,<$7a8
	.byte	<$450,<$4d0,<$550,<$5d0,<$650,<$6d0,<$750,<$7d0

gr_offsets_h:
	.byte	>$400,>$480,>$500,>$580,>$600,>$680,>$700,>$780
	.byte	>$428,>$4a8,>$528,>$5a8,>$628,>$6a8,>$728,>$7a8
	.byte	>$450,>$4d0,>$550,>$5d0,>$650,>$6d0,>$750,>$7d0

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
wait_end:

.assert (>wait_end - >wait) < 1 , error, "wait crosses page boundary"
