PCX2HGR = ../../hgr-utils/pcx2hgr
DOS33 = ../../dos33fs-utils/dos33
TXT2BAS = ../../asoft_basic-utils/tokenize_asoft
SHAPETABLE = ../../hgr-utils/shape_table
MAKEB = ../../dos33fs-utils/make_b
LD65 = /usr/local/bin/ld65
AS65 = /usr/local/bin/as65

DISKNAME=ksp_1.3.7.dsk

all:	$(DISKNAME)

KSP:	ksp
	$(MAKEB) ./ksp ./KSP 0xC00

ksp:	ksp.o
	$(LD65) -o ksp ksp.o -C ./apple2_c00.inc

ksp.o:	ksp.s
	$(AS65) -o ksp.o ksp.s -l ksp.lst


$(DISKNAME):	KSP \
		ROCKET.SHAPE \
		VAB.SHAPE \
		GLOBE.HGR LAUNCHPAD.HGR ORBIT_TOP.HGR ORBIT_RIGHT.HGR \
		LOADING.HGR SQUAD.HGR TITLE.HGR \
		VAB.HGR
	$(DOS33) -y $(DISKNAME) SAVE B KSP
	$(DOS33) -y $(DISKNAME) SAVE B LOADING.HGR
	$(DOS33) -y $(DISKNAME) SAVE B SQUAD.HGR
	$(DOS33) -y $(DISKNAME) SAVE B TITLE.HGR
	$(DOS33) -y $(DISKNAME) SAVE B VAB.HGR
	$(DOS33) -y $(DISKNAME) SAVE B GLOBE.HGR
	$(DOS33) -y $(DISKNAME) SAVE B LAUNCHPAD.HGR
	$(DOS33) -y $(DISKNAME) SAVE B ORBIT_RIGHT.HGR
	$(DOS33) -y $(DISKNAME) SAVE B ORBIT_TOP.HGR
	$(DOS33) -y $(DISKNAME) SAVE B ROCKET.SHAPE
	$(DOS33) -y $(DISKNAME) SAVE B VAB.SHAPE


ROCKET.SHAPE:	../ship2.table
	$(SHAPETABLE) -b < ../ship2.table > ROCKET.SHAPE

VAB.SHAPE:	../ship.table
	$(SHAPETABLE) -b < ../ship.table > VAB.SHAPE

LAUNCHPAD.HGR:	../launchpad.pcx
	$(PCX2HGR) ../launchpad.pcx > LAUNCHPAD.HGR

ORBIT_TOP.HGR:	../orbit_top.pcx
	$(PCX2HGR) ../orbit_top.pcx > ORBIT_TOP.HGR

ORBIT_RIGHT.HGR:	../orbit_right.pcx
	$(PCX2HGR) ../orbit_right.pcx > ORBIT_RIGHT.HGR

GLOBE.HGR:	../globe.pcx
	$(PCX2HGR) ../globe.pcx > GLOBE.HGR

LOADING.HGR:	../loading.pcx
	$(PCX2HGR) ../loading.pcx > LOADING.HGR

SQUAD.HGR:	../squad.pcx
	$(PCX2HGR) ../squad.pcx > SQUAD.HGR

TITLE.HGR:	../title.pcx
	$(PCX2HGR) ../title.pcx > TITLE.HGR

VAB.HGR:	../vab.pcx
	$(PCX2HGR) ../vab.pcx > VAB.HGR

clean:	
	rm -f *~ *.o *.lst KSP ksp *.HGR *.SHAPE *.BAS
