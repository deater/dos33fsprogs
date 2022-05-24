include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../linker_scripts/

all:	dsr_scroll.dsk

dsr_scroll.dsk:	HELLO DSR_SCROLL
	cp $(EMPTYDISK) dsr_scroll.dsk
	$(DOS33) -y dsr_scroll.dsk SAVE A HELLO
	$(DOS33) -y dsr_scroll.dsk BSAVE -a 0xC00 DSR_SCROLL

###

submit:	dsrscroll.zip

dsrscroll.zip:	DSR_SCROLL dsr_scroll.s file_id.diz dsr_scroll.dsk
	mkdir -p outline2022_dsr_scroll
	cp DSR_SCROLL ./outline2022_dsr_scroll
	cp dsr_scroll.s ./outline2022_dsr_scroll
	cp file_id.diz ./outline2022_dsr_scroll
	cp dsr_scroll.dsk ./outline2022_dsr_scroll
	cp dsr_720p.mp4 ./outline2022_dsr_scroll
	zip -r dsrscroll.zip outline2022_dsr_scroll

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DSR_SCROLL:	dsr_scroll.o
	ld65 -o DSR_SCROLL dsr_scroll.o -C $(LINKERSCRIPTS)/apple2_c00.inc

dsr_scroll.o:	dsr_scroll.s
	ca65 -o dsr_scroll.o dsr_scroll.s -l dsr_scroll.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO DSR_SCROLL *.zip
