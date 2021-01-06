DOS33 = ../../utils/dos33fs-utils/dos33
TXT2BAS = ../../utils/asoft_basic-utils/tokenize_asoft
SHAPETABLE = ../../utils/hgr-utils/shape_table
SOUNDCONVERT = ../../utils/asoft_sound/asoft_sound

]TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft


all:	glados33.dsk

OBJECTS.SHAPE:	objects.shape
	$(SHAPETABLE) -b < objects.shape > OBJECTS.SHAPE

CUBE.BAS:	cube.bas
	$(TXT2BAS) < cube.bas > CUBE.BAS

PORTAL.BAS:	portal.bas
	$(TXT2BAS) < portal.bas > PORTAL.BAS

STILL_ALIVE.BAS:	still_alive.bas
	$(TXT2BAS) < still_alive.bas > STILL_ALIVE.BAS

JOYSTICK_TEST.BAS:	joystick_test.bas
	$(TXT2BAS) < joystick_test.bas > JOYSTICK_TEST.BAS

MOUSE_TEST.BAS:	mouse_test.bas
	$(TXT2BAS) < mouse_test.bas > MOUSE_TEST.BAS

shape_test.bas:	objects.shape
	$(SHAPETABLE) < objects.shape > shape_test.bas

SHAPE_TEST.BAS:	shape_test.bas
	$(TXT2BAS) < shape_test.bas > SHAPE_TEST.BAS

sound_test.bas:	still_alive.notes
	$(SOUNDCONVERT) < still_alive.notes > sound_test.bas

SOUND_TEST.BAS:	sound_test.bas

	$(TXT2BAS) < sound_test.bas > SOUND_TEST.BAS

asm/STILL_ALIVE.BIN:	asm/still_alive.s
	cd asm && make

glados33.dsk:	STILL_ALIVE.BAS OBJECTS.SHAPE SHAPE_TEST.BAS SOUND_TEST.BAS \
		PORTAL.BAS CUBE.BAS PORTAL_TITLE.HGR GLADOS.HGR MOUSE_TEST.BAS \
		JOYSTICK_TEST.BAS \
		asm/STILL_ALIVE.BIN
	$(DOS33) -y glados33.dsk SAVE A STILL_ALIVE.BAS
	$(DOS33) -y glados33.dsk SAVE B OBJECTS.SHAPE
	$(DOS33) -y glados33.dsk SAVE B PORTAL_TITLE.HGR
	$(DOS33) -y glados33.dsk SAVE B GLADOS.HGR
	$(DOS33) -y glados33.dsk SAVE A SHAPE_TEST.BAS
	$(DOS33) -y glados33.dsk SAVE A SOUND_TEST.BAS
	$(DOS33) -y glados33.dsk SAVE A PORTAL.BAS
	$(DOS33) -y glados33.dsk SAVE A CUBE.BAS
	$(DOS33) -y glados33.dsk SAVE A MOUSE_TEST.BAS
	$(DOS33) -y glados33.dsk SAVE A JOYSTICK_TEST.BAS
	$(DOS33) -y glados33.dsk BSAVE -a 0xc00 asm/STILL_ALIVE.BIN

clean:	
	cd asm && make clean
	rm -f *~ *.BAS *.SHAPE sound_test.bas shape_test.bas *.lst

