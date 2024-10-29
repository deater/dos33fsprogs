	;==============================
	; two page vertical scroll
	;==============================
	;
	; 8*192*40 = 61440 cycles = roughly 16fps best case
	;
	; initial code, just scroll by 1

hgr_vertical_scroll:
	ldx	#0

	lda	DRAW_PAGE
;	beq	hgr_page1_clearscreen
;	lda	#0
;	beq	hgr_page2_clearscreen


hgr_vertical_scroll_page1:
	; PAGE1 for now

hgr_page1_vscroll:

	ldy	#39
hgr_page1_vscroll_loop:

	lda	$2400,Y		; 1 -> 0
	sta	$2000,Y
	lda	$2800,Y		; 2 -> 1
	sta	$2400,Y
	lda	$2C00,Y		; 3 -> 2
	sta	$2800,Y
	lda	$3000,Y		; 4 -> 3
	sta	$2C00,Y
	lda	$3400,Y		; 5 -> 4
	sta	$3000,Y
	lda	$3800,Y		; 6 -> 5
	sta	$3400,Y
	lda	$3C00,Y		; 7 -> 6
	sta	$3800,Y
	lda	$2080,Y		; 8 -> 7
	sta	$3C00,Y
	lda	$2480,Y		; 9 -> 8
	sta	$2080,Y
	lda	$2880,Y		; 10 -> 9
	sta	$2480,Y
	lda	$2C80,Y		; 11 -> 10
	sta	$2880,Y
	lda	$3080,Y		; 12 -> 11
	sta	$2C80,Y
	lda	$3480,Y		; 13 -> 12
	sta	$3080,Y
	lda	$3880,Y		; 14 -> 13
	sta	$3480,Y
	lda	$3C80,Y		; 15 -> 14
	sta	$3880,Y
	lda	$2100,Y		; 16 -> 15
	sta	$3C80,Y
	lda	$2500,Y		; 17 -> 16
	sta	$2100,Y
	lda	$2900,Y		; 18 -> 17
	sta	$2500,Y
	lda	$2D00,Y		; 19 -> 18
	sta	$2900,Y
	lda	$3100,Y		; 20 -> 19
	sta	$2D00,Y
	lda	$3500,Y		; 21 -> 20
	sta	$3100,Y
	lda	$3900,Y		; 22 -> 21
	sta	$3500,Y
	lda	$3D00,Y		; 23 -> 22
	sta	$3900,Y
	lda	$2180,Y		; 24 -> 23
	sta	$3D00,Y
	lda	$2580,Y		; 25 -> 24
	sta	$2180,Y
	lda	$2980,Y		; 26 -> 25
	sta	$2580,Y
	lda	$2D80,Y		; 27 -> 26
	sta	$2980,Y
	lda	$3180,Y		; 28 -> 27
	sta	$2D80,Y
	lda	$3580,Y		; 29 -> 28
	sta	$3180,Y
	lda	$3980,Y		; 30 -> 29
	sta	$3580,Y
	lda	$3D80,Y		; 31 -> 30
	sta	$3980,Y
	lda	$2200,Y		; 32 -> 31
	sta	$3D80,Y
	lda	$2600,Y		; 33 -> 32
	sta	$2200,Y
	lda	$2A00,Y		; 34 -> 33
	sta	$2600,Y
	lda	$2E00,Y		; 35 -> 34
	sta	$2A00,Y
	lda	$3200,Y		; 36 -> 35
	sta	$2E00,Y
	lda	$3600,Y		; 37 -> 36
	sta	$3200,Y
	lda	$3A00,Y		; 38 -> 37
	sta	$3600,Y
	lda	$3E00,Y		; 39 -> 38
	sta	$3A00,Y
	lda	$2280,Y		; 40 -> 39
	sta	$3E00,Y
	lda	$2680,Y		; 41 -> 40
	sta	$2280,Y
	lda	$2A80,Y		; 42 -> 41
	sta	$2680,Y
	lda	$2E80,Y		; 43 -> 42
	sta	$2A80,Y
	lda	$3280,Y		; 44 -> 43
	sta	$2E80,Y
	lda	$3680,Y		; 45 -> 44
	sta	$3280,Y
	lda	$3A80,Y		; 46 -> 45
	sta	$3680,Y
	lda	$3E80,Y		; 47 -> 46
	sta	$3A80,Y
	lda	$2300,Y		; 48 -> 47
	sta	$3E80,Y
	lda	$2700,Y		; 49 -> 48
	sta	$2300,Y
	lda	$2B00,Y		; 50 -> 49
	sta	$2700,Y
	lda	$2F00,Y		; 51 -> 50
	sta	$2B00,Y
	lda	$3300,Y		; 52 -> 51
	sta	$2F00,Y
	lda	$3700,Y		; 53 -> 52
	sta	$3300,Y
	lda	$3B00,Y		; 54 -> 53
	sta	$3700,Y
	lda	$3F00,Y		; 55 -> 54
	sta	$3B00,Y
	lda	$2380,Y		; 56 -> 55
	sta	$3F00,Y
	lda	$2780,Y		; 57 -> 56
	sta	$2380,Y
	lda	$2B80,Y		; 58 -> 57
	sta	$2780,Y
	lda	$2F80,Y		; 59 -> 58
	sta	$2B80,Y
	lda	$3380,Y		; 60 -> 59
	sta	$2F80,Y
	lda	$3780,Y		; 61 -> 60
	sta	$3380,Y
	lda	$3B80,Y		; 62 -> 61
	sta	$3780,Y
	lda	$3F80,Y		; 63 -> 62
	sta	$3B80,Y
	lda	$2028,Y		; 64 -> 63
	sta	$3F80,Y
	lda	$2428,Y		; 65 -> 64
	sta	$2028,Y
	lda	$2828,Y		; 66 -> 65
	sta	$2428,Y
	lda	$2C28,Y		; 67 -> 66
	sta	$2828,Y
	lda	$3028,Y		; 68 -> 67
	sta	$2C28,Y
	lda	$3428,Y		; 69 -> 68
	sta	$3028,Y
	lda	$3828,Y		; 70 -> 69
	sta	$3428,Y
	lda	$3C28,Y		; 71 -> 70
	sta	$3828,Y
	lda	$20A8,Y		; 72 -> 71
	sta	$3C28,Y
	lda	$24A8,Y		; 73 -> 72
	sta	$20A8,Y
	lda	$28A8,Y		; 74 -> 73
	sta	$24A8,Y
	lda	$2CA8,Y		; 75 -> 74
	sta	$28A8,Y
	lda	$30A8,Y		; 76 -> 75
	sta	$2CA8,Y
	lda	$34A8,Y		; 77 -> 76
	sta	$30A8,Y
	lda	$38A8,Y		; 78 -> 77
	sta	$34A8,Y
	lda	$3CA8,Y		; 79 -> 78
	sta	$38A8,Y
	lda	$2128,Y		; 80 -> 79
	sta	$3CA8,Y
	lda	$2528,Y		; 81 -> 80
	sta	$2128,Y
	lda	$2928,Y		; 82 -> 81
	sta	$2528,Y
	lda	$2D28,Y		; 83 -> 82
	sta	$2928,Y
	lda	$3128,Y		; 84 -> 83
	sta	$2D28,Y
	lda	$3528,Y		; 85 -> 84
	sta	$3128,Y
	lda	$3928,Y		; 86 -> 85
	sta	$3528,Y
	lda	$3D28,Y		; 87 -> 86
	sta	$3928,Y
	lda	$21A8,Y		; 88 -> 87
	sta	$3D28,Y
	lda	$25A8,Y		; 89 -> 88
	sta	$21A8,Y
	lda	$29A8,Y		; 90 -> 89
	sta	$25A8,Y
	lda	$2DA8,Y		; 91 -> 90
	sta	$29A8,Y
	lda	$31A8,Y		; 92 -> 91
	sta	$2DA8,Y
	lda	$35A8,Y		; 93 -> 92
	sta	$31A8,Y
	lda	$39A8,Y		; 94 -> 93
	sta	$35A8,Y
	lda	$3DA8,Y		; 95 -> 94
	sta	$39A8,Y
	lda	$2228,Y		; 96 -> 95
	sta	$3DA8,Y
	lda	$2628,Y		; 97 -> 96
	sta	$2228,Y
	lda	$2A28,Y		; 98 -> 97
	sta	$2628,Y
	lda	$2E28,Y		; 99 -> 98
	sta	$2A28,Y
	lda	$3228,Y		; 100 -> 99
	sta	$2E28,Y
	lda	$3628,Y		; 101 -> 100
	sta	$3228,Y
	lda	$3A28,Y		; 102 -> 101
	sta	$3628,Y
	lda	$3E28,Y		; 103 -> 102
	sta	$3A28,Y
	lda	$22A8,Y		; 104 -> 103
	sta	$3E28,Y
	lda	$26A8,Y		; 105 -> 104
	sta	$22A8,Y
	lda	$2AA8,Y		; 106 -> 105
	sta	$26A8,Y
	lda	$2EA8,Y		; 107 -> 106
	sta	$2AA8,Y
	lda	$32A8,Y		; 108 -> 107
	sta	$2EA8,Y
	lda	$36A8,Y		; 109 -> 108
	sta	$32A8,Y
	lda	$3AA8,Y		; 110 -> 109
	sta	$36A8,Y
	lda	$3EA8,Y		; 111 -> 110
	sta	$3AA8,Y
	lda	$2328,Y		; 112 -> 111
	sta	$3EA8,Y
	lda	$2728,Y		; 113 -> 112
	sta	$2328,Y
	lda	$2B28,Y		; 114 -> 113
	sta	$2728,Y
	lda	$2F28,Y		; 115 -> 114
	sta	$2B28,Y
	lda	$3328,Y		; 116 -> 115
	sta	$2F28,Y
	lda	$3728,Y		; 117 -> 116
	sta	$3328,Y
	lda	$3B28,Y		; 118 -> 117
	sta	$3728,Y
	lda	$3F28,Y		; 119 -> 118
	sta	$3B28,Y
	lda	$23A8,Y		; 120 -> 119
	sta	$3F28,Y
	lda	$27A8,Y		; 121 -> 120
	sta	$23A8,Y
	lda	$2BA8,Y		; 122 -> 121
	sta	$27A8,Y
	lda	$2FA8,Y		; 123 -> 122
	sta	$2BA8,Y
	lda	$33A8,Y		; 124 -> 123
	sta	$2FA8,Y
	lda	$37A8,Y		; 125 -> 124
	sta	$33A8,Y
	lda	$3BA8,Y		; 126 -> 125
	sta	$37A8,Y
	lda	$3FA8,Y		; 127 -> 126
	sta	$3BA8,Y
	lda	$2050,Y		; 128 -> 127
	sta	$3FA8,Y
	lda	$2450,Y		; 129 -> 128
	sta	$2050,Y
	lda	$2850,Y		; 130 -> 129
	sta	$2450,Y
	lda	$2C50,Y		; 131 -> 130
	sta	$2850,Y
	lda	$3050,Y		; 132 -> 131
	sta	$2C50,Y
	lda	$3450,Y		; 133 -> 132
	sta	$3050,Y
	lda	$3850,Y		; 134 -> 133
	sta	$3450,Y
	lda	$3C50,Y		; 135 -> 134
	sta	$3850,Y
	lda	$20D0,Y		; 136 -> 135
	sta	$3C50,Y
	lda	$24D0,Y		; 137 -> 136
	sta	$20D0,Y
	lda	$28D0,Y		; 138 -> 137
	sta	$24D0,Y
	lda	$2CD0,Y		; 139 -> 138
	sta	$28D0,Y
	lda	$30D0,Y		; 140 -> 139
	sta	$2CD0,Y
	lda	$34D0,Y		; 141 -> 140
	sta	$30D0,Y
	lda	$38D0,Y		; 142 -> 141
	sta	$34D0,Y
	lda	$3CD0,Y		; 143 -> 142
	sta	$38D0,Y
	lda	$2150,Y		; 144 -> 143
	sta	$3CD0,Y
	lda	$2550,Y		; 145 -> 144
	sta	$2150,Y
	lda	$2950,Y		; 146 -> 145
	sta	$2550,Y
	lda	$2D50,Y		; 147 -> 146
	sta	$2950,Y
	lda	$3150,Y		; 148 -> 147
	sta	$2D50,Y
	lda	$3550,Y		; 149 -> 148
	sta	$3150,Y
	lda	$3950,Y		; 150 -> 149
	sta	$3550,Y
	lda	$3D50,Y		; 151 -> 150
	sta	$3950,Y
	lda	$21D0,Y		; 152 -> 151
	sta	$3D50,Y
	lda	$25D0,Y		; 153 -> 152
	sta	$21D0,Y
	lda	$29D0,Y		; 154 -> 153
	sta	$25D0,Y
	lda	$2DD0,Y		; 155 -> 154
	sta	$29D0,Y
	lda	$31D0,Y		; 156 -> 155
	sta	$2DD0,Y
	lda	$35D0,Y		; 157 -> 156
	sta	$31D0,Y
	lda	$39D0,Y		; 158 -> 157
	sta	$35D0,Y
	lda	$3DD0,Y		; 159 -> 158
	sta	$39D0,Y
	lda	$2250,Y		; 160 -> 159
	sta	$3DD0,Y
	lda	$2650,Y		; 161 -> 160
	sta	$2250,Y
	lda	$2A50,Y		; 162 -> 161
	sta	$2650,Y
	lda	$2E50,Y		; 163 -> 162
	sta	$2A50,Y
	lda	$3250,Y		; 164 -> 163
	sta	$2E50,Y
	lda	$3650,Y		; 165 -> 164
	sta	$3250,Y
	lda	$3A50,Y		; 166 -> 165
	sta	$3650,Y
	lda	$3E50,Y		; 167 -> 166
	sta	$3A50,Y
	lda	$22D0,Y		; 168 -> 167
	sta	$3E50,Y
	lda	$26D0,Y		; 169 -> 168
	sta	$22D0,Y
	lda	$2AD0,Y		; 170 -> 169
	sta	$26D0,Y
	lda	$2ED0,Y		; 171 -> 170
	sta	$2AD0,Y
	lda	$32D0,Y		; 172 -> 171
	sta	$2ED0,Y
	lda	$36D0,Y		; 173 -> 172
	sta	$32D0,Y
	lda	$3AD0,Y		; 174 -> 173
	sta	$36D0,Y
	lda	$3ED0,Y		; 175 -> 174
	sta	$3AD0,Y
	lda	$2350,Y		; 176 -> 175
	sta	$3ED0,Y
	lda	$2750,Y		; 177 -> 176
	sta	$2350,Y
	lda	$2B50,Y		; 178 -> 177
	sta	$2750,Y
	lda	$2F50,Y		; 179 -> 178
	sta	$2B50,Y
	lda	$3350,Y		; 180 -> 179
	sta	$2F50,Y
	lda	$3750,Y		; 181 -> 180
	sta	$3350,Y
	lda	$3B50,Y		; 182 -> 181
	sta	$3750,Y
	lda	$3F50,Y		; 183 -> 182
	sta	$3B50,Y
	lda	$23D0,Y		; 184 -> 183
	sta	$3F50,Y
	lda	$27D0,Y		; 185 -> 184
	sta	$23D0,Y
	lda	$2BD0,Y		; 186 -> 185
	sta	$27D0,Y
	lda	$2FD0,Y		; 187 -> 186
	sta	$2BD0,Y
	lda	$33D0,Y		; 188 -> 187
	sta	$2FD0,Y
	lda	$37D0,Y		; 189 -> 188
	sta	$33D0,Y
	lda	$3BD0,Y		; 190 -> 189
	sta	$37D0,Y
	lda	$3FD0,Y		; 191 -> 190
	sta	$3BD0,Y
;	lda	$0000,Y		; 192 -> 191
;	sta	$3FD0,Y

	dey

	bmi	done_vscroll

	jmp	hgr_page1_vscroll_loop

done_vscroll:
	rts




