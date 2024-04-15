

; we could calculate this if necessary

tilemap_lookup_high:
.byte	(>big_tilemap)+ 0,(>big_tilemap)+ 0	; 0,1
.byte	(>big_tilemap)+ 1,(>big_tilemap)+ 1	; 2,3
.byte	(>big_tilemap)+ 2,(>big_tilemap)+ 2	; 4,5
.byte	(>big_tilemap)+ 3,(>big_tilemap)+ 3	; 6,7
.byte	(>big_tilemap)+ 4,(>big_tilemap)+ 4	; 8,9
.byte	(>big_tilemap)+ 5,(>big_tilemap)+ 5	; 10,11
.byte	(>big_tilemap)+ 6,(>big_tilemap)+ 6	; 12,13
.byte	(>big_tilemap)+ 7,(>big_tilemap)+ 7 	; 14,15
.byte	(>big_tilemap)+ 8,(>big_tilemap)+ 8	; 16,17
.byte	(>big_tilemap)+ 9,(>big_tilemap)+ 9	; 18,19
.byte	(>big_tilemap)+10,(>big_tilemap)+10	; 20,21
.byte	(>big_tilemap)+11,(>big_tilemap)+11	; 22,23
.byte	(>big_tilemap)+12,(>big_tilemap)+12	; 24,25
.byte	(>big_tilemap)+13,(>big_tilemap)+13	; 26,27
.byte	(>big_tilemap)+14,(>big_tilemap)+14	; 28,29
.byte	(>big_tilemap)+15,(>big_tilemap)+15	; 30,31
.byte	(>big_tilemap)+16,(>big_tilemap)+16	; 32,33
.byte	(>big_tilemap)+17,(>big_tilemap)+17 	; 34,35
.byte	(>big_tilemap)+18,(>big_tilemap)+18	; 36,37
.byte	(>big_tilemap)+19,(>big_tilemap)+19	; 38,39
.byte	(>big_tilemap)+20,(>big_tilemap)+20	; 40,41
.byte	(>big_tilemap)+21,(>big_tilemap)+21	; 42,43
.byte	(>big_tilemap)+22,(>big_tilemap)+22	; 44,45
.byte	(>big_tilemap)+23,(>big_tilemap)+23	; 46,47
.byte	(>big_tilemap)+24,(>big_tilemap)+24	; 48,49
.byte	(>big_tilemap)+25,(>big_tilemap)+25	; 50,51
.byte	(>big_tilemap)+26,(>big_tilemap)+26	; 52,53
.byte	(>big_tilemap)+27,(>big_tilemap)+27 	; 54,55
.byte	(>big_tilemap)+28,(>big_tilemap)+28	; 56,57
.byte	(>big_tilemap)+29,(>big_tilemap)+29	; 58,59
.byte	(>big_tilemap)+30,(>big_tilemap)+30	; 60,61
.byte	(>big_tilemap)+31,(>big_tilemap)+31	; 62,63
.byte	(>big_tilemap)+32,(>big_tilemap)+32	; 64,65
.byte	(>big_tilemap)+33,(>big_tilemap)+33	; 66,67
.byte	(>big_tilemap)+34,(>big_tilemap)+34	; 68,69
.byte	(>big_tilemap)+35,(>big_tilemap)+35	; 70,71
.byte	(>big_tilemap)+36,(>big_tilemap)+36	; 72,73
.byte	(>big_tilemap)+37,(>big_tilemap)+37 	; 74,75
.byte	(>big_tilemap)+38,(>big_tilemap)+38	; 76,77
.byte	(>big_tilemap)+39,(>big_tilemap)+39	; 78,79

tilemap_lookup_low:
.byte	$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80
.byte	$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80
.byte	$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80
.byte	$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80
.byte	$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80
.byte	$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80
.byte	$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80
.byte	$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80
.byte	$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80
.byte	$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80,$00,$80
