
CURLIN = $75
ERRFLG = $D8
TXTPTR = $B8
CHRGET = $00B1

RESTART	=	$D43C
INLIN2	=	$D52E
PARSE_INPUT_LINE = $d559
TRACE_	= $D805

load_file:

	;=================
	; run list command
do_list:
	lda	#<list_string
	sta	cti_smc+1
	lda	#>list_string
	sta	cti_smc+2
	jsr	copy_to_input

	jmp	run_command

	;=================
	; run run command
	; a do-run-run, a do-run-run
do_run:
	lda	#<run_string
	sta	cti_smc
	lda	#>run_string
	sta	cti_smc+1
	jsr	copy_to_input

	jmp	run_command


	;=====================
	; copy_to_input
	;	copies NUL terminator too

copy_to_input:
	ldx	#0
cti_loop:
cti_smc:
	lda	$1234,X
	sta	$200,X
	beq	done_copy
	inx
	bne	cti_loop
done_copy:
	rts


list_string:
	.byte "LIST",0
run_string:
	.byte "RUN",0

run_command:
	; calls MON_GETLN
	; length in X
	; nul terminates
	; turns off sign bits
	;(Y,X) points at buffer - 1   (so $1FF?)


;	jsr	INLIN2
;	stx     TXTPTR		; set up CHRGET to scan the line
;	sty	TXTPTR+1
;	lsr     ERRFLG          ;clear flag
;	jsr     CHRGET
;	tax
;	beq     RESTART         ;empty line
;d450: a2 ff                    ldx     #$ff            ;$ff in hi-byte of CURLIN means
;d452: 86 76                    stx     CURLIN+1        ;  we are in direct mode
;d454: 90 06                    bcc     NUMBERED_LINE   ;CHRGET saw digit, numbered line
;d456: 20 59 d5                 jsr     PARSE_INPUT_LINE ;no number, so parse it
;d459: 4c 05 d8                 jmp     TRACE_          ;and try executing it


	ldx	#$ff
	stx	TXTPTR
	ldy	#$1
	sty	TXTPTR+1
	jsr	CHRGET

	ldx	#$ff
	stx	CURLIN+1
	jsr	PARSE_INPUT_LINE
	jmp	TRACE_

