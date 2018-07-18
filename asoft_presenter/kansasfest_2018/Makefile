ASOFT_PRESENTER = ../asoft_presenter
DOS33 = ../../dos33fs-utils/dos33
PCX2HGR = ../../hgr-utils/pcx2hgr
SHAPE_TABLE = ../../hgr-utils/shape_table
TOKENIZE_ASOFT = ../../asoft_basic-utils/tokenize_asoft


all:	kfest2018_slides.dsk

kfest2018_slides.dsk:	KANSASFEST_2018 \
	TITLE.HGR KATAHDINC.BIN VINCEC.BIN PI_PLAYERC.BIN \
	CHIPTUNE.GR \
	LOAD_DEMO
	$(DOS33) -y kfest2018_slides.dsk SAVE A KANSASFEST_2018
	$(DOS33) -y kfest2018_slides.dsk SAVE B TITLE.HGR
	$(DOS33) -y kfest2018_slides.dsk BSAVE -a 0x2000 KATAHDINC.BIN
	$(DOS33) -y kfest2018_slides.dsk BSAVE -a 0x2000 VINCEC.BIN
	$(DOS33) -y kfest2018_slides.dsk BSAVE -a 0x2000 PI_PLAYERC.BIN
	$(DOS33) -y kfest2018_slides.dsk BSAVE -a 0x800 CHIPTUNE.GR
	$(DOS33) -y kfest2018_slides.dsk SAVE A LOAD_DEMO

LOAD_DEMO:		load_demo.bas
	$(TOKENIZE_ASOFT) < load_demo.bas > LOAD_DEMO

TITLE.HGR:	title.pcx $(PCX2HGR)
	$(PCX2HGR) title.pcx > TITLE.HGR

KATAHDINC.BIN:	katahdin.bmp
	../../bmp2dhr/b2d katahdin.bmp hgr dither

VINCEC.BIN:	vince.bmp
	../../bmp2dhr/b2d vince.bmp hgr dither

PI_PLAYERC.BIN:	pi_player.bmp
	../../bmp2dhr/b2d pi_player.bmp hgr dither


KANSASFEST_2018:	demo.bas
	$(TOKENIZE_ASOFT) < demo.bas > KANSASFEST_2018

demo.bas:		$(ASOFT_PRESENTER) info
	$(ASOFT_PRESENTER) . > demo.bas

clean:	
	rm -f *~ *.IMG *.HGR demo.bas KANSASFEST_2018 LOAD_DEMO \
		VINCEC.BIN KATAHDINC.BIN

