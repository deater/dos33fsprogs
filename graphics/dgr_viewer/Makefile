include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
PNG2GR = ../../utils/gr-utils/png2gr
PNG2RLE = ../../utils/gr-utils/png2rle
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft

all:	dgr_view.dsk


dgr_view.dsk:	$(DOS33) DGR_VIEW
	cp empty.dsk dgr_view.dsk
	$(DOS33) -y dgr_view.dsk BSAVE -a 0x1000 DGR_VIEW

###

DGR_VIEW:	dgr_view.o
	ld65 -o DGR_VIEW dgr_view.o -C ../../linker_scripts/apple2_1000.inc

dgr_view.o:	dgr_view.s
	ca65 -o dgr_view.o dgr_view.s -l dgr_view.lst

clean:	
	rm -f *~ *.o DGR_VIEW *.lst

