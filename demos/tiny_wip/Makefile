include ../../Makefile.inc

DOS33 = ../../utils/dos33fs-utils/dos33
TOKENIZE = ../../utils/asoft_basic-utils/tokenize_asoft
EMPTYDISK = ../../empty_disk/empty.dsk
LINKER_SCRIPTS = ../../linker_scripts/

all:	tiny_demos.dsk

tiny_demos.dsk:	HELLO CHEVRON_17 CIRCUIT_17 TIGER_22 \
	NOISY_TIGER_35 ANGLE_SONG_30 RAMP_34 \
	MAD_COMPUTE_31 WALL_17 BLACKHOLE_64 \
	TEST
	cp $(EMPTYDISK) tiny_demos.dsk
	$(DOS33) -y tiny_demos.dsk SAVE A HELLO
	$(DOS33) -y tiny_demos.dsk BSAVE -a 0xE7 CHEVRON_17
	$(DOS33) -y tiny_demos.dsk BSAVE -a 0xE7 CIRCUIT_17
	$(DOS33) -y tiny_demos.dsk BSAVE -a 0xE7 TIGER_22
	$(DOS33) -y tiny_demos.dsk BSAVE -a 0xE7 NOISY_TIGER_35
	$(DOS33) -y tiny_demos.dsk BSAVE -a 0xE7 ANGLE_SONG_30
	$(DOS33) -y tiny_demos.dsk BSAVE -a 0xE7 RAMP_34
	$(DOS33) -y tiny_demos.dsk BSAVE -a 0xE7 MAD_COMPUTE_31
	$(DOS33) -y tiny_demos.dsk BSAVE -a 0xE7 WALL_17
	$(DOS33) -y tiny_demos.dsk BSAVE -a 0xE7 BLACKHOLE_64
	$(DOS33) -y tiny_demos.dsk BSAVE -a 0xE7 TEST

###

HELLO:	hello.bas
	$(TOKENIZE) < hello.bas > HELLO

###

CHEVRON_17:	chevron_17.o
	ld65 -o CHEVRON_17 chevron_17.o -C $(LINKER_SCRIPTS)/apple2_e7_zp.inc

chevron_17.o:	chevron_17.s
	ca65 -o chevron_17.o chevron_17.s -l chevron_17.lst

###

CIRCUIT_17:	circuit_17.o
	ld65 -o CIRCUIT_17 circuit_17.o -C $(LINKER_SCRIPTS)/apple2_e7_zp.inc

circuit_17.o:	circuit_17.s
	ca65 -o circuit_17.o circuit_17.s -l circuit_17.lst

###

WALL_17:	wall_17.o
	ld65 -o WALL_17 wall_17.o -C $(LINKER_SCRIPTS)/apple2_e7_zp.inc

wall_17.o:	wall_17.s
	ca65 -o wall_17.o wall_17.s -l wall_17.lst

###

BLACKHOLE_64:	blackhole_64.o
	ld65 -o BLACKHOLE_64 blackhole_64.o -C $(LINKER_SCRIPTS)/apple2_e7_zp.inc

blackhole_64.o:	blackhole_64.s
	ca65 -o blackhole_64.o blackhole_64.s -l blackhole_64.lst



###

TIGER_22:	tiger_22.o
	ld65 -o TIGER_22 tiger_22.o -C $(LINKER_SCRIPTS)/apple2_e7_zp.inc

tiger_22.o:	tiger_22.s
	ca65 -o tiger_22.o tiger_22.s -l tiger_22.lst

###

NOISY_TIGER_35:	noisy_tiger_35.o
	ld65 -o NOISY_TIGER_35 noisy_tiger_35.o -C $(LINKER_SCRIPTS)/apple2_e7_zp.inc

noisy_tiger_35.o:	noisy_tiger_35.s
	ca65 -o noisy_tiger_35.o noisy_tiger_35.s -l noisy_tiger_35.lst

###

ANGLE_SONG_30:	angle_song_30.o
	ld65 -o ANGLE_SONG_30 angle_song_30.o -C $(LINKER_SCRIPTS)/apple2_e7_zp.inc

angle_song_30.o:	angle_song_30.s
	ca65 -o angle_song_30.o angle_song_30.s -l angle_song_30.lst

###

RAMP_34:	ramp_34.o
	ld65 -o RAMP_34 ramp_34.o -C $(LINKER_SCRIPTS)/apple2_e7_zp.inc

ramp_34.o:	ramp_34.s
	ca65 -o ramp_34.o ramp_34.s -l ramp_34.lst

###

MAD_COMPUTE_31:	mad_compute_31.o
	ld65 -o MAD_COMPUTE_31 mad_compute_31.o -C $(LINKER_SCRIPTS)/apple2_e7_zp.inc

mad_compute_31.o:	mad_compute_31.s
	ca65 -o mad_compute_31.o mad_compute_31.s -l mad_compute_31.lst




###

TEST:	test.o
	ld65 -o TEST test.o -C $(LINKER_SCRIPTS)/apple2_e7_zp.inc

test.o:	test.s
	ca65 -o test.o test.s -l test.lst

####

clean:	
	rm -f *~ *.o *.lst HELLO \
		CHEVRON_17 CIRCUIT_17 TIGER_22 \
		NOISY_TIGER_35 ANGLE_SONG_30 RAMP_34 \
		MAD_COMPUTE_31 WALL_17 BLACKHOLE_64 \
		TEST *.zip

