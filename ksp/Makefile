PCX2HGR = ../hgr-utils/pcx2hgr
DOS33 = ../dos33fs-utils/dos33
TXT2BAS = ../asoft_basic-utils/tokenize_asoft

all:	ksp.dsk

basic:	VAB.BAS THEME.BAS

ACMPLX.BAS:	acmplx.bas
	$(TXT2BAS) < acmplx.bas > ACMPLX.BAS

FLIGHT.BAS:	flight.bas
	$(TXT2BAS) < flight.bas > FLIGHT.BAS

LAUNCH.BAS:	launch.bas
	$(TXT2BAS) < launch.bas > LAUNCH.BAS

LOADING.BAS:	loading.bas
	$(TXT2BAS) < loading.bas > LOADING.BAS

PHYSICS.BAS:	physics.bas
	$(TXT2BAS) < physics.bas > PHYSICS.BAS

VAB.BAS:	vab.bas
	$(TXT2BAS) < vab.bas > VAB.BAS



ksp.dsk:	ACMPLX.BAS \
		FLIGHT.BAS \
		LAUNCH.BAS GLOBE.HGR LAUNCHPAD.HGR ORBIT_TOP.HGR ORBIT_RIGHT.HGR \
		LOADING.BAS LOADING.HGR SQUAD.HGR TITLE.HGR \
		PHYSICS.BAS \
		VAB.BAS VAB.HGR
	$(DOS33) -y ksp.dsk SAVE B LOADING.HGR
	$(DOS33) -y ksp.dsk SAVE B SQUAD.HGR
	$(DOS33) -y ksp.dsk SAVE B TITLE.HGR
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


LAUNCHPAD.HGR:	launchpad.pcx
	$(PCX2HGR) launchpad.pcx > LAUNCHPAD.HGR

ORBIT_TOP.HGR:	orbit_top.pcx
	$(PCX2HGR) orbit_top.pcx > ORBIT_TOP.HGR

ORBIT_RIGHT.HGR:	orbit_right.pcx
	$(PCX2HGR) orbit_right.pcx > ORBIT_RIGHT.HGR

GLOBE.HGR:	globe.pcx
	$(PCX2HGR) globe.pcx > GLOBE.HGR

LOADING.HGR:	loading.pcx
	$(PCX2HGR) loading.pcx > LOADING.HGR

SQUAD.HGR:	squad.pcx
	$(PCX2HGR) squad.pcx > SQUAD.HGR

TITLE.HGR:	title.pcx
	$(PCX2HGR) title.pcx > TITLE.HGR

VAB.HGR:	vab.pcx
	$(PCX2HGR) vab.pcx > VAB.HGR

clean:	
	rm -f *~ *.HGR
