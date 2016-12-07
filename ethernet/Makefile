DOS33 = ../dos33fs-utils/dos33
TXT2BAS = ../asoft_basic-utils/tokenize_asoft
MAKEB = ../dos33fs-utils/make_b

all:	ethernet.dsk

SETUP.BAS:	setup.bas
	$(TXT2BAS) < setup.bas > SETUP.BAS

WEBSERVER.BAS:	webserver.bas
	$(TXT2BAS) < webserver.bas > WEBSERVER.BAS

about.html:	./c/about.html
	$(MAKEB) ./c/about.html about.html 0xc000

index.html:	./c/index.html
	$(MAKEB) ./c/index.html index.html 0xc000

favicon.ico:	./c/favicon.ico
	$(MAKEB) ./c/favicon.ico favicon.ico 0xc000

vmw_logo.png:	./c/vmw_logo.png
	$(MAKEB) ./c/vmw_logo.png vmw_logo.png 0xc000

R.TXT:	request.txt
	$(MAKEB) request.txt R.TXT 0xc000

ethernet.dsk:	SETUP.BAS \
		WEBSERVER.BAS \
		R.TXT \
		about.html index.html favicon.ico vmw_logo.png
	$(DOS33) -y ethernet.dsk SAVE A SETUP.BAS
	$(DOS33) -y ethernet.dsk SAVE A WEBSERVER.BAS
	$(DOS33) -y ethernet.dsk SAVE B R.TXT
	$(DOS33) -y ethernet.dsk SAVE B about.html
	$(DOS33) -y ethernet.dsk SAVE B index.html
	$(DOS33) -y ethernet.dsk SAVE B favicon.ico
	$(DOS33) -y ethernet.dsk SAVE B vmw_logo.png

clean:	
	rm -f *~ *.BAS R.TXT
