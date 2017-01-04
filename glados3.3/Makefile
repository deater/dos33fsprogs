DOS33 = ../dos33fs-utils/dos33
TXT2BAS = ../asoft_basic-utils/tokenize_asoft
MAKEB = ../dos33fs-utils/make_b

all:	glados33.dsk

STILL_ALIVE.BAS:	still_alive.bas
	$(TXT2BAS) < still_alive.bas > STILL_ALIVE.BAS

glados33.dsk:	STILL_ALIVE.BAS
	$(DOS33) -y glados33.dsk SAVE A STILL_ALIVE.BAS

clean:	
	rm -f *~ *.BAS *.lst

