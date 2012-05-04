CC = gcc
CFLAGS = -O2 -Wall
LFLAGS = 


all:	test.dsk

test.dsk:	TEST VINCE.IMG
	../dos33 test.dsk SAVE A TEST
	../dos33 test.dsk SAVE B VINCE.IMG


VINCE.IMG:	vince.pcx ../pcx2hgr
	../pcx2hgr vince.pcx > VINCE.IMG

TEST:	test.bas
	../tokenize_asoft < test.bas > TEST

test.bas:		generate_presentation
	./generate_presentation test > test.bas

generate_presentation:	generate_presentation.o
	$(CC) $(LFLAGS) -o generate_presentation generate_presentation.o

generate_presentations.o:	generate_presentation.c
	$(CC) $(CFLAGS) -c generate_presentation.c

clean:	
	rm -f *~ *.o generate_presentation

