TXTTAB = $67
PRGEND = $AF
VARTAB = $69
CURLIN = $75
ERRFLG = $D8
TXTPTR = $B8
CHRGET = $00B1

SCRTCH	=	$D64B
RESTART	=	$D43C
INLIN2	=	$D52E
PARSE_INPUT_LINE = $d559
TRACE_	= $D805

load_file:

	;=================
	; run list command
do_list:
	bit	SET_TEXT
	bit	PAGE0
	jsr	HOME

	lda	#<list_string
	sta	cti_smc+1
	lda	#>list_string
	sta	cti_smc+2
	jsr	copy_to_input

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
	; run run command
	; a do-run-run, a do-run-run
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

	rts


file_size:	.word $dede

which_file:	.byte	$0

file_list:
	.word	flyer,flyer_end
	.word	nyan,nyan_end
	.word	qr,qr_end

title_list:
	.word	flyer_title
	.word	nyan_title
	.word	qr_title

flyer_title:
	.byte 8,10,"HI-RES SHAPETABLE FLYER",0
nyan_title:
	.byte 8,10,"HI-RES ANIMATED NYAN CAT",0
qr_title:
	.byte 0,10,"MYSTERY BAR CODE WILL NEVER LET YOU DOWN",0


flyer:
.incbin	"FLYER.BAS"
flyer_end:

nyan:
.incbin	"NYAN.BAS"
nyan_end:

qr:
.incbin	"QR.BAS"
qr_end:


