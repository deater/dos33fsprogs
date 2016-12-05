PCX2HGR = ../hgr-utils/pcx2hgr
DOS33 = ../dos33fs-utils/dos33
TXT2BAS = ../asoft_basic-utils/tokenize_asoft
SHAPETABLE = ../hgr-utils/shape_table

all:	ethernet.dsk

SETUP.BAS:	setup.bas
	$(TXT2BAS) < setup.bas > SETUP.BAS

WEBSERVER.BAS:	webserver.bas
	$(TXT2BAS) < webserver.bas > WEBSERVER.BAS


ethernet.dsk:	SETUP.BAS \
		WEBSERVER.BAS \
		R.TXT
	$(DOS33) -y ethernet.dsk SAVE A SETUP.BAS
	$(DOS33) -y ethernet.dsk SAVE A WEBSERVER.BAS
	$(DOS33) -y ethernet.dsk SAVE T R.TXT


clean:	
	rm -f *~ *.BAS
