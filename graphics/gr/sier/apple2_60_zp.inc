MEMORY {
       ZP: start = $60, size = $90, type = rw;
       RAM: start = $60, size = $8E00, file = %O;
}

SEGMENTS {
#CODE: load = RAM, type = ro;
#RODATA: load = RAM, type = ro;
#DATA: load = RAM, type = rw;
#BSS: load = RAM, type = bss, define = yes;
ZEROPAGE: load = ZP, type = ro;
}
