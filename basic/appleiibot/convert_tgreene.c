/* code by qkumba */

#include <stdio.h>
#include <unistd.h>

#define OFFSET	32
#define OFFSET2	35

//#define OFFSET	35

int main(int argc, char **argv) {

	int i = 0;
	int e = 0,filesize;
	int val,pv,final;
	unsigned char in[1024];
	unsigned char enc[1024],enc2[1024];
	int third,enc_ptr=0;

//	printf("1REM");


	filesize=read(0,in,1024);
	do {
		third = ((in[i + 2] & 3) << 4) +
			((in[i + 1] & 3) << 2) + (in[i + 0] & 3);
		enc[e++]=third+OFFSET2;
		if (i<filesize) {
			val=in[i+0];
			pv=val;
			val=val+0x40;
			val-=third;
//			val&=0xff;
			val=val>>2;
			val=val+OFFSET;
			final=((val-OFFSET)<<2)+third-0x40;
			fprintf(stderr,"%d: %x -> %x %x ==> %x\n",
				i,pv,val,third,final);
			if (pv!=final) fprintf(stderr,"error0: no match!\n");
			if (val<0) fprintf(stderr,"error0, negative! in=%x e=%x val=%x\n",
				in[i+0],third,val);
			if (val<0x20) fprintf(stderr,"error0, unprintable! in=%x pv=%x e=%x val=%x\n",
				in[i+0],pv,third,val);
			if (val>0x7e) fprintf(stderr,"error0, too big! in=%x pv=%x e=%x val=%x\n",
				in[i+0],pv,third,val);
//			printf("%c",val); //(in[i + 0] >> 2) + OFFSET);
			//printf("%c",val); //(in[i + 0] >> 2) + OFFSET);
			enc2[enc_ptr]=val;
			enc_ptr++;
		}
		if (i + 1 < filesize) {
			val=in[i+1];
			pv=val;
			val=val+0x40;
			val-=(third>>2);
//			val&=0xff;
			val=val>>2;
			val=val+OFFSET;
			final=((val-OFFSET)<<2)+(third>>2)-0x40;

			fprintf(stderr,"%d: %x -> %x %x ==> %x\n",
				i+1,pv,val,third>>2,final);
			if (pv!=final) fprintf(stderr,"error1: no match!\n");
			if (val<0) fprintf(stderr,"error1, negative! %x %x\n",
				in[i+0]&0xfc,third);
			if (val<0x20) fprintf(stderr,"error1, unprintable! %x %x\n",
				in[i+0]&0xfc,third);
			if (val>0x7e) fprintf(stderr,"error1, too big! in=%x pv=%x e=%x val=%x\n",
				in[i+0],pv,third,val);
//			printf("%c",val); //(in[i + 1] >> 2) + OFFSET);
			enc2[enc_ptr]=val;
			enc_ptr++;
		}
		if (i + 2 < filesize) {
			val=in[i+2];
			pv=val;
			val=val+0x40;
			val-=(third>>4);
//			val&=0xff;
			val=val>>2;
			val=val+OFFSET;
			final=((val-OFFSET)<<2)+(third>>4)-0x40;
			fprintf(stderr,"%d: %x -> %x %x ==> %x\n",
				i+2,pv,val,third>>4,final);
			if (pv!=final) fprintf(stderr,"error2: no match!\n");
			if (val<0) fprintf(stderr,"error2, negative! %x %x\n",
				in[i+0]&0xfc,third);
			if (val<0x20) fprintf(stderr,"error2, unprintable! %x %x\n",
				in[i+0]&0xfc,third);
			if (val>0x7e) fprintf(stderr,"error2 too big! in=%x pv=%x e=%x val=%x\n",
				in[i+0],pv,third,val);
//			printf("%c",val);//(in[i + 2] >> 2) + OFFSET);
			enc2[enc_ptr]=val;
			enc_ptr++;
		}
	} while ((i += 3) < filesize);
	enc[e]=0;
	enc2[enc_ptr]=0;

// from Tom Greene @txgx42
// $850 = 2128
// with call
#if 0
	printf("1FORI=0TO%d:POKE768+I,4*PEEK(%d+I)-"
		"192+(PEEK(%d+I/3)-%d)/4^(I-INT(I/3)*3):NEXT\n",
		filesize-1,2128,2128+filesize,OFFSET2);
	printf("2CALL768\"%s%s\n",enc2,enc);
#else
	printf("1FORI=0TO%d:POKE%d+I,4*PEEK(%d+I)-"
		"192+(PEEK(%d+I/3)-%d)/4^(I-INT(I/3)*3):NEXT\n",
		filesize-1,
		0x3f5-filesize+3,
		2125,2125+filesize,OFFSET2);
	printf("2&\"%s%s\n",enc2,enc);
#endif

//	printf("%s\n",enc);
//	printf("2FORI=0TO%d:POKE768+I,4*PEEK(2054+I)-"
//		"192+(PEEK(%d+I/3)-32)/4^(I-INT(I/3)*3):NEXT:CALL768\n",
//		filesize,2054+filesize);



//	printf("2FORI=0TO%d:C=(PEEK(%d+I/3)-32)/4^(I-INT(I/3)*3):POKE768+I,C+4*(PEEK(2054+I)-32-INT(C/4)):NEXT:CALL768\n",
//		filesize,2054+filesize);

// note, peek/poke truncate?
//2FORI=1013TO1141:C=(PEEK(1843+I/3)-32)/4^(I-INT(I/3)*3):POKEI,C+4*(PEEK(1041+I)-32-INT(C/4)):NEXT:&



	return 0;
}
