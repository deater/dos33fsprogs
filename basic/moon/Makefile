include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk/empty.dsk

all:	moon.dsk

moon.dsk:	HELLO LANDER.BAS LANDER_BOT.BAS
	cp $(EMPTY_DISK) moon.dsk
	$(DOS33) -y moon.dsk SAVE A HELLO
	$(DOS33) -y moon.dsk SAVE A LANDER.BAS
	$(DOS33) -y moon.dsk SAVE A LANDER_BOT.BAS

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

####

LANDER.BAS:	lander.bas
	$(TOKENIZE) < lander.bas > LANDER.BAS

####

LANDER_BOT.BAS:	lander_bot.bas
	$(TOKENIZE) < lander_bot.bas > LANDER_BOT.BAS

####

clean:
	rm -f *~ *.o *.lst HELLO LANDER.BAS LANDER_BOT.BAS
