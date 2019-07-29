pool_exit_progression:
	.word	pool_exit_1	; 0
	.word	pool_exit_2	; 1
	.word	pool_exit_3	; 2
	.word	pool_exit_2	; 3
	.word	pool_exit_1	; 4
	.word	pool_exit_0	; 5
	.word	pool_exit_0	; 6
	.word	pool_exit_0	; 7
	.word	pool_exit_0	; 8
	.word	pool_exit_0	; 9
	.word	pool_exit_0	; 10
	.word	pool_exit_4	; 11
	.word	pool_exit_5	; 12
	.word	pool_exit_5	; 13
	.word	pool_exit_5	; 14
	.word	pool_exit_5	; 15
	.word	pool_exit_5	; 16
	.word	pool_exit_6	; 17
	.word	pool_exit_7	; 18
	.word	pool_exit_8	; 19
	.word	pool_exit_8	; 20
	.word	pool_exit_8	; 21
	.word	pool_exit_8	; 22
	.word	pool_exit_8	; 23
	.word	pool_exit_9	; 24
	.word	pool_exit_10	; 25












pool_exit_0:		; nothing
	.byte 3,8
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA

pool_exit_1:
	.byte 3,8
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AB,$AA,$AB
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA


pool_exit_2:
	.byte 3,8
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$BA,$AA,$BA
	.byte	$AB,$AA,$AB
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA


pool_exit_3:
	.byte 3,8
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$BB,$AA,$BB
	.byte	$AB,$A9,$AB
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA


pool_exit_4:
	.byte 3,8
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$9A,$AA
	.byte	$BA,$AB,$BA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA


pool_exit_5:
	.byte 3,8
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$9A,$AA
	.byte	$B0,$A9,$BA
	.byte	$AA,$AB,$AA
	.byte	$AA,$AA,$AA


pool_exit_6:
	.byte 3,8
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$9A,$AA
	.byte	$BA,$99,$BA
	.byte	$BB,$A0,$BB
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA

pool_exit_7:
	.byte 3,8
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$9A,$AA
	.byte	$B0,$99,$B0
	.byte	$BB,$00,$BB
	.byte	$AB,$A4,$AB
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA


pool_exit_8:
	.byte 3,8
	.byte	$AA,$AA,$AA
	.byte	$AA,$AA,$AA
	.byte	$AA,$9A,$AA
	.byte	$00,$99,$00
	.byte	$BB,$00,$BB
	.byte	$BB,$4B,$4B
	.byte	$AA,$AA,$74
	.byte	$AA,$AA,$AA

pool_exit_9:
	.byte 3,8
	.byte	$AA,$9A,$AA
	.byte	$AA,$BB,$AA
	.byte	$00,$00,$00
	.byte	$BB,$00,$BB
	.byte	$BB,$40,$BB
	.byte	$CC,$C4,$44
	.byte	$CC,$AA,$74
	.byte	$AA,$AA,$AA

pool_exit_10:
	.byte 3,8
	.byte	$AA,$9A,$AA
	.byte	$AA,$BB,$AA
	.byte	$0A,$00,$00
	.byte	$BB,$00,$BB
	.byte	$BB,$40,$BB
	.byte	$AA,$C4,$44
	.byte	$AA,$CC,$44
	.byte	$AA,$7C,$F4




swim_progression:
	.word swimming1
	.word swimming2
	.word swimming3
	.word swimming4
	.word swimming5
	.word swimming6
	.word swimming7
	.word swimming8


swimming1:
	.byte 2,6
	.byte $77,$AA
	.byte $55,$55
	.byte $00,$00
	.byte $00,$00
	.byte $22,$22
	.byte $55,$77

swimming2:
	.byte 2,6
	.byte $77,$7A
	.byte $55,$55
	.byte $00,$00
	.byte $00,$00
	.byte $52,$22
	.byte $A5,$77

swimming3:
	.byte 2,6
	.byte $77,$77
	.byte $55,$55
	.byte $00,$00
	.byte $00,$00
	.byte $55,$22
	.byte $AA,$77

swimming4:
	.byte 2,6
	.byte $7A,$77
	.byte $55,$55
	.byte $00,$00
	.byte $00,$00
	.byte $52,$22
	.byte $A5,$77

swimming5:
	.byte 2,6
	.byte $AA,$77
	.byte $55,$55
	.byte $00,$00
	.byte $00,$00
	.byte $22,$22
	.byte $55,$77

swimming6:
	.byte 2,6
	.byte $7A,$77
	.byte $55,$55
	.byte $00,$00
	.byte $00,$00
	.byte $22,$72
	.byte $55,$A7

swimming7:
	.byte 2,6
	.byte $77,$77
	.byte $55,$55
	.byte $00,$00
	.byte $00,$00
	.byte $22,$77
	.byte $55,$AA

swimming8:
	.byte 2,6
	.byte $77,$7A
	.byte $55,$55
	.byte $00,$00
	.byte $00,$00
	.byte $22,$72
	.byte $55,$A7

.if 0
swimming1:
	.byte 2,8
	.byte $77,$AA
	.byte $55,$55
	.byte $05,$05
	.byte $00,$00
	.byte $00,$00
	.byte $22,$22
	.byte $22,$22
	.byte $55,$77

swimming2:
	.byte 2,8
	.byte $77,$7A
	.byte $55,$55
	.byte $05,$05
	.byte $00,$00
	.byte $00,$00
	.byte $22,$22
	.byte $52,$22
	.byte $A5,$77

swimming3:
	.byte 2,8
	.byte $77,$77
	.byte $55,$55
	.byte $05,$05
	.byte $00,$00
	.byte $00,$00
	.byte $22,$22
	.byte $55,$22
	.byte $AA,$77

swimming4:
	.byte 2,8
	.byte $7A,$77
	.byte $55,$55
	.byte $05,$05
	.byte $00,$00
	.byte $00,$00
	.byte $22,$22
	.byte $52,$22
	.byte $A5,$77

swimming5:
	.byte 2,8
	.byte $AA,$77
	.byte $55,$55
	.byte $05,$05
	.byte $00,$00
	.byte $00,$00
	.byte $22,$22
	.byte $22,$22
	.byte $55,$77

swimming6:
	.byte 2,8
	.byte $7A,$77
	.byte $55,$55
	.byte $05,$05
	.byte $00,$00
	.byte $00,$00
	.byte $22,$22
	.byte $22,$72
	.byte $55,$A7

swimming7:
	.byte 2,8
	.byte $77,$77
	.byte $55,$55
	.byte $05,$05
	.byte $00,$00
	.byte $00,$00
	.byte $22,$22
	.byte $22,$77
	.byte $55,$AA

swimming8:
	.byte 2,8
	.byte $77,$7A
	.byte $55,$55
	.byte $05,$05
	.byte $00,$00
	.byte $00,$00
	.byte $22,$22
	.byte $22,$72
	.byte $55,$A7


.endif
