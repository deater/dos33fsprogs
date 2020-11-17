TXTTAB = $67
PRGEND = $AF
VARTAB = $69
CURLIN = $75
ERRFLG = $D8
TXTPTR = $B8
CHRGET = $00B1

SCRTCH	=	$D64B
RESTART	=	$D43C
FIX_LINKS =	$D4F2
INLIN2	=	$D52E
PARSE_INPUT_LINE = $d559
TRACE_	= $D805

load_file:

	;=================
	;=================
	; run list command
	;=================
	;=================

do_list:
	; try to get things back to normal

	bit	SET_TEXT
	bit	LORES
	bit	PAGE0
	bit	TEXTGR
	lda	#0
	sta	$C00C	; disable 80 column display
	sta	$C000	; disable 80 column memory mapping
	sta	$C05F	; clear annunicator 3 (double hires)
	jsr	SETNORM
	jsr	TEXT
	jsr	HOME

	lda	#<list_string
	sta	cti_smc+1
	lda	#>list_string
	sta	cti_smc+2
	jsr	copy_to_input

	jsr	display_title

	jmp	run_command

	; want to list from 0 to ffff

;LINNUM = $50
;	lda	#$00
;	sta	LINNUM
;	sta	LINNUM+1
;
;	jsr	$D61A	; FINDLIN, gets line in LOWTR
;
;	lda	#$ff
;	sta	LINNUM
;	sta	LINNUM+1
;
;	jsr	$d6da	; LIST_0
;	jsr	$d6cc	; LIST_0
;
;	rts


	;=================
	;=================
	; display title
	;=================
	;=================

display_title:

	lda	#' '
	ldx	#39
top_loop:
	sta	$6d0,X
	dex
	bpl	top_loop

	lda	which_file
	sec
	sbc	#1		; blurgh hack
	asl
	tay
	lda	title_list,Y
	sta	middle_smc+1
	lda	title_list+1,Y
	sta	middle_smc+2

	ldx	#0
middle_loop:
middle_smc:
	lda	$dede,X
	eor	#$80
	sta	$750,X

	inx
	cpx	#40
	bne	middle_loop

	lda	#' '
	ldx	#39
bottom_loop:
	sta	$7d0,X
	dex
	bpl	bottom_loop

	rts


	;=============================
	;=============================
	; run run command
	; a do-run-run, a do-run-run
	;=============================
	;=============================
do_run:
	jsr	HOME

	lda	#<run_string
	sta	cti_smc+1
	lda	#>run_string
	sta	cti_smc+2
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


	;============================
	;============================
	; do_load
	;============================
	;============================

do_load:

	jsr	SCRTCH			; runs "NEW"
					; messes with stack :(

	lda	which_file
	asl
	asl
	tax

	lda	file_list,X
	sta	get_size_smc1+1
	lda	file_list+1,X
	sta	get_size_smc1+2

	clc
	lda	file_list,X
	adc	#1
	sta	get_size_smc2+1
	lda	file_list+1,X
	adc	#0
	sta	get_size_smc2+2

	clc
	lda	file_list,X
	adc	#2
	sta	do_load_smc1+1
	lda	file_list+1,X
	adc	#0
	sta	do_load_smc1+2

	lda	#<($801)
	sta	do_load_smc2+1
	lda	#>($801)
	sta	do_load_smc2+2

get_size_smc1:
	lda	$dede
	sta	file_size

get_size_smc2:
	lda	$dede
	sta	file_size+1

	; always is 0?
	lda	#0
	sta	$800


do_load_loop:

do_load_smc1:
	lda	$dede
do_load_smc2:
	sta	$0800

	inc	do_load_smc1+1
	bne	no_load1_oflo
	inc	do_load_smc1+2
no_load1_oflo:

	inc	do_load_smc2+1
	bne	no_load2_oflo
	inc	do_load_smc2+2
no_load2_oflo:

	lda	do_load_smc1+1
	cmp	file_list+2,X
	bne	do_load_loop

	lda	do_load_smc1+2
	cmp	file_list+3,X
	bne	do_load_loop

	; done with file list, increment

	inc	which_file

	; update all the values
	; this is actually from the DOS3.3 code, roughly starting at $A413

	; add length to SOP / ASSOP
	; TXTTAB $67 -- start of program
	; need to add the size and store it in PRGEND $AF and VARTAB $69

	clc
	lda	file_size
	ldy	file_size+1
	adc	TXTTAB
	tax
	tya
	adc	TXTTAB+1		; A:X is now end of basic prog

	; skip the error check
	sta	PRGEND+1
	sta	VARTAB+1
	stx	PRGEND
	stx	VARTAB

	jmp	FIX_LINKS		; FIX_LINKS



file_size:	.word $dede

which_file:	.byte	$0

