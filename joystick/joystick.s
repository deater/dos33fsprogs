; Oliver Schmidt
; comp.sys.apple2.programmer

; Call with joystick number (0 or 1) in A.
; Results are stored in value0 and value1.
; UPPER_THRESHOLD is the paddle value you want to consider as "right enough" /
; "down enough".

UPPER_THRESHOLD = 128

;PTRIG = $c070
PADDL1 = $C065

handle_joystick:
	lda	#0

        ; Read both paddles simultaneously
        asl                     ; Joystick number -> paddle number
        tax
        ldy     #$00
        sty     value0
        sty     value1
        lda     PTRIG           ; Trigger paddles
loop:   lda     PADDL0,x        ; Read paddle (0 or 2)
        bmi     set0            ; Cycles:   2   3
        nop                     ; Cycles:   2
        bpl     nop0            ; Cycles:   3
set0:   sty     value0          ; Cycles:       4
nop0:                           ;           -   -
                               ; Cycles:   7   7
        lda     PADDL1,x        ; Read paddle (1 or 3)
        bmi     set1            ; Cycles:   2   3
        nop                     ; Cycles:   2
        bpl     nop1            ; Cycles:   3
set1:   sty     value1          ; Cycles:       4
nop1:                           ;           -   -
                                ; Cycles:   7   7
        iny
        cpy     #UPPER_THRESHOLD+1
        bne     loop

	rts

value0:	.byte	$00
value1:	.byte	$00

