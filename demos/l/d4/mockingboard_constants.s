init_addresses:
	.byte <MOCK_6522_DDRB1,<MOCK_6522_DDRA1		; set the data direction for all pins of PortA/PortB to be output
	.byte <MOCK_6522_ACR,<MOCK_6522_IER		; Continuous interrupts, clear all interrupts
	.byte <MOCK_6522_IFR,<MOCK_6522_IER		; enable interrupt on timer overflow
	.byte <MOCK_6522_T1CL,<MOCK_6522_T1CH		; set oflow value, start counting
	.byte <MOCK_6522_ORB1,<MOCK_6522_ORB1		; reset ay-3-8910

	; note, terminated by the $ff below

init_values:
	.byte $ff,$ff	; set the data direction for all pins of PortA/PortB to be output
	.byte $40,$7f
	.byte $C0,$C0
	.byte $CE,$C7	; c7ce / 1.023e6 = .050s, 20Hz
	.byte MOCK_AY_RESET,MOCK_AY_INACTIVE

