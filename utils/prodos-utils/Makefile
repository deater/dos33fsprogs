include ../../Makefile.inc

CFLAGS := $(CFLAGS) -g

all:	prodos mkprodosfs prodos_cat text_to_prodos prodos_raw

###

prodos:			prodos.o \
			prodos_readwrite.o \
			prodos_catalog.o \
			prodos_dump.o \
			prodos_volume_bitmap.o \
			prodos_voldir.o \
			prodos_time.o \
			prodos_2mg.o
			$(CC) -o prodos prodos.o \
				prodos_readwrite.o \
				prodos_catalog.o \
				prodos_dump.o \
				prodos_volume_bitmap.o \
				prodos_voldir.o \
				prodos_time.o \
				prodos_2mg.o $(LFLAGS)

prodos.o:		prodos.c prodos.h
			$(CC) $(CFLAGS) -g -c prodos.c


###

prodos_cat:	prodos_cat.o
	$(CC) $(LFLAGS) -o prodos_cat prodos_cat.o

prodos_cat.o:	prodos_cat.c
	$(CC) $(CFLAGS) -c prodos_cat.c

###

prodos_raw:	prodos_raw.o prodos_2mg.o
	$(CC) $(LFLAGS) -o prodos_raw prodos_raw.o prodos_2mg.o

prodos_raw.o:	prodos_raw.c
	$(CC) $(CFLAGS) -c prodos_raw.c



###

text_to_prodos:	text_to_prodos.o
	$(CC) $(LFLAGS) -o text_to_prodos text_to_prodos.o

####

text_to_prodos.o:	text_to_prodos.c
	$(CC) $(CFLAGS) -c text_to_prodos.c



###

mkprodosfs:		mkprodosfs.o prodos_readwrite.o prodos_volume_bitmap.o \
				prodos_voldir.o prodos_time.o prodos_2mg.o
			$(CC) $(LFLAGS) -o mkprodosfs mkprodosfs.o \
				prodos_readwrite.o prodos_volume_bitmap.o \
				prodos_voldir.o prodos_time.o prodos_2mg.o

mkprodosfs.o:		mkprodosfs.c prodos.h
			$(CC) $(CFLAGS) -c mkprodosfs.c

###

prodos_2mg.o:	prodos_2mg.c prodos.h
			$(CC) $(CFLAGS) -c prodos_2mg.c

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

prodos_readwrite.o:		prodos_readwrite.c prodos.h
			$(CC) $(CFLAGS) -c prodos_readwrite.c

###

prodos_voldir.o:	prodos_voldir.c prodos.h
			$(CC) $(CFLAGS) -c prodos_voldir.c

###

prodos_time.o:	prodos_time.c prodos.h
			$(CC) $(CFLAGS) -c prodos_time.c


###


install:	
		cp prodos prodos_raw mkprodosfs prodos_cat text_to_prodos $(INSTALL_LOC)

clean:		
		rm -f *~ *.o prodos prodos_raw mkprodosfs prodos_cat text_to_prodos

