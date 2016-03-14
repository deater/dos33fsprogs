PCX2HGR = ../hgr-utils/pcx2hgr
DOS33 = ../dos33fs-utils/dos33

all:	ksp.dsk

ksp.dsk:	LOADING.HGR SQUAD.HGR TITLE.HGR
	$(DOS33) -y ksp.dsk SAVE B LOADING.HGR
	$(DOS33) -y ksp.dsk SAVE B SQUAD.HGR
	$(DOS33) -y ksp.dsk SAVE B TITLE.HGR


LOADING.HGR:	loading.pcx
	$(PCX2HGR) loading.pcx > LOADING.HGR

SQUAD.HGR:	squad.pcx
	$(PCX2HGR) squad.pcx > SQUAD.HGR

TITLE.HGR:	title.pcx
	$(PCX2HGR) title.pcx > TITLE.HGR

clean:	
	rm -f *~ *.HGR
