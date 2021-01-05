; Title Screen / Menu for OOTW

.include "zp.inc"
.include "hardware.inc"

title:
	bit	SET_GR
	bit	LORES
	bit	TEXTGR
	bit	PAGE0
	lda	#0
	sta	DRAW_PAGE

	lda     #>(logo_rle)
        sta     GBASH
        lda     #<(logo_rle)
        sta     GBASL
        lda     #$04                    ; load image off-screen $c00
        jsr     load_rle_gr

	lda     #<title_text
        sta     OUTL
        lda     #>title_text
        sta     OUTH
        jsr     move_and_print_list


title_loop:
	lda	#0
	sta	WHICH_LOAD

wait_for_keypress:
	lda     KEYPRESS
	bpl	wait_for_keypress
	bit	KEYRESET

ready_to_load:
	jmp	$1400			; LOADER starts here

.include "text_print.s"
.include "gr_offsets.s"
.include "gr_unrle.s"

.include "ootw_graphics/logo.inc"

title_text:
.byte 13,20,             "______",0
.byte  0,21,"BY DEATER, A \/\/\/ SOFTWARE PRODUCTION",0
.byte 26,22,",",0
.byte  4,23,"APOLOGIES TO CYAN AND ERIC CHAHI",0
.byte 255

.align $100
.byte 1
.align $100
.byte 1
.align $100
.byte 1
.align $100


.include "loader.s"
