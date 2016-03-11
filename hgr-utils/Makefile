include ../Makefile.inc

all:	pcx2hgr shape_table


shape_table:		shape_table.o
			$(CC) $(LFLAGS) -o shape_table shape_table.o

shape_table.o:		shape_table.c
			$(CC) $(CFLAGS) -c shape_table.c

pcx2hgr:		pcx2hgr.o
			$(CC) $(LFLAGS) -o pcx2hgr pcx2hgr.o

pcx2hgr.o:		pcx2hgr.c
			$(CC) $(CFLAGS) -c pcx2hgr.c


install:	
		cp pcx2hgr shape_table $(INSTALL_LOC)

clean:		
		rm -f *~ *.o pcx2hgr shape_table


