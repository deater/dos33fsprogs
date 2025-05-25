include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../linker_scripts/

all:	starpath.dsk

starpath.dsk:	HELLO STARPATH STARPATH_QUIET
	cp $(EMPTYDISK) starpath.dsk
	$(DOS33) -y starpath.dsk SAVE A HELLO
	$(DOS33) -y starpath.dsk BSAVE -a 0x62 STARPATH
	$(DOS33) -y starpath.dsk BSAVE -a 0x62 STARPATH_QUIET

###

submit:	starpath.zip starpath_small.zip

starpath.zip:	STARPATH STARPATH_QUIET starpath.s file_id.diz starpath.dsk
	mkdir -p outline2025_starpath
	cp STARPATH ./outline2025_starpath
	cp STARPATH_QUIET ./outline2025_starpath
	cp starpath.s ./outline2025_starpath
	cp file_id.diz ./outline2025_starpath
	cp starpath.dsk ./outline2025_starpath
	cp starpath_720p.mp4 ./outline2025_starpath
	cp starpath_screen.png ./outline2025_starpath
	zip -r starpath.zip outline2025_starpath

###

starpath_small.zip:	STARPATH STARPATH_QUIET starpath.s file_id.diz starpath.dsk
	mkdir -p outline2025_starpath_small
	cp STARPATH ./outline2025_starpath_small
	cp STARPATH_QUIET ./outline2025_starpath_small
	cp starpath.s ./outline2025_starpath_small
	cp file_id.diz ./outline2025_starpath_small
	cp starpath.dsk ./outline2025_starpath_small
	zip -r starpath_small.zip outline2025_starpath_small

###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

STARPATH:	starpath.o
	ld65 -o STARPATH starpath.o -C ./apple2_62_zp.inc

starpath.o:	starpath.s
	ca65 -o starpath.o starpath.s -l starpath.lst

###

STARPATH_QUIET:	starpath_quiet.o
	ld65 -o STARPATH_QUIET starpath_quiet.o -C ./apple2_62_zp.inc

starpath_quiet.o:	starpath.s
	ca65 -o starpath_quiet.o starpath.s -DQUIET=1 -l starpath_quiet.lst


####

clean:	
	rm -f *~ *.o *.lst HELLO STARPATH STARPATH_QUIET *.zip
