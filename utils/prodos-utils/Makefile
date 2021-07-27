include ../../Makefile.inc

all:	prodos mkprodosfs

###

prodos:			prodos.o \
			prodos_read.o \
			prodos_catalog.o \
			prodos_dump.o \
			prodos_volume_bitmap.o
			$(CC) -o prodos prodos.o \
				prodos_read.o \
				prodos_catalog.o \
				prodos_dump.o \
				prodos_volume_bitmap.o $(LFLAGS)

prodos.o:		prodos.c prodos.h
			$(CC) $(CFLAGS) -g -c prodos.c


###

mkprodosfs:		mkprodosfs.o prodos_read.o prodos_volume_bitmap.o
			$(CC) $(LFLAGS) -o mkprodosfs mkprodosfs.o \
				prodos_read.o prodos_volume_bitmap.o

mkprodosfs.o:		mkprodosfs.c prodos.h
			$(CC) $(CFLAGS) -c mkprodosfs.c

###

prodos_volume_bitmap.o:		prodos_volume_bitmap.c prodos.h
			$(CC) $(CFLAGS) -c prodos_volume_bitmap.c

###

prodos_catalog.o:	prodos_catalog.c prodos.h
			$(CC) $(CFLAGS) -c prodos_catalog.c

###

prodos_dump.o:		prodos_dump.c prodos.h
			$(CC) $(CFLAGS) -c prodos_dump.c

###

prodos_read.o:		prodos_read.c prodos.h
			$(CC) $(CFLAGS) -c prodos_read.c

###


install:	
		cp prodos prodos_raw mkprodosfs make_b prodos_text2ascii char2hex $(INSTALL_LOC)

clean:		
		rm -f *~ *.o prodos prodos_raw mkprodosfs make_b prodos_text2ascii char2hex
		cd tests && make clean
