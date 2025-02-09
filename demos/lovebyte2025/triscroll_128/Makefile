include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	tri_scroll.dsk

tri_scroll.dsk:	HELLO TRI_SCROLL
	cp $(EMPTYDISK) tri_scroll.dsk
	$(DOS33) -y tri_scroll.dsk SAVE A HELLO
	$(DOS33) -y tri_scroll.dsk BSAVE -a 0xc00 TRI_SCROLL

###

submit:	tri_scroll.zip

tri_scroll.zip:	TRI_SCROLL tri_scroll.s file_id.diz tri_scroll.dsk
	mkdir -p lovebyte2024_tri_scroll
	cp TRI_SCROLL ./lovebyte2024_tri_scroll
	cp tri_scroll.s ./lovebyte2024_tri_scroll
	cp file_id.diz ./lovebyte2024_tri_scroll
	cp tri_scroll.dsk ./lovebyte2024_tri_scroll
	cp tri_scroll_screen.png ./lovebyte2024_tri_scroll
	cp tri_scroll_720p.mp4 ./lovebyte2024_tri_scroll
	zip -r tri_scroll.zip lovebyte2024_tri_scroll

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

TRI_SCROLL:	tri_scroll.o
	ld65 -o TRI_SCROLL tri_scroll.o -C $(LINKERSCRIPTS)/apple2_c00.inc

tri_scroll.o:	tri_scroll.s
	ca65 -o tri_scroll.o tri_scroll.s -l tri_scroll.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO TRI_SCROLL *.zip
