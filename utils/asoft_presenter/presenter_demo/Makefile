ASOFT_PRESENTER = ../asoft_presenter
DOS33 = ../../dos33fs-utils/dos33
PCX2HGR = ../../hgr-utils/pcx2hgr
SHAPE_TABLE = ../../hgr-utils/shape_table
TOKENIZE_ASOFT = ../../asoft_basic-utils/tokenize_asoft


all:	presenter_demo.dsk

presenter_demo.dsk:	PRESENTER_DEMO \
	TITLE.HGR PLASMA_DPOSV.HGR \
	RAPL_MICRO.HGR WATTSUP.HGR \
	MKL_PLASMA.HGR PLASMA_CHOLESKY.HGR \
	RAPL_INT_FP.HGR \
	NUM.SHAPE MMM LOAD_DEMO
	$(DOS33) -y presenter_demo.dsk SAVE A PRESENTER_DEMO
	$(DOS33) -y presenter_demo.dsk SAVE B TITLE.HGR
	$(DOS33) -y presenter_demo.dsk SAVE B PLASMA_DPOSV.HGR
	$(DOS33) -y presenter_demo.dsk SAVE B RAPL_MICRO.HGR
	$(DOS33) -y presenter_demo.dsk SAVE B MKL_PLASMA.HGR
	$(DOS33) -y presenter_demo.dsk SAVE B NUM.SHAPE
	$(DOS33) -y presenter_demo.dsk SAVE B WATTSUP.HGR
	$(DOS33) -y presenter_demo.dsk SAVE B PLASMA_CHOLESKY.HGR
	$(DOS33) -y presenter_demo.dsk SAVE B RAPL_INT_FP.HGR
	$(DOS33) -y presenter_demo.dsk SAVE A MMM
	$(DOS33) -y presenter_demo.dsk SAVE A LOAD_DEMO

RAPL_INT_FP.HGR:	rapl_int_fp.pcx
	$(PCX2HGR) rapl_int_fp.pcx > RAPL_INT_FP.HGR

PLASMA_CHOLESKY.HGR:	plasma_cholesky.pcx
	$(PCX2HGR) plasma_cholesky.pcx > PLASMA_CHOLESKY.HGR

MKL_PLASMA.HGR:		mkl_plasma_energy.pcx
	$(PCX2HGR) mkl_plasma_energy.pcx > MKL_PLASMA.HGR

LOAD_DEMO:		load_demo.bas
	$(TOKENIZE_ASOFT) < load_demo.bas > LOAD_DEMO

WATTSUP.HGR:		wattsup.pcx
	$(PCX2HGR) wattsup.pcx > WATTSUP.HGR

RAPL_MICRO.HGR:		rapl_micro.pcx
	$(PCX2HGR) rapl_micro.pcx > RAPL_MICRO.HGR


PLASMA_DPOSV.HGR:	plasma-dposv-power.pcx
	$(PCX2HGR) plasma-dposv-power.pcx > PLASMA_DPOSV.HGR

MMM:		mmm.bas
	$(TOKENIZE_ASOFT) < mmm.bas > MMM

NUM.SHAPE:	num.table
	$(SHAPE_TABLE) -b < num.table > NUM.SHAPE

TITLE.HGR:	title.pcx $(PCX2HGR)
	$(PCX2HGR) title.pcx > TITLE.HGR

PRESENTER_DEMO:	demo.bas
	$(TOKENIZE_ASOFT) < demo.bas > PRESENTER_DEMO

demo.bas:		$(ASOFT_PRESENTER) info
	$(ASOFT_PRESENTER) . > demo.bas

clean:	
	rm -f *~ *.IMG *.HGR demo.bas PRESENTER_DEMO NUM.SHAPE MMM LOAD_DEMO

