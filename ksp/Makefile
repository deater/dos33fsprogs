PCX2HGR = ../hgr-utils/pcx2hgr
DOS33 = ../dos33fs-utils/dos33
TXT2BAS = ../asoft_basic-utils/tokenize_asoft

all:	ksp.dsk

basic:	VAB.BAS THEME.BAS

VAB.BAS:	vab.bas
	$(TXT2BAS) < vab.bas > VAB.BAS

LOADING.BAS:	loading.bas
	$(TXT2BAS) < loading.bas > LOADING.BAS

ksp.dsk:	LOADING.HGR SQUAD.HGR TITLE.HGR LOADING.BAS VAB.BAS
	$(DOS33) -y ksp.dsk SAVE B LOADING.HGR
	$(DOS33) -y ksp.dsk SAVE B SQUAD.HGR
	$(DOS33) -y ksp.dsk SAVE B TITLE.HGR
	$(DOS33) -y ksp.dsk SAVE A VAB.BAS
	$(DOS33) -y ksp.dsk SAVE A LOADING.BAS


LOADING.HGR:	loading.pcx
	$(PCX2HGR) loading.pcx > LOADING.HGR

SQUAD.HGR:	squad.pcx
	$(PCX2HGR) squad.pcx > SQUAD.HGR

TITLE.HGR:	title.pcx
	$(PCX2HGR) title.pcx > TITLE.HGR

clean:	
	rm -f *~ *.HGR
