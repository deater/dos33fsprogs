include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/
ZX02 = ~/research/6502_compression/zx02.git/build/zx02

all:	dont.dsk

dont.dsk:	HELLO DONT_NEW DONT2 #SA_ED
	cp $(EMPTYDISK) dont.dsk
	$(DOS33) -y dont.dsk SAVE A HELLO
	$(DOS33) -y dont.dsk BSAVE -a 0x800 DONT_NEW
#	$(DOS33) -y dont.dsk BSAVE -a 0xc00 DONT2
#	$(DOS33) -y dont.dsk BSAVE -a 0xc00 SA_ED

###

submit:	dont.zip

dont.zip:	DONT dont.s file_id.diz dont.dsk
	mkdir -p lovebyte2023_dont
	cp DONT ./lovebyte2023_dont
	cp dont.s ./lovebyte2023_dont
	cp file_id.diz ./lovebyte2023_dont
	cp dont.dsk ./lovebyte2023_dont
	cp monitor.txt ./lovebyte2023_dont
	cp dont_screen.png ./lovebyte2023_dont
	cp dont_720p.mp4 ./lovebyte2023_dont
	zip -r dont.zip lovebyte2023_dont

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

DONT_COMPRESS.zx02:	DONT_COMPRESS
	$(ZX02) -f DONT_COMPRESS DONT_COMPRESS.zx02

DONT_COMPRESS:	dont_compress.o
	ld65 -o DONT_COMPRESS dont_compress.o -C $(LINKERSCRIPTS)/apple2_2000.inc

dont_compress.o:	dont_compress.s graphics/scene.hgr still.s
	ca65 -o dont_compress.o dont_compress.s -l dont_compress.lst

###

DONT_NEW:	dont_new.o
	ld65 -o DONT_NEW dont_new.o -C $(LINKERSCRIPTS)/apple2_800.inc

dont_new.o:	dont_new.s DONT_COMPRESS.zx02 opener.s
	ca65 -o dont_new.o dont_new.s -l dont_new.lst


###

DONT2:	dont2.o
	ld65 -o DONT2 dont2.o -C $(LINKERSCRIPTS)/apple2_c00.inc

dont2.o:	dont2.s still.s
	ca65 -o dont2.o dont2.s -l dont2.lst

###

SA_ED:	sa_ed.o
	ld65 -o SA_ED sa_ed.o -C $(LINKERSCRIPTS)/apple2_c00.inc

sa_ed.o:	sa_ed.s duet.s
	ca65 -o sa_ed.o sa_ed.s -l sa_ed.lst

####

submit:	dtv_1k.zip

dtv_1k.zip:	DONT_NEW file_id.diz dont.dsk
	mkdir -p lovebyte2024_dtv_1k
	mkdir -p lovebyte2024_dtv_1k/code
	cp DONT_NEW ./lovebyte2024_dtv_1k
	cp dont_compress.s dont_new.s duet.s opener.s still.s zp.inc
	cp file_id.diz ./lovebyte2024_dtv_1k
	cp dont.dsk ./lovebyte2024_dtv_1k
	cp dtv_1k_screen.png ./lovebyte2024_dtv_1k
	cp dtv_1k_720p.mp4 ./lovebyte2024_dtv_1k
	zip -r dtv_1k.zip lovebyte2024_dtv_1k

####

clean:	
	rm -f *~ *.o *.lst HELLO DONT_COMPRESS DONT_COMPRESS.zx02 DONT2 DONT_NEW *.zip
