MEMORY {
       ZP: start = $00, size = $1A, type = rw;
       RAM: start = $E300, size = $1C00, file = %O;
}

SEGMENTS {
CODE: load = RAM, type = ro;
RODATA: load = RAM, type = ro;
DATA: load = RAM, type = rw;
BSS: load = RAM, type = bss, define = yes;
ZEROPAGE: load = ZP, type = zp;
}
