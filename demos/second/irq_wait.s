	;============================
	; wait for music pattern
	; also check for keypress
	;============================
	; pattern # in A
wait_for_pattern:
	cmp	current_pattern_smc+1
	bcc	done_check_pattern_done		; blt
	beq	done_check_pattern_done		; ble

	lda	KEYPRESS
	bpl	done_check_pattern_notdone
	bit	KEYRESET
	jmp	done_check_pattern_done

	;============================
	; setup timeout of A seconds
	;============================
setup_timeout:
	sta	SECOND_COUNTDOWN
	lda	#0
	sta	IRQ_COUNTDOWN
	rts

	;===========================
	; countodown second timeout
	; also check for keypress
	;===========================
	; carry set = done
check_timeout:
	; check keyboard first
	lda	KEYPRESS
	bpl	timeout_not_keypress
	bit	KEYRESET
;	lda	#0			; reset, is this necessary?
;	sta	IRQ_COUNTDOWN
;	sta	SECOND_COUNTDOWN
	jmp	done_check_timeout_done

timeout_not_keypress:
	lda	IRQ_COUNTDOWN
	bne	done_check_timeout_notdone
irq_countdown_zero:
	lda	SECOND_COUNTDOWN
	beq	done_check_timeout_done

	; otherwise we need to decrement and update
	dec	SECOND_COUNTDOWN
	lda	#50
	sta	IRQ_COUNTDOWN

done_check_pattern_notdone:
done_check_timeout_notdone:
	clc
	rts

done_check_pattern_done:
done_check_timeout_done:
	sec
	rts


	;==========================
	; busy wait A * 1 50Hz tick
	;==========================
wait_ticks:
        sta     IRQ_COUNTDOWN
wait_tick_loop:
	lda	IRQ_COUNTDOWN
	bne	wait_tick_loop
wait_tick_done:
	rts


	;====================
	; busy wait A seconds
	;====================
	; exit early if key pressed

wait_seconds:
	tax

wait_seconds_loop:
	lda	#50		; wait 1s
	jsr	wait_ticks

	lda	KEYPRESS
	bmi	wait_seconds_done

	dex
	bpl	wait_seconds_loop
wait_seconds_done:
	bit	KEYRESET
	rts
