;
;

; Meanwhile...


; Deep beneath Monkey Island,
; the ghost pirate LeChuck's
; ship lies anchored in a river
; of lava.

; S: Captain LeChuck... sir... I... sir
; L: Ah...
; L: There's nothin' like the hot winds of hell blowin' in your face.
; S: No sir...
; S: Nothing like it...
; S: Ah... Sir... I...
; L: It's days like this that makes you glad to be dead.
; ...
; S: There seems to be a new pirate in town.
; ...
; L: I'll handle this personally.
lechuck_cutscene:

	;==========================
	; print meanwhile and wait
	;==========================

	jsr	clear_top
	jsr	clear_bottom

	lda	#<meanwhile_string
	sta	OUTL
	lda	#>meanwhile_string
	sta	OUTH
	jsr	move_and_print

	jsr	page_flip

	ldx	#30
	jsr	wait_a_bit


	;==========================
	; show ship and wait
	;==========================

	lda	#<lechuck_ship_lzsa
	sta	LZSA_SRC_LO
	lda	#>lechuck_ship_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	; copy over background
	jsr	gr_copy_to_current

	lda	#<lava_string
	sta	OUTL
	lda	#>lava_string
	sta	OUTH
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print
	jsr	move_and_print

	 ; flip page
	jsr	page_flip

	ldx	#$C0
	jsr	wait_a_bit


	;==========================
	; show cabin and wait
	;==========================

	lda	#<lechuck_cabin_lzsa
	sta	LZSA_SRC_LO
	lda	#>lechuck_cabin_lzsa
	sta	LZSA_SRC_HI
	lda	#$c			; load to page $c00
	jsr	decompress_lzsa2_fast

	ldy	#0
	sty	COUNT
cabin_loop:
	; copy over background
	jsr	gr_copy_to_current

	ldy	COUNT

	lda	cabin_strings,Y
	sta	OUTL
	lda	cabin_strings+1,Y
	sta	OUTH
	jsr	move_and_print

	 ; flip page
	jsr	page_flip

	ldy	COUNT
	ldx	cabin_speeds,Y
	jsr	wait_a_bit

	iny
	iny
	sty	COUNT
	cpy	#24
	bne	cabin_loop



	; update so we do this once
	lda	FIRST_TIME
	ora	#FIRST_TIME_LEAVE_BAR
	sta	FIRST_TIME

	rts


	;============================
	;============================
	; wait a bit
	;============================
	;============================
	; time to wait in X

wait_a_bit:

	lda	#0
	sta	FRAMEL
	sta	FRAMEH

wait_a_bit_loop:
	jsr	cutscene_inc_frame

	; if it's been x seconds then go to next part
	lda	#$80
	jsr	WAIT

	cpx	FRAMEL
	beq	done_wait_loop

	; early escape if keypressed
	lda	KEYPRESS
	bmi	done_wait_loop

	jmp	wait_a_bit_loop

done_wait_loop:
	bit	KEYRESET
	rts


cutscene_inc_frame:
	inc	FRAMEL
	bne	cutscene_frame_no_oflo
	inc	FRAMEH
cutscene_frame_no_oflo:
	rts


meanwhile_string:
	.byte	0,20,"MEANWHILE...",0

lava_string:
	.byte	7,20,"DEEP BENEATH MONKEY ISLAND,",0
	.byte	7,21,"THE GHOST PIRATE LECHUCK'S",0
	.byte	6,22,"SHIP LIES ANCHORED IN A RIVER",0
	.byte	16,23,"OF LAVA.",0

cabin_strings:
.word	cabin1
.word	cabin2
.word	cabin3
.word	cabin4
.word	cabin5
.word	cabin6
.word	cabin7
.word	cabin8
.word	cabin9
.word	cabin10
.word	cabin11
.word	cabin12

cabin_speeds:
.word	$50
.word	$50
.word	$50
.word	$50
.word	$50
.word	$50
.word	$50
.word	$50
.word	$50
.word	$50
.word	$50
.word	$50


;                      01234567890123456789012345678901234567890
cabin1:	.byte	12,21,"CAPTAIN LECHUCK... SIR...",0
cabin2:	.byte	 0,21,"AH...",0
cabin3:	.byte	 0,21,"THERE'S NOTHIN' LIKE THE HOT WINDS",0
cabin4:	.byte	 0,21,"OF HELL BLOWIN' IN YOUR FACE.",0
cabin5:	.byte	20,21,"NO SIR...",0
cabin6:	.byte	20,21,"NOTHING LIKE IT...",0
cabin7:	.byte	20,21,"AH... SIR... I...",0
cabin8:	.byte	 1,21,"THERE SEEMS TO BE A NEW PIRATE IN TOWN",0
cabin9:	.byte	 0,21,"WHAT?",0
cabin10:.byte	 0,21,"I'LL HANDLE THIS PERSONALLY.",0
cabin11:.byte	 0,21,"MY PLANS ARE TOO IMPORTANT",0
cabin12:.byte	 0,21,"TO BE MESSED UP BY AMATEURS.",0

