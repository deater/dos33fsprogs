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

	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; flame
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; a2
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; flyer
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; nyan
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; autumn
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; rle
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; raster
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; dhgr
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; qr
	.byte	DO_LOAD,1,	DO_LIST,4,	DO_RUN,10	; circles
	.byte	DONE,$FF


file_list:
	.word	flame,flame_end
	.word	a2,a2_end
	.word	flyer,flyer_end
	.word	nyan,nyan_end
	.word	autumn,autumn_end
	.word	rle,rle_end
	.word	raster,raster_end
	.word	dhgr,dhgr_end
	.word	qr,qr_end
	.word	circles,circles_end

title_list:
	.word	flyer_title
	.word	nyan_title
	.word	qr_title

flyer_title:
	.byte 8,10,"HI-RES SHAPETABLE FLYER",0
nyan_title:
	.byte 8,10,"HI-RES ANIMATED NYAN CAT",0
qr_title:
	.byte 0,10,"MYSTERY BAR CODE WILL NEVER LET YOU DOWN",0


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

rle:
.incbin "RLE.BAS"
rle_end:

raster:
.incbin "RASTER4.BAS"
raster_end:

dhgr:
.incbin "DHGR.BAS"
dhgr_end:

circles:
.incbin "CIRCLES.BAS"
circles_end:
