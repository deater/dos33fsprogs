MEMORY {
       ZP: start = $00, size = $1A, type = rw;
       RAM: start = $9500, size = $3000, file = %O;
}

SEGMENTS {
CODE: load = RAM, type = ro, align=$100;
RODATA: load = RAM, type = ro;
DATA: load = RAM, type = rw;
BSS: load = RAM, type = bss, define = yes;
ZEROPAGE: load = ZP, type = zp;
}
