include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	WBOOT2 WBOOT3 WBOOT4 WBOOT5

###

WBOOT2:	wrong_boot2.o
	ld65 -o WBOOT2 wrong_boot2.o -C $(LINKER_SCRIPTS)/apple2_800.inc

wrong_boot2.o: 	wrong_boot2.s
	ca65 -o wrong_boot2.o wrong_boot2.s -l wrong_boot2.lst

###

WBOOT3:	wrong_boot3.o
	ld65 -o WBOOT3 wrong_boot3.o -C $(LINKER_SCRIPTS)/apple2_800.inc

wrong_boot3.o: 	wrong_boot3.s
	ca65 -o wrong_boot3.o wrong_boot3.s -l wrong_boot3.lst

###

WBOOT4:	wrong_boot4.o
	ld65 -o WBOOT4 wrong_boot4.o -C $(LINKER_SCRIPTS)/apple2_800.inc

wrong_boot4.o: 	wrong_boot4.s
	ca65 -o wrong_boot4.o wrong_boot4.s -l wrong_boot4.lst

###

WBOOT5:	wrong_boot5.o
	ld65 -o WBOOT5 wrong_boot5.o -C $(LINKER_SCRIPTS)/apple2_800.inc

wrong_boot5.o: 	wrong_boot5.s
	ca65 -o wrong_boot5.o wrong_boot5.s -l wrong_boot5.lst



###

distclean:
	make clean

###

clean:	
	rm -f *~ *.o *.lst WBOOT2 WBOOT3 WBOOT4 WBOOT5

