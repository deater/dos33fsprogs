include ../../../Makefile.inc

LINKER_SCRIPTS = ../../../linker_scripts/


all:	DISK06 ATRUS_JOURNAL

####

DISK06:	disk06.o
	ld65 -o DISK06 disk06.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

disk06.o:	disk06.s ../zp.inc
	ca65 -o disk06.o disk06.s -l disk06.lst

####

ATRUS_JOURNAL:	atrus_journal.o
	ld65 -o ATRUS_JOURNAL atrus_journal.o -C $(LINKER_SCRIPTS)/apple2_4000.inc

atrus_journal.o:	atrus_journal.s \
		../zp.inc ../hardware.inc ../qload.inc \
		../common_defines.inc disk06_defines.inc
	ca65 -o atrus_journal.o atrus_journal.s -l atrus_journal.lst

####

clean:		
	rm -f *~ *.o *.lst DISK06 \
		ATRUS_JOURNAL

####

distclean:
	rm -f *~ *.o *.lst DISK06 \
		ATRUS_JOURNAL


