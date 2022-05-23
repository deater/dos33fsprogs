MEMORY {
       ZP: start = $70, size = $80, type = rw;
       RAM: start = $E7, size = $8E00, file = %O;
}

SEGMENTS {
#CODE: load = RAM, type = ro;
#RODATA: load = RAM, type = ro;
#DATA: load = RAM, type = rw;
#BSS: load = RAM, type = bss, define = yes;
ZEROPAGE: load = ZP, type = ro;
}
