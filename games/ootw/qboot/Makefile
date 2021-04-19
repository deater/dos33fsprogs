include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts

all:	QBOOT_DISK1 QBOOT_DISK2 QBOOT_DISK3 QLOAD


#TITLE:	title.o
#	ld65 -o TITLE title.o -C $(LINKER_SCRIPTS)/apple2_d00.inc
#
#title.o:	title.s qload.s
#	ca65 -o title.o title.s -l title.lst

####

QBOOT_DISK1:	qboot_sector_d1.o
	ld65 -o QBOOT_DISK1 qboot_sector_d1.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector_d1.o:	qboot_sector.s qboot_stage2.s
	ca65 -o qboot_sector_d1.o -DDISK=1 qboot_sector.s -l qboot_sector_d1.lst

####

QBOOT_DISK2:	qboot_sector_d2.o
	ld65 -o QBOOT_DISK2 qboot_sector_d2.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector_d2.o:	qboot_sector.s qboot_stage2.s
	ca65 -o qboot_sector_d2.o -DDISK=2 qboot_sector.s -l qboot_sector_d2.lst

####

QBOOT_DISK3:	qboot_sector_d3.o
	ld65 -o QBOOT_DISK3 qboot_sector_d3.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector_d3.o:	qboot_sector.s qboot_stage2.s
	ca65 -o qboot_sector_d3.o -DDISK=3 qboot_sector.s -l qboot_sector_d3.lst



####

QLOAD: qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1600.inc

qload.o:        qload.s qboot.inc common_defines.inc title.s
	ca65 -o qload.o qload.s -l qload.lst


#####

clean:		
	rm -f *~ *.o *.lst QBOOT_DISK1 QBOOT_DISK2 QBOOT_DISK3 QBOOT  QLOAD TITLE

#####

distclean:		
	make clean

