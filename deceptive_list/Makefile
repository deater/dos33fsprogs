DOS33 = ../dos33fs-utils/dos33
TXT2BAS = ../asoft_basic-utils/tokenize_asoft

all:	deceptive.dsk

BACKWARD.BAS:	backward.basd
	$(TXT2BAS) < backward.basd > BACKWARD.BAS

deceptive.dsk:	BACKWARD.BAS
	$(DOS33) -y deceptive.dsk SAVE A BACKWARD.BAS

clean:	
	rm -f *~ *.BAS *.SHAPE sound_test.bas shape_test.bas *.lst

