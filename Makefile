include Makefile.inc

all:
	cd utils && make

install:
	cd utils && make install

clean:
	cd asm_routines && make clean
	cd basic && make clean
	cd basic && make clean
	cd combo_disk && make clean
	cd compression && make clean
	cd demos && make clean
	cd disk && make clean
	cd docs && make clean
	cd ethernet && make clean
	cd games && make clean
	cd graphics && make clean
	cd joystick && make clean
	cd linker_scripts && make clean
	cd music && make clean
	cd textmode && make clean
	cd utils && make clean
	cd vaporlock && make clean
	rm -f *~

test:
