


	;=================================
	; Display a sequence of images
	;=================================
	; quit if escape pressed?

	; pattern is TIME, PTR
	; if time==0, then done
	; if time==255, reload $C00 with PTR
	; if time==0..127 wait TIME, then overlay PTR over $C00
	; if time==128..254, wait TIME-128, then overlay GBASL over $C00

run_sequence:
	ldy	#0

run_sequence_loop:
	lda	(INTRO_LOOPL),Y		; get time
	beq	run_sequence_done	; if zero, then done

	cmp	#$ff			; if $ff, then load image to $c00
	bne	not_reload

reload_image:
	iny
	lda	(INTRO_LOOPL),Y
	sta	GBASL
	iny
	lda	(INTRO_LOOPL),Y
	sta	GBASH
	iny
	sty	INTRO_LOOPER		; save for later
	lda	#$0c			; load to $c00
	jsr	load_rle_gr
	jmp	seq_stuff

not_reload:
	tax
	cmp	#$80			;if negative, no need to load pointer
	bcs	no_set_image_ptr	; bge (branch if greater equal)


get_image_ptr:
	iny
	lda	(INTRO_LOOPL),Y
	sta	GBASL
	iny
	lda	(INTRO_LOOPL),Y
	sta	GBASH

no_set_image_ptr:
	txa
	and	#$7f
	tax
	cpx	#1
	beq	seq_no_wait

	jsr	long_wait
seq_no_wait:

	iny
	sty	INTRO_LOOPER		; save for later
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay
	jsr	page_flip
seq_stuff:
	ldy	INTRO_LOOPER

	; exit early if escape pressed

	lda	KEYPRESS
	cmp	#27+$80
	beq	run_sequence_done
	bit	KEYRESET

	jmp	run_sequence_loop
run_sequence_done:
	rts


	;====================================
	; Display a sequence of images 40x40

run_sequence_40x40:
	ldy	#0

run_sequence_40x40_loop:
	lda	(INTRO_LOOPL),Y		; get time
	beq	run_sequence_40x40_done
	tax

	jsr	long_wait

	iny

	lda	(INTRO_LOOPL),Y
	sta	GBASL
	iny
	lda	(INTRO_LOOPL),Y
	sta	GBASH
	iny
	sty	INTRO_LOOPER		; save for later
	lda	#$10			; load to $1000
	jsr	load_rle_gr

	jsr	gr_overlay_40x40
	jsr	page_flip
	ldy	INTRO_LOOPER

	jmp	run_sequence_40x40_loop
run_sequence_40x40_done:
	rts




	;=====================
	; long(er) wait
	; waits approximately ?? ms

long_wait:
	lda	#64
	jsr	WAIT			; delay
	dex
	bne	long_wait
	rts
