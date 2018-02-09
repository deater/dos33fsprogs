;; Our Zero Page Allocations

;; for the LZSS part of the code

OUTPUTL   EQU $FE
OUTPUTH   EQU $FF
LOGOL     EQU $28
LOGOH     EQU $29
STORERL   EQU $95
STORERH   EQU $96
COUNT     EQU $97
;LZSS_MASK	EQU	$98
LOGOENDL  EQU $99
LOGOENDH  EQU $9A
LOADRL    EQU $9B
LOADRH    EQU $9C
EFFECTRL  EQU $9D
EFFECTRH  EQU $9E


;; LZSS Parameters

N  	      EQU 1024
F     	      EQU 64
THRESHOLD     EQU 2
P_BITS	      EQU 10
POSITION_MASK EQU 3
FREQUENT_CHAR EQU 0

;R:  		  .res (1024-64)	; N-F

R		EQU	$9800

	; Init
lzss_init:
	ldx	#<R
	stx	OUTL
	ldx	#>R
	stx	OUTH

	lda	#FREQUENT_CHAR
	ldx	#$4
lzss_init_outer:
	ldy	#$0
lzss_init_inner:
	sta	(OUTL),Y
	iny
	bne	lzss_init_inner
	inc	OUTH
	dex
	bpl	lzss_init_inner

	rts

	;================================
	; Decomress
	; FIXME: optimize
	;================================

lzss_decompress:

	lda	#>(N-F)			; load R value
	sta	STORERH
	lda	#<(N-F)
	sta	STORERL

	ldy	#0			; setup Y for indirect zero page
					; addressing, we always want +0

decompression_loop:

   	lda	#8                  	; set mask counter
	sta	COUNT

	lda	(LOGOL),Y		; load byte

	sta	LZSS_MASK		; store it

	ldx	#LOGOL
	jsr	inc16 			; increment pointer

test_flags:

	lda	LOGOH			; compare to see if we've reached end
	cmp	LOGOENDH
	bne	not_match

	lda	LOGOL
	cmp	LOGOENDL

	beq	done_logo 		; if so, we are done
					; bcs one byte less than jmp

not_match:
        lsr	LZSS_MASK		; shift byte mask into carry flag

	lda	(LOGOL),Y               ; load byte

        ldx	#LOGOL                  ; 16-bit increrment
	jsr	inc16

        bcs	discrete_char		; if set we have discrete char

offset_length:

	sta	LOADRL			; bottom of R offset

	lda	(LOGOL),Y               ; load another byte

	ldx	#LOGOL                  ;
	jsr	inc16			; 16 bit increment

	sta	LOADRH			; top of R offset

	lsr	A
	lsr	A			; shift right by 10 (top byte by 2)

   	clc
	adc	#3			; add threshold+1 (3)

	tax				; store out count in X

output_loop:

	clc 				; calculate R+LOADR
	lda	LOADRL
	adc	#<R
	sta	EFFECTRL

	lda	LOADRH
	and	#((N-1)>>8)		; Mask so mod N
        sta	LOADRH

	adc	#>R
	sta	EFFECTRH

        lda	(EFFECTRL),Y		; Load byte R[LOADR]

  	inc     LOADRL			; increment address
        bne	load_carry1
        inc	LOADRH	 		; handle overflow
load_carry1:

store_byte:
	sta     (OUTPUTL),Y		 ; store byte to output
	inc     OUTPUTL			 ; increment address
        bne	sb_carry
        inc	OUTPUTH	 		 ; handle overflow
sb_carry:
	pha	     			 ; calculate R+STORER
	clc
        lda	STORERL
	adc	#<R
	sta	EFFECTRL

	lda	STORERH
	and	#((N-1)>>8)		 ; mask so mod N

	sta	STORERH
	adc	#>R
	sta	EFFECTRH

	pla				 ; restore from stack

	sta	(EFFECTRL),Y		 ; store A there too

	inc     STORERL			 ; increment address
        bne	store_carry2
        inc	STORERH	 		 ; handle overflow
store_carry2:

	dex  			         ; count down the out counter
	bne	output_loop		 ; loop to output_loop if not 0

	dec	COUNT			 ; count down the mask counter
	bne	test_flags		 ; loop to test_flags if not zero

	beq	decompression_loop	 ; restart whole process

discrete_char:
	ldx	#1   			 ; want to write a single byte

        bne	store_byte		 ; go and store it (1 byte less than jmp)

done_logo:
	rts


;==================================================
; inc16 - increments a 16-bit pointer in zero page
;==================================================

inc16:
        inc     0,X                	 ; increment address
	bne     not_zero
	inx
	inc     0,X			 ; handle overflow
not_zero:
	rts


;; *********************
;; BSS
;; *********************
;.bss

;R:  		  .res (1024-64)	; N-F



