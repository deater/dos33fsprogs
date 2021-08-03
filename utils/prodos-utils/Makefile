include ../../Makefile.inc

CFLAGS := $(CFLAGS) -g

all:	prodos mkprodosfs prodos_cat text_to_prodos

###

prodos:			prodos.o \
			prodos_read.o \
			prodos_catalog.o \
			prodos_dump.o \
			prodos_volume_bitmap.o \
			prodos_voldir.o
			$(CC) -o prodos prodos.o \
				prodos_read.o \
				prodos_catalog.o \
				prodos_dump.o \
				prodos_volume_bitmap.o \
				prodos_voldir.o $(LFLAGS)

prodos.o:		prodos.c prodos.h
			$(CC) $(CFLAGS) -g -c prodos.c


###

prodos_cat:	prodos_cat.o
	$(CC) $(LFLAGS) -o prodos_cat prodos_cat.o

####

prodos_cat.o:	prodos_cat.c
	$(CC) $(CFLAGS) -c prodos_cat.c


###

text_to_prodos:	text_to_prodos.o
	$(CC) $(LFLAGS) -o text_to_prodos text_to_prodos.o

####

text_to_prodos.o:	text_to_prodos.c
	$(CC) $(CFLAGS) -c text_to_prodos.c



###

mkprodosfs:		mkprodosfs.o prodos_read.o prodos_volume_bitmap.o \
				prodos_voldir.o
			$(CC) $(LFLAGS) -o mkprodosfs mkprodosfs.o \
				prodos_read.o prodos_volume_bitmap.o \
				prodos_voldir.o

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

prodos_voldir.o:	prodos_voldir.c prodos.h
			$(CC) $(CFLAGS) -c prodos_voldir.c


###


install:	
		cp prodos mkprodosfs prodoscat text_to_prodos $(INSTALL_LOC)

clean:		
		rm -f *~ *.o prodos mkprodosfs prodoscat text_to_prodos

