include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	TITLE

####

TITLE:	title.o
	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_d00.inc

title.o:	title.s loader.s
	ca65 -o title.o title.s -l title.lst

#####

clean:		
	rm -f *~ *.o *.lst TITLE

#####

distclean:		
	make clean

