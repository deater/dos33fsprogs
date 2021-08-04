include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	z.dsk z

z.dsk:	HELLO ARCS.BAS
	cp $(EMPTY_DISK) z.dsk
	$(DOS33) -y z.dsk SAVE A HELLO
	$(DOS33) -y z.dsk SAVE A ARCS.BAS

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

ARCS.BAS:	arcs.bas
	$(TOKENIZE) < arcs.bas > ARCS.BAS

####

z:	z.o
	$(CC) $(LFLAGS) -o z z.o

z.o:	z.c
	$(CC) $(CFLAGS) -c z.c

####


clean:
	rm -f *~ *.o *.lst HELLO z

