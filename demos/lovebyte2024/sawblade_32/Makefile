include ../../../Makefile.inc

DOS33 = ../../../utils/dos33fs-utils/dos33
TOKENIZE = ../../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../../empty_disk/empty.dsk
LINKERSCRIPTS = ../../../linker_scripts/

all:	sawblade.dsk

sawblade.dsk:	HELLO SAWBLADE
	cp $(EMPTYDISK) sawblade.dsk
	$(DOS33) -y sawblade.dsk SAVE A HELLO
	$(DOS33) -y sawblade.dsk BSAVE -a 0xe6 SAWBLADE

###

submit:	sawblade.zip

sawblade.zip:	SAWBLADE sawblade.s file_id.diz sawblade.dsk
	mkdir -p lovebyte2024_sawblade
	cp SAWBLADE ./lovebyte2024_sawblade
	cp sawblade.s ./lovebyte2024_sawblade
	cp file_id.diz ./lovebyte2024_sawblade
	cp sawblade.dsk ./lovebyte2024_sawblade
	cp monitor.txt ./lovebyte2024_sawblade
	cp sawblade_screen.png ./lovebyte2024_sawblade
	cp sawblade_720p.mp4 ./lovebyte2024_sawblade
	zip -r sawblade.zip lovebyte2024_sawblade

####


####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

SAWBLADE:	sawblade.o
	ld65 -o SAWBLADE sawblade.o -C $(LINKERSCRIPTS)/apple2_c00.inc

sawblade.o:	sawblade.s
	ca65 -o sawblade.o sawblade.s -l sawblade.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO SAWBLADE *.zip
