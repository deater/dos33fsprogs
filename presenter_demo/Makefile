CC = gcc
CFLAGS = -O2 -Wall
LFLAGS = 

all:	presenter_demo.dsk

presenter_demo.dsk:	PRESENTER_DEMO TITLE.IMG NUM.SHAPE MMM
	../dos33 presenter_demo.dsk SAVE A PRESENTER_DEMO
	../dos33 presenter_demo.dsk SAVE B TITLE.IMG
	../dos33 presenter_demo.dsk SAVE B NUM.SHAPE
	../dos33 presenter_demo.dsk SAVE A MMM


MMM:		mmm.bas
	../tokenize_asoft < mmm.bas > MMM

NUM.SHAPE:	num.table
	../shape_table -b < num.table > NUM.SHAPE

TITLE.IMG:	title.pcx ../pcx2hgr
	../pcx2hgr title.pcx > TITLE.IMG

PRESENTER_DEMO:	demo.bas
	../tokenize_asoft < demo.bas > PRESENTER_DEMO

demo.bas:		../asoft_presenter
	../asoft_presenter . > demo.bas

clean:	
	rm -f *~ *.IMG demo.bas PRESENTER_DEMO NUM.SHAPE MMM

