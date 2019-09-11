; VMW Chiptune Dumper

; for debug purposes prints the raw values to screen
; we re-route this to the printer in Slot #1 for debugging

.include	"zp.inc"
.include	"hardware.inc"

PT3_LOC = $4000

PT3_USE_ZERO_PAGE = 1

	;=============================
	; Setup
	;=============================
pt3_setup:
	jsr     HOME
	jsr     TEXT


	; Init disk code

	jsr	rts_init

	; init variables

	lda	#0
	sta	DRAW_PAGE
	sta	DONE_PLAYING
	sta	WHICH_FILE

	; Set to 1MHz mode (no translate) for validation purposes
	lda	#$18
	sta	convert_177_smc1
	sta	convert_177_smc2
	sta	convert_177_smc3
	sta	convert_177_smc4
	sta	convert_177_smc5


	;==================
	; load first song
	;==================


	; Set COUT to the printer in PR#1

	lda	#$02
	sta	$36
	lda	#$C1
	sta	$37

	jsr	new_song

	;============================
	; Loop forever
	;============================
main_loop:

	jsr	pt3_make_frame

	lda	FRAMEH
	jsr	PRBYTE
	lda	FRAMEL
	jsr	PRBYTE
	lda	#':'+$80
	jsr	COUT
	lda	#' '+$80
	jsr	COUT

	; A
	lda	#'A'+$80
	jsr	COUT
	lda	#':'+$80
	jsr	COUT
	lda	AY_REGISTERS+1
	jsr	PRBYTE
	lda	AY_REGISTERS+0
	jsr	PRBYTE
	lda	#' '+$80
	jsr	COUT

	; B
	lda	#'B'+$80
	jsr	COUT
	lda	#':'+$80
	jsr	COUT
	lda	AY_REGISTERS+3
	jsr	PRBYTE
	lda	AY_REGISTERS+2
	jsr	PRBYTE
	lda	#' '+$80
	jsr	COUT

	; C
	lda	#'C'+$80
	jsr	COUT
	lda	#':'+$80
	jsr	COUT
	lda	AY_REGISTERS+5
	jsr	PRBYTE
	lda	AY_REGISTERS+4
	jsr	PRBYTE
	lda	#' '+$80
	jsr	COUT

	; N
	lda	#'N'+$80
	jsr	COUT
	lda	#':'+$80
	jsr	COUT
	lda	AY_REGISTERS+6
	jsr	PRBYTE
	lda	#' '+$80
	jsr	COUT

	; M
	lda	#'M'+$80
	jsr	COUT
	lda	#':'+$80
	jsr	COUT
	lda	AY_REGISTERS+7
	jsr	PRBYTE
	lda	#' '+$80
	jsr	COUT

	jsr	CROUT1

	ldx	#6
six_space:
	lda	#' '+$80
	jsr	COUT
	dex
	bne	six_space

	; A amp
	lda	#'V'+$80
	jsr	COUT
	lda	#':'+$80
	jsr	COUT
	lda	AY_REGISTERS+8
	jsr	PRBYTE
	lda	#' '+$80
	jsr	COUT
	lda	#' '+$80
	jsr	COUT
	lda	#' '+$80
	jsr	COUT

	; B amp
	lda	#'V'+$80
	jsr	COUT
	lda	#':'+$80
	jsr	COUT
	lda	AY_REGISTERS+9
	jsr	PRBYTE
	lda	#' '+$80
	jsr	COUT
	lda	#' '+$80
	jsr	COUT
	lda	#' '+$80
	jsr	COUT

	; C amp
	lda	#'V'+$80
	jsr	COUT
	lda	#':'+$80
	jsr	COUT
	lda	AY_REGISTERS+10
	jsr	PRBYTE
	lda	#' '+$80
	jsr	COUT
	lda	#' '+$80
	jsr	COUT
	lda	#' '+$80
	jsr	COUT

	; Envelope
	lda	#'E'+$80
	jsr	COUT
	lda	#':'+$80
	jsr	COUT
	lda	AY_REGISTERS+12
	jsr	PRBYTE
	lda	AY_REGISTERS+11
	jsr	PRBYTE

	; Envelope type
	lda	#','+$80
	jsr	COUT
	lda	AY_REGISTERS+13
	jsr	PRBYTE

	jsr	CROUT1

	inc	FRAMEL
	bne	no_frame_oflo
	inc	FRAMEH
no_frame_oflo:

	; STOP EARLY for DEBUGGING

;	lda	FRAMEL
;	cmp	#$A4
;	bne	checkcheck
;	lda	FRAMEH
;	cmp	#$1
;	beq	all_done
;checkcheck:


	; check if end
	lda	DONE_SONG
	bne	all_done
	jmp	main_loop

all_done:
	jmp	all_done




	;=================
	; load a new song
	;=================

new_song:

	;=========================
	; Init Variables
	;=========================

	;===========================
	; Load in PT3 file
	;===========================

	jsr	get_filename

	; needs to be space-padded $A0 30-byte filename

	lda	#<readfile_filename
	sta	namlo
	lda	#>readfile_filename
	sta	namhi

	ldy	#0
	ldx	#30		; 30 chars
name_loop:
	lda	(INL),Y
	beq	space_loop
	ora	#$80
	sta	(namlo),Y
	iny
	dex
	bne	name_loop
	beq	done_name_loop
space_loop:
	lda	#$a0		; pad with ' '
	sta	(namlo),Y
	iny
	dex
	bne	space_loop

done_name_loop:

	; open and read a file
	; loads to whatever it was BSAVED at (default is $2000)

	jsr	read_file		; read PT3 file from disk


	;=========================
	; Print Info
	;=========================

	; NUL terminate the strings we want to print
	lda	#0
	sta	PT3_LOC+$3E
	sta	PT3_LOC+$62

	; print title

	lda	#>(PT3_LOC+$1E)		; point to header title
	sta	OUTH
	lda	#<(PT3_LOC+$1E)
	sta	OUTL

	jsr	print_cout

	jsr	CROUT1

	; Print Author

	lda	#>(PT3_LOC+$42)		; point to header title
	sta	OUTH
	lda	#<(PT3_LOC+$42)
	sta	OUTL

	jsr	print_cout

	jsr	CROUT1
	jsr	CROUT1

	jsr	pt3_init_song

	rts




	;==================
	; Get filename
	;==================
	; WHICH_FILE holds number
	; MAX_FILES has max
	; Scroll through until find
	; point INH:INL to it
get_filename:

	ldy	#0
	ldx	WHICH_FILE

	lda	#<song_list			; point to filename
	sta	INL
	lda	#>song_list
	sta	INH

get_filename_loop:
	cpx	#0
	beq	filename_found

inner_loop:
	iny
	lda	(INL),Y
	bne	inner_loop

	iny

	dex
	jmp	get_filename_loop

filename_found:
	tya
	clc
	adc	INL
	sta	INL
	lda	INH
	adc	#0
	sta	INH

	rts


	;===============
	; print cout
	;===============
print_cout:
	ldy	#0
cout_loop:
	lda	(OUTL),Y
	beq	cout_done

	clc
	adc	#$80
	jsr	COUT

	iny
	jmp	cout_loop

cout_done:
	rts



FRAMEL:	.byte	$00
FRAMEH:	.byte	$00



;==========
; filenames
;==========

song_list:

	.asciiz "IT.PT3"	; ST
;	.asciiz "CR.PT3"	; ST
;	.asciiz "EA.PT3"	; ST
;	.asciiz "RI.PT3"	; ST
;	.asciiz "OO.PT3"	; ASM_34_35
;	.asciiz "DY.PT3"	; ASM_34_35
;	.asciiz "BH.PT3"	; PT_34_35
;	.asciiz "CH.PT3"	; REAL_34_35

;=========
;routines
;=========
.include	"qkumba_rts.s"
;.include	"../pt3_lib/pt3_lib.s"

.include	"pt3_lib_core.s"
.include	"pt3_lib_init.s"




;============
; dummy vars
;============

pt3_loop_smc:
