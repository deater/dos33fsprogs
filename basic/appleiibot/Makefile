include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTY_DISK = ../../empty_disk

all:	appleiibot.dsk convert_to convert_back convert_qkumba make_boxes convert_vmw convert_tgreene

appleiibot.dsk:	E2.BAS FLAME.BAS FLAME2.BAS HELLO \
	CIRCLES.BAS AUTUMN.BAS QKUMBA.BAS ASTEROID.BAS PERSON.BAS SHIP.BAS \
	CONCERT.BAS NYAN.BAS RASTER.BAS DHGR.BAS RASTER3.BAS LOTS.BAS LOAD \
	RASTER4.BAS RASTER5.BAS PUMPKIN.BAS PUMPKIN_SMALL.BAS LADY.BAS \
	A2.BAS FOURAM.BAS FLOPPY.BAS QR.BAS A2_4EVER.BAS RLE.BAS RLE2.BAS \
	RLEASM.BAS HORIZON.BAS FLYER.BAS STAR.BAS HYPER.BAS FASTAR.BAS \
	FASTAR2.BAS BIN.BAS FALLING.BAS SNOW.BAS XMAS.BAS AN3.BAS PLASMA.BAS \
	C64.BAS SIERPINSKI.BAS FAKES.BAS SIER.BAS DROPS.BAS RR.BAS RR_HGR.BAS \
	COMBO.BAS WIRES.BAS PATTERN.BAS BALL.BAS LINES.BAS MOD9.BAS \
	XOR_ZOOM.BAS MOD9_HGR.BAS SIER_HGR.BAS MOVE.BAS SINE.BAS XDRAW128.BAS \
	GATOR.BAS CURSOR.BAS STARGATE.BAS TUNNEL.BAS STARFIELD.BAS \
	STAROOPS.BAS HGRSTARFIELD.BAS COOL_BOT.BAS WEB.BAS ORB.BAS \
	FIREWORKS.BAS THINKING.BAS ARCS.BAS WIRE_HGR.BAS STATIC.BAS \
	OVAL.BAS OVAL_HGR.BAS MOVING.BAS THICK_SINE.BAS TURKEY.BAS \
	FLAME_HGR.BAS RECT.BAS SNOWY.BAS
#	cp $(EMPTY_DISK)/empty.dsk  appleiibot.dsk
	cp empty.dsk appleiibot.dsk
	$(DOS33) -y appleiibot.dsk BSAVE -a 0x0300 LOAD
	$(DOS33) -y appleiibot.dsk SAVE A HELLO
	$(DOS33) -y appleiibot.dsk SAVE A E2.BAS
	$(DOS33) -y appleiibot.dsk SAVE A FLAME.BAS
	$(DOS33) -y appleiibot.dsk SAVE A FLAME2.BAS
	$(DOS33) -y appleiibot.dsk SAVE A AUTUMN.BAS
	$(DOS33) -y appleiibot.dsk SAVE A CIRCLES.BAS
	$(DOS33) -y appleiibot.dsk SAVE A QKUMBA.BAS
	$(DOS33) -y appleiibot.dsk SAVE A ASTEROID.BAS
	$(DOS33) -y appleiibot.dsk SAVE A PERSON.BAS
	$(DOS33) -y appleiibot.dsk SAVE A SHIP.BAS
	$(DOS33) -y appleiibot.dsk SAVE A NYAN.BAS
	$(DOS33) -y appleiibot.dsk SAVE A CONCERT.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RASTER.BAS
	$(DOS33) -y appleiibot.dsk SAVE A DHGR.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RASTER3.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RASTER4.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RASTER5.BAS
	$(DOS33) -y appleiibot.dsk SAVE A LOTS.BAS
	$(DOS33) -y appleiibot.dsk SAVE A PUMPKIN.BAS
	$(DOS33) -y appleiibot.dsk SAVE A PUMPKIN_SMALL.BAS
	$(DOS33) -y appleiibot.dsk SAVE A LADY.BAS
	$(DOS33) -y appleiibot.dsk SAVE A A2.BAS
	$(DOS33) -y appleiibot.dsk SAVE A FOURAM.BAS
	$(DOS33) -y appleiibot.dsk SAVE A FLOPPY.BAS
	$(DOS33) -y appleiibot.dsk SAVE A QR.BAS
	$(DOS33) -y appleiibot.dsk SAVE A A2_4EVER.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RLE.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RLE2.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RLEASM.BAS
	$(DOS33) -y appleiibot.dsk SAVE A HORIZON.BAS
	$(DOS33) -y appleiibot.dsk SAVE A FLYER.BAS
	$(DOS33) -y appleiibot.dsk SAVE A STAR.BAS
	$(DOS33) -y appleiibot.dsk SAVE A HYPER.BAS
	$(DOS33) -y appleiibot.dsk SAVE A FASTAR.BAS
	$(DOS33) -y appleiibot.dsk SAVE A FASTAR2.BAS
	$(DOS33) -y appleiibot.dsk SAVE A BIN.BAS
	$(DOS33) -y appleiibot.dsk SAVE A FALLING.BAS
	$(DOS33) -y appleiibot.dsk SAVE A SNOW.BAS
	$(DOS33) -y appleiibot.dsk SAVE A XMAS.BAS
	$(DOS33) -y appleiibot.dsk SAVE A AN3.BAS
	$(DOS33) -y appleiibot.dsk SAVE A PLASMA.BAS
	$(DOS33) -y appleiibot.dsk SAVE A C64.BAS
	$(DOS33) -y appleiibot.dsk SAVE A SIERPINSKI.BAS
	$(DOS33) -y appleiibot.dsk SAVE A FAKES.BAS
	$(DOS33) -y appleiibot.dsk SAVE A SIER.BAS
	$(DOS33) -y appleiibot.dsk SAVE A DROPS.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RR.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RR_HGR.BAS
	$(DOS33) -y appleiibot.dsk SAVE A COMBO.BAS
	$(DOS33) -y appleiibot.dsk SAVE A WIRES.BAS
	$(DOS33) -y appleiibot.dsk SAVE A PATTERN.BAS
	$(DOS33) -y appleiibot.dsk SAVE A BALL.BAS
	$(DOS33) -y appleiibot.dsk SAVE A LINES.BAS
	$(DOS33) -y appleiibot.dsk SAVE A MOD9.BAS
	$(DOS33) -y appleiibot.dsk SAVE A XOR_ZOOM.BAS
	$(DOS33) -y appleiibot.dsk SAVE A MOD9_HGR.BAS
	$(DOS33) -y appleiibot.dsk SAVE A SIER_HGR.BAS
	$(DOS33) -y appleiibot.dsk SAVE A MOVE.BAS
	$(DOS33) -y appleiibot.dsk SAVE A SINE.BAS
	$(DOS33) -y appleiibot.dsk SAVE A XDRAW128.BAS
	$(DOS33) -y appleiibot.dsk SAVE A GATOR.BAS
	$(DOS33) -y appleiibot.dsk SAVE A CURSOR.BAS
	$(DOS33) -y appleiibot.dsk SAVE A STARGATE.BAS
	$(DOS33) -y appleiibot.dsk SAVE A TUNNEL.BAS
	$(DOS33) -y appleiibot.dsk SAVE A STARFIELD.BAS
	$(DOS33) -y appleiibot.dsk SAVE A STAROOPS.BAS
	$(DOS33) -y appleiibot.dsk SAVE A HGRSTARFIELD.BAS
	$(DOS33) -y appleiibot.dsk SAVE A COOL_BOT.BAS
	$(DOS33) -y appleiibot.dsk SAVE A WEB.BAS
	$(DOS33) -y appleiibot.dsk SAVE A ORB.BAS
	$(DOS33) -y appleiibot.dsk SAVE A FIREWORKS.BAS
	$(DOS33) -y appleiibot.dsk SAVE A THINKING.BAS
	$(DOS33) -y appleiibot.dsk SAVE A ARCS.BAS
	$(DOS33) -y appleiibot.dsk SAVE A WIRE_HGR.BAS
	$(DOS33) -y appleiibot.dsk SAVE A STATIC.BAS
	$(DOS33) -y appleiibot.dsk SAVE A OVAL.BAS
	$(DOS33) -y appleiibot.dsk SAVE A OVAL_HGR.BAS
	$(DOS33) -y appleiibot.dsk SAVE A MOVING.BAS
	$(DOS33) -y appleiibot.dsk SAVE A THICK_SINE.BAS
	$(DOS33) -y appleiibot.dsk SAVE A TURKEY.BAS
	$(DOS33) -y appleiibot.dsk SAVE A FLAME_HGR.BAS
	$(DOS33) -y appleiibot.dsk SAVE A RECT.BAS
	$(DOS33) -y appleiibot.dsk SAVE A SNOWY.BAS

####

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

make_boxes:	make_boxes.o
	$(CC) $(LFLAGS) -o make_boxes make_boxes.o

make_boxes.o:	make_boxes.c
	$(CC) $(CFLAGS) -c make_boxes.c


###

convert_to:	convert_to.o
	$(CC) $(LFLAGS) -o convert_to convert_to.o

convert_to.o:	convert_to.c
	$(CC) $(CFLAGS) -c convert_to.c

###

convert_qkumba:	convert_qkumba.o
	$(CC) $(LFLAGS) -o convert_qkumba convert_qkumba.o

convert_qkumba.o:	convert_qkumba.c
	$(CC) $(CFLAGS) -c convert_qkumba.c

###

convert_vmw:	convert_vmw.o
	$(CC) $(LFLAGS) -o convert_vmw convert_vmw.o

convert_vmw.o:	convert_vmw.c
	$(CC) $(CFLAGS) -c convert_vmw.c

###

convert_tgreene:	convert_tgreene.o
	$(CC) $(LFLAGS) -o convert_tgreene convert_tgreene.o

convert_tgreene.o:	convert_tgreene.c
	$(CC) $(CFLAGS) -c convert_tgreene.c


###

convert_back:	convert_back.o
	$(CC) $(LFLAGS) -o convert_back convert_back.o

convert_back.o:	convert_back.c
	$(CC) $(CFLAGS) -c convert_back.c


###

LOAD:	load.o
	ld65 -o LOAD load.o -C ../../linker_scripts/apple2_300.inc

load.o:	load.s
	ca65 -o load.o load.s -l load.lst

####

ARCS.BAS:	arcs.bas
	$(TOKENIZE) < arcs.bas > ARCS.BAS

####

QKUMBA2.BAS:	qkumba_seasons.bas
	$(TOKENIZE) < qkumba_seasons.bas > QKUMBA2.BAS

####

QKUMBA.BAS:	qkumba_autumn.bas
	$(TOKENIZE) < qkumba_autumn.bas > QKUMBA.BAS

####

CONCERT.BAS:	concert.bas
	$(TOKENIZE) < concert.bas > CONCERT.BAS

####

NYAN.BAS:	nyan.bas
	$(TOKENIZE) < nyan.bas > NYAN.BAS

####

MOD9.BAS:	mod9.bas
	$(TOKENIZE) < mod9.bas > MOD9.BAS

####

XDRAW128.BAS:	xdraw128.bas
	$(TOKENIZE) < xdraw128.bas > XDRAW128.BAS


####

MOD9_HGR.BAS:	mod9_hgr.bas
	$(TOKENIZE) < mod9_hgr.bas > MOD9_HGR.BAS

####

SIER_HGR.BAS:	sier_hgr.bas
	$(TOKENIZE) < sier_hgr.bas > SIER_HGR.BAS

####

XOR_ZOOM.BAS:	xor_zoom.bas
	$(TOKENIZE) < xor_zoom.bas > XOR_ZOOM.BAS


####

FALLING.BAS:	falling.bas
	$(TOKENIZE) < falling.bas > FALLING.BAS

####

SNOW.BAS:	snow.bas
	$(TOKENIZE) < snow.bas > SNOW.BAS

####

SNOWY.BAS:	snowy.bas
	$(TOKENIZE) < snowy.bas > SNOWY.BAS

####

THICK_SINE.BAS:	thick_sine.bas
	$(TOKENIZE) < thick_sine.bas > THICK_SINE.BAS

####

MOVE.BAS:	move.bas
	$(TOKENIZE) < move.bas > MOVE.BAS

####

SINE.BAS:	sine.bas
	$(TOKENIZE) < sine.bas > SINE.BAS

####

TURKEY.BAS:	turkey.bas
	$(TOKENIZE) < turkey.bas > TURKEY.BAS

####

XMAS.BAS:	xmas.bas
	$(TOKENIZE) < xmas.bas > XMAS.BAS

####

AN3.BAS:	an3.bas
	$(TOKENIZE) < an3.bas > AN3.BAS

####

PLASMA.BAS:	plasma.bas
	$(TOKENIZE) < plasma.bas > PLASMA.BAS

####

C64.BAS:	c64.bas
	$(TOKENIZE) < c64.bas > C64.BAS


####

E2.BAS:	entropy_small.bas
	$(TOKENIZE) < entropy_small.bas > E2.BAS

####

BIN.BAS:	bin.bas
	$(TOKENIZE) < bin.bas > BIN.BAS

####

GATOR.BAS:	gator.bas
	$(TOKENIZE) < gator.bas > GATOR.BAS

####

CURSOR.BAS:	cursor.bas
	$(TOKENIZE) < cursor.bas > CURSOR.BAS

####

STARGATE.BAS:	stargate.bas
	$(TOKENIZE) < stargate.bas > STARGATE.BAS

####

TUNNEL.BAS:	tunnel.bas
	$(TOKENIZE) < tunnel.bas > TUNNEL.BAS

####

STARFIELD.BAS:	starfield.bas
	$(TOKENIZE) < starfield.bas > STARFIELD.BAS

####

STAROOPS.BAS:	staroops.bas
	$(TOKENIZE) < staroops.bas > STAROOPS.BAS



####

FLAME2.BAS:	flame2.bas
	$(TOKENIZE) < flame2.bas > FLAME2.BAS


####

FLAME.BAS:	flame.bas
	$(TOKENIZE) < flame.bas > FLAME.BAS

####

AUTUMN.BAS:	autumn.bas
	$(TOKENIZE) < autumn.bas > AUTUMN.BAS

####

CIRCLES.BAS:	circles.bas
	$(TOKENIZE) < circles.bas > CIRCLES.BAS

####

ASTEROID.BAS:	asteroid.bas
	$(TOKENIZE) < asteroid.bas > ASTEROID.BAS

####

PERSON.BAS:	person.bas
	$(TOKENIZE) < person.bas > PERSON.BAS

####

SHIP.BAS:	ship.bas
	$(TOKENIZE) < ship.bas > SHIP.BAS

####

RASTER.BAS:	raster.bas
	$(TOKENIZE) < raster.bas > RASTER.BAS

####

DHGR.BAS:	dhgr.bas
	$(TOKENIZE) < dhgr.bas > DHGR.BAS

####

RASTER3.BAS:	raster3.bas
	$(TOKENIZE) < raster3.bas > RASTER3.BAS

####

RASTER4.BAS:	raster4.bas
	$(TOKENIZE) < raster4.bas > RASTER4.BAS


####

RASTER5.BAS:	raster5.bas
	$(TOKENIZE) < raster5.bas > RASTER5.BAS

####

PUMPKIN.BAS:	pumpkin.bas
	$(TOKENIZE) < pumpkin.bas > PUMPKIN.BAS

####

LADY.BAS:	lady.bas
	$(TOKENIZE) < lady.bas > LADY.BAS

####

PUMPKIN_SMALL.BAS:	pumpkin_small.bas
	$(TOKENIZE) < pumpkin_small.bas > PUMPKIN_SMALL.BAS

####

LOTS.BAS:	lots.bas
	$(TOKENIZE) < lots.bas > LOTS.BAS

####

A2.BAS:	a2.bas
	$(TOKENIZE) < a2.bas > A2.BAS

####

A2_4EVER.BAS:	a2_4ever.bas
	$(TOKENIZE) < a2_4ever.bas > A2_4EVER.BAS


####

FOURAM.BAS:	fouram.bas
	$(TOKENIZE) < fouram.bas > FOURAM.BAS

####

FLOPPY.BAS:	floppy.bas
	$(TOKENIZE) < floppy.bas > FLOPPY.BAS


####

QR.BAS:	qr.bas
	$(TOKENIZE) < qr.bas > QR.BAS

####

THINKING.BAS:	thinking.bas
	$(TOKENIZE) < thinking.bas > THINKING.BAS

####

RLE.BAS:	rle.bas
	$(TOKENIZE) < rle.bas > RLE.BAS

####

RLE2.BAS:	rle2.bas
	$(TOKENIZE) < rle2.bas > RLE2.BAS

####

RLEASM.BAS:	rleasm.bas
	$(TOKENIZE) < rleasm.bas > RLEASM.BAS

####

HORIZON.BAS:	horizon.bas
	$(TOKENIZE) < horizon.bas > HORIZON.BAS

####

FLYER.BAS:	flyer.bas
	$(TOKENIZE) < flyer.bas > FLYER.BAS

####

STAR.BAS:	star.bas
	$(TOKENIZE) < star.bas > STAR.BAS

####

FASTAR.BAS:	fastar.bas
	$(TOKENIZE) < fastar.bas > FASTAR.BAS

####

FASTAR2.BAS:	fastar2.bas
	$(TOKENIZE) < fastar2.bas > FASTAR2.BAS


####

HYPER.BAS:	hyper.bas
	$(TOKENIZE) < hyper.bas > HYPER.BAS


####

FAKES.BAS:	fakes.bas
	$(TOKENIZE) < fakes.bas > FAKES.BAS

####

SIER.BAS:	sier.bas
	$(TOKENIZE) < sier.bas > SIER.BAS

####

DROPS.BAS:	drops.bas
	$(TOKENIZE) < drops.bas > DROPS.BAS

####

WIRE_HGR.BAS:	wire_hgr.bas
	$(TOKENIZE) < wire_hgr.bas > WIRE_HGR.BAS

####

STATIC.BAS:	static.bas
	$(TOKENIZE) < static.bas > STATIC.BAS

####

RR.BAS:	rr.bas
	$(TOKENIZE) < rr.bas > RR.BAS

####

RR_HGR.BAS:	rr_hgr.bas
	$(TOKENIZE) < rr_hgr.bas > RR_HGR.BAS

####

COMBO.BAS:	combo.bas
	$(TOKENIZE) < combo.bas > COMBO.BAS

####

WIRES.BAS:	wires.bas
	$(TOKENIZE) < wires.bas > WIRES.BAS

####

PATTERN.BAS:	pattern.bas
	$(TOKENIZE) < pattern.bas > PATTERN.BAS

####

BALL.BAS:	ball.bas
	$(TOKENIZE) < ball.bas > BALL.BAS

####

LINES.BAS:	lines.bas
	$(TOKENIZE) < lines.bas > LINES.BAS

####

HGRSTARFIELD.BAS:	hgrstarfield.bas
	$(TOKENIZE) < hgrstarfield.bas > HGRSTARFIELD.BAS


####

SIERPINSKI.BAS:	sierpinski.bas
	$(TOKENIZE) < sierpinski.bas > SIERPINSKI.BAS

####

COOL_BOT.BAS:	cool_bot.bas
	$(TOKENIZE) < cool_bot.bas > COOL_BOT.BAS

####

WEB.BAS:	web.bas
	$(TOKENIZE) < web.bas > WEB.BAS

####

OVAL.BAS:	oval.bas
	$(TOKENIZE) < oval.bas > OVAL.BAS

####

MOVING.BAS:	moving.bas
	$(TOKENIZE) < moving.bas > MOVING.BAS

####

OVAL_HGR.BAS:	oval_hgr.bas
	$(TOKENIZE) < oval_hgr.bas > OVAL_HGR.BAS


####

ORB.BAS:	orb.bas
	$(TOKENIZE) < orb.bas > ORB.BAS

####

RECT.BAS:	rect.bas
	$(TOKENIZE) < rect.bas > RECT.BAS

####

FIREWORKS.BAS:	fireworks.bas
	$(TOKENIZE) < fireworks.bas > FIREWORKS.BAS

####

FLAME_HGR.BAS:	flame_hgr.bas
	$(TOKENIZE) < flame_hgr.bas > FLAME_HGR.BAS

####

clean:
	rm -f *~ *.o *.lst convert_to convert_from convert_qkumba convert_vmw make_boxes convert_back convert_tgreene LOAD *.BAS
