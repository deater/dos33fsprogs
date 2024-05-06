include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../linker_scripts/

all:	cosmic_fish.dsk

cosmic_fish.dsk:	HELLO COSMIC_FISH
	cp $(EMPTYDISK) cosmic_fish.dsk
	$(DOS33) -y cosmic_fish.dsk SAVE A HELLO
	$(DOS33) -y cosmic_fish.dsk BSAVE -a 0x2000 COSMIC_FISH

###

submit:	cosmic_fish.zip cosmic_fish_small.zip

cosmic_fish.zip:	COSMIC_FISH cosmic_fish.s file_id.diz cosmic_fish.dsk
	mkdir -p outline2024_cosmic_fish
	cp COSMIC_FISH ./outline2024_cosmic_fish
	cp cosmic_fish.s ./outline2024_cosmic_fish
	cp file_id.diz ./outline2024_cosmic_fish
	cp cosmic_fish.dsk ./outline2024_cosmic_fish
	cp cosmic_fish_720p.mp4 ./outline2024_cosmic_fish
	cp cosmic_fish_screen.png ./outline2024_cosmic_fish
	zip -r cosmic_fish.zip outline2024_cosmic_fish

###

cosmic_fish_small.zip:	COSMIC_FISH cosmic_fish.s file_id.diz cosmic_fish.dsk
	mkdir -p outline2024_cosmic_fish_small
	cp COSMIC_FISH ./outline2024_cosmic_fish_small
	cp cosmic_fish.s ./outline2024_cosmic_fish_small
	cp file_id.diz ./outline2024_cosmic_fish_small
	cp cosmic_fish.dsk ./outline2024_cosmic_fish_small
	zip -r cosmic_fish_small.zip outline2024_cosmic_fish_small

###


HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

COSMIC_FISH:	cosmic_fish.o
	ld65 -o COSMIC_FISH cosmic_fish.o -C $(LINKERSCRIPTS)/apple2_2000.inc

cosmic_fish.o:	cosmic_fish.s
	ca65 -o cosmic_fish.o cosmic_fish.s -l cosmic_fish.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO COSMIC_FISH *.zip
