include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
EMPTY_DISK = ../../../empty_disk
HGR2PNG = ../../../utils/hgr-utils/png2hgr
LINKER_SCRIPTS = ../../../linker_scripts
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft

all:	planet.dsk

####

submit:	planet256.zip

planet256.zip:	PLANET.BAS planet.bas file_id.diz planet.dsk
	mkdir -p lovebyte_turbo_planet
	cp PLANET.BAS ./lovebyte_turbo_planet
	cp planet.bas ./lovebyte_turbo_planet
	cp file_id.diz ./lovebyte_turbo_planet
	cp planet.dsk ./lovebyte_turbo_planet
#	cp cometsong_720p.mp4 ./lovebyte_turbo_planet
	zip -r planet256.zip lovebyte_turbo_planet

####

planet.dsk:	HELLO PLANET.BAS
	cp $(EMPTY_DISK)/empty.dsk ./planet.dsk
	$(DOS33) -y planet.dsk SAVE A HELLO
	$(DOS33) -y planet.dsk SAVE A PLANET.BAS
#	$(DOS33) -y planet.dsk -t BIN -a 0xc00 BSAVE VIZ

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

clean:
	rm -f *~ *.o *.lst HELLO
