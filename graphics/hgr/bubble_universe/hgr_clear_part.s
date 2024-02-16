	; we only draw to
	;	Xpositions 140+-64 ( 76-204, /7 = 10 - 30)
	;	Ypositions 96+-64 = 32 - 160

hgr_clear_part:

	lda	#0			; color

	ldy	HGR_PAGE
	cpy	#$40
	bne	hgr_page1_clearscreen
	jmp	hgr_page2_clearscreen

hgr_page1_clearscreen:

	ldy	#10
hgr_page1_cls_loop:
.if 0
	sta	$2000,Y		; 0
	sta	$2400,Y		; 1
	sta	$2800,Y		; 2
	sta	$2C00,Y		; 3
	sta	$3000,Y		; 4
	sta	$3400,Y		; 5
	sta	$3800,Y		; 6
	sta	$3C00,Y		; 7

	sta	$2080,Y		; 8
	sta	$2480,Y		; 9
	sta	$2880,Y		; 10
	sta	$2C80,Y		; 11
	sta	$3080,Y		; 12
	sta	$3480,Y		; 13
	sta	$3880,Y		; 14
	sta	$3C80,Y		; 15

	sta	$2100,Y		; 16
	sta	$2500,Y		; 17
	sta	$2900,Y		; 18
	sta	$2D00,Y		; 19
	sta	$3100,Y		; 20
	sta	$3500,Y		; 21
	sta	$3900,Y		; 22
	sta	$3D00,Y		; 23

	sta	$2180,Y		; 24
	sta	$2580,Y		; 25
	sta	$2980,Y		; 26
	sta	$2D80,Y		; 27
	sta	$3180,Y		; 28
	sta	$3580,Y		; 29
	sta	$3980,Y		; 30
	sta	$3D80,Y		; 31
.endif
	sta	$2200,Y		; 32
	sta	$2600,Y		; 33
	sta	$2A00,Y		; 34
	sta	$2E00,Y		; 35
	sta	$3200,Y		; 36
	sta	$3600,Y		; 37
	sta	$3A00,Y		; 38
	sta	$3E00,Y		; 39

	sta	$2280,Y		; 40
	sta	$2680,Y		; 41
	sta	$2A80,Y		; 42
	sta	$2E80,Y		; 43
	sta	$3280,Y		; 44
	sta	$3680,Y		; 45
	sta	$3A80,Y		; 46
	sta	$3E80,Y		; 47

	sta	$2300,Y		; 48
	sta	$2700,Y		; 49
	sta	$2B00,Y		; 50
	sta	$2F00,Y		; 51
	sta	$3300,Y		; 52
	sta	$3700,Y		; 53
	sta	$3B00,Y		; 54
	sta	$3F00,Y		; 55

	sta	$2380,Y		; 56
	sta	$2780,Y		; 57
	sta	$2B80,Y		; 58
	sta	$2F80,Y		; 59
	sta	$3380,Y		; 60
	sta	$3780,Y		; 61
	sta	$3B80,Y		; 62
	sta	$3F80,Y		; 63

	;=======

	sta	$2028,Y		; 64
	sta	$2428,Y		; 1
	sta	$2828,Y		; 2
	sta	$2C28,Y		; 3
	sta	$3028,Y		; 4
	sta	$3428,Y		; 5
	sta	$3828,Y		; 6
	sta	$3C28,Y		; 7

	sta	$20A8,Y		; 72
	sta	$24A8,Y		; 9
	sta	$28A8,Y		; 10
	sta	$2CA8,Y		; 11
	sta	$30A8,Y		; 12
	sta	$34A8,Y		; 13
	sta	$38A8,Y		; 14
	sta	$3CA8,Y		; 15

	sta	$2128,Y		; 80
	sta	$2528,Y		; 17
	sta	$2928,Y		; 18
	sta	$2D28,Y		; 19
	sta	$3128,Y		; 20
	sta	$3528,Y		; 21
	sta	$3928,Y		; 22
	sta	$3D28,Y		; 23

	sta	$21A8,Y		; 88
	sta	$25A8,Y		; 25
	sta	$29A8,Y		; 26
	sta	$2DA8,Y		; 27
	sta	$31A8,Y		; 28
	sta	$35A8,Y		; 29
	sta	$39A8,Y		; 30
	sta	$3DA8,Y		; 31

	sta	$2228,Y		; 96
	sta	$2628,Y		; 33
	sta	$2A28,Y		; 34
	sta	$2E28,Y		; 35
	sta	$3228,Y		; 36
	sta	$3628,Y		; 37
	sta	$3A28,Y		; 38
	sta	$3E28,Y		; 39

	sta	$22A8,Y		; 104
	sta	$26A8,Y		; 41
	sta	$2AA8,Y		; 42
	sta	$2EA8,Y		; 43
	sta	$32A8,Y		; 44
	sta	$36A8,Y		; 45
	sta	$3AA8,Y		; 46
	sta	$3EA8,Y		; 47

	sta	$2328,Y		; 112
	sta	$2728,Y		; 49
	sta	$2B28,Y		; 50
	sta	$2F28,Y		; 51
	sta	$3328,Y		; 52
	sta	$3728,Y		; 53
	sta	$3B28,Y		; 54
	sta	$3F28,Y		; 55

	sta	$23A8,Y		; 120
	sta	$27A8,Y		; 57
	sta	$2BA8,Y		; 58
	sta	$2FA8,Y		; 59
	sta	$33A8,Y		; 60
	sta	$37A8,Y		; 61
	sta	$3BA8,Y		; 62
	sta	$3FA8,Y		; 63

	;=========

	sta	$2050,Y		; 128
	sta	$2450,Y		; 1
	sta	$2850,Y		; 2
	sta	$2C50,Y		; 3
	sta	$3050,Y		; 4
	sta	$3450,Y		; 5
	sta	$3850,Y		; 6
	sta	$3C50,Y		; 7

	sta	$20D0,Y		; 136
	sta	$24D0,Y		; 9
	sta	$28D0,Y		; 10
	sta	$2CD0,Y		; 11
	sta	$30D0,Y		; 12
	sta	$34D0,Y		; 13
	sta	$38D0,Y		; 14
	sta	$3CD0,Y		; 15

	sta	$2150,Y		; 144
	sta	$2550,Y		; 17
	sta	$2950,Y		; 18
	sta	$2D50,Y		; 19
	sta	$3150,Y		; 20
	sta	$3550,Y		; 21
	sta	$3950,Y		; 22
	sta	$3D50,Y		; 23

	sta	$21D0,Y		; 152
	sta	$25D0,Y		; 25
	sta	$29D0,Y		; 26
	sta	$2DD0,Y		; 27
	sta	$31D0,Y		; 28
	sta	$35D0,Y		; 29
	sta	$39D0,Y		; 30
	sta	$3DD0,Y		; 31
.if 0
	sta	$2250,Y		; 160
	sta	$2650,Y		; 33
	sta	$2A50,Y		; 34
	sta	$2E50,Y		; 35
	sta	$3250,Y		; 36
	sta	$3650,Y		; 37
	sta	$3A50,Y		; 38
	sta	$3E50,Y		; 39

	sta	$22D0,Y		; 168
	sta	$26D0,Y		; 41
	sta	$2AD0,Y		; 42
	sta	$2ED0,Y		; 43
	sta	$32D0,Y		; 44
	sta	$36D0,Y		; 45
	sta	$3AD0,Y		; 46
	sta	$3ED0,Y		; 47

	sta	$2350,Y		; 176
	sta	$2750,Y		; 49
	sta	$2B50,Y		; 50
	sta	$2F50,Y		; 51
	sta	$3350,Y		; 52
	sta	$3750,Y		; 53
	sta	$3B50,Y		; 54
	sta	$3F50,Y		; 55

	sta	$23D0,Y		; 184
	sta	$27D0,Y		; 57
	sta	$2BD0,Y		; 58
	sta	$2FD0,Y		; 59
	sta	$33D0,Y		; 60
	sta	$37D0,Y		; 61
	sta	$3BD0,Y		; 62
	sta	$3FD0,Y		; 63
.endif
	iny
	cpy	#30
	beq	hgr_page1_cls_done
	jmp	hgr_page1_cls_loop

hgr_page1_cls_done:

	jmp	hgr_page2_cls_done


hgr_page2_clearscreen:

	ldy	#10
hgr_page2_cls_loop:
.if 0
	sta	$4000,Y		; 0
	sta	$4400,Y		; 1
	sta	$4800,Y		; 2
	sta	$4C00,Y		; 3
	sta	$5000,Y		; 4
	sta	$5400,Y		; 5
	sta	$5800,Y		; 6
	sta	$5C00,Y		; 7

	sta	$4080,Y		; 8
	sta	$4480,Y		; 9
	sta	$4880,Y		; 10
	sta	$4C80,Y		; 11
	sta	$5080,Y		; 12
	sta	$5480,Y		; 13
	sta	$5880,Y		; 14
	sta	$5C80,Y		; 15

	sta	$4100,Y		; 16
	sta	$4500,Y		; 17
	sta	$4900,Y		; 18
	sta	$4D00,Y		; 19
	sta	$5100,Y		; 20
	sta	$5500,Y		; 21
	sta	$5900,Y		; 22
	sta	$5D00,Y		; 23

	sta	$4180,Y		; 24
	sta	$4580,Y		; 25
	sta	$4980,Y		; 26
	sta	$4D80,Y		; 27
	sta	$5180,Y		; 28
	sta	$5580,Y		; 29
	sta	$5980,Y		; 30
	sta	$5D80,Y		; 31
.endif
	sta	$4200,Y		; 32
	sta	$4600,Y		; 33
	sta	$4A00,Y		; 34
	sta	$4E00,Y		; 35
	sta	$5200,Y		; 36
	sta	$5600,Y		; 37
	sta	$5A00,Y		; 38
	sta	$5E00,Y		; 39

	sta	$4280,Y		; 40
	sta	$4680,Y		; 41
	sta	$4A80,Y		; 42
	sta	$4E80,Y		; 43
	sta	$5280,Y		; 44
	sta	$5680,Y		; 45
	sta	$5A80,Y		; 46
	sta	$5E80,Y		; 47

	sta	$4300,Y		; 48
	sta	$4700,Y		; 49
	sta	$4B00,Y		; 50
	sta	$4F00,Y		; 51
	sta	$5300,Y		; 52
	sta	$5700,Y		; 53
	sta	$5B00,Y		; 54
	sta	$5F00,Y		; 55

	sta	$4380,Y		; 56
	sta	$4780,Y		; 57
	sta	$4B80,Y		; 58
	sta	$4F80,Y		; 59
	sta	$5380,Y		; 60
	sta	$5780,Y		; 61
	sta	$5B80,Y		; 62
	sta	$5F80,Y		; 63

	;=======

	sta	$4028,Y		; 64
	sta	$4428,Y		; 1
	sta	$4828,Y		; 2
	sta	$4C28,Y		; 3
	sta	$5028,Y		; 4
	sta	$5428,Y		; 5
	sta	$5828,Y		; 6
	sta	$5C28,Y		; 7

	sta	$40A8,Y		; 72
	sta	$44A8,Y		; 9
	sta	$48A8,Y		; 10
	sta	$4CA8,Y		; 11
	sta	$50A8,Y		; 12
	sta	$54A8,Y		; 13
	sta	$58A8,Y		; 14
	sta	$5CA8,Y		; 15

	sta	$4128,Y		; 80
	sta	$4528,Y		; 17
	sta	$4928,Y		; 18
	sta	$4D28,Y		; 19
	sta	$5128,Y		; 20
	sta	$5528,Y		; 21
	sta	$5928,Y		; 22
	sta	$5D28,Y		; 23

	sta	$41A8,Y		; 88
	sta	$45A8,Y		; 25
	sta	$49A8,Y		; 26
	sta	$4DA8,Y		; 27
	sta	$51A8,Y		; 28
	sta	$55A8,Y		; 29
	sta	$59A8,Y		; 30
	sta	$5DA8,Y		; 31

	sta	$4228,Y		; 96
	sta	$4628,Y		; 33
	sta	$4A28,Y		; 34
	sta	$4E28,Y		; 35
	sta	$5228,Y		; 36
	sta	$5628,Y		; 37
	sta	$5A28,Y		; 38
	sta	$5E28,Y		; 39

	sta	$42A8,Y		; 104
	sta	$46A8,Y		; 41
	sta	$4AA8,Y		; 42
	sta	$4EA8,Y		; 43
	sta	$52A8,Y		; 44
	sta	$56A8,Y		; 45
	sta	$5AA8,Y		; 46
	sta	$5EA8,Y		; 47

	sta	$4328,Y		; 112
	sta	$4728,Y		; 49
	sta	$4B28,Y		; 50
	sta	$4F28,Y		; 51
	sta	$5328,Y		; 52
	sta	$5728,Y		; 53
	sta	$5B28,Y		; 54
	sta	$5F28,Y		; 55

	sta	$43A8,Y		; 120
	sta	$47A8,Y		; 57
	sta	$4BA8,Y		; 58
	sta	$4FA8,Y		; 59
	sta	$53A8,Y		; 60
	sta	$57A8,Y		; 61
	sta	$5BA8,Y		; 62
	sta	$5FA8,Y		; 63

	;=========

	sta	$4050,Y		; 128
	sta	$4450,Y		; 1
	sta	$4850,Y		; 2
	sta	$4C50,Y		; 3
	sta	$5050,Y		; 4
	sta	$5450,Y		; 5
	sta	$5850,Y		; 6
	sta	$5C50,Y		; 7

	sta	$40D0,Y		; 136
	sta	$44D0,Y		; 9
	sta	$48D0,Y		; 10
	sta	$4CD0,Y		; 11
	sta	$50D0,Y		; 12
	sta	$54D0,Y		; 13
	sta	$58D0,Y		; 14
	sta	$5CD0,Y		; 15

	sta	$4150,Y		; 144
	sta	$4550,Y		; 17
	sta	$4950,Y		; 18
	sta	$4D50,Y		; 19
	sta	$5150,Y		; 20
	sta	$5550,Y		; 21
	sta	$5950,Y		; 22
	sta	$5D50,Y		; 23

	sta	$41D0,Y		; 152
	sta	$45D0,Y		; 25
	sta	$49D0,Y		; 26
	sta	$4DD0,Y		; 27
	sta	$51D0,Y		; 28
	sta	$55D0,Y		; 29
	sta	$59D0,Y		; 30
	sta	$5DD0,Y		; 31
.if 0
	sta	$4250,Y		; 160
	sta	$4650,Y		; 33
	sta	$4A50,Y		; 34
	sta	$4E50,Y		; 35
	sta	$5250,Y		; 36
	sta	$5650,Y		; 37
	sta	$5A50,Y		; 38
	sta	$5E50,Y		; 39

	sta	$42D0,Y		; 168
	sta	$46D0,Y		; 41
	sta	$4AD0,Y		; 42
	sta	$4ED0,Y		; 43
	sta	$52D0,Y		; 44
	sta	$56D0,Y		; 45
	sta	$5AD0,Y		; 46
	sta	$5ED0,Y		; 47

	sta	$4350,Y		; 176
	sta	$4750,Y		; 49
	sta	$4B50,Y		; 50
	sta	$4F50,Y		; 51
	sta	$5350,Y		; 52
	sta	$5750,Y		; 53
	sta	$5B50,Y		; 54
	sta	$5F50,Y		; 55

	sta	$43D0,Y		; 184
	sta	$47D0,Y		; 57
	sta	$4BD0,Y		; 58
	sta	$4FD0,Y		; 59
	sta	$53D0,Y		; 60
	sta	$57D0,Y		; 61
	sta	$5BD0,Y		; 62
	sta	$5FD0,Y		; 63
.endif
	iny
	cpy	#30
	beq	hgr_page2_cls_done
	jmp	hgr_page2_cls_loop
hgr_page2_cls_done:
;	rts

