CC = gcc
CFLAGS = -O2 -Wall
LFLAGS = 

all:	presenter_demo.dsk

presenter_demo.dsk:	PRESENTER_DEMO \
	TITLE.HGR PLASMA_DPOSV.HGR \
	RAPL_MICRO.HGR WATTSUP.HGR \
	MKL_PLASMA.HGR PLASMA_CHOLESKY.HGR\
	NUM.SHAPE MMM LOAD_DEMO
	../dos33 presenter_demo.dsk SAVE A PRESENTER_DEMO
	../dos33 presenter_demo.dsk SAVE B TITLE.HGR
	../dos33 presenter_demo.dsk SAVE B PLASMA_DPOSV.HGR
	../dos33 presenter_demo.dsk SAVE B RAPL_MICRO.HGR
	../dos33 presenter_demo.dsk SAVE B MKL_PLASMA.HGR
	../dos33 presenter_demo.dsk SAVE B NUM.SHAPE
	../dos33 presenter_demo.dsk SAVE B WATTSUP.HGR
	../dos33 presenter_demo.dsk SAVE B PLASMA_CHOLESKY.HGR
	../dos33 presenter_demo.dsk SAVE A MMM
	../dos33 presenter_demo.dsk SAVE A LOAD_DEMO

PLASMA_CHOLESKY.HGR:	plasma_cholesky.pcx
	../pcx2hgr plasma_cholesky.pcx > PLASMA_CHOLESKY.HGR

MKL_PLASMA.HGR:		mkl_plasma_energy.pcx
	../pcx2hgr mkl_plasma_energy.pcx > MKL_PLASMA.HGR

LOAD_DEMO:		load_demo.bas
	../tokenize_asoft < load_demo.bas > LOAD_DEMO

WATTSUP.HGR:		wattsup.pcx
	../pcx2hgr wattsup.pcx > WATTSUP.HGR

RAPL_MICRO.HGR:		rapl_micro.pcx
	../pcx2hgr rapl_micro.pcx > RAPL_MICRO.HGR


PLASMA_DPOSV.HGR:	plasma-dposv-power.pcx
	../pcx2hgr plasma-dposv-power.pcx > PLASMA_DPOSV.HGR

MMM:		mmm.bas
	../tokenize_asoft < mmm.bas > MMM

NUM.SHAPE:	num.table
	../shape_table -b < num.table > NUM.SHAPE

TITLE.HGR:	title.pcx ../pcx2hgr
	../pcx2hgr title.pcx > TITLE.HGR

PRESENTER_DEMO:	demo.bas
	../tokenize_asoft < demo.bas > PRESENTER_DEMO

demo.bas:		../asoft_presenter info
	../asoft_presenter . > demo.bas

clean:	
	rm -f *~ *.IMG *.HGR demo.bas PRESENTER_DEMO NUM.SHAPE MMM LOAD_DEMO

