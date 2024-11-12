WaitForKeyWithTimeout:
; in:    A = timeout length (like standard $FCA8 wait routine)
; out:   A clobbered (not always 0 if key is pressed, but also not the key pressed)
;        X/Y preserved
         sec
wait1:   pha
wait2:   sbc   #1
         bne   wait2
         pla
         bit   KBD
         bmi   wfk_exit
         sbc   #1
         bne   wait1
wfk_exit:    rts
