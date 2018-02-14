#define RAMSIZE	128*1024
extern unsigned char ram[RAMSIZE];
extern unsigned char a,y,x;
unsigned short y_indirect(unsigned char base, unsigned char y);
