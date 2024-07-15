include ../../Makefile.inc

EMPTY_DISK = ../../empty_disk/
LINKER_SCRIPTS = ../../linker_scripts/
CADIUS = ~/research/apple2/cadius/bin/release/cadius
PRODOSDIR = ../../utils/prodos-utils/
PRODOS = ../../utils/prodos-utils/prodos

all:	prorwts_test.2mg

# Note: cadius, put #XXYYYY after filename for type/value

#prorwts_test.po:	disk01_files/LEVEL_ARRIVAL prorwts_ca65.o
#	$(PRODOSDIR)/mkprodosfs prorwts_test.po -n Test

prorwts_ca65.o:	prorwts_ca65.s
	ca65 -o prorwts_ca65.o prorwts_ca65.s -l prorwts_ca65.lst

###

prorwts_test.2mg:	\
	PROBOOTHD
	$(CADIUS) CREATEVOLUME prorwts_test.2mg Test 32MB
	dd conv=notrunc if=PROBOOTHD of=prorwts_test.2mg bs=512 count=1
#	$(CADIUS) CREATEFOLDER prorwts_test.2mg /Test/DISK01
#	$(CADIUS) CREATEFOLDER prorwts_test.2mg /Test/DISK39
#	$(CADIUS) CREATEFOLDER prorwts_test.2mg /Test/DISK40
#	$(CADIUS) CREATEFOLDER prorwts_test.2mg /Test/DISK41
#	$(CADIUS) CREATEFOLDER prorwts_test.2mg /Test/DISK43
#	$(CADIUS) ADDFILE  prorwts_test.2mg  /Test/DISK01/ disk01_files/LEVEL_ARRIVAL


###
PROBOOTHD:	proboothd.o
	ld65 -o PROBOOTHD proboothd.o -C $(LINKER_SCRIPTS)/apple2_800.inc

proboothd.o:	proboothd.s
	ca65 -o proboothd.o proboothd.s -l proboothd.lst

####

clean:		
	rm -f *~ *.o *.lst
