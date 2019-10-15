
	; want colors 01234567
	; line 0: $X0 to $800
	; line 1: $X1 to $400
	; line 2: $X2
	; line 3: $X3
	; line 4: $4X
	; line 5: $5X
	; line 6: $6X
	; line 7: $7X

	; UNROLL 96 TIMES!  ARE WE MAD?  YES!

;=========
; 0(0) = $400
	; 65 cycles total
	bit	PAGE0	; 4
	lda	#$0b	; 2
	sta	$800	; 4
	sta	$801	; 4
	sta	$802	; 4
	sta	$803	; 4
	sta	$804	; 4
	sta	$805	; 4
	sta	$806	; 4
	sta	$807	; 4
	sta	$808	; 4
	sta	$809	; 4
	sta	$80a	; 4
	sta	$80b	; 4
	sta	$80c	; 4
	sta	$80d	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$0f	; 2
	sta	$400	; 4
	sta	$401	; 4
	sta	$402	; 4
	sta	$403	; 4
	sta	$404	; 4
	sta	$405	; 4
	sta	$406	; 4
	sta	$407	; 4
	sta	$408	; 4
	sta	$409	; 4
	sta	$40a	; 4
	sta	$40b	; 4
	sta	$40c	; 4
	sta	$40d	; 4
	lda	TEMP	; 3


; 1
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$0b	; 2
	sta	$800	; 4
	sta	$801	; 4
	sta	$802	; 4
	sta	$803	; 4
	sta	$804	; 4
	sta	$805	; 4
	sta	$806	; 4
	sta	$807	; 4
	sta	$808	; 4
	sta	$809	; 4
	sta	$80a	; 4
	sta	$80b	; 4
	sta	$80c	; 4
	sta	$80d	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$30	; 2
	sta	$400	; 4
	sta	$401	; 4
	sta	$402	; 4
	sta	$403	; 4
	sta	$404	; 4
	sta	$405	; 4
	sta	$406	; 4
	sta	$407	; 4
	sta	$408	; 4
	sta	$409	; 4
	sta	$40a	; 4
	sta	$40b	; 4
	sta	$40c	; 4
	sta	$40d	; 4
	lda	TEMP	; 3

; 2
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$800	; 4
	sta	$801	; 4
	sta	$802	; 4
	sta	$803	; 4
	sta	$804	; 4
	sta	$805	; 4
	sta	$806	; 4
	sta	$807	; 4
	sta	$808	; 4
	sta	$809	; 4
	sta	$80a	; 4
	sta	$80b	; 4
	sta	$80c	; 4
	sta	$80d	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$400	; 4
	sta	$401	; 4
	sta	$402	; 4
	sta	$403	; 4
	sta	$404	; 4
	sta	$405	; 4
	sta	$406	; 4
	sta	$407	; 4
	sta	$408	; 4
	sta	$409	; 4
	sta	$40a	; 4
	sta	$40b	; 4
	sta	$40c	; 4
	sta	$40d	; 4
	lda	TEMP	; 3

; 3
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$800	; 4
	sta	$801	; 4
	sta	$802	; 4
	sta	$803	; 4
	sta	$804	; 4
	sta	$805	; 4
	sta	$806	; 4
	sta	$807	; 4
	sta	$808	; 4
	sta	$809	; 4
	sta	$80a	; 4
	sta	$80b	; 4
	sta	$80c	; 4
	sta	$80d	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$400	; 4
	sta	$401	; 4
	sta	$402	; 4
	sta	$403	; 4
	sta	$404	; 4
	sta	$405	; 4
	sta	$406	; 4
	sta	$407	; 4
	sta	$408	; 4
	sta	$409	; 4
	sta	$40a	; 4
	sta	$40b	; 4
	sta	$40c	; 4
	sta	$40d	; 4
	lda	TEMP	; 3

;===================
; 4 (L1)=$480
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$880	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$480	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

; 5
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$880	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$480	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 6
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$880	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$480	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 7
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$880	; 4
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$500	; 4
	lda	#$00	; 2
	sta	$501	; 4
	lda	#$00	; 2
	sta	$502	; 4
	lda	#$00	; 2
	sta	$503	; 4
	lda	#$00	; 2
	sta	$504	; 4
	lda	#$00	; 2
	sta	$505	; 4
	lda	#$00	; 2
	sta	$506	; 4
	lda	#$00	; 2
	sta	$507	; 4
	lda	#$00	; 2
	sta	$508	; 4
	bit	krg	; 4
	lda	TEMP	; 3

;================================
; 8 (L2) = $500

	; 65 cycles
	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$902	; 4
	lda	#$00	; 2
	sta	$903	; 4
	lda	#$00	; 2
	sta	$904	; 4
	lda	#$00	; 2
	sta	$905	; 4
	lda	#$00	; 2
	sta	$906	; 4
	lda	#$00	; 2
	sta	$907	; 4
	lda	#$00	; 2
	sta	$908	; 4
	lda	#$00	; 2
	sta	$909	; 4
	lda	#$00	; 2
	sta	$90a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$502	; 4
	lda	#$00	; 2
	sta	$503	; 4
	lda	#$00	; 2
	sta	$504	; 4
	lda	#$00	; 2
	sta	$505	; 4
	lda	#$00	; 2
	sta	$506	; 4
	lda	#$00	; 2
	sta	$507	; 4
	lda	#$00	; 2
	sta	$508	; 4
	lda	#$00	; 2
	sta	$509	; 4
	lda	#$00	; 2
	sta	$50a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

; 9
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$902	; 4
	lda	#$00	; 2
	sta	$903	; 4
	lda	#$00	; 2
	sta	$904	; 4
	lda	#$00	; 2
	sta	$905	; 4
	lda	#$00	; 2
	sta	$906	; 4
	lda	#$00	; 2
	sta	$907	; 4
	lda	#$00	; 2
	sta	$908	; 4
	lda	#$00	; 2
	sta	$909	; 4
	lda	#$00	; 2
	sta	$90a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$502	; 4
	lda	#$00	; 2
	sta	$503	; 4
	lda	#$00	; 2
	sta	$504	; 4
	lda	#$10	; 2
	sta	$505	; 4
	lda	#$10	; 2
	sta	$506	; 4
	lda	#$10	; 2
	sta	$507	; 4
	lda	#$00	; 2
	sta	$508	; 4
	lda	#$00	; 2
	sta	$509	; 4
	lda	#$00	; 2
	sta	$50a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

; 10
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$902	; 4
	lda	#$00	; 2
	sta	$903	; 4
	lda	#$00	; 2
	sta	$904	; 4
	lda	#$90	; 2
	sta	$905	; 4
	lda	#$90	; 2
	sta	$906	; 4
	lda	#$90	; 2
	sta	$907	; 4
	lda	#$00	; 2
	sta	$908	; 4
	lda	#$00	; 2
	sta	$909	; 4
	lda	#$00	; 2
	sta	$90a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$502	; 4
	lda	#$00	; 2
	sta	$503	; 4
	lda	#$10	; 2
	sta	$504	; 4
	lda	#$d0	; 2
	sta	$505	; 4
	lda	#$d0	; 2
	sta	$506	; 4
	lda	#$d0	; 2
	sta	$507	; 4
	lda	#$10	; 2
	sta	$508	; 4
	lda	#$00	; 2
	sta	$509	; 4
	lda	#$00	; 2
	sta	$50a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

; 11
	; 65 cycles
	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$902	; 4
	lda	#$00	; 2
	sta	$903	; 4
	lda	#$90	; 2
	sta	$904	; 4
	lda	#$40	; 2
	sta	$905	; 4
	lda	#$40	; 2
	sta	$906	; 4
	lda	#$40	; 2
	sta	$907	; 4
	lda	#$90	; 2
	sta	$908	; 4
	lda	#$00	; 2
	sta	$909	; 4
	lda	#$00	; 2
	sta	$90a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$582	; 4
	lda	#$01	; 2
	sta	$583	; 4
	lda	#$0d	; 2
	sta	$584	; 4
	lda	#$06	; 2
	sta	$585	; 4
	lda	#$06	; 2
	sta	$586	; 4
	lda	#$06	; 2
	sta	$587	; 4
	lda	#$0d	; 2
	sta	$588	; 4
	lda	#$01	; 2
	sta	$589	; 4
	lda	#$00	; 2
	sta	$58a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

;================================
; 12 (L3) = $580

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$982	; 4
	lda	#$09	; 2
	sta	$983	; 4
	lda	#$04	; 2
	sta	$984	; 4
	lda	#$02	; 2
	sta	$985	; 4
	lda	#$02	; 2
	sta	$986	; 4
	lda	#$02	; 2
	sta	$987	; 4
	lda	#$04	; 2
	sta	$988	; 4
	lda	#$09	; 2
	sta	$989	; 4
	lda	#$00	; 2
	sta	$98a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$01	; 2
	sta	$582	; 4
	lda	#$0d	; 2
	sta	$583	; 4
	lda	#$06	; 2
	sta	$584	; 4
	lda	#$00	; 2
	sta	$585	; 4
	lda	#$00	; 2
	sta	$586	; 4
	lda	#$00	; 2
	sta	$587	; 4
	lda	#$06	; 2
	sta	$588	; 4
	lda	#$0d	; 2
	sta	$589	; 4
	lda	#$01	; 2
	sta	$58a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

; 13

	bit	PAGE0	; 4
	lda	#$09	; 2
	sta	$982	; 4
	lda	#$04	; 2
	sta	$983	; 4
	lda	#$02	; 2
	sta	$984	; 4
	lda	#$00	; 2
	sta	$985	; 4
	lda	#$00	; 2
	sta	$986	; 4
	lda	#$00	; 2
	sta	$987	; 4
	lda	#$02	; 2
	sta	$988	; 4
	lda	#$04	; 2
	sta	$989	; 4
	lda	#$09	; 2
	sta	$98a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$d0	; 2
	sta	$582	; 4
	lda	#$60	; 2
	sta	$583	; 4
	lda	#$00	; 2
	sta	$584	; 4
	lda	#$00	; 2
	sta	$585	; 4
	lda	#$00	; 2
	sta	$586	; 4
	lda	#$00	; 2
	sta	$587	; 4
	lda	#$00	; 2
	sta	$588	; 4
	lda	#$60	; 2
	sta	$589	; 4
	lda	#$d0	; 2
	sta	$58a	; 4
	bit	krg	; 4
	lda	TEMP	; 3


; 14
	bit	PAGE0	; 4
	lda	#$40	; 2
	sta	$982	; 4
	lda	#$20	; 2
	sta	$983	; 4
	lda	#$00	; 2
	sta	$984	; 4
	lda	#$00	; 2
	sta	$985	; 4
	lda	#$00	; 2
	sta	$986	; 4
	lda	#$00	; 2
	sta	$987	; 4
	lda	#$00	; 2
	sta	$988	; 4
	lda	#$20	; 2
	sta	$989	; 4
	lda	#$40	; 2
	sta	$98a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$60	; 2
	sta	$582	; 4
	lda	#$00	; 2
	sta	$583	; 4
	lda	#$00	; 2
	sta	$584	; 4
	lda	#$00	; 2
	sta	$585	; 4
	lda	#$00	; 2
	sta	$586	; 4
	lda	#$00	; 2
	sta	$587	; 4
	lda	#$00	; 2
	sta	$588	; 4
	lda	#$00	; 2
	sta	$589	; 4
	lda	#$60	; 2
	sta	$58a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

; 15

	bit	PAGE0	; 4
	lda	#$20	; 2
	sta	$982	; 4
	lda	#$00	; 2
	sta	$983	; 4
	lda	#$00	; 2
	sta	$984	; 4
	lda	#$00	; 2
	sta	$985	; 4
	lda	#$00	; 2
	sta	$986	; 4
	lda	#$00	; 2
	sta	$987	; 4
	lda	#$00	; 2
	sta	$988	; 4
	lda	#$00	; 2
	sta	$989	; 4
	lda	#$20	; 2
	sta	$98a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$602	; 4
	lda	#$00	; 2
	sta	$603	; 4
	lda	#$00	; 2
	sta	$604	; 4
	lda	#$00	; 2
	sta	$605	; 4
	lda	#$00	; 2
	sta	$606	; 4
	lda	#$00	; 2
	sta	$607	; 4
	lda	#$00	; 2
	sta	$608	; 4
	lda	#$00	; 2
	sta	$609	; 4
	lda	#$00	; 2
	sta	$60a	; 4
	bit	krg	; 4
	lda	TEMP	; 3


;================================
; 16 (L4) = $600


	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$a02	; 4
	lda	#$00	; 2
	sta	$a03	; 4
	lda	#$00	; 2
	sta	$a04	; 4
	lda	#$00	; 2
	sta	$a05	; 4
	lda	#$05	; 2
	sta	$a06	; 4
	lda	#$00	; 2
	sta	$a07	; 4
	lda	#$00	; 2
	sta	$a08	; 4
	lda	#$00	; 2
	sta	$a09	; 4
	lda	#$20	; 2
	sta	$a0a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$602	; 4
	lda	#$00	; 2
	sta	$603	; 4
	lda	#$00	; 2
	sta	$604	; 4
	lda	#$00	; 2
	sta	$605	; 4
	lda	#$07	; 2
	sta	$606	; 4
	lda	#$00	; 2
	sta	$607	; 4
	lda	#$00	; 2
	sta	$608	; 4
	lda	#$00	; 2
	sta	$609	; 4
	lda	#$00	; 2
	sta	$60a	; 4
	bit	krg	; 4
	lda	TEMP	; 3


; 17
	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$a02	; 4
	lda	#$00	; 2
	sta	$a03	; 4
	lda	#$00	; 2
	sta	$a04	; 4
	lda	#$00	; 2
	sta	$a05	; 4
	lda	#$0f	; 2
	sta	$a06	; 4
	lda	#$00	; 2
	sta	$a07	; 4
	lda	#$00	; 2
	sta	$a08	; 4
	lda	#$00	; 2
	sta	$a09	; 4
	lda	#$00	; 2
	sta	$a0a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$602	; 4
	lda	#$00	; 2
	sta	$603	; 4
	lda	#$00	; 2
	sta	$604	; 4
	lda	#$80	; 2
	sta	$605	; 4
	lda	#$80	; 2
	sta	$606	; 4
	lda	#$80	; 2
	sta	$607	; 4
	lda	#$00	; 2
	sta	$608	; 4
	lda	#$00	; 2
	sta	$609	; 4
	lda	#$40	; 2
	sta	$60a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

; 18

	bit	PAGE0	; 4
	lda	#$b0	; 2
	sta	$a02	; 4
	lda	#$e0	; 2
	sta	$a03	; 4
	lda	#$e0	; 2
	sta	$a04	; 4
	lda	#$e0	; 2
	sta	$a05	; 4
	lda	#$e0	; 2
	sta	$a06	; 4
	lda	#$e0	; 2
	sta	$a07	; 4
	lda	#$c0	; 2
	sta	$a08	; 4
	lda	#$c0	; 2
	sta	$a09	; 4
	lda	#$40	; 2
	sta	$a0a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$30	; 2
	sta	$602	; 4
	lda	#$e0	; 2
	sta	$603	; 4
	lda	#$e0	; 2
	sta	$604	; 4
	lda	#$e0	; 2
	sta	$605	; 4
	lda	#$e0	; 2
	sta	$606	; 4
	lda	#$e0	; 2
	sta	$607	; 4
	lda	#$c0	; 2
	sta	$608	; 4
	lda	#$c0	; 2
	sta	$609	; 4
	lda	#$c0	; 2
	sta	$60a	; 4
	bit	krg	; 4
	lda	TEMP	; 3

; 19
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3


;================================
; 20 (L5) = $680

	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

; 21
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

; 22
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

; 23
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3


;================================
; 24 (L6) = $700

	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

; 25
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

; 26
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

; 27
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

;================================
; 28 (L7) = $780

	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

; 29
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

; 30
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 31
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 32
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 33
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 34
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 35
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 36
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 37
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 38
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 39
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 40
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 41
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 42
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 43
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 44
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 45
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 46
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 47
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 48
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 49
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 50
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 51
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 52
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 53
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 54
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 55
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 56
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 57
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 58
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 59
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 60
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 61
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 62
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	; 63
	bit	PAGE0						; 4
	; 65 cycles
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	inc	krg	; 6
	bit	krg	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$03	; 2
	sta	$450	; 4
	sta	$451	; 4
	sta	$452	; 4
	sta	$453	; 4
	sta	$454	; 4
	sta	$455	; 4
	sta	$456	; 4
	sta	$457	; 4
	sta	$458	; 4
	sta	$459	; 4
	sta	$45a	; 4
	sta	$45b	; 4
	sta	$45c	; 4
	sta	$45d	; 4
	lda	TEMP	; 3

;=========
; 64(L16) = $450

	bit	PAGE0	; 4
	lda	#$0b	; 2
	sta	$850	; 4
	sta	$851	; 4
	sta	$852	; 4
	sta	$853	; 4
	sta	$854	; 4
	sta	$855	; 4
	sta	$856	; 4
	sta	$857	; 4
	sta	$858	; 4
	sta	$859	; 4
	sta	$85a	; 4
	sta	$85b	; 4
	sta	$85c	; 4
	sta	$85d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$0f	; 2
	sta	$450	; 4
	sta	$451	; 4
	sta	$452	; 4
	sta	$453	; 4
	sta	$454	; 4
	sta	$455	; 4
	sta	$456	; 4
	sta	$457	; 4
	sta	$458	; 4
	sta	$459	; 4
	sta	$45a	; 4
	sta	$45b	; 4
	sta	$45c	; 4
	sta	$45d	; 4
	lda	TEMP	; 3

; 65
	bit	PAGE0	; 4
	lda	#$0b	; 2
	sta	$850	; 4
	sta	$851	; 4
	sta	$852	; 4
	sta	$853	; 4
	sta	$854	; 4
	sta	$855	; 4
	sta	$856	; 4
	sta	$857	; 4
	sta	$858	; 4
	sta	$859	; 4
	sta	$85a	; 4
	sta	$85b	; 4
	sta	$85c	; 4
	sta	$85d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$30	; 2
	sta	$450	; 4
	sta	$451	; 4
	sta	$452	; 4
	sta	$453	; 4
	sta	$454	; 4
	sta	$455	; 4
	sta	$456	; 4
	sta	$457	; 4
	sta	$458	; 4
	sta	$459	; 4
	sta	$45a	; 4
	sta	$45b	; 4
	sta	$45c	; 4
	sta	$45d	; 4
	lda	TEMP	; 3

; 66

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$850	; 4
	sta	$851	; 4
	sta	$852	; 4
	sta	$853	; 4
	sta	$854	; 4
	sta	$855	; 4
	sta	$856	; 4
	sta	$857	; 4
	sta	$858	; 4
	sta	$859	; 4
	sta	$85a	; 4
	sta	$85b	; 4
	sta	$85c	; 4
	sta	$85d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$450	; 4
	sta	$451	; 4
	sta	$452	; 4
	sta	$453	; 4
	sta	$454	; 4
	sta	$455	; 4
	sta	$456	; 4
	sta	$457	; 4
	sta	$458	; 4
	sta	$459	; 4
	sta	$45a	; 4
	sta	$45b	; 4
	sta	$45c	; 4
	sta	$45d	; 4
	lda	TEMP	; 3

; 67

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$850	; 4
	sta	$851	; 4
	sta	$852	; 4
	sta	$853	; 4
	sta	$854	; 4
	sta	$855	; 4
	sta	$856	; 4
	sta	$857	; 4
	sta	$858	; 4
	sta	$859	; 4
	sta	$85a	; 4
	sta	$85b	; 4
	sta	$85c	; 4
	sta	$85d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$02	; 2
	sta	$4d0	; 4
	sta	$4d1	; 4
	sta	$4d2	; 4
	sta	$4d3	; 4
	sta	$4d4	; 4
	sta	$4d5	; 4
	sta	$4d6	; 4
	sta	$4d7	; 4
	sta	$4d8	; 4
	sta	$4d9	; 4
	sta	$4da	; 4
	sta	$4db	; 4
	sta	$4dc	; 4
	sta	$4dd	; 4
	lda	TEMP	; 3

;=========
; 68(L17) = $4d0

	bit	PAGE0	; 4
	lda	#$06	; 2
	sta	$8d0	; 4
	sta	$8d1	; 4
	sta	$8d2	; 4
	sta	$8d3	; 4
	sta	$8d4	; 4
	sta	$8d5	; 4
	sta	$8d6	; 4
	sta	$8d7	; 4
	sta	$8d8	; 4
	sta	$8d9	; 4
	sta	$8da	; 4
	sta	$8db	; 4
	sta	$8dc	; 4
	sta	$8dd	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$0f	; 2
	sta	$4d0	; 4
	sta	$4d1	; 4
	sta	$4d2	; 4
	sta	$4d3	; 4
	sta	$4d4	; 4
	sta	$4d5	; 4
	sta	$4d6	; 4
	sta	$4d7	; 4
	sta	$4d8	; 4
	sta	$4d9	; 4
	sta	$4da	; 4
	sta	$4db	; 4
	sta	$4dc	; 4
	sta	$4dd	; 4
	lda	TEMP	; 3

; 69

	bit	PAGE0	; 4
	lda	#$06	; 2
	sta	$8d0	; 4
	sta	$8d1	; 4
	sta	$8d2	; 4
	sta	$8d3	; 4
	sta	$8d4	; 4
	sta	$8d5	; 4
	sta	$8d6	; 4
	sta	$8d7	; 4
	sta	$8d8	; 4
	sta	$8d9	; 4
	sta	$8da	; 4
	sta	$8db	; 4
	sta	$8dc	; 4
	sta	$8dd	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$20	; 2
	sta	$4d0	; 4
	sta	$4d1	; 4
	sta	$4d2	; 4
	sta	$4d3	; 4
	sta	$4d4	; 4
	sta	$4d5	; 4
	sta	$4d6	; 4
	sta	$4d7	; 4
	sta	$4d8	; 4
	sta	$4d9	; 4
	sta	$4da	; 4
	sta	$4db	; 4
	sta	$4dc	; 4
	sta	$4dd	; 4
	lda	TEMP	; 3

; 70

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$8d0	; 4
	sta	$8d1	; 4
	sta	$8d2	; 4
	sta	$8d3	; 4
	sta	$8d4	; 4
	sta	$8d5	; 4
	sta	$8d6	; 4
	sta	$8d7	; 4
	sta	$8d8	; 4
	sta	$8d9	; 4
	sta	$8da	; 4
	sta	$8db	; 4
	sta	$8dc	; 4
	sta	$8dd	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$4d0	; 4
	sta	$4d1	; 4
	sta	$4d2	; 4
	sta	$4d3	; 4
	sta	$4d4	; 4
	sta	$4d5	; 4
	sta	$4d6	; 4
	sta	$4d7	; 4
	sta	$4d8	; 4
	sta	$4d9	; 4
	sta	$4da	; 4
	sta	$4db	; 4
	sta	$4dc	; 4
	sta	$4dd	; 4
	lda	TEMP	; 3

; 71

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$8d0	; 4
	sta	$8d1	; 4
	sta	$8d2	; 4
	sta	$8d3	; 4
	sta	$8d4	; 4
	sta	$8d5	; 4
	sta	$8d6	; 4
	sta	$8d7	; 4
	sta	$8d8	; 4
	sta	$8d9	; 4
	sta	$8da	; 4
	sta	$8db	; 4
	sta	$8dc	; 4
	sta	$8dd	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$04	; 2
	sta	$550	; 4
	sta	$551	; 4
	sta	$552	; 4
	sta	$553	; 4
	sta	$554	; 4
	sta	$555	; 4
	sta	$556	; 4
	sta	$557	; 4
	sta	$558	; 4
	sta	$559	; 4
	sta	$55a	; 4
	sta	$55b	; 4
	sta	$55c	; 4
	sta	$55d	; 4
	lda	TEMP	; 3


;=========
; 72(L18) = $550

	bit	PAGE0	; 4
	lda	#$0c	; 2
	sta	$950	; 4
	sta	$951	; 4
	sta	$952	; 4
	sta	$953	; 4
	sta	$954	; 4
	sta	$955	; 4
	sta	$956	; 4
	sta	$957	; 4
	sta	$958	; 4
	sta	$959	; 4
	sta	$95a	; 4
	sta	$95b	; 4
	sta	$95c	; 4
	sta	$95d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$0f	; 2
	sta	$550	; 4
	sta	$551	; 4
	sta	$552	; 4
	sta	$553	; 4
	sta	$554	; 4
	sta	$555	; 4
	sta	$556	; 4
	sta	$557	; 4
	sta	$558	; 4
	sta	$559	; 4
	sta	$55a	; 4
	sta	$55b	; 4
	sta	$55c	; 4
	sta	$55d	; 4
	lda	TEMP	; 3

; 73

	bit	PAGE0	; 4
	lda	#$0c	; 2
	sta	$950	; 4
	sta	$951	; 4
	sta	$952	; 4
	sta	$953	; 4
	sta	$954	; 4
	sta	$955	; 4
	sta	$956	; 4
	sta	$957	; 4
	sta	$958	; 4
	sta	$959	; 4
	sta	$95a	; 4
	sta	$95b	; 4
	sta	$95c	; 4
	sta	$95d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$40	; 2
	sta	$550	; 4
	sta	$551	; 4
	sta	$552	; 4
	sta	$553	; 4
	sta	$554	; 4
	sta	$555	; 4
	sta	$556	; 4
	sta	$557	; 4
	sta	$558	; 4
	sta	$559	; 4
	sta	$55a	; 4
	sta	$55b	; 4
	sta	$55c	; 4
	sta	$55d	; 4
	lda	TEMP	; 3

; 74

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$950	; 4
	sta	$951	; 4
	sta	$952	; 4
	sta	$953	; 4
	sta	$954	; 4
	sta	$955	; 4
	sta	$956	; 4
	sta	$957	; 4
	sta	$958	; 4
	sta	$959	; 4
	sta	$95a	; 4
	sta	$95b	; 4
	sta	$95c	; 4
	sta	$95d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$550	; 4
	sta	$551	; 4
	sta	$552	; 4
	sta	$553	; 4
	sta	$554	; 4
	sta	$555	; 4
	sta	$556	; 4
	sta	$557	; 4
	sta	$558	; 4
	sta	$559	; 4
	sta	$55a	; 4
	sta	$55b	; 4
	sta	$55c	; 4
	sta	$55d	; 4
	lda	TEMP	; 3

; 75

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$950	; 4
	sta	$951	; 4
	sta	$952	; 4
	sta	$953	; 4
	sta	$954	; 4
	sta	$955	; 4
	sta	$956	; 4
	sta	$957	; 4
	sta	$958	; 4
	sta	$959	; 4
	sta	$95a	; 4
	sta	$95b	; 4
	sta	$95c	; 4
	sta	$95d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$05	; 2
	sta	$5d0	; 4
	sta	$5d1	; 4
	sta	$5d2	; 4
	sta	$5d3	; 4
	sta	$5d4	; 4
	sta	$5d5	; 4
	sta	$5d6	; 4
	sta	$5d7	; 4
	sta	$5d8	; 4
	sta	$5d9	; 4
	sta	$5da	; 4
	sta	$5db	; 4
	sta	$5dc	; 4
	sta	$5dd	; 4
	lda	TEMP	; 3


;=========
; 76(L19) = $5d0

	bit	PAGE0	; 4
	lda	#$07	; 2
	sta	$9d0	; 4
	sta	$9d1	; 4
	sta	$9d2	; 4
	sta	$9d3	; 4
	sta	$9d4	; 4
	sta	$9d5	; 4
	sta	$9d6	; 4
	sta	$9d7	; 4
	sta	$9d8	; 4
	sta	$9d9	; 4
	sta	$9da	; 4
	sta	$9db	; 4
	sta	$9dc	; 4
	sta	$9dd	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$0f	; 2
	sta	$5d0	; 4
	sta	$5d1	; 4
	sta	$5d2	; 4
	sta	$5d3	; 4
	sta	$5d4	; 4
	sta	$5d5	; 4
	sta	$5d6	; 4
	sta	$5d7	; 4
	sta	$5d8	; 4
	sta	$5d9	; 4
	sta	$5da	; 4
	sta	$5db	; 4
	sta	$5dc	; 4
	sta	$5dd	; 4
	lda	TEMP	; 3

; 77

	bit	PAGE0	; 4
	lda	#$07	; 2
	sta	$9d0	; 4
	sta	$9d1	; 4
	sta	$9d2	; 4
	sta	$9d3	; 4
	sta	$9d4	; 4
	sta	$9d5	; 4
	sta	$9d6	; 4
	sta	$9d7	; 4
	sta	$9d8	; 4
	sta	$9d9	; 4
	sta	$9da	; 4
	sta	$9db	; 4
	sta	$9dc	; 4
	sta	$9dd	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$50	; 2
	sta	$5d0	; 4
	sta	$5d1	; 4
	sta	$5d2	; 4
	sta	$5d3	; 4
	sta	$5d4	; 4
	sta	$5d5	; 4
	sta	$5d6	; 4
	sta	$5d7	; 4
	sta	$5d8	; 4
	sta	$5d9	; 4
	sta	$5da	; 4
	sta	$5db	; 4
	sta	$5dc	; 4
	sta	$5dd	; 4
	lda	TEMP	; 3

; 78

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$9d0	; 4
	sta	$9d1	; 4
	sta	$9d2	; 4
	sta	$9d3	; 4
	sta	$9d4	; 4
	sta	$9d5	; 4
	sta	$9d6	; 4
	sta	$9d7	; 4
	sta	$9d8	; 4
	sta	$9d9	; 4
	sta	$9da	; 4
	sta	$9db	; 4
	sta	$9dc	; 4
	sta	$9dd	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$5d0	; 4
	sta	$5d1	; 4
	sta	$5d2	; 4
	sta	$5d3	; 4
	sta	$5d4	; 4
	sta	$5d5	; 4
	sta	$5d6	; 4
	sta	$5d7	; 4
	sta	$5d8	; 4
	sta	$5d9	; 4
	sta	$5da	; 4
	sta	$5db	; 4
	sta	$5dc	; 4
	sta	$5dd	; 4
	lda	TEMP	; 3

; 79

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$9d0	; 4
	sta	$9d1	; 4
	sta	$9d2	; 4
	sta	$9d3	; 4
	sta	$9d4	; 4
	sta	$9d5	; 4
	sta	$9d6	; 4
	sta	$9d7	; 4
	sta	$9d8	; 4
	sta	$9d9	; 4
	sta	$9da	; 4
	sta	$9db	; 4
	sta	$9dc	; 4
	sta	$9dd	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$01	; 2
	sta	$650	; 4
	sta	$651	; 4
	sta	$652	; 4
	sta	$653	; 4
	sta	$654	; 4
	sta	$655	; 4
	sta	$656	; 4
	sta	$657	; 4
	sta	$658	; 4
	sta	$659	; 4
	sta	$65a	; 4
	sta	$65b	; 4
	sta	$65c	; 4
	sta	$65d	; 4
	lda	TEMP	; 3


;=========
; 80(L20) = $650

	bit	PAGE0	; 4
	lda	#$03	; 2
	sta	$a50	; 4
	sta	$a51	; 4
	sta	$a52	; 4
	sta	$a53	; 4
	sta	$a54	; 4
	sta	$a55	; 4
	sta	$a56	; 4
	sta	$a57	; 4
	sta	$a58	; 4
	sta	$a59	; 4
	sta	$a5a	; 4
	sta	$a5b	; 4
	sta	$a5c	; 4
	sta	$a5d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$0f	; 2
	sta	$650	; 4
	sta	$651	; 4
	sta	$652	; 4
	sta	$653	; 4
	sta	$654	; 4
	sta	$655	; 4
	sta	$656	; 4
	sta	$657	; 4
	sta	$658	; 4
	sta	$659	; 4
	sta	$65a	; 4
	sta	$65b	; 4
	sta	$65c	; 4
	sta	$65d	; 4
	lda	TEMP	; 3

; 81

	bit	PAGE0	; 4
	lda	#$03	; 2
	sta	$a50	; 4
	sta	$a51	; 4
	sta	$a52	; 4
	sta	$a53	; 4
	sta	$a54	; 4
	sta	$a55	; 4
	sta	$a56	; 4
	sta	$a57	; 4
	sta	$a58	; 4
	sta	$a59	; 4
	sta	$a5a	; 4
	sta	$a5b	; 4
	sta	$a5c	; 4
	sta	$a5d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$10	; 2
	sta	$650	; 4
	sta	$651	; 4
	sta	$652	; 4
	sta	$653	; 4
	sta	$654	; 4
	sta	$655	; 4
	sta	$656	; 4
	sta	$657	; 4
	sta	$658	; 4
	sta	$659	; 4
	sta	$65a	; 4
	sta	$65b	; 4
	sta	$65c	; 4
	sta	$65d	; 4
	lda	TEMP	; 3

; 82

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$a50	; 4
	sta	$a51	; 4
	sta	$a52	; 4
	sta	$a53	; 4
	sta	$a54	; 4
	sta	$a55	; 4
	sta	$a56	; 4
	sta	$a57	; 4
	sta	$a58	; 4
	sta	$a59	; 4
	sta	$a5a	; 4
	sta	$a5b	; 4
	sta	$a5c	; 4
	sta	$a5d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$650	; 4
	sta	$651	; 4
	sta	$652	; 4
	sta	$653	; 4
	sta	$654	; 4
	sta	$655	; 4
	sta	$656	; 4
	sta	$657	; 4
	sta	$658	; 4
	sta	$659	; 4
	sta	$65a	; 4
	sta	$65b	; 4
	sta	$65c	; 4
	sta	$65d	; 4
	lda	TEMP	; 3

; 83

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$a50	; 4
	sta	$a51	; 4
	sta	$a52	; 4
	sta	$a53	; 4
	sta	$a54	; 4
	sta	$a55	; 4
	sta	$a56	; 4
	sta	$a57	; 4
	sta	$a58	; 4
	sta	$a59	; 4
	sta	$a5a	; 4
	sta	$a5b	; 4
	sta	$a5c	; 4
	sta	$a5d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$08	; 2
	sta	$6d0	; 4
	sta	$6d1	; 4
	sta	$6d2	; 4
	sta	$6d3	; 4
	sta	$6d4	; 4
	sta	$6d5	; 4
	sta	$6d6	; 4
	sta	$6d7	; 4
	sta	$6d8	; 4
	sta	$6d9	; 4
	sta	$6da	; 4
	sta	$6db	; 4
	sta	$6dc	; 4
	sta	$6dd	; 4
	lda	TEMP	; 3


;=========
; 84(21) = $6d0

	bit	PAGE0	; 4
	lda	#$0d	; 2
	sta	$ad0	; 4
	sta	$ad1	; 4
	sta	$ad2	; 4
	sta	$ad3	; 4
	sta	$ad4	; 4
	sta	$ad5	; 4
	sta	$ad6	; 4
	sta	$ad7	; 4
	sta	$ad8	; 4
	sta	$ad9	; 4
	sta	$ada	; 4
	sta	$adb	; 4
	sta	$adc	; 4
	sta	$add	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$0f	; 2
	sta	$6d0	; 4
	sta	$6d1	; 4
	sta	$6d2	; 4
	sta	$6d3	; 4
	sta	$6d4	; 4
	sta	$6d5	; 4
	sta	$6d6	; 4
	sta	$6d7	; 4
	sta	$6d8	; 4
	sta	$6d9	; 4
	sta	$6da	; 4
	sta	$6db	; 4
	sta	$6dc	; 4
	sta	$6dd	; 4
	lda	TEMP	; 3

; 85

	bit	PAGE0	; 4
	lda	#$0d	; 2
	sta	$ad0	; 4
	sta	$ad1	; 4
	sta	$ad2	; 4
	sta	$ad3	; 4
	sta	$ad4	; 4
	sta	$ad5	; 4
	sta	$ad6	; 4
	sta	$ad7	; 4
	sta	$ad8	; 4
	sta	$ad9	; 4
	sta	$ada	; 4
	sta	$adb	; 4
	sta	$adc	; 4
	sta	$add	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$80	; 2
	sta	$6d0	; 4
	sta	$6d1	; 4
	sta	$6d2	; 4
	sta	$6d3	; 4
	sta	$6d4	; 4
	sta	$6d5	; 4
	sta	$6d6	; 4
	sta	$6d7	; 4
	sta	$6d8	; 4
	sta	$6d9	; 4
	sta	$6da	; 4
	sta	$6db	; 4
	sta	$6dc	; 4
	sta	$6dd	; 4
	lda	TEMP	; 3

; 86

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$ad0	; 4
	sta	$ad1	; 4
	sta	$ad2	; 4
	sta	$ad3	; 4
	sta	$ad4	; 4
	sta	$ad5	; 4
	sta	$ad6	; 4
	sta	$ad7	; 4
	sta	$ad8	; 4
	sta	$ad9	; 4
	sta	$ada	; 4
	sta	$adb	; 4
	sta	$adc	; 4
	sta	$add	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$6d0	; 4
	sta	$6d1	; 4
	sta	$6d2	; 4
	sta	$6d3	; 4
	sta	$6d4	; 4
	sta	$6d5	; 4
	sta	$6d6	; 4
	sta	$6d7	; 4
	sta	$6d8	; 4
	sta	$6d9	; 4
	sta	$6da	; 4
	sta	$6db	; 4
	sta	$6dc	; 4
	sta	$6dd	; 4
	lda	TEMP	; 3

; 87

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$ad0	; 4
	sta	$ad1	; 4
	sta	$ad2	; 4
	sta	$ad3	; 4
	sta	$ad4	; 4
	sta	$ad5	; 4
	sta	$ad6	; 4
	sta	$ad7	; 4
	sta	$ad8	; 4
	sta	$ad9	; 4
	sta	$ada	; 4
	sta	$adb	; 4
	sta	$adc	; 4
	sta	$add	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$0c	; 2
	sta	$750	; 4
	sta	$751	; 4
	sta	$752	; 4
	sta	$753	; 4
	sta	$754	; 4
	sta	$755	; 4
	sta	$756	; 4
	sta	$757	; 4
	sta	$758	; 4
	sta	$759	; 4
	sta	$75a	; 4
	sta	$75b	; 4
	sta	$75c	; 4
	sta	$75d	; 4
	lda	TEMP	; 3


;=========
; 88(L22) = $750

	bit	PAGE0	; 4
	lda	#$0e	; 2
	sta	$b50	; 4
	sta	$b51	; 4
	sta	$b52	; 4
	sta	$b53	; 4
	sta	$b54	; 4
	sta	$b55	; 4
	sta	$b56	; 4
	sta	$b57	; 4
	sta	$b58	; 4
	sta	$b59	; 4
	sta	$b5a	; 4
	sta	$b5b	; 4
	sta	$b5c	; 4
	sta	$b5d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$0f	; 2
	sta	$750	; 4
	sta	$751	; 4
	sta	$752	; 4
	sta	$753	; 4
	sta	$754	; 4
	sta	$755	; 4
	sta	$756	; 4
	sta	$757	; 4
	sta	$758	; 4
	sta	$759	; 4
	sta	$75a	; 4
	sta	$75b	; 4
	sta	$75c	; 4
	sta	$75d	; 4
	lda	TEMP	; 3

; 89

	bit	PAGE0	; 4
	lda	#$0e	; 2
	sta	$b50	; 4
	sta	$b51	; 4
	sta	$b52	; 4
	sta	$b53	; 4
	sta	$b54	; 4
	sta	$b55	; 4
	sta	$b56	; 4
	sta	$b57	; 4
	sta	$b58	; 4
	sta	$b59	; 4
	sta	$b5a	; 4
	sta	$b5b	; 4
	sta	$b5c	; 4
	sta	$b5d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$c0	; 2
	sta	$750	; 4
	sta	$751	; 4
	sta	$752	; 4
	sta	$753	; 4
	sta	$754	; 4
	sta	$755	; 4
	sta	$756	; 4
	sta	$757	; 4
	sta	$758	; 4
	sta	$759	; 4
	sta	$75a	; 4
	sta	$75b	; 4
	sta	$75c	; 4
	sta	$75d	; 4
	lda	TEMP	; 3

; 90

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$b50	; 4
	sta	$b51	; 4
	sta	$b52	; 4
	sta	$b53	; 4
	sta	$b54	; 4
	sta	$b55	; 4
	sta	$b56	; 4
	sta	$b57	; 4
	sta	$b58	; 4
	sta	$b59	; 4
	sta	$b5a	; 4
	sta	$b5b	; 4
	sta	$b5c	; 4
	sta	$b5d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$750	; 4
	sta	$751	; 4
	sta	$752	; 4
	sta	$753	; 4
	sta	$754	; 4
	sta	$755	; 4
	sta	$756	; 4
	sta	$757	; 4
	sta	$758	; 4
	sta	$759	; 4
	sta	$75a	; 4
	sta	$75b	; 4
	sta	$75c	; 4
	sta	$75d	; 4
	lda	TEMP	; 3

; 91

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$b50	; 4
	sta	$b51	; 4
	sta	$b52	; 4
	sta	$b53	; 4
	sta	$b54	; 4
	sta	$b55	; 4
	sta	$b56	; 4
	sta	$b57	; 4
	sta	$b58	; 4
	sta	$b59	; 4
	sta	$b5a	; 4
	sta	$b5b	; 4
	sta	$b5c	; 4
	sta	$b5d	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$09	; 2
	sta	$7d0	; 4
	sta	$7d1	; 4
	sta	$7d2	; 4
	sta	$7d3	; 4
	sta	$7d4	; 4
	sta	$7d5	; 4
	sta	$7d6	; 4
	sta	$7d7	; 4
	sta	$7d8	; 4
	sta	$7d9	; 4
	sta	$7da	; 4
	sta	$7db	; 4
	sta	$7dc	; 4
	sta	$7dd	; 4
	lda	TEMP	; 3


;=========
; 92(L23) = $7d0

	bit	PAGE0	; 4
	lda	#$0d	; 2
	sta	$bd0	; 4
	sta	$bd1	; 4
	sta	$bd2	; 4
	sta	$bd3	; 4
	sta	$bd4	; 4
	sta	$bd5	; 4
	sta	$bd6	; 4
	sta	$bd7	; 4
	sta	$bd8	; 4
	sta	$bd9	; 4
	sta	$bda	; 4
	sta	$bdb	; 4
	sta	$bdc	; 4
	sta	$bdd	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$0f	; 2
	sta	$7d0	; 4
	sta	$7d1	; 4
	sta	$7d2	; 4
	sta	$7d3	; 4
	sta	$7d4	; 4
	sta	$7d5	; 4
	sta	$7d6	; 4
	sta	$7d7	; 4
	sta	$7d8	; 4
	sta	$7d9	; 4
	sta	$7da	; 4
	sta	$7db	; 4
	sta	$7dc	; 4
	sta	$7dd	; 4
	lda	TEMP	; 3

; 93

	bit	PAGE0	; 4
	lda	#$0d	; 2
	sta	$bd0	; 4
	sta	$bd1	; 4
	sta	$bd2	; 4
	sta	$bd3	; 4
	sta	$bd4	; 4
	sta	$bd5	; 4
	sta	$bd6	; 4
	sta	$bd7	; 4
	sta	$bd8	; 4
	sta	$bd9	; 4
	sta	$bda	; 4
	sta	$bdb	; 4
	sta	$bdc	; 4
	sta	$bdd	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$90	; 2
	sta	$7d0	; 4
	sta	$7d1	; 4
	sta	$7d2	; 4
	sta	$7d3	; 4
	sta	$7d4	; 4
	sta	$7d5	; 4
	sta	$7d6	; 4
	sta	$7d7	; 4
	sta	$7d8	; 4
	sta	$7d9	; 4
	sta	$7da	; 4
	sta	$7db	; 4
	sta	$7dc	; 4
	sta	$7dd	; 4
	lda	TEMP	; 3

; 94

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$bd0	; 4
	sta	$bd1	; 4
	sta	$bd2	; 4
	sta	$bd3	; 4
	sta	$bd4	; 4
	sta	$bd5	; 4
	sta	$bd6	; 4
	sta	$bd7	; 4
	sta	$bd8	; 4
	sta	$bd9	; 4
	sta	$bda	; 4
	sta	$bdb	; 4
	sta	$bdc	; 4
	sta	$bdd	; 4
	lda	TEMP	; 3

	bit	PAGE1	; 4
	lda	#$00	; 2
	sta	$7d0	; 4
	sta	$7d1	; 4
	sta	$7d2	; 4
	sta	$7d3	; 4
	sta	$7d4	; 4
	sta	$7d5	; 4
	sta	$7d6	; 4
	sta	$7d7	; 4
	sta	$7d8	; 4
	sta	$7d9	; 4
	sta	$7da	; 4
	sta	$7db	; 4
	sta	$7dc	; 4
	sta	$7dd	; 4
	lda	TEMP	; 3

; 95

	bit	PAGE0	; 4
	lda	#$00	; 2
	sta	$bd0	; 4
	sta	$bd1	; 4
	sta	$bd2	; 4
	sta	$bd3	; 4
	sta	$bd4	; 4
	sta	$bd5	; 4
	sta	$bd6	; 4
	sta	$bd7	; 4
	sta	$bd8	; 4
	sta	$bd9	; 4
	sta	$bda	; 4
	sta	$bdb	; 4
	sta	$bdc	; 4
	sta	$bdd	; 4
	lda	TEMP	; 3

	; 65 cycles
	bit	PAGE1	; 4
	lda	#$03	; 2
	sta	$400	; 4
	sta	$401	; 4
	sta	$402	; 4
	sta	$403	; 4
	sta	$404	; 4
	sta	$405	; 4
	sta	$406	; 4
	sta	$407	; 4
	sta	$408	; 4
	sta	$409	; 4
	sta	$40a	; 4
	sta	$40b	; 4
	sta	$40c	; 4
	sta	$40d	; 4
	lda	TEMP	; 3


