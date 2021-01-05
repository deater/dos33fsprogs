include Makefile.inc

all:
	cd utils && make

install:
	cd utils && make install

clean:
	cd asm_routines && make clean
	cd utils && make clean
	rm -f *~

test:
