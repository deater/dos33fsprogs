;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    UNSIGNED DIVIDE BY 10 (16 BIT)
;    By Omegamatrix
;    126 cycles (max), 79 bytes
;
;    Start with 16 bit value in counterHigh, counterLow
;    End with 16 bit result in highTen, lowTen
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

TensRemaining:
    .byte 0,25,51,76,102,128,153,179,204,230
ModRemaing:
    .byte 0,6,2,8,4,0,6,2,8,4

startDivideBy10:
    ldy    #-2                   ;2  @2   skips a branch the first time through
    lda    counterHigh           ;3  @5
do8bitDiv:
    sta    temp                  ;3  @8
    lsr                          ;2  @10
    adc    #13                   ;2  @12
    adc    temp                  ;3  @15
    ror                          ;2  @17
    lsr                          ;2  @19
    lsr                          ;2  @21
    adc    temp                  ;3  @24
    ror                          ;2  @26
    adc    temp                  ;3  @29
    ror                          ;2  @31
    lsr                          ;2  @33
    and    #$7C                  ;2  @35   AND'ing here...
    sta    temp                  ;3  @38   and saving result as highTen (times 4)
    lsr                          ;2  @40
    lsr                          ;2  @42
    iny                          ;2  @44
    bpl    finishLowTen          ;2/3 @46/47...120

    sta    highTen               ;3  @49
    adc    temp                  ;3  @52   highTen (times 5)
    asl                          ;2  @54   highTen (times 10)
    sbc    counterHigh           ;3  @57
    eor    #$FF                  ;2  @59
    tay                          ;2  @61   mod 10 result!

    lda    TensRemaining,Y       ;4  @65   Fill the low byte with the tens it should
    sta    lowTen                ;3  @68   have at this point from the high byte divide.
    lda    counterLow            ;3  @71
    adc    ModRemaing,Y          ;4  @75
    bcc    do8bitDiv             ;2/3 @77/78

overflowFound:
    cmp    #4                    ;2  @79   We have overflowed, but we can apply a shortcut.
    lda    #25                   ;2  @81   Divide by 10 will be at least 25, and the
                                 ;         carry is set when higher for the next addition.
finishLowTen:
    adc    lowTen                ;3  @123
    sta    lowTen                ;3  @126  routine ends at either 87 or 126 cycles

	rts
