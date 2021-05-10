	;=================================
	; Display a sequence of images
	;=================================
	; quit if escape pressed?

	; this version (as opposed to original) the time delay is
	;	*after* showing the image

	; pattern is TIME, PTR
	; if time==       0, then done
	; if time==1 or 129, then no pause
	; if time==     255, reload background $C00 with PTR, no delay
	; if time==  2..127, overlay PTR over $C00, then wait TIME
	; if time==130..254, overlay current over $C00, then wait TIME-128
	;		assumes LZSA pointer points to image
	;		basically after decoding one, input points to next


run_sequence:
	ldy	#0

run_sequence_loop:
	lda	(INTRO_LOOPL),Y		; get time
	beq	run_sequence_done	; if zero, then done

	cmp	#$ff			; if $ff, then load image to $c00
	bne	not_reload

	; reload background
reload_bg:
	iny
	lda	(INTRO_LOOPL),Y
	sta     getsrc_smc+1    ; LZSA_SRC_LO
	iny
	lda	(INTRO_LOOPL),Y
	sta     getsrc_smc+2    ; LZSA_SRC_HI
	iny
	sty	INTRO_LOOPER		; save for later
	lda	#$0c			; load to $c00
	jsr	decompress_lzsa2_fast
	jmp	seq_stuff

not_reload:
	tax				; load delay into X
	bmi	no_set_image_ptr	; if negative, no need to load pointer

	; need to get image pointer from data stream
get_image_ptr:
	iny
	lda	(INTRO_LOOPL),Y
	sta     getsrc_smc+1    ; LZSA_SRC_LO
	iny
	lda	(INTRO_LOOPL),Y
	sta     getsrc_smc+2    ; LZSA_SRC_HI

no_set_image_ptr:

	; decompress image

	txa
	pha				; save X on stack

	iny
	sty	INTRO_LOOPER		; save for later
	lda	#$10			; load to $1000
	jsr	decompress_lzsa2_fast

	; display image and page flip

	jsr	gr_overlay
	jsr	page_flip

	pla				; restore X from stack

	and	#$7f
	tax
	cpx	#1
	beq	seq_no_wait

	jsr	long_wait
seq_no_wait:

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
	sta     getsrc_smc+1    ; LZSA_SRC_LO

	iny
	lda	(INTRO_LOOPL),Y
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	iny
	sty	INTRO_LOOPER		; save for later
	lda	#$10			; load to $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay_40x40
	jsr	page_flip
	ldy	INTRO_LOOPER

	jmp	run_sequence_40x40_loop
run_sequence_40x40_done:
	rts


.if 0
	;=====================
	; WAIT: delay 1/2(26+27A+5A^2) us
	; A=60 approx  9.823ms
	; A=61 approx 10.139ms
	; A=62 approx 10.460ms
	; A=63 approx 10.786ms
	; A=64 approx 11.117ms
	;

	;=====================
	; long(er) wait
	; waits approximately X*10 ms
	; X=100 1s
	; X=4 = 40ms= 1/25s
long_wait:
	lda	#60
	jsr	WAIT			; delay
	dex
	bne	long_wait
	rts
.endif
