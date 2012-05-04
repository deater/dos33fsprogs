CC = gcc
CFLAGS = -O2 -Wall
LFLAGS = 

all:	presenter_demo.dsk

presenter_demo.dsk:	TEST VINCE.IMG
	../dos33 presenter_demo.dsk SAVE A TEST
	../dos33 presenter_demo.dsk SAVE B VINCE.IMG


VINCE.IMG:	vince.pcx ../pcx2hgr
	../pcx2hgr vince.pcx > VINCE.IMG

TEST:	test.bas
	../tokenize_asoft < test.bas > TEST

test.bas:		../asoft_presenter
	../asoft_presenter . > test.bas

clean:	
	rm -f *~ *.IMG *.bas

