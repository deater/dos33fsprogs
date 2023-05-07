include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG2DGR = ../../utils/gr-utils/png2dgr
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	make_dgr_viewer

###

make_dgr_viewer:	make_dgr_viewer.o
	$(CC) $(LFLAGS) -o make_dgr_viewer make_dgr_viewer.o

make_dgr_viewer.o:	make_dgr_viewer.c
	$(CC) $(CFLAGS) -c make_dgr_viewer.c

###

clean:	
	rm -f *~ *.o DGR_VIEW *.lst make_dgr_viewer

