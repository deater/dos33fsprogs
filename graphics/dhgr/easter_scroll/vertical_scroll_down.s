	;==============================
	; two page vertical scroll down
	;==============================
	;
	; 8*192*40 = 61440 cycles = roughly 16fps best case


	; can also be used for dhgr

hgr_vertical_scroll_down_aux:
	sta	RDAUX
	sta	WRAUX

hgr_vertical_scroll_down_main:


hgr_vertical_scroll_down:
	ldx	#0

	lda	DRAW_PAGE
	beq	hgr_vertical_scroll_down_page1
	jmp	hgr_vertical_scroll_down_page2


hgr_vertical_scroll_down_page1:
	; PAGE1 for now

hgr_page1_vscroll_down:

	ldy	#39
hgr_page1_vscroll_down_loop:
.if 1
	lda	$37D0,Y		; 189 -> 191
	sta	$3FD0,Y
	lda	$33D0,Y		; 188 -> 190
	sta	$3BD0,Y
	lda	$2FD0,Y		; 187 -> 189
	sta	$37D0,Y
	lda	$2BD0,Y		; 186 -> 188
	sta	$33D0,Y
	lda	$27D0,Y		; 185 -> 187
	sta	$2FD0,Y
	lda	$23D0,Y		; 184 -> 186
	sta	$2BD0,Y
	lda	$3F50,Y		; 183 -> 185
	sta	$27D0,Y
	lda	$3B50,Y		; 182 -> 184
	sta	$23D0,Y
	lda	$3750,Y		; 181 -> 183
	sta	$3F50,Y
	lda	$3350,Y		; 180 -> 182
	sta	$3B50,Y
	lda	$2F50,Y		; 179 -> 181
	sta	$3750,Y
	lda	$2B50,Y		; 178 -> 180
	sta	$3350,Y
	lda	$2750,Y		; 177 -> 179
	sta	$2F50,Y
	lda	$2350,Y		; 176 -> 178
	sta	$2B50,Y
	lda	$3ED0,Y		; 175 -> 177
	sta	$2750,Y
	lda	$3AD0,Y		; 174 -> 176
	sta	$2350,Y
	lda	$36D0,Y		; 173 -> 175
	sta	$3ED0,Y
	lda	$32D0,Y		; 172 -> 174
	sta	$3AD0,Y
	lda	$2ED0,Y		; 171 -> 173
	sta	$36D0,Y
	lda	$2AD0,Y		; 170 -> 172
	sta	$32D0,Y
	lda	$26D0,Y		; 169 -> 171
	sta	$2ED0,Y
.endif
	lda	$22D0,Y		; 168 -> 170
	sta	$2AD0,Y
	lda	$3E50,Y		; 167 -> 169
	sta	$26D0,Y
	lda	$3A50,Y		; 166 -> 168
	sta	$22D0,Y
	lda	$3650,Y		; 165 -> 167
	sta	$3E50,Y
	lda	$3250,Y		; 164 -> 166
	sta	$3A50,Y
	lda	$2E50,Y		; 163 -> 165
	sta	$3650,Y
	lda	$2A50,Y		; 162 -> 164
	sta	$3250,Y
	lda	$2650,Y		; 161 -> 163
	sta	$2E50,Y
	lda	$2250,Y		; 160 -> 162
	sta	$2A50,Y
	lda	$3DD0,Y		; 159 -> 161
	sta	$2650,Y
	lda	$39D0,Y		; 158 -> 160
	sta	$2250,Y
	lda	$35D0,Y		; 157 -> 159
	sta	$3DD0,Y
	lda	$31D0,Y		; 156 -> 158
	sta	$39D0,Y
	lda	$2DD0,Y		; 155 -> 157
	sta	$35D0,Y
	lda	$29D0,Y		; 154 -> 156
	sta	$31D0,Y
	lda	$25D0,Y		; 153 -> 155
	sta	$2DD0,Y
	lda	$21D0,Y		; 152 -> 154
	sta	$29D0,Y
	lda	$3D50,Y		; 151 -> 153
	sta	$25D0,Y
	lda	$3950,Y		; 150 -> 152
	sta	$21D0,Y
	lda	$3550,Y		; 149 -> 151
	sta	$3D50,Y
	lda	$3150,Y		; 148 -> 150
	sta	$3950,Y
	lda	$2D50,Y		; 147 -> 149
	sta	$3550,Y
	lda	$2950,Y		; 146 -> 148
	sta	$3150,Y
	lda	$2550,Y		; 145 -> 147
	sta	$2D50,Y
	lda	$2150,Y		; 144 -> 146
	sta	$2950,Y
	lda	$3CD0,Y		; 143 -> 145
	sta	$2550,Y
	lda	$38D0,Y		; 142 -> 144
	sta	$2150,Y
	lda	$34D0,Y		; 141 -> 143
	sta	$3CD0,Y
	lda	$30D0,Y		; 140 -> 142
	sta	$38D0,Y
	lda	$2CD0,Y		; 139 -> 141
	sta	$34D0,Y
	lda	$28D0,Y		; 138 -> 140
	sta	$30D0,Y
	lda	$24D0,Y		; 137 -> 139
	sta	$2CD0,Y
	lda	$20D0,Y		; 136 -> 138
	sta	$28D0,Y
	lda	$3C50,Y		; 135 -> 137
	sta	$24D0,Y
	lda	$3850,Y		; 134 -> 136
	sta	$20D0,Y
	lda	$3450,Y		; 133 -> 135
	sta	$3C50,Y
	lda	$3050,Y		; 132 -> 134
	sta	$3850,Y
	lda	$2C50,Y		; 131 -> 133
	sta	$3450,Y
	lda	$2850,Y		; 130 -> 132
	sta	$3050,Y
	lda	$2450,Y		; 129 -> 131
	sta	$2C50,Y
	lda	$2050,Y		; 128 -> 130
	sta	$2850,Y
	lda	$3FA8,Y		; 127 -> 129
	sta	$2450,Y
	lda	$3BA8,Y		; 126 -> 128
	sta	$2050,Y
	lda	$37A8,Y		; 125 -> 127
	sta	$3FA8,Y
	lda	$33A8,Y		; 124 -> 126
	sta	$3BA8,Y
	lda	$2FA8,Y		; 123 -> 125
	sta	$37A8,Y
	lda	$2BA8,Y		; 122 -> 124
	sta	$33A8,Y
	lda	$27A8,Y		; 121 -> 123
	sta	$2FA8,Y
	lda	$23A8,Y		; 120 -> 122
	sta	$2BA8,Y
	lda	$3F28,Y		; 119 -> 121
	sta	$27A8,Y
	lda	$3B28,Y		; 118 -> 120
	sta	$23A8,Y
	lda	$3728,Y		; 117 -> 119
	sta	$3F28,Y
	lda	$3328,Y		; 116 -> 118
	sta	$3B28,Y
	lda	$2F28,Y		; 115 -> 117
	sta	$3728,Y
	lda	$2B28,Y		; 114 -> 116
	sta	$3328,Y
	lda	$2728,Y		; 113 -> 115
	sta	$2F28,Y
	lda	$2328,Y		; 112 -> 114
	sta	$2B28,Y
	lda	$3EA8,Y		; 111 -> 113
	sta	$2728,Y
	lda	$3AA8,Y		; 110 -> 112
	sta	$2328,Y
	lda	$36A8,Y		; 109 -> 111
	sta	$3EA8,Y
	lda	$32A8,Y		; 108 -> 110
	sta	$3AA8,Y
	lda	$2EA8,Y		; 107 -> 109
	sta	$36A8,Y
	lda	$2AA8,Y		; 106 -> 108
	sta	$32A8,Y
	lda	$26A8,Y		; 105 -> 107
	sta	$2EA8,Y
	lda	$22A8,Y		; 104 -> 106
	sta	$2AA8,Y
	lda	$3E28,Y		; 103 -> 105
	sta	$26A8,Y
	lda	$3A28,Y		; 102 -> 104
	sta	$22A8,Y
	lda	$3628,Y		; 101 -> 103
	sta	$3E28,Y
	lda	$3228,Y		; 100 -> 102
	sta	$3A28,Y
	lda	$2E28,Y		; 99 -> 101
	sta	$3628,Y
	lda	$2A28,Y		; 98 -> 100
	sta	$3228,Y
	lda	$2628,Y		; 97 -> 99
	sta	$2E28,Y
	lda	$2228,Y		; 96 -> 98
	sta	$2A28,Y
	lda	$3DA8,Y		; 95 -> 97
	sta	$2628,Y
	lda	$39A8,Y		; 94 -> 96
	sta	$2228,Y
	lda	$35A8,Y		; 93 -> 95
	sta	$3DA8,Y
	lda	$31A8,Y		; 92 -> 94
	sta	$39A8,Y
	lda	$2DA8,Y		; 91 -> 93
	sta	$35A8,Y
	lda	$29A8,Y		; 90 -> 92
	sta	$31A8,Y
	lda	$25A8,Y		; 89 -> 91
	sta	$2DA8,Y
	lda	$21A8,Y		; 88 -> 90
	sta	$29A8,Y
	lda	$3D28,Y		; 87 -> 89
	sta	$25A8,Y
	lda	$3928,Y		; 86 -> 88
	sta	$21A8,Y
	lda	$3528,Y		; 85 -> 87
	sta	$3D28,Y
	lda	$3128,Y		; 84 -> 86
	sta	$3928,Y
	lda	$2D28,Y		; 83 -> 85
	sta	$3528,Y
	lda	$2928,Y		; 82 -> 84
	sta	$3128,Y
	lda	$2528,Y		; 81 -> 83
	sta	$2D28,Y
	lda	$2128,Y		; 80 -> 82
	sta	$2928,Y
	lda	$3CA8,Y		; 79 -> 81
	sta	$2528,Y
	lda	$38A8,Y		; 78 -> 80
	sta	$2128,Y
	lda	$34A8,Y		; 77 -> 79
	sta	$3CA8,Y
	lda	$30A8,Y		; 76 -> 78
	sta	$38A8,Y
	lda	$2CA8,Y		; 75 -> 77
	sta	$34A8,Y
	lda	$28A8,Y		; 74 -> 76
	sta	$30A8,Y
	lda	$24A8,Y		; 73 -> 75
	sta	$2CA8,Y
	lda	$20A8,Y		; 72 -> 74
	sta	$28A8,Y
	lda	$3C28,Y		; 71 -> 73
	sta	$24A8,Y
	lda	$3828,Y		; 70 -> 72
	sta	$20A8,Y
	lda	$3428,Y		; 69 -> 71
	sta	$3C28,Y
	lda	$3028,Y		; 68 -> 70
	sta	$3828,Y
	lda	$2C28,Y		; 67 -> 69
	sta	$3428,Y
	lda	$2828,Y		; 66 -> 68
	sta	$3028,Y
	lda	$2428,Y		; 65 -> 67
	sta	$2C28,Y
	lda	$2028,Y		; 64 -> 66
	sta	$2828,Y
	lda	$3F80,Y		; 63 -> 65
	sta	$2428,Y
	lda	$3B80,Y		; 62 -> 64
	sta	$2028,Y
	lda	$3780,Y		; 61 -> 63
	sta	$3F80,Y
	lda	$3380,Y		; 60 -> 62
	sta	$3B80,Y
	lda	$2F80,Y		; 59 -> 61
	sta	$3780,Y
	lda	$2B80,Y		; 58 -> 60
	sta	$3380,Y
	lda	$2780,Y		; 57 -> 59
	sta	$2F80,Y
	lda	$2380,Y		; 56 -> 58
	sta	$2B80,Y
	lda	$3F00,Y		; 55 -> 57
	sta	$2780,Y
	lda	$3B00,Y		; 54 -> 56
	sta	$2380,Y
	lda	$3700,Y		; 53 -> 55
	sta	$3F00,Y
	lda	$3300,Y		; 52 -> 54
	sta	$3B00,Y
	lda	$2F00,Y		; 51 -> 53
	sta	$3700,Y
	lda	$2B00,Y		; 50 -> 52
	sta	$3300,Y
	lda	$2700,Y		; 49 -> 51
	sta	$2F00,Y
	lda	$2300,Y		; 48 -> 50
	sta	$2B00,Y
	lda	$3E80,Y		; 47 -> 49
	sta	$2700,Y
	lda	$3A80,Y		; 46 -> 48
	sta	$2300,Y
	lda	$3680,Y		; 45 -> 47
	sta	$3E80,Y
	lda	$3280,Y		; 44 -> 46
	sta	$3A80,Y
	lda	$2E80,Y		; 43 -> 45
	sta	$3680,Y
	lda	$2A80,Y		; 42 -> 44
	sta	$3280,Y
	lda	$2680,Y		; 41 -> 43
	sta	$2E80,Y
	lda	$2280,Y		; 40 -> 42
	sta	$2A80,Y
	lda	$3E00,Y		; 39 -> 41
	sta	$2680,Y
	lda	$3A00,Y		; 38 -> 40
	sta	$2280,Y
	lda	$3600,Y		; 37 -> 39
	sta	$3E00,Y
	lda	$3200,Y		; 36 -> 38
	sta	$3A00,Y
	lda	$2E00,Y		; 35 -> 37
	sta	$3600,Y
	lda	$2A00,Y		; 34 -> 36
	sta	$3200,Y
	lda	$2600,Y		; 33 -> 35
	sta	$2E00,Y
	lda	$2200,Y		; 32 -> 34
	sta	$2A00,Y
	lda	$3D80,Y		; 31 -> 33
	sta	$2600,Y
	lda	$3980,Y		; 30 -> 32
	sta	$2200,Y
	lda	$3580,Y		; 29 -> 31
	sta	$3D80,Y
	lda	$3180,Y		; 28 -> 30
	sta	$3980,Y
	lda	$2D80,Y		; 27 -> 29
	sta	$3580,Y
	lda	$2980,Y		; 26 -> 28
	sta	$3180,Y
	lda	$2580,Y		; 25 -> 27
	sta	$2D80,Y
	lda	$2180,Y		; 24 -> 26
	sta	$2980,Y
	lda	$3D00,Y		; 23 -> 25
	sta	$2580,Y
	lda	$3900,Y		; 22 -> 24
	sta	$2180,Y
	lda	$3500,Y		; 21 -> 23
	sta	$3D00,Y
	lda	$3100,Y		; 20 -> 22
	sta	$3900,Y
	lda	$2D00,Y		; 19 -> 21
	sta	$3500,Y
	lda	$2900,Y		; 18 -> 20
	sta	$3100,Y
	lda	$2500,Y		; 17 -> 19
	sta	$2D00,Y
	lda	$2100,Y		; 16 -> 18
	sta	$2900,Y
	lda	$3C80,Y		; 15 -> 17
	sta	$2500,Y
	lda	$3880,Y		; 14 -> 16
	sta	$2100,Y
	lda	$3480,Y		; 13 -> 15
	sta	$3C80,Y
	lda	$3080,Y		; 12 -> 14
	sta	$3880,Y
	lda	$2C80,Y		; 11 -> 13
	sta	$3480,Y
	lda	$2880,Y		; 10 -> 12
	sta	$3080,Y
	lda	$2480,Y		; 9 -> 11
	sta	$2C80,Y
	lda	$2080,Y		; 8 -> 10
	sta	$2880,Y
	lda	$3C00,Y		; 7 -> 9
	sta	$2480,Y
	lda	$3800,Y		; 6 -> 8
	sta	$2080,Y
	lda	$3400,Y		; 5 -> 7
	sta	$3C00,Y
	lda	$3000,Y		; 4 -> 6
	sta	$3800,Y
	lda	$2C00,Y		; 3 -> 5
	sta	$3400,Y
	lda	$2800,Y		; 2 -> 4
	sta	$3000,Y
	lda	$2400,Y		; 1 -> 3
	sta	$2C00,Y
	lda	$2000,Y		; 0 -> 2
	sta	$2800,Y

	dey

	bmi	done_vscroll_down

	jmp	hgr_page1_vscroll_down_loop

done_vscroll_down:
	sta	RDMAIN
	sta	WRMAIN
	rts

hgr_vertical_scroll_down_page2:
	; PAGE1 for now

hgr_page2_vscroll_down:

	ldy	#39
hgr_page2_vscroll_down_loop:
.if 1
	lda	$57D0,Y		; 189 -> 191
	sta	$5FD0,Y
	lda	$53D0,Y		; 188 -> 190
	sta	$5BD0,Y
	lda	$4FD0,Y		; 187 -> 189
	sta	$57D0,Y
	lda	$4BD0,Y		; 186 -> 188
	sta	$53D0,Y
	lda	$47D0,Y		; 185 -> 187
	sta	$4FD0,Y
	lda	$43D0,Y		; 184 -> 186
	sta	$4BD0,Y
	lda	$5F50,Y		; 183 -> 185
	sta	$47D0,Y
	lda	$5B50,Y		; 182 -> 184
	sta	$43D0,Y
	lda	$5750,Y		; 181 -> 183
	sta	$5F50,Y
	lda	$5350,Y		; 180 -> 182
	sta	$5B50,Y
	lda	$4F50,Y		; 179 -> 181
	sta	$5750,Y
	lda	$4B50,Y		; 178 -> 180
	sta	$5350,Y
	lda	$4750,Y		; 177 -> 179
	sta	$4F50,Y
	lda	$4350,Y		; 176 -> 178
	sta	$4B50,Y
	lda	$5ED0,Y		; 175 -> 177
	sta	$4750,Y
	lda	$5AD0,Y		; 174 -> 176
	sta	$4350,Y
	lda	$56D0,Y		; 173 -> 175
	sta	$5ED0,Y
	lda	$52D0,Y		; 172 -> 174
	sta	$5AD0,Y
	lda	$4ED0,Y		; 171 -> 173
	sta	$56D0,Y
	lda	$4AD0,Y		; 170 -> 172
	sta	$52D0,Y
	lda	$46D0,Y		; 169 -> 171
	sta	$4ED0,Y
.endif

	lda	$42D0,Y		; 168 -> 170
	sta	$4AD0,Y
	lda	$5E50,Y		; 167 -> 169
	sta	$46D0,Y
	lda	$5A50,Y		; 166 -> 168
	sta	$42D0,Y
	lda	$5650,Y		; 165 -> 167
	sta	$5E50,Y
	lda	$5250,Y		; 164 -> 166
	sta	$5A50,Y
	lda	$4E50,Y		; 163 -> 165
	sta	$5650,Y
	lda	$4A50,Y		; 162 -> 164
	sta	$5250,Y
	lda	$4650,Y		; 161 -> 163
	sta	$4E50,Y
	lda	$4250,Y		; 160 -> 162
	sta	$4A50,Y
	lda	$5DD0,Y		; 159 -> 161
	sta	$4650,Y
	lda	$59D0,Y		; 158 -> 160
	sta	$4250,Y
	lda	$55D0,Y		; 157 -> 159
	sta	$5DD0,Y
	lda	$51D0,Y		; 156 -> 158
	sta	$59D0,Y
	lda	$4DD0,Y		; 155 -> 157
	sta	$55D0,Y
	lda	$49D0,Y		; 154 -> 156
	sta	$51D0,Y
	lda	$45D0,Y		; 153 -> 155
	sta	$4DD0,Y
	lda	$41D0,Y		; 152 -> 154
	sta	$49D0,Y
	lda	$5D50,Y		; 151 -> 153
	sta	$45D0,Y
	lda	$5950,Y		; 150 -> 152
	sta	$41D0,Y
	lda	$5550,Y		; 149 -> 151
	sta	$5D50,Y
	lda	$5150,Y		; 148 -> 150
	sta	$5950,Y
	lda	$4D50,Y		; 147 -> 149
	sta	$5550,Y
	lda	$4950,Y		; 146 -> 148
	sta	$5150,Y
	lda	$4550,Y		; 145 -> 147
	sta	$4D50,Y
	lda	$4150,Y		; 144 -> 146
	sta	$4950,Y
	lda	$5CD0,Y		; 143 -> 145
	sta	$4550,Y
	lda	$58D0,Y		; 142 -> 144
	sta	$4150,Y
	lda	$54D0,Y		; 141 -> 143
	sta	$5CD0,Y
	lda	$50D0,Y		; 140 -> 142
	sta	$58D0,Y
	lda	$4CD0,Y		; 139 -> 141
	sta	$54D0,Y
	lda	$48D0,Y		; 138 -> 140
	sta	$50D0,Y
	lda	$44D0,Y		; 137 -> 139
	sta	$4CD0,Y
	lda	$40D0,Y		; 136 -> 138
	sta	$48D0,Y
	lda	$5C50,Y		; 135 -> 137
	sta	$44D0,Y
	lda	$5850,Y		; 134 -> 136
	sta	$40D0,Y
	lda	$5450,Y		; 133 -> 135
	sta	$5C50,Y
	lda	$5050,Y		; 132 -> 134
	sta	$5850,Y
	lda	$4C50,Y		; 131 -> 133
	sta	$5450,Y
	lda	$4850,Y		; 130 -> 132
	sta	$5050,Y
	lda	$4450,Y		; 129 -> 131
	sta	$4C50,Y
	lda	$4050,Y		; 128 -> 130
	sta	$4850,Y
	lda	$5FA8,Y		; 127 -> 129
	sta	$4450,Y
	lda	$5BA8,Y		; 126 -> 128
	sta	$4050,Y
	lda	$57A8,Y		; 125 -> 127
	sta	$5FA8,Y
	lda	$53A8,Y		; 124 -> 126
	sta	$5BA8,Y
	lda	$4FA8,Y		; 123 -> 125
	sta	$57A8,Y
	lda	$4BA8,Y		; 122 -> 124
	sta	$53A8,Y
	lda	$47A8,Y		; 121 -> 123
	sta	$4FA8,Y
	lda	$43A8,Y		; 120 -> 122
	sta	$4BA8,Y
	lda	$5F28,Y		; 119 -> 121
	sta	$47A8,Y
	lda	$5B28,Y		; 118 -> 120
	sta	$43A8,Y
	lda	$5728,Y		; 117 -> 119
	sta	$5F28,Y
	lda	$5328,Y		; 116 -> 118
	sta	$5B28,Y
	lda	$4F28,Y		; 115 -> 117
	sta	$5728,Y
	lda	$4B28,Y		; 114 -> 116
	sta	$5328,Y
	lda	$4728,Y		; 113 -> 115
	sta	$4F28,Y
	lda	$4328,Y		; 112 -> 114
	sta	$4B28,Y
	lda	$5EA8,Y		; 111 -> 113
	sta	$4728,Y
	lda	$5AA8,Y		; 110 -> 112
	sta	$4328,Y
	lda	$56A8,Y		; 109 -> 111
	sta	$5EA8,Y
	lda	$52A8,Y		; 108 -> 110
	sta	$5AA8,Y
	lda	$4EA8,Y		; 107 -> 109
	sta	$56A8,Y
	lda	$4AA8,Y		; 106 -> 108
	sta	$52A8,Y
	lda	$46A8,Y		; 105 -> 107
	sta	$4EA8,Y
	lda	$42A8,Y		; 104 -> 106
	sta	$4AA8,Y
	lda	$5E28,Y		; 103 -> 105
	sta	$46A8,Y
	lda	$5A28,Y		; 102 -> 104
	sta	$42A8,Y
	lda	$5628,Y		; 101 -> 103
	sta	$5E28,Y
	lda	$5228,Y		; 100 -> 102
	sta	$5A28,Y
	lda	$4E28,Y		; 99 -> 101
	sta	$5628,Y
	lda	$4A28,Y		; 98 -> 100
	sta	$5228,Y
	lda	$4628,Y		; 97 -> 99
	sta	$4E28,Y
	lda	$4228,Y		; 96 -> 98
	sta	$4A28,Y
	lda	$5DA8,Y		; 95 -> 97
	sta	$4628,Y
	lda	$59A8,Y		; 94 -> 96
	sta	$4228,Y
	lda	$55A8,Y		; 93 -> 95
	sta	$5DA8,Y
	lda	$51A8,Y		; 92 -> 94
	sta	$59A8,Y
	lda	$4DA8,Y		; 91 -> 93
	sta	$55A8,Y
	lda	$49A8,Y		; 90 -> 92
	sta	$51A8,Y
	lda	$45A8,Y		; 89 -> 91
	sta	$4DA8,Y
	lda	$41A8,Y		; 88 -> 90
	sta	$49A8,Y
	lda	$5D28,Y		; 87 -> 89
	sta	$45A8,Y
	lda	$5928,Y		; 86 -> 88
	sta	$41A8,Y
	lda	$5528,Y		; 85 -> 87
	sta	$5D28,Y
	lda	$5128,Y		; 84 -> 86
	sta	$5928,Y
	lda	$4D28,Y		; 83 -> 85
	sta	$5528,Y
	lda	$4928,Y		; 82 -> 84
	sta	$5128,Y
	lda	$4528,Y		; 81 -> 83
	sta	$4D28,Y
	lda	$4128,Y		; 80 -> 82
	sta	$4928,Y
	lda	$5CA8,Y		; 79 -> 81
	sta	$4528,Y
	lda	$58A8,Y		; 78 -> 80
	sta	$4128,Y
	lda	$54A8,Y		; 77 -> 79
	sta	$5CA8,Y
	lda	$50A8,Y		; 76 -> 78
	sta	$58A8,Y
	lda	$4CA8,Y		; 75 -> 77
	sta	$54A8,Y
	lda	$48A8,Y		; 74 -> 76
	sta	$50A8,Y
	lda	$44A8,Y		; 73 -> 75
	sta	$4CA8,Y
	lda	$40A8,Y		; 72 -> 74
	sta	$48A8,Y
	lda	$5C28,Y		; 71 -> 73
	sta	$44A8,Y
	lda	$5828,Y		; 70 -> 72
	sta	$40A8,Y
	lda	$5428,Y		; 69 -> 71
	sta	$5C28,Y
	lda	$5028,Y		; 68 -> 70
	sta	$5828,Y
	lda	$4C28,Y		; 67 -> 69
	sta	$5428,Y
	lda	$4828,Y		; 66 -> 68
	sta	$5028,Y
	lda	$4428,Y		; 65 -> 67
	sta	$4C28,Y
	lda	$4028,Y		; 64 -> 66
	sta	$4828,Y
	lda	$5F80,Y		; 63 -> 65
	sta	$4428,Y
	lda	$5B80,Y		; 62 -> 64
	sta	$4028,Y
	lda	$5780,Y		; 61 -> 63
	sta	$5F80,Y
	lda	$5380,Y		; 60 -> 62
	sta	$5B80,Y
	lda	$4F80,Y		; 59 -> 61
	sta	$5780,Y
	lda	$4B80,Y		; 58 -> 60
	sta	$5380,Y
	lda	$4780,Y		; 57 -> 59
	sta	$4F80,Y
	lda	$4380,Y		; 56 -> 58
	sta	$4B80,Y
	lda	$5F00,Y		; 55 -> 57
	sta	$4780,Y
	lda	$5B00,Y		; 54 -> 56
	sta	$4380,Y
	lda	$5700,Y		; 53 -> 55
	sta	$5F00,Y
	lda	$5300,Y		; 52 -> 54
	sta	$5B00,Y
	lda	$4F00,Y		; 51 -> 53
	sta	$5700,Y
	lda	$4B00,Y		; 50 -> 52
	sta	$5300,Y
	lda	$4700,Y		; 49 -> 51
	sta	$4F00,Y
	lda	$4300,Y		; 48 -> 50
	sta	$4B00,Y
	lda	$5E80,Y		; 47 -> 49
	sta	$4700,Y
	lda	$5A80,Y		; 46 -> 48
	sta	$4300,Y
	lda	$5680,Y		; 45 -> 47
	sta	$5E80,Y
	lda	$5280,Y		; 44 -> 46
	sta	$5A80,Y
	lda	$4E80,Y		; 43 -> 45
	sta	$5680,Y
	lda	$4A80,Y		; 42 -> 44
	sta	$5280,Y
	lda	$4680,Y		; 41 -> 43
	sta	$4E80,Y
	lda	$4280,Y		; 40 -> 42
	sta	$4A80,Y
	lda	$5E00,Y		; 39 -> 41
	sta	$4680,Y
	lda	$5A00,Y		; 38 -> 40
	sta	$4280,Y
	lda	$5600,Y		; 37 -> 39
	sta	$5E00,Y
	lda	$5200,Y		; 36 -> 38
	sta	$5A00,Y
	lda	$4E00,Y		; 35 -> 37
	sta	$5600,Y
	lda	$4A00,Y		; 34 -> 36
	sta	$5200,Y
	lda	$4600,Y		; 33 -> 35
	sta	$4E00,Y
	lda	$4200,Y		; 32 -> 34
	sta	$4A00,Y
	lda	$5D80,Y		; 31 -> 33
	sta	$4600,Y
	lda	$5980,Y		; 30 -> 32
	sta	$4200,Y
	lda	$5580,Y		; 29 -> 31
	sta	$5D80,Y
	lda	$5180,Y		; 28 -> 30
	sta	$5980,Y
	lda	$4D80,Y		; 27 -> 29
	sta	$5580,Y
	lda	$4980,Y		; 26 -> 28
	sta	$5180,Y
	lda	$4580,Y		; 25 -> 27
	sta	$4D80,Y
	lda	$4180,Y		; 24 -> 26
	sta	$4980,Y
	lda	$5D00,Y		; 23 -> 25
	sta	$4580,Y
	lda	$5900,Y		; 22 -> 24
	sta	$4180,Y
	lda	$5500,Y		; 21 -> 23
	sta	$5D00,Y
	lda	$5100,Y		; 20 -> 22
	sta	$5900,Y
	lda	$4D00,Y		; 19 -> 21
	sta	$5500,Y
	lda	$4900,Y		; 18 -> 20
	sta	$5100,Y
	lda	$4500,Y		; 17 -> 19
	sta	$4D00,Y
	lda	$4100,Y		; 16 -> 18
	sta	$4900,Y
	lda	$5C80,Y		; 15 -> 17
	sta	$4500,Y
	lda	$5880,Y		; 14 -> 16
	sta	$4100,Y
	lda	$5480,Y		; 13 -> 15
	sta	$5C80,Y
	lda	$5080,Y		; 12 -> 14
	sta	$5880,Y
	lda	$4C80,Y		; 11 -> 13
	sta	$5480,Y
	lda	$4880,Y		; 10 -> 12
	sta	$5080,Y
	lda	$4480,Y		; 9 -> 11
	sta	$4C80,Y
	lda	$4080,Y		; 8 -> 10
	sta	$4880,Y
	lda	$5C00,Y		; 7 -> 9
	sta	$4480,Y
	lda	$5800,Y		; 6 -> 8
	sta	$4080,Y
	lda	$5400,Y		; 5 -> 7
	sta	$5C00,Y
	lda	$5000,Y		; 4 -> 6
	sta	$5800,Y
	lda	$4C00,Y		; 3 -> 5
	sta	$5400,Y
	lda	$4800,Y		; 2 -> 4
	sta	$5000,Y
	lda	$4400,Y		; 1 -> 3
	sta	$4C00,Y
	lda	$4000,Y		; 0 -> 2
	sta	$4800,Y

	dey

	bmi	done_vscroll2_down

	jmp	hgr_page2_vscroll_down_loop

done_vscroll2_down:
	sta	RDMAIN
	sta	WRMAIN
	rts



