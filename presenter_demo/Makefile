CC = gcc
CFLAGS = -O2 -Wall
LFLAGS = 

all:	presenter_demo.dsk

presenter_demo.dsk:	PRESENTER_DEMO VINCE.IMG
	../dos33 presenter_demo.dsk SAVE A PRESENTER_DEMO
	../dos33 presenter_demo.dsk SAVE B VINCE.IMG


VINCE.IMG:	vince.pcx ../pcx2hgr
	../pcx2hgr vince.pcx > VINCE.IMG

PRESENTER_DEMO:	demo.bas
	../tokenize_asoft < demo.bas > PRESENTER_DEMO

demo.bas:		../asoft_presenter
	../asoft_presenter . > demo.bas

clean:	
	rm -f *~ *.IMG *.bas PRESENTER_DEMO

