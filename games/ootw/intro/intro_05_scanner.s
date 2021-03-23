;=============================
; OOTW -- Intro -- The Scanner
;=============================

intro_05_scanner:

;===============================
;===============================
; Scanner
;===============================
;===============================

scanner:
	lda	#<(intro_scanner_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(intro_scanner_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	jsr	gr_copy_to_current
	jsr	page_flip

	lda	#<scanning_sequence
	sta	INTRO_LOOPL
	lda	#>scanning_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence

;===============================
;===============================
; Spinny DNA / Key
;===============================
;===============================

scanner2:
	lda	#<(ai_bg_lzsa)
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	#>(ai_bg_lzsa)
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$c			; load to off-screen $c00
	jsr	decompress_lzsa2_fast

	jsr	clear_bottom
	bit	TEXTGR			; split graphics/text

	jsr	gr_copy_to_current_40x40
	jsr	page_flip

	jsr	clear_bottom

	;=============================
	; Identification (nothing)
	;=============================

	lda	#0
	sta	DNA_OUT
	sta	DNA_PROGRESS

	lda	#<ai_sequence
	sta	INTRO_LOOPL
	lda	#>ai_sequence
	sta	INTRO_LOOPH

	jsr	run_sequence_static

	; slices        / | - / nothing (pause)
	; more slices   / | - / nothing (pause)
	; small circle  / | - / nothing (pause)
	; big circle    / | - / nothing (pause)

;	jsr	gr_copy_to_current_40x40
;	jsr	draw_dna
;	jsr	page_flip

	; approx one rotation until "Good evening"
	; two rotation, then switch to key + Ferrari
	; three rotations, then done

	;                   -   !!! DNA START 1 line
	;                     /   !!! DNA start 1 line
	;                         !!! DNA 2 lines
	; DNA 5 lines
	; Good evening professor.
	; DNA all lines

	; Triggers:
	; + DNA starts midway through big circle
	; + Good evening printed at DNA_OUT=5
	; + Switch to key, print ferrari


	; Key             |
	; I see you have driven here in your \ Ferrari.
	; Key                - / nothing (pause)


	ldx	#35
spin_on_key:
	txa
	pha

	jsr	draw_dna
	jsr	page_flip

	pla
	tax

	lda	#250
	jsr	WAIT

	dex
	bne	spin_on_key

	rts





	;=================================
	; Display a sequence of images
	; with /-|/ static overlay

run_sequence_static:
	ldy	#0				; init

run_sequence_static_loop:

	lda	(INTRO_LOOPL),Y			; draw DNA
	sta	DNA_OUT
	iny

	lda	(INTRO_LOOPL),Y			; pause for time
	beq	run_sequence_static_done
	tax

	lda	DNA_OUT
	bne	pause_draw_dna

	jsr	long_wait
	jmp	done_pause_dna
pause_draw_dna:
	txa
	pha

	tya
	pha

	jsr	draw_dna
	jsr	page_flip

	pla
	tay

	pla
	tax

	lda	#250
	jsr	WAIT

	dex
	bne	pause_draw_dna

done_pause_dna:

	iny					; point to overlay

	lda	#10				; set up static loop
	sta	STATIC_LOOPER

	sty	INTRO_LOOPER			; save for later

static_loop:

	lda	(INTRO_LOOPL),Y
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	iny
	lda	(INTRO_LOOPL),Y
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$10			; load to $1000
	jsr	decompress_lzsa2_fast

	jsr	gr_overlay_40x40

	ldy	STATIC_LOOPER
	lda	static_pattern,Y
        sta     getsrc_smc+1    ; LZSA_SRC_LO
	lda	static_pattern+1,Y
	sta     getsrc_smc+2    ; LZSA_SRC_HI

	lda	#$10			; load to $1000
	jsr	decompress_lzsa2_fast


	; force 40x40 overlay

	jsr	gr_overlay_40x40_noload

	lda	DNA_OUT
	beq	no_dna

	jsr	draw_dna

no_dna:
	jsr	page_flip

	ldy	INTRO_LOOPER

	ldx	#3
	jsr	long_wait

	dec	STATIC_LOOPER
	dec	STATIC_LOOPER

	bpl	static_loop

	iny
	iny

	jmp	run_sequence_static_loop
run_sequence_static_done:
	rts





	;====================================
	; Draw DNA
	;====================================
draw_dna:

	lda	#0	; count
	sta	DNA_COUNT

draw_dna_loop:
	clc
	lda	DNA_COUNT
	adc	#10
	sta	YPOS

	lda     #26
        sta     XPOS

	lda	DNA_COUNT		; 0, 4, 8, 12, 16....
	lsr
	clc
	adc	DNA_PROGRESS		; 0,2,4,6,8,...

	and	#$e
	tax

	lda	dna_list,X
	sta	INL
	lda     dna_list+1,X
	sta	INH

	jsr	put_sprite

	lda	DNA_COUNT
	clc
	adc	#4
	sta	DNA_COUNT

	; for DNA_PROGRESS 0,2,4,6,8,10,12 we only want to print
	; first X lines (gradually fade in)
	; after that, draw the whole thing

	lda	DNA_PROGRESS
	cmp	#14
	bpl	dna_full

	asl
	cmp	DNA_COUNT
	bpl	draw_dna_loop
	bmi	dna_full_done

dna_full:
	lda	DNA_COUNT
	cmp	#28
	bne	draw_dna_loop

dna_full_done:

	inc	DNA_PROGRESS
	inc	DNA_PROGRESS

	; see if printing message
	lda	DNA_PROGRESS
	cmp	#10
	bne	no_good_message

	lda	#<good_evening
	sta	OUTL
	lda	#>good_evening
	sta	OUTH
	jsr	print_both_pages
	jmp	no_ferrari_message

no_good_message:
	cmp	#$30
	bne	no_ferrari_message

	lda	#<ferrari
	sta	OUTL
	lda	#>ferrari
	sta	OUTH
	jsr	print_both_pages
	jsr	print_both_pages


no_ferrari_message:
	rts




;=================================
;=================================
; Intro Segment 05 Data (Scanner)
;=================================
;=================================

.include "graphics/05_scanner/intro_scanner.inc"
.include "graphics/05_scanner/intro_scanning.inc"
.include "graphics/05_scanner/intro_ai_bg.inc"
.include "graphics/05_scanner/intro_ai.inc"


; Scanning sequence

scanning_sequence:
	.byte	15
	.word	scan01_lzsa
	.byte	128+15	;	.word	scan02_lzsa
	.byte	128+15	;	.word	scan03_lzsa
	.byte	128+15	;	.word	scan04_lzsa
	.byte	128+15	;	.word	scan05_lzsa
	.byte	128+15	;	.word	scan06_lzsa
	.byte	128+15	;	.word	scan07_lzsa
	.byte	128+15	;	.word	scan08_lzsa
	.byte	128+15	;	.word	scan09_lzsa
	.byte	128+15	;	.word	scan10_lzsa
	.byte	128+20	;	.word	scan11_lzsa
	.byte	128+20	;	.word	scan12_lzsa
	.byte	128+20	;	.word	scan13_lzsa
	.byte	128+20	;	.word	scan14_lzsa
	.byte	128+20	;	.word	scan15_lzsa
	.byte	128+20	;	.word	scan16_lzsa
	.byte	128+40	;	.word	scan17_lzsa
	.byte	128+40	;	.word	scan18_lzsa
	.byte	128+40	;	.word	scan19_lzsa
	.byte	40
	.word	scan19_lzsa
	.byte	0


; AI sequence

ai_sequence:
	.byte	0,50		; pause at start, no dna
	.word	ai01_lzsa	; slices

	.byte	0,50		; pause at start, no dna
	.word	ai02_lzsa	; slices_zoom

	.byte	0,50		; pasue as start, no dna
	.word	ai03_lzsa	; little circle

	.byte	0,50		; pause at start, no dna
	.word	ai04_lzsa	; big circle

	.byte	1,20		; pause longer, yes dna
	.word	ai05_lzsa	; key

	.byte	0,0
;	.word	ai05_lzsa	; key
;	.byte	0

static_pattern:
	.word	nothing_lzsa	; 0
	.word	nothing_lzsa	; 2
	.word	static01_lzsa	; 4
	.word	static03_lzsa	; 6
	.word	static02_lzsa	; 8
	.word	static01_lzsa	; 10

	; Scanning text

good_evening:
	.byte 2,21,"GOOD EVENING PROFESSOR.",0
ferrari:
	.byte 2,21,"I SEE YOU HAVE DRIVEN HERE IN YOUR",0
	.byte 2,22,"FERRARI.",0


dna_list:
	.word dna0_sprite
	.word dna1_sprite
	.word dna2_sprite
	.word dna3_sprite
	.word dna4_sprite
	.word dna5_sprite
	.word dna6_sprite
	.word dna7_sprite

dna0_sprite:
	.byte   $7,$2
	.byte   $66,$40,$40,$40,$40,$40,$cc
	.byte   $06,$00,$00,$00,$00,$00,$0c

dna1_sprite:
	.byte   $7,$2
	.byte   $00,$66,$40,$40,$40,$cc,$00
	.byte   $00,$06,$00,$00,$00,$0c,$00

dna2_sprite:
	.byte   $7,$2
	.byte   $00,$00,$66,$40,$cc,$00,$00
	.byte   $00,$00,$06,$00,$0c,$00,$00

dna3_sprite:
	.byte   $7,$2
	.byte   $00,$00,$00,$66,$00,$00,$00
	.byte   $00,$00,$00,$06,$00,$00,$00

dna4_sprite:
	.byte   $7,$2
	.byte   $00,$00,$CC,$40,$66,$00,$00
	.byte   $00,$00,$0C,$00,$06,$00,$00

dna5_sprite:
	.byte   $7,$2
	.byte   $00,$CC,$40,$40,$40,$66,$00
	.byte   $00,$0C,$00,$00,$00,$06,$00

dna6_sprite:
	.byte   $7,$2
	.byte   $CC,$40,$40,$40,$40,$40,$66
	.byte   $0C,$00,$00,$00,$00,$00,$06

dna7_sprite:
	.byte   $7,$2
	.byte   $66,$40,$40,$40,$40,$40,$cc
	.byte   $06,$00,$00,$00,$00,$00,$0c

