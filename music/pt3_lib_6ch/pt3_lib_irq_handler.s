

pt3_irq_handler:

pt3_irq_smc1:
	bit	MOCK_6522_T1CL	; clear 6522 interrupt by reading T1C-L	; 4

	lda	DONE_PLAYING						; 3
	beq	pt3_play_music_2	; if song done, don't play music; 3/2nt
	jmp	done_pt3_irq_handler					; 3
								;============

	;==================================
	; play song2

pt3_play_music_2:

	; decode a frame of music

	jsr	pt3_make_frame_2

	; handle song over condition
	lda	DONE_SONG_2
	beq	pt3_play_music		; if not done, continue to other song

	lda	LOOP_2			; see if looping, if so continue(?)
	beq	pt3_play_music

pt3_loop_smc_2:
	lda	#$d1			; looping, move to loop location
					; non-zero to avoid the temptation
					; to merge with following lda #$0
	sta	current_pattern_smc_2+1
	lda	#$0
	sta	current_line_smc_2+1
	sta	current_subframe_smc_2+1
	sta	DONE_SONG_2		; undo the done song

;	beq	done_pt3_irq_handler_2	; branch always
	beq	pt3_play_music_2	; branch always


pt3_play_music:

	jsr	pt3_make_frame

	; handle song over condition
	lda	DONE_SONG
	beq	mb_write_frame		; if not done, continue

	lda	LOOP			; see if looping
	beq	move_to_next

pt3_loop_smc:
	lda	#$d1			; looping, move to loop location
					; non-zero to avoid the temptation
					; to merge with following lda #$0
	sta	current_pattern_smc+1
	lda	#$0
	sta	current_line_smc+1
	sta	current_subframe_smc+1
	sta	DONE_SONG		; undo the next song

;	beq	done_pt3_irq_handler	; branch always
	beq	pt3_play_music		; branch always


move_to_next:
	; same as "press right"
	ldx	#$20
	jmp	quiet_exit

	;======================================
	; Write frames to Mockingboard
	;======================================
	; for speed could merge this into
	; the decode code
mb_write_frame:





	tax			; set up reg count			; 2
								;============
								;	  2

	;==================================
	; loop through the 14 registers
	; reading the value, then write out
	;==================================

mb_write_loop:
	lda	AY_REGISTERS,X	; load register value			; 4

	; special case R13.  If it is 0xff, then don't update
	; otherwise might spuriously reset the envelope settings

	cpx	#13							; 2
	bne	mb_not_13						; 3/2nt
	cmp	#$ff							; 2
	beq	mb_skip_13						; 3/2nt
								;============
								; typ 5
mb_not_13:


	; address
pt3_irq_smc2:
	stx	MOCK_6522_ORA1		; put address on PA1		; 4
	ldy	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
pt3_irq_smc3:
	sty	MOCK_6522_ORB1		; latch_address on PB1          ; 4
	ldy	#MOCK_AY_INACTIVE	; go inactive			; 2
pt3_irq_smc4:
	sty	MOCK_6522_ORB1						; 4

        ; value
pt3_irq_smc5:
	sta	MOCK_6522_ORA1		; put value on PA1		; 4
	lda	#MOCK_AY_WRITE		;				; 2
pt3_irq_smc6:
	sta	MOCK_6522_ORB1		; write on PB1			; 4
	sty	MOCK_6522_ORB1						; 4

mb_no_write:
	inx				; point to next register	; 2
	cpx	#14			; if 14 we're done		; 2
	bmi	mb_write_loop		; otherwise, loop		; 3/2nt
								;============
								; 	7
mb_skip_13:

	;==================================
	; do 6522 #2
	;==================================

mb_write_frame_2:


	ldx	#0


mb_write_loop_2:
	lda	AY_REGISTERS_2,X	; load register value			; 4

	; special case R13.  If it is 0xff, then don't update
	; otherwise might spuriously reset the envelope settings

	cpx	#13							; 2
	bne	mb_not_13_2						; 3/2nt
	cmp	#$ff							; 2
	beq	mb_skip_13_2						; 3/2nt
								;============
								; typ 5
mb_not_13_2:


	; address
pt3_irq_smc2_2:
	stx	MOCK_6522_ORA2		; put address on PA2		; 4
	ldy	#MOCK_AY_LATCH_ADDR	; latch_address for PB1		; 2
pt3_irq_smc3_2:
	sty	MOCK_6522_ORB2		; latch_address on PB2		; 4
	ldy	#MOCK_AY_INACTIVE	; go inactive			; 2
pt3_irq_smc4_2:
	sty	MOCK_6522_ORB2						; 4

        ; value
pt3_irq_smc5_2:
	sta	MOCK_6522_ORA2		; put value on PA2		; 4
	lda	#MOCK_AY_WRITE		;				; 2
pt3_irq_smc7:
	sta	MOCK_6522_ORB2		; write on PB2			; 4
	sty	MOCK_6522_ORB2						; 4

mb_no_write_2:
	inx				; point to next register	; 2
	cpx	#14			; if 14 we're done		; 2
	bmi	mb_write_loop_2		; otherwise, loop		; 3/2nt
								;============
								; 	7
mb_skip_13_2:



	;=================================
	; Finally done with this interrupt
	;=================================

done_pt3_irq_handler:
