include ../../Makefile.inc

CFLAGS = -O2 -Wall -g

all:	pcx2hgr png2hgr png2dhgr shape_table dump_table hgr2png hgr_make_sprite

dump_table:		dump_table.o
			$(CC) -o dump_table dump_table.o $(LFLAGS)

dump_table.o:		dump_table.c
			$(CC) $(CFLAGS) -c dump_table.c


shape_table:		shape_table.o
			$(CC) -o shape_table shape_table.o $(LFLAGS)

shape_table.o:		shape_table.c
			$(CC) $(CFLAGS) -c shape_table.c

pcx2hgr:		pcx2hgr.o
			$(CC) -o pcx2hgr pcx2hgr.o $(LFLAGS)

pcx2hgr.o:		pcx2hgr.c
			$(CC) $(CFLAGS) -c pcx2hgr.c
###

png2hgr:		png2hgr.o
			$(CC) -o png2hgr png2hgr.o $(LFLAGS) -lpng

png2hgr.o:		png2hgr.c
			$(CC) $(CFLAGS) -c png2hgr.c

###

hgr_make_sprite:		hgr_make_sprite.o
			$(CC) -o hgr_make_sprite hgr_make_sprite.o $(LFLAGS) -lpng

hgr_make_sprite.o:		hgr_make_sprite.c
			$(CC) $(CFLAGS) -c hgr_make_sprite.c


###

hgr2png:		hgr2png.o
			$(CC) -o hgr2png hgr2png.o $(LFLAGS) -lpng

hgr2png.o:		hgr2png.c
			$(CC) $(CFLAGS) -c hgr2png.c

###

png2dhgr:		png2dhgr.o
			$(CC) -o png2dhgr png2dhgr.o $(LFLAGS) -lpng

png2dhgr.o:		png2dhgr.c
			$(CC) $(CFLAGS) -c png2dhgr.c



install:	
		cp pcx2hgr shape_table png2hgr hgr2png hgr_make_sprite $(INSTALL_LOC)

clean:		
		rm -f *~ *.o pcx2hgr shape_table dump_table png2hgr png2dhgr hgr2png hgr_make_sprite

