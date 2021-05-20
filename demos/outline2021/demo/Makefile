include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
DOS33_RAW = ../../../utils/dos33fs-utils/dos33_raw
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
LINKER_SCRIPTS = ../../../linker_scripts
EMPTY_DISK = ../../../empty_disk

all:	outline2021.dsk

#outline2021.dsk:	HELLO QBOOT QLOAD OUTLINE
#	cp $(EMPTY_DISK)/empty.dsk outline2021.dsk
#	$(DOS33) -y outline2021.dsk SAVE A HELLO
#	$(DOS33) -y outline2021.dsk BSAVE -a 0x6000 OUTLINE

outline2021.dsk:	QBOOT QLOAD OUTLINE
	cp $(EMPTY_DISK)/empty.dsk outline2021.dsk
	$(DOS33_RAW) outline2021.dsk  0  0 QBOOT               0   1
	$(DOS33_RAW) outline2021.dsk  0  2 QBOOT	       1   1
	$(DOS33_RAW) outline2021.dsk  0  4 QBOOT               2   1
	$(DOS33_RAW) outline2021.dsk  1  0 QLOAD               0   14
	$(DOS33_RAW) outline2021.dsk  2  0 OUTLINE             0   0

submit:	outline2021_island_submit.zip

outline2021_island_submit.zip:	OUTLINE file_id.diz outline2021.dsk
	mkdir -p outline2021_island
	cp OUTLINE ./outline2021_island
	cp file_id.diz ./outline2021_island
	cp outline2021.dsk ./outline2021_island
	zip -r outline2021_island.zip outline2021_island
	mkdir -p outline2021_island_submit
	cp outline_island_720p.mp4 ./outline2021_island_submit
	cp outline2021_island.zip ./outline2021_island_submit
	zip -r outline2021_island_submit.zip outline2021_island_submit


####

QLOAD:	qload.o
	ld65 -o QLOAD qload.o -C $(LINKER_SCRIPTS)/apple2_1600.inc

qload.o:	qload.s qboot.inc
	ca65 -o qload.o qload.s -l qload.lst

####

QBOOT:    qboot_sector.o
	ld65 -o QBOOT qboot_sector.o -C $(LINKER_SCRIPTS)/apple2_800.inc

qboot_sector.o:	qboot_sector.s qboot_stage2.s
	ca65 -o qboot_sector.o qboot_sector.s -l qboot_sector.lst



###

#HELLO:	hello.bas
#	$(TOKENIZE) < hello.bas > HELLO

###

OUTLINE:	outline.o
	ld65 -o OUTLINE outline.o -C apple2_5000.inc

outline.o:	outline.s zp.inc \
	pt3_lib_mockingboard_setup.s \
	shimmer.s a2_inside.s drops.s wires.s \
	rotoplasma_tiny.s rocket_away.s anothermist.s \
	flying_dir.inc tfv_flying.s flying_mode7.s credits.s
	ca65 -o outline.o outline.s -l outline.lst

###

clean:	
	rm -f *~ *.o *.lst HELLO OUTLINE QLOAD QBOOT

