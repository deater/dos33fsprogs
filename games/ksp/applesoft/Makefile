PCX2HGR = ../../../utils/hgr-utils/pcx2hgr
DOS33 = ../../../utils/dos33fs-utils/dos33
TXT2BAS = ../../../utils/asoft_basic-utils/tokenize_asoft
SHAPETABLE = ../../../utils/hgr-utils/shape_table

all:	ksp.dsk


$(TXT2BAS):
	cd ../../../utils/asoft_basic-utils && make

$(SHAPETABLE):
	cd ../../../utils/hgr-utils && make

$(PCX2HGR):
	cd ../../../utils/hgr-utils && make

ACMPLX.BAS:	acmplx.bas $(TXT2BAS)
	$(TXT2BAS) < acmplx.bas > ACMPLX.BAS

CONTRACT.BAS:	contract.bas
	$(TXT2BAS) < contract.bas > CONTRACT.BAS

FLIGHT.BAS:	flight.bas
	$(TXT2BAS) < flight.bas > FLIGHT.BAS

KSP.BAS:	ksp.bas
	$(TXT2BAS) < ksp.bas > KSP.BAS

LAUNCH.BAS:	launch.bas
	$(TXT2BAS) < launch.bas > LAUNCH.BAS

LOADING.BAS:	loading.bas
	$(TXT2BAS) < loading.bas > LOADING.BAS

PHYSICS.BAS:	physics.bas
	$(TXT2BAS) < physics.bas > PHYSICS.BAS

VAB.BAS:	vab.bas
	$(TXT2BAS) < vab.bas > VAB.BAS

LOAD_KSP.BAS:	load_ksp.bas
	$(TXT2BAS) < load_ksp.bas > LOAD_KSP.BAS

ROCKET.SHAPE:	../ship2.table $(SHAPETABLE)
	$(SHAPETABLE) -b < ../ship2.table > ROCKET.SHAPE

VAB.SHAPE:	../ship.table $(SHAPETABLE)
	$(SHAPETABLE) -b < ../ship.table > VAB.SHAPE


ksp.dsk:	ACMPLX.BAS \
		CONTRACT.BAS \
		FLIGHT.BAS \
		KSP.BAS \
		ROCKET.SHAPE \
		VAB.SHAPE \
		LOAD_KSP.BAS \
		LAUNCH.BAS GLOBE.HGR LAUNCHPAD.HGR ORBIT_TOP.HGR ORBIT_RIGHT.HGR \
		LOADING.BAS LOADING.HGR LOADING2.HGR SQUAD.HGR TITLE.HGR \
		PHYSICS.BAS \
		VAB.BAS VAB.HGR
	$(DOS33) -y ksp.dsk BSAVE -a 0x2000 LOADING.HGR
	$(DOS33) -y ksp.dsk BSAVE -a 0x2000 SQUAD.HGR
	$(DOS33) -y ksp.dsk BSAVE -a 0x2000 TITLE.HGR
	$(DOS33) -y ksp.dsk SAVE A VAB.BAS
	$(DOS33) -y ksp.dsk SAVE B VAB.HGR
	$(DOS33) -y ksp.dsk SAVE A LOADING.BAS
	$(DOS33) -y ksp.dsk SAVE A ACMPLX.BAS
	$(DOS33) -y ksp.dsk SAVE A LAUNCH.BAS
	$(DOS33) -y ksp.dsk SAVE B GLOBE.HGR
	$(DOS33) -y ksp.dsk SAVE B LAUNCHPAD.HGR
	$(DOS33) -y ksp.dsk SAVE B ORBIT_RIGHT.HGR
	$(DOS33) -y ksp.dsk SAVE B ORBIT_TOP.HGR
	$(DOS33) -y ksp.dsk SAVE A PHYSICS.BAS
	$(DOS33) -y ksp.dsk SAVE A FLIGHT.BAS
	$(DOS33) -y ksp.dsk SAVE A CONTRACT.BAS
	$(DOS33) -y ksp.dsk SAVE A KSP.BAS
	$(DOS33) -y ksp.dsk SAVE A LOAD_KSP.BAS
	$(DOS33) -y ksp.dsk SAVE B ROCKET.SHAPE
	$(DOS33) -y ksp.dsk SAVE B VAB.SHAPE


LAUNCHPAD.HGR:	../launchpad.pcx
	$(PCX2HGR) ../launchpad.pcx > LAUNCHPAD.HGR

ORBIT_TOP.HGR:	../orbit_top.pcx
	$(PCX2HGR) ../orbit_top.pcx > ORBIT_TOP.HGR

ORBIT_RIGHT.HGR:	../orbit_right.pcx
	$(PCX2HGR) ../orbit_right.pcx > ORBIT_RIGHT.HGR

GLOBE.HGR:	../globe.pcx
	$(PCX2HGR) ../globe.pcx > GLOBE.HGR

LOADING.HGR:	../loading.pcx
	$(PCX2HGR) ../loading.pcx -r > LOADING.HGR

LOADING2.HGR:	../loading2.pcx
	$(PCX2HGR) ../loading2.pcx -r > LOADING2.HGR

SQUAD.HGR:	../squad.pcx
	$(PCX2HGR) ../squad.pcx -r > SQUAD.HGR

TITLE.HGR:	../title.pcx
	$(PCX2HGR) ../title.pcx -r > TITLE.HGR

VAB.HGR:	../vab.pcx
	$(PCX2HGR) ../vab.pcx > VAB.HGR

clean:	
	rm -f *~ *.HGR *.SHAPE *.BAS
