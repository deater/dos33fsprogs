; test 4-cade dhgr 48-box wipes

;(c) 2020 by 4am & qkumba
;    2025 modifications by deater

; can move most things around, but breaks if we move aux backup
; from $9000 to $a000


; NOTE!  It also stomps all over $7000-$8F00!!!!


.include "../../../../demos/demosplash2025/hardware.inc"
.include "../../../../demos/demosplash2025/zp.inc"
.include "common_defines.inc"

; zero page use

src		= $00	; [word][must be at $00] used by drawing routines
dst		= $02	; [word] used by drawing routines
rowcount	= $04	; [byte] used by drawing routines
tmpy		= $05	; [byte] used by drawing routines
box		= $0E	; [byte] counter in main loop
DHGR48BoxStages	= $10	; $10-$3F $30 bytes, current stage for each box

; $09-$FF also used during inital table build????

; High bytes of drawing routines for each stage (actual routines will be page-aligned).
; To minimize code size, we build drawing routines in this order:
; - copy01 (STAGE1 template)
; - copy00 (STAGE0 template)
; - copy0F..copy09 (OUTER_STAGE template)
; - copy08..copy02 (MIDDLE_STAGE template)
; - change some opcodes to turn the 'copy' routines into 'clear' routines
; - clear0F..clear08 (OUTER_STAGE)
; - clear07..clear02 (MIDDLE_STAGE)
; - clear01 (STAGE1)
; - clear00 (STAGE0)
dhgr_clear00  = $70
dhgr_clear01  = $71
dhgr_clear02  = $72
dhgr_clear03  = $73
dhgr_clear04  = $74
dhgr_clear05  = $75
dhgr_clear06  = $76
dhgr_clear07  = $77
dhgr_clear08  = $78
dhgr_clear09  = $79
dhgr_clear0A  = $7A
dhgr_clear0B  = $7B
dhgr_clear0C  = $7C
dhgr_clear0D  = $7D
dhgr_clear0E  = $7E
dhgr_clear0F  = $7F
dhgr_copy02   = $80
dhgr_copy03   = $81
dhgr_copy04   = $82
dhgr_copy05   = $83
dhgr_copy06   = $84
dhgr_copy07   = $85
dhgr_copy08   = $86
dhgr_copy09   = $87
dhgr_copy0A   = $88
dhgr_copy0B   = $89
dhgr_copy0C   = $8A
dhgr_copy0D   = $8B
dhgr_copy0E   = $8C
dhgr_copy0F   = $8D
dhgr_copy00   = $8E
dhgr_copy01   = $8F

; main memory addresses used by graphic effects
; why are these+1?

hgrlo		= hposn_low		;
mirror_cols	= hposn_low+$C0
hgrhi		= hposn_high		;
hgr1hi		= hgrhi

DHGR48StageDrawingRoutines = $D00   ; $100 bytes

auxsrc_hgrhi	= $E01	; [$C0 bytes] HGR base addresses (hi) starting at $9000
BoxesX		= $F90	; [$30 bytes] starting row for each box
BoxesY		= $FC0	; [$30 bytes] starting byte offset for each box

;hgrlo          = $0201               ; $C0 bytes
;mirror_cols    = $02C1               ; $28 bytes
;hgrhi          = $0301               ; $C0 bytes
;hgr1hi         = hgrhi

;DHGR48StageDrawingRoutines = $6F00   ; $100 bytes

; $9000-$AFFF used as copy of AUX memory

; why are these not all in $BD page?

;auxsrc_hgrhi	= $BD01	; [$C0 bytes] HGR base addresses (hi) starting at $9000
;BoxesX		= $BE90	; [$30 bytes] starting row for each box
;BoxesY		= $BEC0	; [$30 bytes] starting byte offset for each box


ds_test:

	LDA	LCBANK1
	LDA	LCBANK1


	jsr	hgr_make_tables

	;==================
        ; Init DHGR mode
        ;==================

        bit     SET_GR
        bit     HIRES
        bit     FULLGR
        sta     AN3
        sta     EIGHTYCOLON

        ;=================================
        ; test wipe...
        ;=================================
test_loop:

        jsr     load_test_graphic

        jsr     wait_until_keypress

	ldx	#0
	jsr	wipe_48

        jsr     wait_until_keypress

	jmp	test_loop


	;======================================
	;======================================
	; wipe 48
	;======================================
	;======================================
	; which one in X
wipe_48:

	stx	which_one

	jsr	Init

	rts


which_one:
	.byte	0

Init:

	ldy	which_one
	lda	wipes_box_init_l,Y
	sta	initonce_smc1+1
	lda	wipes_box_init_h,Y
	sta	initonce_smc1+2

	lda	wipes_stages_l,Y
	sta	stages_hi_smc+1
	lda	wipes_stages_h,Y
	sta	stages_hi_smc+2

	lda	wipes_stages_size,Y
	sta	stages_size_smc+1

	; initialize and copy stage drawing routines table into place

	; write 256 bytes of 0s off end of EndStageHi?
	; why? do we need padding?

	ldx	#0
	txa
io_m1:
;	sta	EndStagesHi, X
	sta	DHGR48StageDrawingRoutines, X
	inx
	bne	io_m1

	ldx	#0
io_m2:
stages_hi_smc:
	lda	$DDDD, X
	sta	DHGR48StageDrawingRoutines, X
	inx
stages_size_smc:
	cpx	#$DD
	bne	io_m2

;	beq	Start		; always branches

Start:

	jsr	BuildingPhase	; building phase
				; to inititalize drawing routines and tables

	; copy this effect's initial stages to zp
	ldx   #47
s_m1:

initonce_smc1:
	ldy	$DDDD, X
	sty	DHGR48BoxStages, X
	dex
	bpl	s_m1

	jmp	DrawingPhase		; exit via vector to drawing phase


; want this to start at $6200?

; this has to align on page start or won't work

;.align 256

; The screen is separated into 48 boxes.
; Boxes are laid out in a grid, left-to-right, top-down:
;
; 0  1  2  3  4  5  6  7
; 8  9  10 11 12 13 14 15
; 16 17 18 19 20 21 22 23
; 24 25 26 27 28 29 30 31
; 32 33 34 35 36 37 38 39
; 40 41 42 43 44 45 46 47
;
; Each box is 70x32 pixels, so each row of each box is 5 consecutive
; bytes in main memory and another 5 in auxiliary memory, all of which
; are easy to find once you calculate the base address for that row.
;
; |BoxInitialStages| defines the initial grid of stages for each box.
; Each stage is used as an index into the |StagesHi| array
; to find the drawing routine for that stage (if any).
; Each box's stage is incremented after each iteration through the main loop.
; When the main loop iterates through all 48 boxes without drawing anything,
; the program exits.
;
; There are 16 clear routines that set certain bits to 0 (black),
; labeled clear00..clear0F. clear00 clears the inner-most box, and
; clear0F clears the outermost box (see diagram).
; There are 16 copy routines that copy certain bits from the source
; image on page 2 to the destination image on page 1, labeled copy00..copy0F.
;
; row|                 pixels
; ---+---------------------------------------
; 00 |FFFFFFF|FFFFFFF|FFFFFFF|FFFFFFF|FFFFFFF
; 01 |FEEEEEE|EEEEEEE|EEEEEEE|EEEEEEE|EEEEEEF
; 02 |FEDDDDD|DDDDDDD|DDDDDDD|DDDDDDD|DDDDDEF
; 03 |FEDCCCC|CCCCCCC|CCCCCCC|CCCCCCC|CCCCDEF
; 04 |FEDCBBB|BBBBBBB|BBBBBBB|BBBBBBB|BBBCDEF
; 05 |FEDCBAA|AAAAAAA|AAAAAAA|AAAAAAA|AABCDEF
; 06 |FEDCBA9|9999999|9999999|9999999|9ABCDEF
; 07 |FEDCBA9|8888888|8888888|8888888|9ABCDEF
; ---+-------+-------+-------+-------+-------
; 08 |FEDCBA9|8777777|7777777|7777778|9ABCDEF
; 09 |FEDCBA9|8766666|6666666|6666678|9ABCDEF
; 0A |FEDCBA9|8765555|5555555|5555678|9ABCDEF
; 0B |FEDCBA9|8765444|4444444|4445678|9ABCDEF
; 0C |FEDCBA9|8765433|3333333|3345678|9ABCDEF
; 0D |FEDCBA9|8765432|2222222|2345678|9ABCDEF
; 0E |FEDCBA9|8765432|1111111|2345678|9ABCDEF
; 0F |FEDCBA9|8765432|1000001|2345678|9ABCDEF
; ---+-------+-------+-------+-------+-------
; 10 |FEDCBA9|8765432|1000001|2345678|9ABCDEF
; 11 |FEDCBA9|8765432|1111111|2345678|9ABCDEF
; 12 |FEDCBA9|8765432|2222222|2345678|9ABCDEF
; 13 |FEDCBA9|8765433|3333333|3345678|9ABCDEF
; 14 |FEDCBA9|8765444|4444444|4445678|9ABCDEF
; 15 |FEDCBA9|8765555|5555555|5555678|9ABCDEF
; 16 |FEDCBA9|8766666|6666666|6666678|9ABCDEF
; 17 |FEDCBA9|8777777|7777777|7777778|9ABCDEF
; ---+-------+-------+-------+-------+-------
; 18 |FEDCBA9|8888888|8888888|8888888|9ABCDEF
; 19 |FEDCBA9|9999999|9999999|9999999|9ABCDEF
; 1A |FEDCBAA|AAAAAAA|AAAAAAA|AAAAAAA|AABCDEF
; 1B |FEDCBBB|BBBBBBB|BBBBBBB|BBBBBBB|BBBCDEF
; 1C |FEDCCCC|CCCCCCC|CCCCCCC|CCCCCCC|CCCCDEF
; 1D |FEDDDDD|DDDDDDD|DDDDDDD|DDDDDDD|DDDDDEF
; 1E |FEEEEEE|EEEEEEE|EEEEEEE|EEEEEEE|EEEEEEF
; 1F |FFFFFFF|FFFFFFF|FFFFFFF|FFFFFFF|FFFFFFF
;



; tokens for code generation
; used as indexes into |codegen_pieces| and |codegen_piece_lengths|,
; so keep all three in sync
k_rts			= 0        ; must be 0
k_edge_left_mask_main	= 1        ; must be 1
k_edge_right_mask_main	= 2        ; must be 2
k_left_mask_main	= 3        ; must be 3
k_right_mask_main	= 4        ; must be 4
k_edge_left_mask_aux	= 5        ; must be 5
k_edge_right_mask_aux	= 6        ; must be 6
k_left_mask_aux		= 7        ; must be 7
k_right_mask_aux	= 8        ; must be 8
k_current_page		= 9
k_switch_to_main	= 10
k_switch_to_aux		= 11
k_switch_to_aux_and_byte_copy = 12
k_inx_and_recalc	= 13
k_recalc		= 14
k_set_row_count		= 15
k_set_first_row		= 16
k_iny2			= 17
k_iny			= 18
k_dey			= 19
k_save_y		= 20
k_restore_y		= 21
k_middle_jsr		= 22
k_outer_jsr		= 23
k_middle_branch		= 24
k_outer_branch		= 25
k_mask_copy_pre 	= 26
k_mask_copy_post	= 27
k_byte_copy		= 28
k_byte_copy_and_iny	= 29
k_bitcopy		= 30       ; must be last token


; FIXME: these need to be here even if unused?  Why?

FXCode:
        jmp     BuildingPhase
;*=FXCode+3
        jmp     DrawingPhase



; All template p-code must be on the same page
.align 256

; Template for 'stage 0' routine (copy00), which copies the innermost
; part of the box (labeled '0' in diagram above).
STAGE0:
         .byte k_set_first_row
         .byte k_iny2
         .byte k_recalc
         .byte k_bitcopy, k_left_mask_main
         .byte k_switch_to_aux
         .byte k_bitcopy, k_left_mask_main
         .byte k_switch_to_main
         .byte k_inx_and_recalc
         .byte k_bitcopy, k_left_mask_aux
         .byte k_switch_to_aux
         .byte k_bitcopy, k_left_mask_aux
         .byte k_rts       ; also serves as an end-of-template marker

; Template for 'stage 1' routine (copy01), which copies the pixels
; around the innermost box (labeled '1' in diagram above).
STAGE1:
         .byte k_set_first_row
         .byte k_iny2
         .byte k_recalc
         .byte k_byte_copy
         .byte k_switch_to_aux_and_byte_copy
         .byte k_switch_to_main
         .byte k_inx_and_recalc
         .byte k_byte_copy
         .byte k_switch_to_aux_and_byte_copy
         .byte k_switch_to_main
         .byte k_inx_and_recalc
         .byte k_byte_copy
         .byte k_switch_to_aux_and_byte_copy
         .byte k_switch_to_main
         .byte k_inx_and_recalc
         .byte k_byte_copy
         .byte k_switch_to_aux_and_byte_copy
         .byte k_rts       ; also serves as an end-of-template marker

; Template for stages 2-8 (copy02..copy08)
MIDDLE_STAGE:
         .byte k_set_row_count
         .byte k_set_first_row
         .byte k_iny
         .byte k_save_y
         .byte k_middle_jsr, k_current_page
         ;-
         .byte k_inx_and_recalc
         .byte k_bitcopy, k_left_mask_main
         .byte k_iny2
         .byte k_bitcopy, k_right_mask_main
         .byte k_switch_to_aux
         .byte k_bitcopy, k_right_mask_aux
         .byte k_restore_y
         .byte k_bitcopy, k_left_mask_aux
         .byte k_switch_to_main
         .byte k_middle_branch
         ;+
         .byte k_inx_and_recalc
         .byte k_bitcopy, k_edge_left_mask_main
         .byte k_iny
         .byte k_byte_copy_and_iny
         .byte k_bitcopy, k_edge_right_mask_main
         .byte k_switch_to_aux
         .byte k_bitcopy, k_edge_right_mask_aux
         .byte k_dey
         .byte k_byte_copy
         .byte k_dey
         .byte k_bitcopy, k_edge_left_mask_aux
         .byte k_rts       ; also serves as an end-of-template marker

; Template for stages 9-15 (copy09..copy0F)
OUTER_STAGE:
         .byte k_set_row_count
         .byte k_set_first_row
         .byte k_save_y
         .byte k_outer_jsr, k_current_page
         ;-
         .byte k_inx_and_recalc
         .byte k_bitcopy, k_left_mask_main
         .byte k_iny2
         .byte k_iny2
         .byte k_bitcopy, k_right_mask_main
         .byte k_switch_to_aux
         .byte k_bitcopy, k_right_mask_aux
         .byte k_restore_y
         .byte k_bitcopy, k_left_mask_aux
         .byte k_switch_to_main
         .byte k_outer_branch
         ;+
         .byte k_inx_and_recalc
         .byte k_bitcopy, k_edge_left_mask_main
         .byte k_iny
         .byte k_byte_copy_and_iny
         .byte k_byte_copy_and_iny
         .byte k_byte_copy_and_iny
         .byte k_bitcopy, k_edge_right_mask_main
         .byte k_switch_to_aux
         .byte k_bitcopy, k_edge_right_mask_aux
         .byte k_dey
         .byte k_byte_copy
         .byte k_dey
         .byte k_byte_copy
         .byte k_dey
         .byte k_byte_copy
         .byte k_dey
         .byte k_bitcopy, k_edge_left_mask_aux
         .byte k_rts       ; also serves as an end-of-template marker

.assert (>* - >STAGE0) < 1 , error, "stage0 crosses page boundary"


	; corrupts???

BuildingPhase:

	; generate |BoxesX| and |BoxesY| arrays

	ldx	#48
	ldy	#$A0
	lda	#$23
	pha
bp_m1:
	tya
	sta	BoxesX-1, X
	pla
	sta	BoxesY-1, X
	sec
	sbc	#5
	bcs	bp_p1
	lda	#$23
bp_p1:
	pha
	dex
	txa
	and	#7
	bne	bp_m1
	tya
	sec
	sbc	#$20
	tay
	txa
	bne	bp_m1
	pla

	; construct drawing routines for each stage
	; This overwrites the entire zero page?????

	jsr	BuildDrawingRoutines


	; A=0 here

	; vmw: needed?
	ldx	#$C0

	; X=$C0 here

bp_m2:
	lda	hgrhi-1, X
	clc
	adc	#$70
	sta	auxsrc_hgrhi-1, X
	dex
	bne	bp_m2
	rts

DrawingPhase:
	sta	$C001	; 80STORE mode so we can bank $2000/aux
			; in & out with STA $C055 & $C054
MainLoop:
	ldx	#48
BoxLoop:
	ldy	DHGR48BoxStages-1, X  ; for each box, get its current stage
	inc	DHGR48BoxStages-1, X  ; increment every box's stage every time through the loop
	lda	DHGR48StageDrawingRoutines, Y
	beq	NextBox		; if stage's drawing routine is 0, nothing to do
	stx	box
	sta	jj+2
	lda	BoxesX-1, X	; A = starting HGR row for this box
	ldy	BoxesY-1, X	; Y = starting byte offset for this box
	clc
jj:
	jsr	$0000		; [SMC] call drawing routine for this stage
	ldx	box
NextBox:
	dex
	bne	BoxLoop
	lda	jj+2
	beq	np_p1		; if we didn't draw anything in any box, we're done
	stx	jj+2		; X=0 here
	bit	KBD		; check for key
	bpl	MainLoop
np_p1:
	sta	$C000		; 80STORE off
	; execution falls through here

; These are all the pieces of code we need to construct the drawing routines.
; There are 32 drawing routines, which we construct from
; four templates (below). Templates use tokens to refer to these code pieces.
; Note that several pieces overlap in order to minimize code size.
; Everything from CODEGEN_COPY_START and onward is copied to zero page for
; the code generation phase on program startup.

EDGE_LEFT_MASK_MAIN	= $01      ; address $01 to match token
EDGE_RIGHT_MASK_MAIN	= $02      ; address $02 to match token
LEFT_MASK_MAIN		= $03      ; address $03 to match token
RIGHT_MASK_MAIN		= $04      ; address $04 to match token
EDGE_LEFT_MASK_AUX	= $05      ; address $05 to match token
EDGE_RIGHT_MASK_AUX	= $06      ; address $06 to match token
LEFT_MASK_AUX		= $07      ; address $07 to match token
RIGHT_MASK_AUX		= $08      ; address $08 to match token

CODEGEN_COPY_START:

.org $09
;!pseudopc 9 {
RTS0:
SWITCH_TO_MAIN:
	sta	$C054
SWITCH_TO_MAIN_E:
	rts			; also terminates MainLoop
RTS0_E:
;

SWITCH_TO_AUX_AND_BYTE_COPY:
SWITCH_TO_AUX:
	sta	$C055
	lda	auxsrc_hgrhi, X
	sta	src+1
SWITCH_TO_AUX_E:

BYTECOPY_AND_INY:
BYTECOPY:
	lda	(src), Y
	sta	(dst), Y
BYTECOPY_E:
SWITCH_TO_AUX_AND_BYTE_COPY_E:
INY2:
INY1:
	iny
INY1_E:
BYTECOPY_AND_INY_E:
	iny
INY2_E:
;
DEY1:
	dey
DEY1_E:
;
SAVE_Y:
	sty	tmpy
SAVE_Y_E:
;
RESTORE_Y:
	ldy	tmpy
RESTORE_Y_E:
;
INX_AND_RECALC:
	inx
RECALC:
	lda	hgrlo, X
	sta	src
	sta	dst
	lda	hgrhi, X
	sta	dst+1
	eor	#$60			; 2000 -> 0010 4000?
	sta	src+1
RECALC_E:
INX_AND_RECALC_E:
;
SET_ROW_COUNT:
ROW_COUNT=*+1
	ldx	#$1D		; SMC
	stx	rowcount
SET_ROW_COUNT_E:
;
SET_FIRST_ROW:
FIRST_ROW=*+1
	adc	#$0E		; SMC
	tax
SET_FIRST_ROW_E:
;
MASKCOPY_PRE:
	lda	(dst), Y
BIT_FOR_CLEAR:
	eor	(src), Y
	.byte	$29		; (AND #$44 opcode)
MASKCOPY_PRE_E:
;

codegen_pieces:			; address of each of the pieces
				; (on zero page, so 1 byte)
         .byte <RTS0
;
MIDDLE_BRANCH:
	dec	rowcount
	.byte	$10,$C8
MIDDLE_BRANCH_E:
;
OUTER_BRANCH:
	dec	rowcount
	.byte $10,$C6
OUTER_BRANCH_E:
;
	.byte	<codegen_dst		; current page
	.byte	<SWITCH_TO_MAIN
	.byte	<SWITCH_TO_AUX
	.byte	<SWITCH_TO_AUX_AND_BYTE_COPY
	.byte	<INX_AND_RECALC
	.byte	<RECALC
	.byte	<SET_ROW_COUNT
	.byte	<SET_FIRST_ROW
	.byte	<INY2
	.byte	<INY1
	.byte	<DEY1
	.byte	<SAVE_Y
	.byte	<RESTORE_Y
	.byte	<MIDDLE_JSR
	.byte	<OUTER_JSR
	.byte	<MIDDLE_BRANCH
	.byte	<OUTER_BRANCH
	.byte	<MASKCOPY_PRE
	.byte	<MASKCOPY_POST
	.byte	<BYTECOPY
	.byte	<BYTECOPY_AND_INY

codegen_piece_lengths:		; length of each of the pieces
	.byte RTS0_E-RTS0
;
MASKCOPY_POST:
	eor	(dst), Y
	sta	(dst), Y
MASKCOPY_POST_E:
;
MIDDLE_JSR:
	.byte	$20,$46
MIDDLE_JSR_E:
OUTER_JSR:
	.byte $20,$47
OUTER_JSR_E:
;
	.byte 1 ; current page
	.byte SWITCH_TO_MAIN_E-SWITCH_TO_MAIN
	.byte SWITCH_TO_AUX_E-SWITCH_TO_AUX
	.byte SWITCH_TO_AUX_AND_BYTE_COPY_E-SWITCH_TO_AUX_AND_BYTE_COPY
	.byte INX_AND_RECALC_E-INX_AND_RECALC
	.byte RECALC_E-RECALC
	.byte SET_ROW_COUNT_E-SET_ROW_COUNT
	.byte SET_FIRST_ROW_E-SET_FIRST_ROW
	.byte INY2_E-INY2
	.byte INY1_E-INY1
	.byte DEY1_E-DEY1
	.byte SAVE_Y_E-SAVE_Y
	.byte RESTORE_Y_E-RESTORE_Y
	.byte MIDDLE_JSR_E-MIDDLE_JSR
	.byte OUTER_JSR_E-OUTER_JSR
	.byte MIDDLE_BRANCH_E-MIDDLE_BRANCH
	.byte OUTER_BRANCH_E-OUTER_BRANCH
	.byte MASKCOPY_PRE_E-MASKCOPY_PRE
	.byte MASKCOPY_POST_E-MASKCOPY_POST
	.byte BYTECOPY_E-BYTECOPY
	.byte BYTECOPY_AND_INY_E-BYTECOPY_AND_INY

BuildDrawingRoutineFrom:
	sta	<codegen_token_src	; STA opcode ($85)
				; also serves as 'length' of k_bitcopy token
BuildDrawingRoutine:
	ldy	#0
	sty	<codegen_token_x
bdr_om1:
	jsr	GetNextToken
	pha
	jsr	ProcessToken
	pla
	bne	bdr_om1
	dec	<codegen_dst
	inc	<FIRST_ROW
	rts

GetNextToken:
codegen_token_x=*+1
	ldx	#$00
codegen_token_src=*+1
	lda	OUTER_STAGE, X
	inc	<codegen_token_x
	rts

ProcessBitcopyToken:
	jsr	GetNextToken
	sta	<bitcopy_mask
bitcopy_mask=*+1
	lda	$FD			; SMC
	beq	ExitProcessToken	; copymask=0 -> nothing to generate
	bmi	pbt_p1			; copymask>=$80 -> assume full byte
	lda	#k_mask_copy_pre
	jsr	ProcessToken
	lda	#1
	sta	<piece_length
	lda	<bitcopy_mask
	jsr	ProcessMaskToken
	lda	#k_mask_copy_post

	;HIDE_NEXT_2_BYTES
	.byte	$2C			; 3-byte bit
pbt_p1:
	lda	#k_byte_copy
	; execution falls through here
ProcessToken:
	tax
	lda	<codegen_piece_lengths, X
	bmi	ProcessBitcopyToken	; only bitcopy has length>=$80
	sta	<piece_length
	lda	<codegen_pieces, X
	; execution falls through here
ProcessMaskToken:
	sta	<piece_src
	ldx	#0
pbt_m1:
piece_src=*+1
	lda	$FD, X		; SMC
	.byte	$99,$00		; STA $4400, Y
codegen_dst:
	.byte	dhgr_copy01	; SMC
	iny
	inx
piece_length=*+1
	cpx	#$FD		; SMC
	bcc	pbt_m1
ExitProcessToken:
	rts

codegen_stage:
	.byte 27
codegen_maskindex:
	.byte 0

CopyAuxDHGRToMain:
; X=0
	sta	READAUXMEM	; copy $4000-5FFF/aux to $A000-BFFF/main
				; was $9000-$AFFF
	ldy	#$20
at_a:
	lda	$4000, X
at_b:
	sta	$9000, X		; not a000?
	inx
	bne	at_a
	inc	<at_a+2
	inc	<at_b+2
	dey
	bne	at_a
	sta	READMAINMEM
; X=0,Y=0
	rts
;}
.reloc

EdgeRightMasks:
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000001
	.byte %00000111
	.byte %00011111
	.byte %11111111
LeftMasks:
	.byte %01100000
	.byte %00011000
	.byte %00000111
	.byte %00000000
RightMasks:
	.byte %00000000
	.byte %00000000
	.byte %00000000			; also terminates LeftMasks
	.byte %00000001
	.byte %00000110
	.byte %00011000
EdgeLeftMasks:
	.byte %01100000			; also terminates RightMasks
	.byte %01111000
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
EdgeLeftMasksAux:
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %01000000
	.byte %01110000
	.byte %01111100
	.byte %11111111
RightMasksAux:
	.byte %00000011
	.byte %00001100
	.byte %01110000
	.byte %00000000
LeftMasksAux:
	.byte %00000000
	.byte %00000000
	.byte %00000000		; also terminates RightMasksAux
	.byte %01000000
	.byte %00110000
	.byte %00001100
EdgeRightMasksAux:
	.byte %00000011		; also terminates LeftMasksAux
	.byte %00001111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111

BuildDrawingRoutines:
	; copy codegen data to zero page
	ldx	#0
bdr_m1:
	lda	CODEGEN_COPY_START, X
	sta	$09, X
	inx
	bne	bdr_m1
	; X=0 here

	; copy the half of the source image from $4000/aux to main memory
	jsr	CopyAuxDHGRToMain

	; X,Y=0 here

	; generate drawing routines for copy01, then copy00
	jsr	BuildStage1And0

	; A=0 here
	sta	<FIRST_ROW

	; generate drawing routines for copy0F..copy02, then clear0F..clear02
	lda	#<MIDDLE_STAGE
bdr_m3:
	eor	#(<OUTER_STAGE ^ <MIDDLE_STAGE)
	sta	<codegen_token_src
	ldx	#6
bdr_m2:
	stx	<codegen_maskindex
	lda	EdgeLeftMasks, X
	sta	<EDGE_LEFT_MASK_MAIN
	lda	EdgeRightMasks, X
	sta	<EDGE_RIGHT_MASK_MAIN
	lda	LeftMasks, X
	sta	<LEFT_MASK_MAIN
	lda	RightMasks, X
	sta	<RIGHT_MASK_MAIN
	lda	EdgeLeftMasksAux, X
	sta	<EDGE_LEFT_MASK_AUX
	lda	EdgeRightMasksAux, X
	sta	<EDGE_RIGHT_MASK_AUX
	lda	LeftMasksAux, X
	sta	<LEFT_MASK_AUX
	lda	RightMasksAux, X
	sta	<RIGHT_MASK_AUX
	jsr	BuildDrawingRoutine
	dec	<ROW_COUNT
	dec	<ROW_COUNT
	dec	<codegen_stage
	bmi	BuildStage1And0
	lda	<codegen_stage
	eor	#13
	bne	bdr_p1

	; reset counts and switch from copy to clear
	sta	<FIRST_ROW
	lda	#$1D
	sta	<ROW_COUNT
	lda	#$A9
	sta	<BYTECOPY
	lda	#$24
	sta	<BIT_FOR_CLEAR
bdr_p1:
	lda	<codegen_token_src
	ldx	<codegen_maskindex
	dex
	bmi	bdr_m3
	bpl	bdr_m2			; always branches

; generate drawing routines for copy01, copy00 (or clear01, clear00)
BuildStage1And0:
	lda	#%00011111
	sta	<LEFT_MASK_MAIN
	lda	#%01111100
	sta	<LEFT_MASK_AUX
	lda	#<STAGE1
	jsr	BuildDrawingRoutineFrom
	lda	#<STAGE0
	jmp	BuildDrawingRoutineFrom


;==============================================
;==============================================
; wipe data
;==============================================
;==============================================

wipes_box_init_l:
	.byte <spiral_BoxInitialStages
	.byte <snake_BoxInitialStages
	.byte <arrow_BoxInitialStages
	.byte <down_BoxInitialStages
	.byte <long_diagonal_BoxInitialStages
	.byte <side_side_BoxInitialStages
	.byte <sync_BoxInitialStages
	.byte <pageturn_BoxInitialStages
wipes_box_init_h:
	.byte >spiral_BoxInitialStages
	.byte >snake_BoxInitialStages
	.byte >arrow_BoxInitialStages
	.byte >down_BoxInitialStages
	.byte >long_diagonal_BoxInitialStages
	.byte >side_side_BoxInitialStages
	.byte >sync_BoxInitialStages
	.byte >pageturn_BoxInitialStages
wipes_stages_l:
	.byte <spiral_StagesHi
	.byte <snake_StagesHi
	.byte <arrow_StagesHi
	.byte <down_StagesHi
	.byte <long_diagonal_StagesHi
	.byte <side_side_StagesHi
	.byte <sync_StagesHi
	.byte <pageturn_StagesHi
wipes_stages_h:
	.byte >spiral_StagesHi
	.byte >snake_StagesHi
	.byte >arrow_StagesHi
	.byte >down_StagesHi
	.byte >long_diagonal_StagesHi
	.byte >side_side_StagesHi
	.byte >sync_StagesHi
	.byte >pageturn_StagesHi
wipes_stages_size:
	.byte spiral_EndStagesHi-spiral_StagesHi
	.byte snake_EndStagesHi-snake_StagesHi
	.byte arrow_EndStagesHi-arrow_StagesHi
	.byte down_EndStagesHi-down_StagesHi
	.byte long_diagonal_EndStagesHi-long_diagonal_StagesHi
	.byte side_side_EndStagesHi-side_side_StagesHi
	.byte sync_EndStagesHi-sync_StagesHi
	.byte pageturn_EndStagesHi-pageturn_StagesHi

;=============================================
; Spiral Wipe

spiral_BoxInitialStages:
	.byte $00,$E9,$EA,$EB,$EC,$ED,$EE,$EF
	.byte $FF,$E8,$D9,$DA,$DB,$DC,$DD,$F0
	.byte $FE,$E7,$D8,$D1,$D2,$D3,$DE,$F1
	.byte $FD,$E6,$D7,$D6,$D5,$D4,$DF,$F2
	.byte $FC,$E5,$E4,$E3,$E2,$E1,$E0,$F3
	.byte $FB,$FA,$F9,$F8,$F7,$F6,$F5,$F4

spiral_StagesHi:	; high bytes of address of drawing routine for each stage
	.byte dhgr_copy0F
	.byte dhgr_copy0E
	.byte dhgr_copy0D
	.byte dhgr_copy0C
	.byte dhgr_copy0B
	.byte dhgr_copy0A
	.byte dhgr_copy09
	.byte dhgr_copy08
	.byte dhgr_copy07
	.byte dhgr_copy06
	.byte dhgr_copy05
	.byte dhgr_copy04
	.byte dhgr_copy03
	.byte dhgr_copy02
	.byte dhgr_copy01
	.byte dhgr_copy00
spiral_EndStagesHi:

;=============================================
; Snake Wipe

snake_BoxInitialStages:

.byte $00,$FF,$FE,$FD,$FC,$FB,$FA,$F9
.byte $F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8
.byte $F0,$EF,$EE,$ED,$EC,$EB,$EA,$E9
.byte $E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8
.byte $E0,$DF,$DE,$DD,$DC,$DB,$DA,$D9
.byte  $D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8

snake_StagesHi:	; high bytes of address of drawing routine for each stage
.byte dhgr_copy0F
.byte dhgr_copy0E
.byte dhgr_copy0D
.byte dhgr_copy0C
.byte dhgr_copy0B
.byte dhgr_copy0A
.byte dhgr_copy09
.byte dhgr_copy08
.byte dhgr_copy07
.byte dhgr_copy06
.byte dhgr_copy05
.byte dhgr_copy04
.byte dhgr_copy03
.byte dhgr_copy02
.byte dhgr_copy01
.byte dhgr_copy00
snake_EndStagesHi:

;=============================================
; Arrow Wipe

arrow_BoxInitialStages:

.byte $FA,$F6,$F4,$F0,$EE,$EA,$E8,$E4
.byte $FC,$FA,$F6,$F4,$F0,$EE,$EA,$E8
.byte $00,$FC,$FA,$F6,$F4,$F0,$EE,$EA
.byte $FF,$FD,$F9,$F7,$F3,$F1,$ED,$EB
.byte $FD,$F9,$F7,$F3,$F1,$ED,$EB,$E7
.byte $F9,$F7,$F3,$F1,$ED,$EB,$E7,$E5

arrow_StagesHi:	; high bytes of address of drawing routine for each stage
.byte dhgr_copy00
.byte dhgr_copy01
.byte dhgr_copy02
.byte dhgr_copy03
.byte dhgr_copy04
.byte dhgr_copy05
.byte dhgr_copy06
.byte dhgr_copy07
.byte dhgr_copy08
.byte dhgr_copy09
.byte dhgr_copy0A
.byte dhgr_copy0B
.byte dhgr_copy0C
.byte dhgr_copy0D
.byte dhgr_copy0E
.byte dhgr_copy0F
arrow_EndStagesHi:


;=============================================
; Down Wipe

down_BoxInitialStages:

.byte $00,$FF,$00,$FF,$00,$FF,$00,$FF
.byte $FE,$FD,$FE,$FD,$FE,$FD,$FE,$FD
.byte $FC,$FB,$FC,$FB,$FC,$FB,$FC,$FB
.byte $FA,$F9,$FA,$F9,$FA,$F9,$FA,$F9
.byte $F8,$F7,$F8,$F7,$F8,$F7,$F8,$F7
.byte $F6,$F5,$F6,$F5,$F6,$F5,$F6,$F5

down_StagesHi:	; high bytes of address of drawing routine for each stage
.byte dhgr_copy0F
.byte dhgr_copy0E
.byte dhgr_copy0D
.byte dhgr_copy0C
.byte dhgr_copy0B
.byte dhgr_copy0A
.byte dhgr_copy09
.byte dhgr_copy08
.byte dhgr_copy07
.byte dhgr_copy06
.byte dhgr_copy05
.byte dhgr_copy04
.byte dhgr_copy03
.byte dhgr_copy02
.byte dhgr_copy01
.byte dhgr_copy00
down_EndStagesHi:

;=============================================
; Long Diagonal Wipe

long_diagonal_BoxInitialStages:

.byte $00,$FE,$FC,$FA,$F8,$F6,$F4,$F2
.byte $FE,$FC,$FA,$F8,$F6,$F4,$F2,$F0
.byte $FC,$FA,$F8,$F6,$F4,$F2,$F0,$EE
.byte $FA,$F8,$F6,$F4,$F2,$F0,$EE,$EC
.byte $F8,$F6,$F4,$F2,$F0,$EE,$EC,$EA
.byte $F6,$F4,$F2,$F0,$EE,$EC,$EA,$E8

long_diagonal_StagesHi: ; high bytes of address of drawing routine for each stage
.byte dhgr_copy00
.byte dhgr_copy01
.byte dhgr_copy02
.byte dhgr_copy03
.byte dhgr_copy04
.byte dhgr_copy05
.byte dhgr_copy06
.byte dhgr_copy07
.byte dhgr_copy08
.byte dhgr_copy09
.byte dhgr_copy0A
.byte dhgr_copy0B
.byte dhgr_copy0C
.byte dhgr_copy0D
.byte dhgr_copy0E
.byte dhgr_copy0F
long_diagonal_EndStagesHi:


;=============================================
; Side to Side Wipe

side_side_BoxInitialStages:
.byte $00,$FC,$F8,$F4,$F0,$EC,$E8,$E4
.byte $E4,$E8,$EC,$F0,$F4,$F8,$FC,$00
.byte $00,$FC,$F8,$F4,$F0,$EC,$E8,$E4
.byte $E4,$E8,$EC,$F0,$F4,$F8,$FC,$00
.byte $00,$FC,$F8,$F4,$F0,$EC,$E8,$E4
.byte $E4,$E8,$EC,$F0,$F4,$F8,$FC,$00

side_side_StagesHi: ; high bytes of address of drawing routine for each stage
.byte dhgr_copy00
.byte dhgr_copy01
.byte dhgr_copy02
.byte dhgr_copy03
.byte dhgr_copy04
.byte dhgr_copy05
.byte dhgr_copy06
.byte dhgr_copy07
.byte dhgr_copy08
.byte dhgr_copy09
.byte dhgr_copy0A
.byte dhgr_copy0B
.byte dhgr_copy0C
.byte dhgr_copy0D
.byte dhgr_copy0E
.byte dhgr_copy0F
side_side_EndStagesHi:

;=============================================
; Sync Wipe

sync_BoxInitialStages:

.byte $00,$FF,$00,$FF,$00,$FF,$00,$FF
.byte $FF,$00,$FF,$00,$FF,$00,$FF,$00
.byte $00,$FF,$00,$FF,$00,$FF,$00,$FF
.byte $FF,$00,$FF,$00,$FF,$00,$FF,$00
.byte $00,$FF,$00,$FF,$00,$FF,$00,$FF
.byte $FF,$00,$FF,$00,$FF,$00,$FF,$00

sync_StagesHi: ; high bytes of address of drawing routine for each stage
.byte dhgr_copy0F
.byte dhgr_copy0E
.byte dhgr_copy0D
.byte dhgr_copy0C
.byte dhgr_copy0B
.byte dhgr_copy0A
.byte dhgr_copy09
.byte dhgr_copy08
.byte dhgr_copy07
.byte dhgr_copy06
.byte dhgr_copy05
.byte dhgr_copy04
.byte dhgr_copy03
.byte dhgr_copy02
.byte dhgr_copy01
.byte dhgr_copy00
sync_EndStagesHi:


;=============================================
; Page Turn Clearn Wipe

pageturn_BoxInitialStages:

.byte $E1,$E2,$E1,$E7,$ED,$F3,$F9,$FF
.byte $E7,$E8,$E7,$E8,$EE,$F4,$FA,$00
.byte $ED,$EE,$ED,$EE,$ED,$F3,$F9,$FF
.byte $F3,$F4,$F3,$F4,$F3,$F4,$FA,$00
.byte $F9,$FA,$F9,$FA,$F9,$FA,$F9,$FF
.byte $FF,$00,$FF,$00,$FF,$00,$FF,$00

pageturn_StagesHi: ; high bytes of address of drawing routine for each stage
.byte dhgr_clear0F
.byte dhgr_clear0E
.byte dhgr_clear0D
.byte dhgr_clear0C
.byte dhgr_clear0B
.byte dhgr_clear0A
.byte dhgr_clear09
.byte dhgr_clear08
.byte dhgr_clear07
.byte dhgr_clear06
.byte dhgr_clear05
.byte dhgr_clear04
.byte dhgr_clear03
.byte dhgr_clear02
.byte dhgr_clear01
.byte dhgr_clear00
.byte 0,0,0,0,0,0,0,0,0,0,0,0,0
.byte dhgr_copy00
.byte dhgr_copy01
.byte dhgr_copy02
.byte dhgr_copy03
.byte dhgr_copy04
.byte dhgr_copy05
.byte dhgr_copy06
.byte dhgr_copy07
.byte dhgr_copy08
.byte dhgr_copy09
.byte dhgr_copy0A
.byte dhgr_copy0B
.byte dhgr_copy0C
.byte dhgr_copy0D
.byte dhgr_copy0E
.byte dhgr_copy0F
pageturn_EndStagesHi:



.include "../../../../demos/demosplash2025/hgr_table.s"
.include "../wait_keypress.s"

	;=================================
        ; Load Test Graphic
        ;=================================
load_test_graphic:

        sta     SET80COL        ; set Page1/Page2 flip MAIN/AUX
        bit     PAGE1

        ; bin part

        lda     #<test_graphic_bin
        sta     zx_src_l+1
        lda     #>test_graphic_bin
        sta     zx_src_h+1
        lda     #$20
        jsr     zx02_full_decomp

; aux part

        bit     PAGE2

        lda     #<test_graphic_aux
        sta     zx_src_l+1
        lda     #>test_graphic_aux
        sta     zx_src_h+1
        lda     #$20
        jsr     zx02_full_decomp

        bit     PAGE1
        sta     CLR80COL

        rts

test_graphic_aux:
        .incbin "../graphics/a2_nine.aux.zx02"
test_graphic_bin:
        .incbin "../graphics/a2_nine.bin.zx02"

.include "../zx02_optim.s"
