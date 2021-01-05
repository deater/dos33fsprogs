; flame:	clean
; a2:		clean
; flyer:	clean
; nyan:		clean
; rle:		??
; autumn:	??
; raster:	??
; qr:		??
; circles:	??


todo_list:

	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,5	; flame
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,15	; a2
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; flyer
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,20	; nyan
	.byte	DO_LOAD,1,	DO_LIST,1,	DO_RUN,20	; raster
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,35	; qr
	.byte	DO_LOAD,1,	DO_LIST,1,	DO_RUN,12	; dhgr
	.byte	DO_LOAD,1,	DO_LIST,1,	DO_RUN,10	; circles
	.byte	DO_LOAD,1,	DO_LIST,1,	DO_RUN,10	; autumn
	.byte	DO_CREDITS,$FF
	.byte	DONE,$FF


;	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,15	; rle



file_list:
	.word	flame,flame_end			; 0
	.word	a2,a2_end			; 1
	.word	flyer,flyer_end			; 2
	.word	nyan,nyan_end			; 3
	.word	raster,raster_end		; 4
	.word	qr,qr_end			; 5
	.word	dhgr,dhgr_end			; 6
	.word	circles,circles_end		; 7
	.word	autumn,autumn_end		; 8


;	.word	rle,rle_end



title_list:
	.word	flame_title
	.word	a2_title
	.word	flyer_title
	.word	nyan_title
;	.word	rle_title
	.word	raster_title
	.word	qr_title
	.word	dhgr_title
	.word	circles_title
	.word	autumn_title



;              0123456789012345678901234567890123456789
flame_title:
	.byte "             PSX DOOM FIRE              "
a2_title:
	.byte "          LO-RES SELF PORTRAIT          "
flyer_title:
	.byte "         HI-RES SHAPETABLE FLYER        "
nyan_title:
	.byte "        HI-RES ANIMATED NYAN CAT        "
qr_title:
	.byte "    BAR CODE WILL NEVER LET YOU DOWN    "
autumn_title:
	.byte "             HI-RES FRACTAL             "
;rle_title:
;	.byte "               RLE SHAPES               "
circles_title:
	.byte "            HYPNOTIC CIRCLES            "
dhgr_title:
	.byte "              DHGR PATTERN              "
raster_title:
	.byte "             DHGR COLOR BARS            "


flyer:
.incbin	"FLYER.BAS"
flyer_end:

nyan:
.incbin	"NYAN.BAS"
nyan_end:

qr:
.incbin	"QR.BAS"
qr_end:

flame:
.incbin	"FLAME2.BAS"
flame_end:

a2:
.incbin	"A2.BAS"
a2_end:

autumn:
.incbin	"AUTUMN.BAS"
autumn_end:

;rle:
;.incbin "RLE.BAS"
;rle_end:

raster:
.incbin "RASTER4.BAS"
raster_end:

dhgr:
.incbin "DHGR.BAS"
dhgr_end:

circles:
.incbin "CIRCLES.BAS"
circles_end:
