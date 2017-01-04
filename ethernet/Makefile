DOS33 = ../dos33fs-utils/dos33
TXT2BAS = ../asoft_basic-utils/tokenize_asoft
MAKEB = ../dos33fs-utils/make_b

all:	ethernet.dsk

memcpy:	memcpy.o
	ld65 -o memcpy memcpy.o -t none

memcpy.o:	memcpy.s
	ca65 -o memcpy.o memcpy.s -l memcpy.lst

SETUP.BAS:	setup.bas
	$(TXT2BAS) < setup.bas > SETUP.BAS

WEBSERVER.BAS:	webserver.bas
	$(TXT2BAS) < webserver.bas > WEBSERVER.BAS

R.TXT:	request.txt
	$(MAKEB) request.txt R.TXT 0xc000

ethernet.dsk:	SETUP.BAS \
		WEBSERVER.BAS \
		R.TXT \
		./c/about.html ./c/index.html ./c/favicon.ico ./c/vmw_logo.png
	$(DOS33) -y ethernet.dsk SAVE A SETUP.BAS
	$(DOS33) -y ethernet.dsk SAVE A WEBSERVER.BAS
	$(DOS33) -y ethernet.dsk BSAVE R.TXT
	$(DOS33) -y ethernet.dsk BSAVE -a 0x4000 ./c/about.html
	$(DOS33) -y ethernet.dsk BSAVE -a 0x4000 ./c/index.html
	$(DOS33) -y ethernet.dsk BSAVE -a 0x4000 ./c/favicon.ico
	$(DOS33) -y ethernet.dsk BSAVE -a 0x4000 ./c/vmw_logo.png

clean:	
	rm -f *~ *.BAS R.TXT *.o *.lst memcpy

