#define RAMSIZE	128*1024
extern unsigned char ram[RAMSIZE];
extern unsigned char a,y,x;
extern unsigned short sp;
extern unsigned int n,z,c,v;

unsigned short y_indirect(unsigned char base, unsigned char y);
int init_6502(void);
void adc(int value);
void sbc(int value);
void cmp(int value);
void cpy(int value);
void cpx(int value);
void pha(void);
void pla(void);
void lsr(void);
void asl(void);
void ror(void);
void rol(void);
void ror_mem(int addr);
void rol_mem(int addr);
void dex(void);
void dey(void);
void inx(void);
void iny(void);
void tax(void);
void tay(void);
void txa(void);
void tya(void);


unsigned char high(int value);
unsigned char low(int value);

