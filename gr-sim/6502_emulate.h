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
void asl_mem(int addr);
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
void bit(int value);
void bit_mem(int addr);
void lda(int addr);
void lda_const(int value);
void ldx(int addr);
void ldx_const(int value);
void ldy(int addr);
void ldy_const(int value);

unsigned char high(int value);
unsigned char low(int value);

