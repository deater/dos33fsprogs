; alternate implementation by Oliver Schmidt
; from https://github.com/cc65/cc65/blob/master/libsrc/apple2/waitvsync.s

wait_vblank_iic:
;       sei                     ; disables interrupts
        sta     IOUDISOFF
        lda     RDVBLMSK
        bit     ENVBL
        bit     PTRIG           ; Reset VBL interrupt flag
:       bit     RDVBLBAR
        bpl     :-
        asl
        bcs     :+              ; VBL interrupts were already enabled
        bit     DISVBL
:       sta     IOUDISON        ; IIc Tech Ref Man: The firmware normally leaves IOUDIS on.
;       cli                     ; re-enable interrupts

        rts



	;===========================
        ; wait for vblank on IIgs
        ; opposte of IIe?
wait_vblank_iigs:
        lda     VBLANK
        bpl     wait_vblank_iigs        ; wait for negative (in vblank)
wait_vblank_done_iigs:
        lda     VBLANK                  ; wait for positive (vlank done)
        bmi     wait_vblank_done_iigs
	rts

	;===========================
        ; wait for vblank on IIe
wait_vblank_iie:
        lda     VBLANK
        bmi     wait_vblank_iie         ; wait for positive (in vblank)
wait_vblank_done_iie:
        lda     VBLANK                  ; wait for negative (vlank done)
        bpl     wait_vblank_done_iie
	rts


