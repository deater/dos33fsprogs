        ;=====================
        ; long(er) wait
        ; waits approximately X*10 ms
        ; X=100 1s
        ; X=4 = 40ms= 1/25s
long_wait:
        lda     #60
        jsr     WAIT                    ; delay
        dex
        bne     long_wait
        rts
