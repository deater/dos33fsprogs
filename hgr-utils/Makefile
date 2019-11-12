include ../Makefile.inc

CFLAGS = -O2 -Wall -g

all:	pcx2hgr png2hgr shape_table dump_table

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

png2hgr:		png2hgr.o
			$(CC) -o png2hgr png2hgr.o $(LFLAGS) -lpng

png2hgr.o:		png2hgr.c
			$(CC) $(CFLAGS) -c png2hgr.c



install:	
		cp pcx2hgr shape_table png2hgr $(INSTALL_LOC)

clean:		
		rm -f *~ *.o pcx2hgr shape_table dump_table png2hgr

