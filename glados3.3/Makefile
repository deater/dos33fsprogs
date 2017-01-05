DOS33 = ../dos33fs-utils/dos33
TXT2BAS = ../asoft_basic-utils/tokenize_asoft
SHAPETABLE = ../hgr-utils/shape_table


all:	glados33.dsk

OBJECTS.SHAPE:	objects.shape
	$(SHAPETABLE) -b < objects.shape > OBJECTS.SHAPE

STILL_ALIVE.BAS:	still_alive.bas
	$(TXT2BAS) < still_alive.bas > STILL_ALIVE.BAS

shape_test.bas:	objects.shape
	$(SHAPETABLE) < objects.shape > shape_test.bas

SHAPE_TEST.BAS:	shape_test.bas
	$(TXT2BAS) < shape_test.bas > SHAPE_TEST.BAS

glados33.dsk:	STILL_ALIVE.BAS OBJECTS.SHAPE SHAPE_TEST.BAS
	$(DOS33) -y glados33.dsk SAVE A STILL_ALIVE.BAS
	$(DOS33) -y glados33.dsk SAVE B OBJECTS.SHAPE
	$(DOS33) -y glados33.dsk SAVE A SHAPE_TEST.BAS

clean:	
	rm -f *~ *.BAS *.SHAPE *.lst

