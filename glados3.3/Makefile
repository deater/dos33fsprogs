DOS33 = ../dos33fs-utils/dos33
TXT2BAS = ../asoft_basic-utils/tokenize_asoft
SHAPETABLE = ../hgr-utils/shape_table
SOUNDCONVERT = ../asoft_sound/asoft_sound

all:	glados33.dsk

OBJECTS.SHAPE:	objects.shape
	$(SHAPETABLE) -b < objects.shape > OBJECTS.SHAPE

CUBE.BAS:	cube.bas
	$(TXT2BAS) < cube.bas > CUBE.BAS

PORTAL.BAS:	portal.bas
	$(TXT2BAS) < portal.bas > PORTAL.BAS

STILL_ALIVE.BAS:	still_alive.bas
	$(TXT2BAS) < still_alive.bas > STILL_ALIVE.BAS

shape_test.bas:	objects.shape
	$(SHAPETABLE) < objects.shape > shape_test.bas

SHAPE_TEST.BAS:	shape_test.bas
	$(TXT2BAS) < shape_test.bas > SHAPE_TEST.BAS

sound_test.bas:	still_alive.notes
	$(SOUNDCONVERT) < still_alive.notes > sound_test.bas

SOUND_TEST.BAS:	sound_test.bas

	$(TXT2BAS) < sound_test.bas > SOUND_TEST.BAS

glados33.dsk:	STILL_ALIVE.BAS OBJECTS.SHAPE SHAPE_TEST.BAS SOUND_TEST.BAS \
		PORTAL.BAS CUBE.BAS PORTAL_TITLE.HGR
	$(DOS33) -y glados33.dsk SAVE A STILL_ALIVE.BAS
	$(DOS33) -y glados33.dsk SAVE B OBJECTS.SHAPE
	$(DOS33) -y glados33.dsk SAVE B PORTAL_TITLE.HGR
	$(DOS33) -y glados33.dsk SAVE A SHAPE_TEST.BAS
	$(DOS33) -y glados33.dsk SAVE A SOUND_TEST.BAS
	$(DOS33) -y glados33.dsk SAVE A PORTAL.BAS
	$(DOS33) -y glados33.dsk SAVE A CUBE.BAS

clean:	
	rm -f *~ *.BAS *.SHAPE sound_test.bas shape_test.bas *.lst

