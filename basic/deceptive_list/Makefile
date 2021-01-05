DOS33 = ../../utils/dos33fs-utils/dos33
TXT2BAS = ../../utils/asoft_basic-utils/tokenize_asoft

all:	deceptive.dsk

deceptive.dsk:	HIDDEN.BAS
	$(DOS33) -y deceptive.dsk SAVE A HIDDEN.BAS


HIDDEN.BAS:	hidden.basd
	$(TXT2BAS) < hidden.basd > HIDDEN.BAS


clean:	
	rm -f *~ *.BAS *.lst

