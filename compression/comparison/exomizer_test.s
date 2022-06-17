.include "zp.inc"
.include "hardware.inc"

exomizer_test:

        bit     SET_GR
        bit     PAGE1
        bit     HIRES
        bit     FULLGR

	lda	#<data_begin
	sta	_byte_lo
	lda	#>data_begin
	sta	_byte_hi

	jsr	decrunch

.if 0

;	lda	#<data_begin
;	sta	zp_src_lo
;	lda	#>data_begin
;	sta	zp_src_hi


	lda   #$1F
        pha
        lda   #>(data_end)	; sizehi2
        pha
        lda   #<(data_end)	; sizelo2
        pha
        lda   #>(start_d-1)		; #>(@loaddecrunch - 1)
        pha
        lda   #<(start_d-1)		; #<(@loaddecrunch - 1)
        pha

	jmp	decrunch_table


;decrunch_table:
;!warn "entry=",*
;        pla			; <loaddecrunch
 ;       tay

;        pla			; >loaddecrunch
;        tax
;        clc

;        pla			; sizelo2
;        adc #$F8
;        sta _byte_lo

;        pla			;sizehi2
;        sta zp_bitbuf

;        pla			;#$1F
;        adc zp_bitbuf
;        sta _byte_hi

;        txa
;        pha

;        tya
 ;       pha

 ;       jmp decrunch




;	jsr	decrunch

.endif

end:
	jmp	end


get_crunched_byte:
_byte_lo = * + 1
_byte_hi = * + 2
         lda $1234        ; needs to be set correctly before
                          ; decrunch_file is called.
         inc _byte_lo
         bne _byte_skip_hi
         inc _byte_hi
_byte_skip_hi:
         rts

start_d:

.include "exodecrunch.s"


data_begin:
.byte $20,$00
.incbin "level5.exo"
data_end:
