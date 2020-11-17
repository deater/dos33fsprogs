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

	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; autumn
	.byte	DO_CREDITS,$FF
	.byte	DONE,$FF

	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,15	; a2
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; flyer
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,15	; nyan
;	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,15	; rle
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,15	; raster
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,15	; qr
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; dhgr
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; circles





file_list:
	.word	flame,flame_end
	.word	autumn,autumn_end

	.word	a2,a2_end
	.word	flyer,flyer_end
	.word	nyan,nyan_end
;	.word	rle,rle_end
	.word	raster,raster_end
	.word	qr,qr_end
	.word	dhgr,dhgr_end
	.word	circles,circles_end



title_list:
	.word	flame_title
	.word	autumn_title

	.word	a2_title
	.word	flyer_title
	.word	nyan_title
;	.word	rle_title
	.word	raster_title
	.word	qr_title
	.word	dhgr_title
	.word	circles_title


;              0123456789012345678901234567890123456789
flame_title:
	.byte "             PSX DOOM FIRE              "
a2_title:
	.byte "          LO-RES SELF PORTRAIT          "
flyer_title:
	.byte "        HI-RES SHAPETABLE FLYER         "
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
