MEMORY {
       ZP: start = $80, size = $120, type = rw;
       RAM: start = $100, size = $8E00, file = %O;
}

SEGMENTS {
#CODE: load = RAM, type = ro;
#RODATA: load = RAM, type = ro;
#DATA: load = RAM, type = rw;
#BSS: load = RAM, type = bss, define = yes;
ZEROPAGE: load = ZP, type = ro;
}
