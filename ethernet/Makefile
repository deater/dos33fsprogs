DOS33 = ../dos33fs-utils/dos33
TXT2BAS = ../asoft_basic-utils/tokenize_asoft
MAKEB = ../dos33fs-utils/make_b

all:	ethernet.dsk

SETUP.BAS:	setup.bas
	$(TXT2BAS) < setup.bas > SETUP.BAS

WEBSERVER.BAS:	webserver.bas
	$(TXT2BAS) < webserver.bas > WEBSERVER.BAS

R.TXT:	request.txt
	$(MAKEB) request.txt R.TXT 0xc000

ethernet.dsk:	SETUP.BAS \
		WEBSERVER.BAS \
		R.TXT
	$(DOS33) -y ethernet.dsk SAVE A SETUP.BAS
	$(DOS33) -y ethernet.dsk SAVE A WEBSERVER.BAS
	$(DOS33) -y ethernet.dsk SAVE B R.TXT


clean:	
	rm -f *~ *.BAS R.TXT
