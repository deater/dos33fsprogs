
CURLIN = $75
ERRFLG = $D8
TXTPTR = $B8
CHRGET = $00B1

RESTART	=	$D43C
INLIN2	=	$D52E
PARSE_INPUT_LINE = $d559
TRACE_	= $D805

load_file:


do_list:
	lda	#'L'
	sta	$200
	lda	#'I'
	sta	$201
	lda	#'S'
	sta	$202
	lda	#'T'
	sta	$203
	lda	#0
	sta	$204
	jmp	run_command


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

